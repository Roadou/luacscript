function PaGlobalFunc_ServantFunction_All_Open(isGuild, servantType)
  if nil == isGuild or nil == servantType or nil == Panel_Dialog_ServantFunction_All or true == Panel_Dialog_ServantFunction_All:GetShow() then
    return
  end
  PaGlobal_ServantFunction_All._isGuild = isGuild
  PaGlobal_ServantFunction_All:prepareOpen(isGuild, servantType)
end
function HandleEventPadPress_ServantFunction_All_ChangeTab(isUp)
  if nil == Panel_Dialog_ServantFunction_All or false == Panel_Dialog_ServantFunction_All:GetShow() then
    return
  end
  local tempIdx = PaGlobal_ServantFunction_All._currentTab
  if nil == PaGlobal_ServantFunction_All._tempBtnTable or PaGlobal_ServantFunction_All._currentNpcType == PaGlobal_ServantFunction_All._ENUM_NPC_TYPE._SEA then
    return
  end
  if 1 == PaGlobal_ServantFunction_All._functionButtonCount then
    return
  end
  if true == isUp then
    tempIdx = tempIdx + 1
    if tempIdx > PaGlobal_ServantFunction_All._ENUM._COUNT - 2 then
      tempIdx = 0
    end
  else
    tempIdx = tempIdx - 1
    if tempIdx < 0 then
      tempIdx = PaGlobal_ServantFunction_All._ENUM._COUNT - 2
    end
  end
  local changedIdx = PaGlobal_ServantFunction_All._tempBtnTable[tempIdx]
  if nil == PaGlobal_ServantFunction_All._tempBtnTable[tempIdx] then
    return
  end
  PaGlobalFunc_ServantFunction_All_ChangeTab(changedIdx)
end
function PaGlobalFunc_ServantFunction_All_ChangeTab(idx)
  if nil == Panel_Dialog_ServantFunction_All or false == Panel_Dialog_ServantFunction_All:GetShow() then
    return
  end
  if nil == idx or nil == Panel_Dialog_ServantList_All or nil == Panel_Dialog_ServantExchange_All or nil == Panel_Dialog_ServantMarket_Rental_Mating_All or nil == Panel_Dialog_ServantLookChange_All or nil == Panel_Dialog_ServantCarriageLink_All or nil == Panel_Dialog_ServantMarket_All or nil == Panel_Dialog_ServantSwiftTraining_All or nil == Panel_Dialog_ServantSwiftResult_All then
    return
  end
  TooltipSimple_Hide()
  if nil ~= PaGlobal_Window_ServantRateDesc_Close then
    PaGlobal_Window_ServantRateDesc_Close()
  end
  PaGlobalFunc_ServantExchange_All_Close()
  PaGlobalFunc_ServantSkillManagement_All_Close()
  PaGlobalFunc_ServantSwiftTraining_All_Close()
  PaGlobalFunc_ServantRegist_All_Close()
  PaGlobalFunc_ServantTransferList_All_Close()
  PaGlobalFunc_ServantMarket_Rental_Mating_All_Close()
  PaGlobalFunc_ServantMarket_All_Close()
  PaGlobalFunc_ServantCarriageLink_All_Close()
  PaGlobalFunc_ServantLookChange_All_Close()
  PaGlobalFunc_ServantNameRegist_All_Close()
  PaGlobalFunc_ServantExchange_Fantasy_All_Close()
  PaGlobalFunc_MarketPlace_Close(false)
  PaGlobalFunc_ServantTransferBackwardList_All_Close()
  if _ContentsGroup_HorseSimulator == true then
    PaGlobalFunc_ServantSimulator_CloseIfNotStikerModeUI()
  end
  if _ContentsGroup_FantasyHorse == true then
    PaGlobalFunc_ServantFantasySkin_Close()
  end
  if true == self._isConsole then
    PaGlobalFunc_ServantInfo_All_SetIgnoreSnapToOtherPanel(false)
  end
  if true == _ContentsGroup_Sailor and nil ~= PaGlobal_SailorManager_All then
    PaGlobal_SailorManager_All:prepareCloseForce()
  end
  if _ContentsGroup_EmployeePresetJob == true then
    PaGlobalFunc_SailorPresetManager_All_Close()
  end
  if false == Panel_Dialog_ServantList_All:GetShow() then
    if true == _ContentsGroup_RenewUI then
      if false == Panel_Window_Barter_Search:GetShow() then
        PaGlobalFunc_ServantList_All_Open()
      end
    else
      PaGlobalFunc_ServantList_All_Open()
    end
  end
  if PaGlobal_ServantFunction_All._ENUM._LIST == idx then
    if true == _ContentsGroup_RenewUI then
      if false == Panel_Window_Barter_Search:GetShow() then
        PaGlobalFunc_ServantList_All_Open()
      end
    else
      PaGlobalFunc_ServantList_All_Open()
    end
  elseif PaGlobal_ServantFunction_All._ENUM._LINK == idx then
    PaGlobalFunc_ServantCarriageLink_All_Open()
  elseif PaGlobal_ServantFunction_All._ENUM._EXCHANGE == idx then
    PaGlobalFunc_ServantExchange_All_Open()
  elseif PaGlobal_ServantFunction_All._ENUM._MATING == idx then
    PaGlobalFunc_ServantMarket_Rental_Mating_All_Open(true)
    PaGlobalFunc_ServantFunction_All_SidePanelClose()
  elseif PaGlobal_ServantFunction_All._ENUM._MARKET == idx then
    PaGlobalFunc_ServantMarket_All_Open()
    PaGlobalFunc_ServantFunction_All_SidePanelClose()
  elseif PaGlobal_ServantFunction_All._ENUM._RENTAL == idx then
    PaGlobalFunc_ServantMarket_Rental_Mating_All_Open(false)
    PaGlobalFunc_ServantFunction_All_SidePanelClose()
  elseif PaGlobal_ServantFunction_All._ENUM._WORLDMARKET == idx then
    PaGlobalFunc_MarketPlace_Open()
    PaGlobalFunc_ServantFunction_All_SidePanelClose()
  elseif PaGlobal_ServantFunction_All._ENUM._HORSESIMULATOR == idx then
    local openTabList = {
      [1] = PaGlobal_ServantSimulator._tabType.GROWUP,
      [2] = PaGlobal_ServantSimulator._tabType.MATING
    }
    local crogCount = 0
    local maxCount = ToClient_getServantMaxCountByType(CppEnums.ServantWhereType.ServantWhereTypeCrogdaloStable)
    if _ContentsGroup_Crogdalo == true and getSelfPlayer():isInstancePlayer() == false then
      for ii = 0, maxCount - 1 do
        local servantInfo = ToClient_getServantCrogdaloByIndex(ii)
        if servantInfo ~= nil then
          crogCount = crogCount + 1
        end
      end
    end
    local servantCount = stable_count()
    local servantNo
    local temporaryWrapper = getTemporaryInformationWrapper()
    if temporaryWrapper == nil then
      return
    end
    local servantInfo = temporaryWrapper:getUnsealVehicle(__eServantTypeVehicle)
    if servantInfo ~= nil and servantInfo:getVehicleType() == __eVehicleType_Horse then
      servantNo = servantInfo:getServantNo()
    else
      servantNo = PaGlobalFunc_ServantList_getFirstHorseServantNo()
    end
    if crogCount + servantCount > 0 and servantNo ~= nil then
      openTabList[3] = PaGlobal_ServantSimulator._tabType.DETAIL
    end
    PaGlobalFunc_ServantSimulator_Open(openTabList, servantNo, nil)
    PaGlobalFunc_ServantFunction_All_SidePanelClose()
  else
    return
  end
  if _ContentsGroup_HorseSimulator == true then
    if idx == PaGlobal_ServantFunction_All._ENUM._HORSESIMULATOR then
      PaGlobal_ServantSimulator:changeCloseButtonInputEvent(true)
    else
      PaGlobal_ServantSimulator:changeCloseButtonInputEvent(false)
    end
  end
  PaGlobal_ServantFunction_All._currentTab = idx
  if nil ~= Panel_Dialog_ServantList_All and PaGlobal_ServantFunction_All._ENUM._LIST ~= idx then
    PaGlobalFunc_ServantList_All_SubMenuClose()
  end
  local selectBarPosX = PaGlobal_ServantFunction_All._tabButtonForCategory[idx]:GetSpanSize().x + 50
  PaGlobal_ServantFunction_All._ui._stc_TabButtonBar:SetSpanSize(selectBarPosX, PaGlobal_ServantFunction_All._ui._stc_TabButtonBar:GetSpanSize().y)
  for tabIdx = 0, #PaGlobal_ServantFunction_All._tabButtonForCategory do
    if nil ~= PaGlobal_ServantFunction_All._tabButtonForCategory[tabIdx] then
      if tabIdx == idx then
        PaGlobal_ServantFunction_All._tabButtonForCategory[tabIdx]:SetCheck(true)
      else
        PaGlobal_ServantFunction_All._tabButtonForCategory[tabIdx]:SetCheck(false)
      end
    end
  end
end
function PaGlobalFunc_ServantFunction_All_SidePanelClose()
  if nil ~= Panel_Dialog_ServantList_All then
    PaGlobalFunc_ServantList_All_Close()
  end
  if nil ~= Panel_Dialog_ServantInfo_All then
    PaGlobalFunc_ServantInfo_All_Close()
  end
end
function PaGlobalFunc_ServantFunction_All_Close()
  if nil == Panel_Dialog_ServantFunction_All and false == Panel_Dialog_ServantFunction_All then
    return
  end
  if true == Panel_Dialog_ServantOnlyList_All:GetShow() then
    PaGlobalFunc_ServantOnlyList_All_Close()
    return
  end
  if true == Panel_ImperialSupply_Horse_Confirm:GetShow() then
    PaGlobal_ImperialSupplyMSG:prepareClose()
    return
  end
  if _ContentsGroup_HorseSimulator == true and Panel_Dialog_ServantSimulatorSubView ~= nil and Panel_Dialog_ServantSimulatorSubView:GetShow() == true then
    PaGlobalFunc_ServantSimulatorSubView_Close()
    return
  end
  if true == PaGlobal_ServantFunction_All._isConsole then
    if nil ~= PaGlobal_SailorManager_All_isShowRecoverToolTip and nil ~= PaGlobal_SailorManager_All_CloseRecoverToolTip and true == PaGlobal_SailorManager_All_isShowRecoverToolTip() then
      PaGlobal_SailorManager_All_CloseRecoverToolTip()
      return
    end
    if Panel_Window_ServantUpgradeInfo ~= nil and Panel_Window_ServantUpgradeInfo:GetShow() == true then
      PaGlobal_ServantUpgradeInfo_Close()
      HandleEventLUp_ServantUpgrade_Cancel()
      return
    end
  end
  if nil ~= Panel_Window_ServantRateDesc and true == Panel_Window_ServantRateDesc:GetShow() then
    PaGlobal_Window_ServantRateDesc_Close()
    return
  end
  if Panel_Window_SailorPreset_NameEdit_All ~= nil and Panel_Window_SailorPreset_NameEdit_All:GetShow() == true then
    PaGlobalFunc_SailorPreset_NameEdit_All_Close()
    return
  end
  if Panel_Window_SailorPresetManager_All ~= nil and Panel_Window_SailorPresetManager_All:GetShow() == true then
    PaGlobalFunc_SailorPresetManager_All_Close()
    return
  end
  if Panel_Window_SailorPresetGroup_All ~= nil and Panel_Window_SailorPresetGroup_All:GetShow() == true then
    PaGlobalFunc_SailorPresetGroup_All_Close()
    return
  end
  if Panel_Dialog_ServantLvUpMessageBox_All ~= nil and Panel_Dialog_ServantLvUpMessageBox_All:GetShow() == true then
    PaGlobal_ServantLvUpMessageBox_All_Close()
    return
  end
  local panelList = Array.new()
  panelList:push_back(Panel_Window_ServantRateDesc)
  panelList:push_back(Panel_Dialog_ServantExchange_All)
  panelList:push_back(Panel_Dialog_ServantSwiftTraining_All)
  panelList:push_back(Panel_Dialog_ServantSkillManagement_All)
  panelList:push_back(Panel_Dialog_ServantRegist_All)
  panelList:push_back(Panel_Dialog_ServantTransferList_All)
  panelList:push_back(Panel_Dialog_ServantMarket_All)
  panelList:push_back(Panel_Dialog_ServantMarket_Rental_Mating_All)
  panelList:push_back(Panel_Dialog_ServantCarriageLink_All)
  panelList:push_back(Panel_Window_SailorManager_All)
  panelList:push_back(Panel_Window_ShipEquipManagement_ALL)
  panelList:push_back(Panel_Dialog_ServantNameRegist_All)
  panelList:push_back(Panel_Window_Barter_Refresh)
  panelList:push_back(Panel_Window_MarketPlace_Main)
  panelList:push_back(Panel_Window_Barter_Search)
  panelList:push_back(Panel_Window_CargoLoading_ALL)
  panelList:push_back(Panel_Window_ServantUpgradeInfo)
  panelList:push_back(Panel_Window_ServantUpgrade)
  panelList:push_back(Panel_Dialog_ServantLookChange_All)
  panelList:push_back(Panel_Dialog_ServantExchange_Fantasy_All)
  if _ContentsGroup_HorseSimulator == true then
    panelList:push_back(Panel_Dialog_ServantSimulator)
  end
  if _ContentsGroup_FantasyHorse == true then
    panelList:push_back(Panel_Dialog_ServantFantasySkin)
  end
  if _ContentsGroup_ServantLevelDown == true then
    panelList:push_back(Panel_Dialog_HorseLevelDecrease_All)
  end
  local closeFuntion = Array.new()
  closeFuntion:push_back(PaGlobal_Window_ServantRateDesc_Close)
  closeFuntion:push_back(PaGlobalFunc_ServantExchange_All_Close)
  closeFuntion:push_back(PaGlobalFunc_ServantSwiftTraining_All_Close)
  closeFuntion:push_back(PaGlobalFunc_ServantSkillManagement_All_Close)
  closeFuntion:push_back(PaGlobalFunc_ServantRegist_All_Close)
  closeFuntion:push_back(PaGlobalFunc_ServantTransferList_All_Close)
  closeFuntion:push_back(PaGlobalFunc_ServantMarket_All_Close)
  closeFuntion:push_back(PaGlobalFunc_ServantMarket_Rental_Mating_All_Close)
  closeFuntion:push_back(PaGlobalFunc_ServantCarriageLink_All_Close)
  closeFuntion:push_back(PaGlobal_SailorManager_All_CloseForce)
  closeFuntion:push_back(HandleEventMLUp_ShipEquipManagement_Close)
  closeFuntion:push_back(PaGlobalFunc_ServantNameRegist_All_Close)
  closeFuntion:push_back(PaGlobal_BarterInfoSearch_Refresh_Close)
  closeFuntion:push_back(PaGlobalFunc_MarketPlace_Close)
  closeFuntion:push_back(PaGlobal_BarterInfoSearch_Close)
  closeFuntion:push_back(HandleEventMLUp_CargoLoading_Close)
  closeFuntion:push_back(PaGlobal_ServantUpgradeInfo_Close)
  closeFuntion:push_back(HandleEventLUp_ServantUpgrade_Cancel)
  closeFuntion:push_back(PaGlobalFunc_ServantLookChange_All_Close)
  closeFuntion:push_back(PaGlobalFunc_ServantExchange_Fantasy_All_Close)
  if _ContentsGroup_HorseSimulator == true then
    closeFuntion:push_back(PaGlobalFunc_ServantSimulator_Close)
  end
  if _ContentsGroup_FantasyHorse == true then
    closeFuntion:push_back(PaGlobalFunc_ServantFantasySkin_Close)
  end
  if _ContentsGroup_ServantLevelDown == true then
    closeFuntion:push_back(PaGlobal_Dialog_HorseLevelDecrease_All_Close)
  end
  if _ContentsGroup_EmployeePresetJob == true then
    closeFuntion:push_back(PaGlobalFunc_SailorPresetManager_All_Close)
  end
  for i = 1, #panelList do
    if nil ~= panelList[i] and true == panelList[i]:GetShow() and false == panelList[i]:IsUISubApp() then
      closeFuntion[i]()
      PaGlobalFunc_ServantFunction_All_ChangeTab(0)
      return
    end
  end
  PaGlobal_ServantFunction_All:prepareClose()
end
function PaGlobalFunc_ServantFunction_All_ForceClose()
  if nil == Panel_Dialog_ServantFunction_All or false == Panel_Dialog_ServantFunction_All:GetShow() then
    return
  end
  PaGlobal_ServantFunction_All:prepareClose()
end
function PaGlobalFunc_ServantFunction_All_GetIsGuild(isTest)
  if true == isTest then
    return false
  end
  if nil == Panel_Dialog_ServantFunction_All then
    return
  end
  return PaGlobal_ServantFunction_All._isGuild
end
function FromClient_ServantFunction_All_OnScreenResize()
  if nil == Panel_Dialog_ServantFunction_All or false == Panel_Dialog_ServantFunction_All:GetShow() then
    return
  end
  local screenX = getScreenSizeX()
  Panel_Dialog_ServantFunction_All:SetSize(screenX, Panel_Dialog_ServantFunction_All:GetSizeY())
  Panel_Dialog_ServantFunction_All:ComputePos()
  for tabIdx = 0, #PaGlobal_ServantFunction_All._tabButtonForCategory do
    if nil ~= PaGlobal_ServantFunction_All._tabButtonForCategory[tabIdx] then
      PaGlobal_ServantFunction_All._tabButtonForCategory[tabIdx]:ComputePos()
    end
  end
end
function PaGlobalFunc_ServantFunction_All_TempOnOff(isOn)
  if nil == Panel_Dialog_ServantFunction_All then
    return
  end
  Panel_Dialog_ServantFunction_All:SetShow(isOn)
end
function PaGlobalFunc_ServantFunction_All_Get_NpcType()
  if nil == Panel_Dialog_ServantFunction_All then
    return
  end
  if nil == PaGlobal_ServantFunction_All._currentNpcType then
    return
  end
  return PaGlobal_ServantFunction_All._currentNpcType
end
function PaGlobalFunc_ServantFunction_All_EffectFilter_Mapae(slotNo, itemWrapper)
  if nil == Panel_Dialog_ServantFunction_All then
    return true
  end
  if nil == itemWrapper then
    return true
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if nil == itemSSW then
    return true
  end
  local returnValue = true
  local isMapae = itemSSW:get():isMapae()
  local isGuildMapae = itemSSW:get():isGuildMapae()
  local itemKey = itemWrapper:get():getKey():getItemKey()
  local npcType = ToClient_GetServnatTypeFromNpc()
  if npcType ~= itemSSW:get():getMapaeServantType() then
    return true
  end
  if isGuildStable() then
    if isGuildMapae then
      returnValue = true
    else
      returnValue = false
    end
  elseif isMapae and not isGuildMapae then
    returnValue = true
  else
    returnValue = false
  end
  return not returnValue
end
function PaGlobalFunc_ServantFunction_All_ScenePushObject(servantInfo, beforeSceneIndex, actionIndex)
  if Panel_Dialog_ServantFunction_All == nil then
    return
  end
  if servantInfo == nil then
    return
  end
  local characterKeyRaw = servantInfo:getCharacterKeyRaw()
  local afterSceneIndex = getIndexByCharacterKey(characterKeyRaw)
  if beforeSceneIndex == afterSceneIndex then
    return beforeSceneIndex
  end
  if beforeSceneIndex ~= -1 then
    showSceneCharacter(beforeSceneIndex, false)
  end
  if afterSceneIndex ~= -1 then
    if actionIndex ~= nil then
      showSceneCharacter(afterSceneIndex, true, actionIndex)
    else
      showSceneCharacter(afterSceneIndex, true)
    end
  end
  return afterSceneIndex
end
function PaGlobalFunc_ServantFunction_All_Servant_ScenePopObject(sceneIndex)
  if nil == Panel_Dialog_ServantFunction_All or false == Panel_Dialog_ServantFunction_All:GetShow() then
    return
  end
  if -1 ~= sceneIndex and nil ~= sceneIndex then
    showSceneCharacter(sceneIndex, false)
  end
end
