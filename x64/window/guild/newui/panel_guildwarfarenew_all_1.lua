function PaGlobal_GuildWarfareNew_All:initialize()
  if self._initialize == true then
    return
  end
  self._ui.stc_SelectBG = UI.getChildControl(Panel_GuildWarfareNew_All, "Static_SelectArea")
  self._ui.list_history = UI.getChildControl(self._ui.stc_SelectBG, "List2_History")
  self._ui.btn_history = UI.getChildControl(self._ui.stc_SelectBG, "Button_HistoryToggle")
  self._ui.txt_WarType = UI.getChildControl(self._ui.stc_SelectBG, "StaticText_WarType")
  self._ui.txt_Region = UI.getChildControl(self._ui.stc_SelectBG, "StaticText_Region")
  self._ui.txt_Result = UI.getChildControl(self._ui.stc_SelectBG, "StaticText_Result")
  self._ui.btn_Refresh = UI.getChildControl(self._ui.stc_SelectBG, "Button_Refresh")
  self._ui.btn_SiegeResult = UI.getChildControl(self._ui.stc_SelectBG, "Button_SiegeResult")
  self._ui.btn_SiegeResult:SetShow(true)
  self._ui.txt_WarType:SetPosX(self._ui.txt_WarType:GetPosX() + 100)
  if self._ui.btn_SiegeResult:GetTextSizeX() - 10 > self._ui.btn_SiegeResult:GetSizeX() then
    self._ui.btn_SiegeResult:SetSize(self._ui.btn_SiegeResult:GetTextSizeX() + 10, self._ui.btn_SiegeResult:GetSizeY())
    self._ui.txt_WarType:SetPosX(self._ui.btn_SiegeResult:GetPosX() + self._ui.btn_SiegeResult:GetSizeX() + 10)
  end
  self._ui.stc_TopBG = UI.getChildControl(Panel_GuildWarfareNew_All, "Static_TopArea")
  self._ui.txt_CharName = UI.getChildControl(self._ui.stc_TopBG, "StaticText_M_CharName")
  self._ui.stc_CommadCenter = UI.getChildControl(self._ui.stc_TopBG, "Static_M_CommandCenter")
  self._ui.stc_Tower = UI.getChildControl(self._ui.stc_TopBG, "Static_M_Tower")
  self._ui.stc_CastleGate = UI.getChildControl(self._ui.stc_TopBG, "Static_M_CastleGate")
  self._ui.stc_Summons = UI.getChildControl(self._ui.stc_TopBG, "Static_M_Summons")
  self._ui.stc_Installation = UI.getChildControl(self._ui.stc_TopBG, "Static_M_Installation")
  self._ui.stc_Member = UI.getChildControl(self._ui.stc_TopBG, "Static_M_Member")
  self._ui.stc_Death = UI.getChildControl(self._ui.stc_TopBG, "Static_M_Death")
  self._ui.stc_OceanTent = UI.getChildControl(self._ui.stc_TopBG, "Static_M_OceanTent")
  self._ui.stc_GalleyShip = UI.getChildControl(self._ui.stc_TopBG, "Static_M_GalleyShip")
  self._ui.stc_BigShip = UI.getChildControl(self._ui.stc_TopBG, "Static_M_BigShip")
  self._ui.stc_CarrackShip = UI.getChildControl(self._ui.stc_TopBG, "Static_M_CarrackShip")
  self._ui.stc_BattleShip = UI.getChildControl(self._ui.stc_TopBG, "Static_M_BattleShip")
  self._ui.stc_NormalShip = UI.getChildControl(self._ui.stc_TopBG, "Static_M_NormalShip")
  self._ui.stc_DestroyMyShip = UI.getChildControl(self._ui.stc_TopBG, "Static_M_DestroyMyShip")
  self._ui.txt_Sort = UI.getChildControl(self._ui.stc_TopBG, "StaticText_Sort")
  self._ui.stc_MainBG = UI.getChildControl(Panel_GuildWarfareNew_All, "Static_MainArea")
  self._ui.stc_LeftBG = UI.getChildControl(self._ui.stc_MainBG, "Static_LeftBG")
  self._ui.stc_RightBG = UI.getChildControl(self._ui.stc_MainBG, "Static_RIghtBG")
  self._ui.list2_Warfare = UI.getChildControl(self._ui.stc_MainBG, "List2_Warfare")
  self._ui.txt_IconHelper = UI.getChildControl(Panel_GuildWarfareNew_All, "StaticText_IconHelper")
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._icons = {
    [0] = self._ui.txt_CharName,
    [self._eRecordIconType.Icon_CommandCenter] = self._ui.stc_CommadCenter,
    [self._eRecordIconType.Icon_Tent] = self._ui.stc_Tower,
    [self._eRecordIconType.Icon_CastleGate] = self._ui.stc_CastleGate,
    [self._eRecordIconType.Icon_Summon] = self._ui.stc_Summons,
    [self._eRecordIconType.Icon_Installation] = self._ui.stc_Installation,
    [self._eRecordIconType.Icon_Member] = self._ui.stc_Member,
    [self._eRecordIconType.Icon_Death] = self._ui.stc_Death,
    [self._eRecordIconType.Icon_OceanTent] = self._ui.stc_OceanTent,
    [self._eRecordIconType.Icon_GalleyShip] = self._ui.stc_GalleyShip,
    [self._eRecordIconType.Icon_BigShip] = self._ui.stc_BigShip,
    [self._eRecordIconType.Icon_CarrackShip] = self._ui.stc_CarrackShip,
    [self._eRecordIconType.Icon_BattleShip] = self._ui.stc_BattleShip,
    [self._eRecordIconType.Icon_NormalShip] = self._ui.stc_NormalShip,
    [self._eRecordIconType.Icon_DestroyMyShip] = self._ui.stc_DestroyMyShip
  }
  self._isListDescSort = {
    name = false,
    command = false,
    tower = false,
    castlegate = false,
    summons = false,
    installation = false,
    member = false,
    death = false,
    oceanTent = false,
    galleyShip = false,
    bigShip = false,
    carrackShip = false,
    battleShip = false,
    normalShip = false,
    destroyMyShip = false
  }
  self._ui.list2_Warfare:changeAnimationSpeed(50)
  if self._isConsole == false then
    self._ui.list2_Warfare:changeScrollMoveIndex(10)
  end
  self:validate()
  self:registEventHandler()
  self._isFirstOpenTab = true
  self._initialize = true
end
function PaGlobal_GuildWarfareNew_All:registEventHandler()
  if Panel_GuildWarfareNew_All == nil then
    return
  end
  self._ui.btn_Refresh:addInputEvent("Mouse_LUp", "PaGlobal_GuildWarfareNew_All_HistoryRefresh()")
  self._ui.btn_Refresh:addInputEvent("Mouse_On", "HandleEventOnOut_GuildWarfareNew_All_RefershShowTooltip(true)")
  self._ui.btn_Refresh:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildWarfareNew_All_RefershShowTooltip(false)")
  self._ui.btn_SiegeResult:addInputEvent("Mouse_LUp", "PaGlobal_GuildWarfareNew_All_HistoryResult()")
  self._ui.list2_Warfare:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_GuildWarfareNew_CreateContents_All")
  self._ui.list2_Warfare:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.list2_Warfare:getElementManager():clearKey()
  self._ui.list2_Warfare:addInputEvent("Mouse_UpScroll", "PaGlobal_GuildWarfare_All_SaveScrollData()")
  self._ui.list2_Warfare:addInputEvent("Mouse_DownScroll", "PaGlobal_GuildWarfare_All_SaveScrollData()")
  self._ui.list_history:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_GuildWarfareNew_All_HistoryList")
  self._ui.list_history:createChildContent(__ePAUIList2ElementManagerType_List)
  for idx, control in pairs(self._icons) do
    control:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildWarfareNew_Select_SortType( " .. idx .. ")")
    if 0 ~= idx then
      control:addInputEvent("Mouse_On", "HandleEventLUp_GuildWarfareNew_IconToolTip_Show(" .. idx .. ", true)")
      control:addInputEvent("Mouse_Out", "HandleEventLUp_GuildWarfareNew_IconToolTip_Show(" .. idx .. ", false)")
    end
  end
  self._ui.btn_history:addInputEvent("Mouse_LUp", "PaGlobal_GuildWarfare_All_ToggleList()")
  registerEvent("FromClient_GuildSiegeHistoryListAck", "PaGlobal_GuildWarfareNew_All_HistoryRecordUpdate")
  registerEvent("FromClient_GuildSiegePersonalRecordListAck", "PaGlobal_GuildWarfareNew_All_PersonalRecordUpdate")
  registerEvent("FromClient_ResponseParticipateSiege", "PaGlobal_GuildWarfareNew_All_ProgressingScoreUpdate")
  registerEvent("FromClient_GuildSiegeProgressingPersonalScoreUpdate", "PaGlobal_GuildWarfareNew_All_ProgressingScoreUpdate")
  registerEvent("FromClient_GuildSelfJoin", "PaGlobalFunc_GuildWarfareNew_All_ResetAll")
end
function PaGlobal_GuildWarfareNew_All:prepareOpen()
  if self._initialize == false then
    return
  end
  self:update()
  self:open()
end
function PaGlobal_GuildWarfareNew_All:prepareClose()
  if Panel_GuildWarfareNew_All == nil then
    return
  end
  if self._ui.btn_history:IsCheck() == true then
    self._ui.btn_history:SetCheck(false)
    self._ui.list_history:SetShow(false)
  end
  self:close()
end
function PaGlobal_GuildWarfareNew_All:close()
  if Panel_GuildWarfareNew_All == nil then
    return
  end
  Panel_GuildWarfareNew_All:SetShow(false)
end
function PaGlobal_GuildWarfareNew_All:open()
  if Panel_GuildWarfareNew_All == nil then
    return
  end
  self:SetShow(true)
end
function PaGlobal_GuildWarfareNew_All:update()
  if self._initialize == false then
    return
  end
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if myGuildInfo == nil then
    return
  end
  self:updateSiegeRecordList()
  self:updateSiegePersonalRecordList()
  self:sortDataList()
  PaGlobal_GuildWarfare_All_LoadScrollData()
end
function PaGlobal_GuildWarfareNew_All:updateSiegeRecordState()
  if Panel_GuildWarfareNew_All == nil then
    return
  end
  self._currentSiegeHistoryState = self.ENUM_SIEGE_RECORD_COMBOBOX_STATE.NOTPROGRESSING_NODATA_NOLAST
  local isProgressingSiege = ToClient_isAnySiegeBeingForRecord()
  local historyRecordCount = ToClient_getGuildSiegeHistoryRecordCount()
  local loadLast = ToClient_isLoadLastGuildSiegeHistoryRecord()
  local moreRequestButton = loadLast == true or historyRecordCount >= 30
  if isProgressingSiege == false then
    if historyRecordCount == 0 then
      if moreRequestButton == false then
        self._currentSiegeHistoryState = self.ENUM_SIEGE_RECORD_COMBOBOX_STATE.NOTPROGRESSING_NODATA_NOLAST
      else
        self._currentSiegeHistoryState = self.ENUM_SIEGE_RECORD_COMBOBOX_STATE.NOTPROGRESSING_NODATA
      end
    elseif moreRequestButton == false then
      self._currentSiegeHistoryState = self.ENUM_SIEGE_RECORD_COMBOBOX_STATE.NOTPROGRESSING_DATA_NOLAST
    else
      self._currentSiegeHistoryState = self.ENUM_SIEGE_RECORD_COMBOBOX_STATE.NOTPROGRESSING_DATA_LAST
    end
  elseif moreRequestButton == false then
    self._currentSiegeHistoryState = self.ENUM_SIEGE_RECORD_COMBOBOX_STATE.PROGRESSING_NOLAST
  else
    self._currentSiegeHistoryState = self.ENUM_SIEGE_RECORD_COMBOBOX_STATE.PROGRESSING_LAST
  end
end
function PaGlobal_GuildWarfareNew_All:onChangeSiegeRecordListSelect()
  if Panel_GuildWarfareNew_All == nil then
    return
  end
  self._ui.list2_Warfare:getElementManager():clearKey()
  if self._currentHistoryListIndex < 0 then
    return
  end
  local data = self._listData[self._currentHistoryListIndex]
  if data == nil then
    return
  end
  if data._type == self._type.eJustToday then
  elseif data._type == self._type.eProgressing then
  elseif data._type == self._type.eHistory then
    local siegeHistoryRecordIndex = data._historyIndex
    local siegeHistoryWrapper = ToClient_getGuildSiegeHistoryRecordRecord(siegeHistoryRecordIndex)
    if siegeHistoryWrapper ~= nil then
      local personalRecordLoaded = ToClient_getGuildSiegePersonalRecordLoaded(siegeHistoryRecordIndex)
      if personalRecordLoaded == false then
        local callSuccess = ToClient_reqestPersonalRecord(siegeHistoryRecordIndex)
        if callSuccess == false then
          self._currentHistoryListIndex = 0
        end
      end
    end
  elseif data._type == self._type.eRequestHistory and ToClient_reqestRecentSiegeHistory() == true then
    self:updateSiegeRecordList()
  end
  self:updateSiegePersonalRecordList()
end
function PaGlobal_GuildWarfareNew_All:updateSelectTitle()
  if Panel_GuildWarfareNew_All == nil then
    return
  end
  self._ui.txt_WarType:SetShow(false)
  self._ui.txt_Region:SetShow(false)
  self._ui.txt_Result:SetShow(false)
  self._ui.btn_history:SetText("---")
  self._ui.btn_history:SetTextMode(__eTextMode_LimitText)
  UI.setLimitTextAndAddTooltip(self._ui.btn_history)
  if self._currentHistoryListIndex < 0 then
    return
  end
  local data = self._listData[self._currentHistoryListIndex]
  if data == nil then
    return
  end
  local siegeTerritoryType = __eSiegeTerritoryType_Default
  self._ui.btn_history:SetText(data._text)
  if data._type == self._type.eJustToday then
    self._ui.txt_WarType:SetShow(false)
    self._ui.txt_Region:SetShow(false)
    self._ui.txt_Result:SetShow(false)
  elseif data._type == self._type.eProgressing then
    local siegeBeing = ToClient_isAnySiegeBeingForRecord()
    if siegeBeing == false then
      self._ui.txt_WarType:SetShow(false)
      self._ui.txt_Region:SetShow(false)
    else
      self._ui.txt_WarType:SetShow(true)
      self._ui.txt_Region:SetShow(true)
      siegeTerritoryType = ToClient_getSiegeTerritoryType()
      local isMinorSiegeBeing = ToClient_isMinorSiegeBeingForRecord()
      if isMinorSiegeBeing == true then
        if siegeTerritoryType == __eSiegeTerritoryType_Ocean then
          self._ui.txt_WarType:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_WARFAIR_OCEANSIEGEWAR"))
        else
          self._ui.txt_WarType:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_WARFAIR_SIEGEWAR"))
        end
      else
        self._ui.txt_WarType:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_WARFAIR_TERRITORYWAR"))
      end
      local progressingTerritoryName = ToClient_isAnySiegeBeingTerritoryName()
      self._ui.txt_Region:SetText(progressingTerritoryName)
    end
  elseif data._type == self._type.eHistory then
    local historyIndex = data._historyIndex
    local siegeHistoryWrapper = ToClient_getGuildSiegeHistoryRecordRecord(historyIndex)
    if siegeHistoryWrapper == nil then
      self._ui.txt_WarType:SetShow(false)
      self._ui.txt_Region:SetShow(false)
    else
      self._ui.txt_WarType:SetShow(true)
      self._ui.txt_Region:SetShow(true)
      siegeTerritoryType = siegeHistoryWrapper:getSiegeTerritoryType()
      if siegeHistoryWrapper:isVilliageSiege() == true then
        if siegeTerritoryType == __eSiegeTerritoryType_Ocean then
          self._ui.txt_WarType:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_WARFAIR_OCEANSIEGEWAR"))
        else
          self._ui.txt_WarType:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_WARFAIR_SIEGEWAR"))
        end
      else
        self._ui.txt_WarType:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_WARFAIR_TERRITORYWAR"))
      end
      local territoryName = ToClient_getTerritoryNameByTerritoryKey(siegeHistoryWrapper:getTerritoryKeyRaw())
      self._ui.txt_Region:SetText(territoryName)
      local siegeResult = siegeHistoryWrapper:isOccupied()
      if siegeResult == 0 then
        self._ui.txt_Result:SetShow(false)
      elseif siegeResult == 1 then
        self._ui.txt_Result:SetShow(true)
        self._ui.txt_Result:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_WARFAIR_FAIL"))
      elseif siegeResult == 2 then
        self._ui.txt_Result:SetShow(true)
        self._ui.txt_Result:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_WARFAIR_SUCCESS"))
      end
    end
  end
  self:showRecordIconBySiegeTerritoryType(siegeTerritoryType)
end
function PaGlobal_GuildWarfareNew_All:updateSiegePersonalRecordList()
  if Panel_GuildWarfareNew_All == nil then
    return
  end
  local myGuildWarfareListInfo = ToClient_GetMyGuildInfoWrapper()
  if myGuildWarfareListInfo == nil then
    return
  end
  self._ui.list2_Warfare:getElementManager():clearKey()
  self:updateSelectTitle()
  if self._currentHistoryListIndex < 0 then
    for key, control in pairs(self._personalDataList) do
      control = nil
    end
    self._personalDataListSize = 0
  end
  if self._currentHistoryListIndex < 0 then
    return
  end
  local data = self._listData[self._currentHistoryListIndex]
  if data == nil then
    return
  end
  if data._type == self._type.eJustToday then
    for key, control in pairs(self._personalDataList) do
      control = nil
    end
    self._personalDataListSize = 0
  elseif data._type == self._type.eProgressing then
    ToClient_refreshProgressingGuildSiegePersonalRecord()
    local progressCount = ToClient_getProgressingGuildSiegePersonalRecordCount()
    for personalIndex = 0, progressCount - 1 do
      local presonalRecordWrapper = ToClient_getProgressingGuildSiegePersonalRecord(personalIndex)
      self._personalDataList[personalIndex] = {
        idx = personalIndex,
        siegeTerritoryType = ToClient_getSiegeTerritoryType(),
        name = presonalRecordWrapper:getUserNickname(),
        userNo = presonalRecordWrapper:getUserNo(),
        death = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeDeath),
        command = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeSiegeSymbol),
        tower = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeSiegeTent),
        master = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeGuildMaster),
        castlegate = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeCastleGate),
        commander = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeSquadCaptain),
        member = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeSquadMember),
        help = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeAssist),
        summons = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeSummon),
        installation = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeInstallation),
        killBySiege = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeKillBySiegeWeapon),
        galleyShip = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeGalleyShip),
        bigShip = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeBigShip),
        carrackShip = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeCarrackShip),
        battleShip = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeBattleShip),
        normalShip = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeNormalShip),
        destroyMyShip = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeDestroyMyShip)
      }
      self._personalDataList[personalIndex].member = self._personalDataList[personalIndex].master + self._personalDataList[personalIndex].commander + self._personalDataList[personalIndex].member + self._personalDataList[personalIndex].killBySiege
    end
    self._personalDataListSize = progressCount
  elseif data._type == self._type.eHistory then
    local siegeHistoryRecordIndex = data._historyIndex
    local personalRecordCount = ToClient_getGuildSiegePersonalRecordCount(siegeHistoryRecordIndex)
    if personalRecordCount == 0 then
      for key, control in pairs(self._personalDataList) do
        control = nil
      end
      self._personalDataListSize = 0
    else
      local historySiegeTerritoryType = __eSiegeTerritoryType_Default
      local siegeHistoryWrapper = ToClient_getGuildSiegeHistoryRecordRecord(siegeHistoryRecordIndex)
      if siegeHistoryWrapper ~= nil then
        historySiegeTerritoryType = siegeHistoryWrapper:getSiegeTerritoryType()
      end
      for personalIndex = 0, personalRecordCount - 1 do
        local presonalRecordWrapper = ToClient_getGuildSiegePersonalRecord(siegeHistoryRecordIndex, personalIndex)
        self._personalDataList[personalIndex] = {
          idx = personalIndex,
          siegeTerritoryType = historySiegeTerritoryType,
          name = presonalRecordWrapper:getUserNickname(),
          userNo = presonalRecordWrapper:getUserNo(),
          death = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeDeath),
          command = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeSiegeSymbol),
          tower = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeSiegeTent),
          master = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeGuildMaster),
          castlegate = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeCastleGate),
          commander = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeSquadCaptain),
          member = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeSquadMember),
          help = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeAssist),
          summons = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeSummon),
          installation = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeInstallation),
          killBySiege = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeKillBySiegeWeapon),
          galleyShip = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeGalleyShip),
          bigShip = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeBigShip),
          carrackShip = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeCarrackShip),
          battleShip = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeBattleShip),
          normalShip = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeNormalShip),
          destroyMyShip = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeDestroyMyShip)
        }
        self._personalDataList[personalIndex].member = self._personalDataList[personalIndex].master + self._personalDataList[personalIndex].commander + self._personalDataList[personalIndex].member + self._personalDataList[personalIndex].killBySiege
      end
      self._personalDataListSize = personalRecordCount
    end
  else
    _PA_LOG("\234\184\184\235\147\156\237\152\132\237\153\169", "\236\157\180\235\159\176 \234\178\189\236\154\176\234\176\128 \236\158\136\236\156\188\235\169\180 \236\149\136\235\144\169\235\139\136\235\139\164.Type :" .. data._type)
  end
  for index = 0, self._personalDataListSize - 1 do
    if self._personalDataList[index] ~= nil then
      self._ui.list2_Warfare:getElementManager():pushKey(toInt64(0, index))
    end
  end
end
function PaGlobal_GuildWarfareNew_All:createListContents(contents, key)
  if Panel_GuildWarfareNew_All == nil then
    return
  end
  contents:SetIgnore(self._isConsole == false)
  if self._currentHistoryListIndex < 0 then
    return
  end
  local index = Int64toInt32(key)
  local dataIdx = self._personalDataList[index].idx
  local txt_CharName = UI.getChildControl(contents, "StaticText_V_CharName")
  local txt_recordValue_1 = UI.getChildControl(contents, "StaticText_RecordValue_1")
  local txt_recordValue_2 = UI.getChildControl(contents, "StaticText_RecordValue_2")
  local txt_recordValue_3 = UI.getChildControl(contents, "StaticText_RecordValue_3")
  local txt_recordValue_4 = UI.getChildControl(contents, "StaticText_RecordValue_4")
  local txt_recordValue_5 = UI.getChildControl(contents, "StaticText_RecordValue_5")
  local txt_recordValue_6 = UI.getChildControl(contents, "StaticText_RecordValue_6")
  local txt_recordValue_7 = UI.getChildControl(contents, "StaticText_RecordValue_7")
  local txt_PlatformIcon = UI.getChildControl(contents, "Static_CrossPlay")
  if self._personalDataList[index].siegeTerritoryType == __eSiegeTerritoryType_Ocean then
    txt_recordValue_1:SetText(self._personalDataList[index].tower)
    txt_recordValue_2:SetText(self._personalDataList[index].galleyShip)
    txt_recordValue_3:SetText(self._personalDataList[index].bigShip)
    txt_recordValue_4:SetText(self._personalDataList[index].carrackShip)
    txt_recordValue_5:SetText(self._personalDataList[index].battleShip)
    txt_recordValue_6:SetText(self._personalDataList[index].normalShip)
    txt_recordValue_7:SetText(self._personalDataList[index].destroyMyShip)
  else
    txt_recordValue_1:SetText(self._personalDataList[index].command)
    txt_recordValue_2:SetText(self._personalDataList[index].tower)
    txt_recordValue_3:SetText(self._personalDataList[index].castlegate)
    txt_recordValue_4:SetText(self._personalDataList[index].summons)
    txt_recordValue_5:SetText(self._personalDataList[index].installation)
    txt_recordValue_6:SetText(self._personalDataList[index].member)
    txt_recordValue_7:SetText(self._personalDataList[index].death)
  end
  txt_CharName:SetText(self._personalDataList[index].name)
  txt_PlatformIcon:SetShow(false)
  if self._personalDataList[index].userNo == getSelfPlayer():get():getUserNo() then
    txt_CharName:SetFontColor(Defines.Color.C_FFEF9C7F)
  else
    txt_CharName:SetFontColor(Defines.Color.C_FFC4BEBE)
  end
  if ToClient_isTotalGameClient() == true then
    local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
    local selfPlayerPlatformType = ToClient_getGamePlatformType()
    local myGuildMemberInfo = myGuildInfo:getMemberByUserNo(self._personalDataList[index].userNo)
    if myGuildMemberInfo == nil then
      myGuildMemberInfo = myGuildInfo:getVolunteerMemberByUserNo(self._personalDataList[index].userNo)
    end
    if myGuildMemberInfo == nil then
      local guildOut = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDMEMBER_WITHDRAW_GUILD")
      txt_CharName:SetText(guildOut)
    else
      local isOnline = myGuildMemberInfo:isOnline()
      local memberPlatformType = myGuildMemberInfo:getPlatformType()
      local platformID
      if isOnline == true and selfPlayerPlatformType == memberPlatformType then
        if ToClient_isPS() == true then
          platformID = " / ( " .. tostring(ToClient_getOnlineId(self._personalDataList[index].userNo)) .. " )"
        elseif ToClient_isXBox() == true then
          platformID = " / ( " .. tostring(ToClient_getXboxGuildUserGamerTag(self._personalDataList[index].userNo)) .. " )"
        end
      end
      if platformID == nil then
        platformID = " / ( - )"
      end
      txt_CharName:SetText(self._personalDataList[index].name .. platformID)
      self:setCrossPlayIcon(txt_PlatformIcon, memberPlatformType, txt_CharName)
    end
  end
  txt_CharName:SetTextMode(__eTextMode_LimitText)
  UI.setLimitTextAndAddTooltip(txt_CharName)
end
function PaGlobal_GuildWarfareNew_All:setCrossPlayIcon(targetControl, platformType, nameControl)
  if Panel_GuildWarfareNew_All == nil then
    return
  end
  if platformType == nil then
    return
  end
  targetControl:SetShow(false)
  if _ContentsGroup_ConsoleIntegration == true then
    targetControl:SetShow(true)
    local selfPlayerPlatform = ToClient_getGamePlatformType()
    if selfPlayerPlatform == platformType then
      if __eGAME_PLATFORM_TYPE_PS == selfPlayerPlatform then
        targetControl:ChangeTextureInfoNameAsync("combine/commonicon/crossplay_icon_ps.dds")
      elseif __eGAME_PLATFORM_TYPE_XB == selfPlayerPlatform then
        targetControl:ChangeTextureInfoNameAsync("combine/commonicon/crossplay_icon_xb.dds")
      end
    else
      targetControl:ChangeTextureInfoNameAsync("combine/commonicon/crossplay_icon_other.dds")
    end
  end
end
function PaGlobal_GuildWarfareNew_All:updateSiegeRecordData()
  if Panel_GuildWarfareNew_All == nil then
    return
  end
  for index = 0, self._listDataSize - 1 do
    if self._listData[index] ~= nil then
      self._listData[index] = nil
    end
  end
  self._listDataSize = 0
  local addCurrentData = false
  local addProgressingSiege = false
  local addHistoryRecord = false
  local addRequestMoreList = false
  if self._currentSiegeHistoryState == self.ENUM_SIEGE_RECORD_COMBOBOX_STATE.NOTPROGRESSING_NODATA_NOLAST then
    addCurrentData = true
    addRequestMoreList = true
  elseif self._currentSiegeHistoryState == self.ENUM_SIEGE_RECORD_COMBOBOX_STATE.NOTPROGRESSING_NODATA then
    addCurrentData = true
  elseif self._currentSiegeHistoryState == self.ENUM_SIEGE_RECORD_COMBOBOX_STATE.NOTPROGRESSING_DATA_NOLAST then
    addHistoryRecord = true
    addRequestMoreList = true
  elseif self._currentSiegeHistoryState == self.ENUM_SIEGE_RECORD_COMBOBOX_STATE.NOTPROGRESSING_DATA_LAST then
    addHistoryRecord = true
  elseif self._currentSiegeHistoryState == self.ENUM_SIEGE_RECORD_COMBOBOX_STATE.PROGRESSING_NOLAST then
    addProgressingSiege = true
    addHistoryRecord = true
    addRequestMoreList = true
  else
    if self._currentSiegeHistoryState == self.ENUM_SIEGE_RECORD_COMBOBOX_STATE.PROGRESSING_LAST then
      addProgressingSiege = true
      addHistoryRecord = true
    else
    end
  end
  if addCurrentData == true then
    local year = ToClient_GetThisYear()
    local month = ToClient_GetThisMonth()
    local day = ToClient_GetToday()
    local yearRear2 = year % 100
    local dayOfWeek = ToClient_GetDayOfWeekYearMonthDay(year, month, day)
    local dayString = self._dayStringList[dayOfWeek]
    local curTimeString = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_BOSSALERT_ALARM_DATE", "year", tostring(yearRear2), "month", tostring(month), "day", tostring(day))
    self._listData[self._listDataSize] = {
      _type = self._type.eJustToday,
      _text = curTimeString .. "(" .. dayString .. ")",
      _siegeScroeNo = nil,
      _historyIndex = -1
    }
    self._listDataSize = self._listDataSize + 1
  end
  if addProgressingSiege == true then
    self._listData[self._listDataSize] = {
      _type = self._type.eProgressing,
      _text = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILDWARFAREINFO"),
      _siegeScroeNo = nil,
      _historyIndex = -1
    }
    self._listDataSize = self._listDataSize + 1
  end
  if addHistoryRecord == true then
    local dataText = ""
    local siegeScoreNo = 0
    local dataHistoryIndex = -1
    local historyRecordCount = ToClient_getGuildSiegeHistoryRecordCount()
    for historyIndex = 0, historyRecordCount - 1 do
      local siegeHistoryWrapper = ToClient_getGuildSiegeHistoryRecordRecord(historyIndex)
      if siegeHistoryWrapper == nil then
        dataText = "---"
      else
        siegeScoreNo = siegeHistoryWrapper:getSiegeScoreNo()
        local isYear = ToClient_getYearFromSiegeScoreNo(siegeScoreNo) % 100
        local isMonth = ToClient_getMonthFromSiegeScoreNo(siegeScoreNo)
        local isDay = ToClient_getDayFromSiegeScoreNo(siegeScoreNo)
        local day = ToClient_getDayOfWeekFromSiegeScroeNo(siegeScoreNo)
        local dayString = self._dayStringList[day]
        local curTimeString = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_BOSSALERT_ALARM_DATE", "year", tostring(isYear), "month", tostring(isMonth), "day", tostring(isDay))
        dataText = curTimeString .. "(" .. dayString .. ")"
      end
      self._listData[self._listDataSize] = {
        _type = self._type.eHistory,
        _text = dataText,
        _siegeScroeNo = siegeScoreNo,
        _historyIndex = historyIndex
      }
      self._listDataSize = self._listDataSize + 1
    end
  end
  if addRequestMoreList == true then
    self._listData[self._listDataSize] = {
      _type = self._type.eRequestHistory,
      _text = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_JOIN_REFRESHLIST"),
      _siegeScroeNo = 0,
      _historyIndex = -1
    }
    self._listDataSize = self._listDataSize + 1
  end
end
function PaGlobal_GuildWarfareNew_All:updateSiegeRecordList()
  if Panel_GuildWarfareNew_All == nil then
    return
  end
  self:updateSiegeRecordState()
  self:updateSiegeRecordData()
  self._ui.list_history:getElementManager():clearKey()
  for index = 0, self._listDataSize - 1 do
    self._ui.list_history:getElementManager():pushKey(index)
  end
end
function PaGlobal_GuildWarfareNew_All:createHistoryListContents(contents, key)
  if Panel_GuildWarfareNew_All == nil then
    return
  end
  local dataSize = self._listDataSize
  if dataSize <= 0 then
    return
  end
  local index = Int64toInt32(key)
  local text = UI.getChildControl(contents, "StaticText_History")
  contents:SetIgnore(false)
  text:SetText(self._listData[index]._text)
  text:SetTextMode(__eTextMode_LimitText)
  UI.setLimitTextAndAddTooltip(text)
  contents:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildWarfareNew_UpdateRecordList(" .. index .. ")")
end
function PaGlobal_GuildWarfareNew_All:validate()
  if Panel_GuildWarfareNew_All == nil then
    return
  end
  self._ui.stc_SelectBG:isValidate()
  self._ui.txt_WarType:isValidate()
  self._ui.txt_Region:isValidate()
  self._ui.txt_Result:isValidate()
  self._ui.btn_Refresh:isValidate()
  self._ui.stc_TopBG:isValidate()
  self._ui.txt_CharName:isValidate()
  self._ui.stc_CommadCenter:isValidate()
  self._ui.stc_Tower:isValidate()
  self._ui.stc_CastleGate:isValidate()
  self._ui.stc_Summons:isValidate()
  self._ui.stc_Installation:isValidate()
  self._ui.stc_Member:isValidate()
  self._ui.stc_Death:isValidate()
  self._ui.stc_OceanTent:isValidate()
  self._ui.stc_GalleyShip:isValidate()
  self._ui.stc_BigShip:isValidate()
  self._ui.stc_CarrackShip:isValidate()
  self._ui.stc_BattleShip:isValidate()
  self._ui.stc_NormalShip:isValidate()
  self._ui.stc_DestroyMyShip:isValidate()
  self._ui.txt_Sort:isValidate()
  self._ui.stc_MainBG:isValidate()
  self._ui.list2_Warfare:isValidate()
  self._ui.list_history:isValidate()
  self._ui.btn_history:isValidate()
end
function PaGlobal_GuildWarfareNew_All:hideSortIcon()
  if Panel_GuildWarfareNew_All == nil then
    return
  end
  self._ui.txt_Sort:SetShow(false)
end
function PaGlobal_GuildWarfareNew_All:setSortIcon(index, isDsce)
  if Panel_GuildWarfareNew_All == nil then
    return
  end
  self._ui.txt_Sort:SetPosX(self._icons[index]:GetPosX() + self._icons[index]:GetSizeX())
  if index == 0 then
    self._ui.txt_Sort:SetFontColor(Defines.Color.C_FFD8AD70)
  else
    self._ui.txt_Sort:SetFontColor(Defines.Color.C_FFFFFFFF)
  end
  if isDsce then
    self._ui.txt_Sort:SetText("\226\150\188")
  else
    self._ui.txt_Sort:SetText("\226\150\178")
  end
  self._ui.txt_Sort:SetShow(true)
end
function PaGlobal_GuildWarfareNew_All:selectSortType(sortType)
  if Panel_GuildWarfareNew_All == nil then
    return
  end
  self._selectedSortType = sortType
  local isDsce
  if sortType == 0 then
    self._isListDescSort.name = not self._isListDescSort.name
    isDsce = self._isListDescSort.name
  elseif sortType == self._eRecordIconType.Icon_CommandCenter then
    self._isListDescSort.command = not self._isListDescSort.command
    isDsce = self._isListDescSort.command
  elseif sortType == self._eRecordIconType.Icon_Tent then
    self._isListDescSort.tower = not self._isListDescSort.tower
    isDsce = self._isListDescSort.tower
  elseif sortType == self._eRecordIconType.Icon_CastleGate then
    self._isListDescSort.castlegate = not self._isListDescSort.castlegate
    isDsce = self._isListDescSort.castlegate
  elseif sortType == self._eRecordIconType.Icon_Summon then
    self._isListDescSort.summons = not self._isListDescSort.summons
    isDsce = self._isListDescSort.summons
  elseif sortType == self._eRecordIconType.Icon_Installation then
    self._isListDescSort.installation = not self._isListDescSort.installation
    isDsce = self._isListDescSort.installation
  elseif sortType == self._eRecordIconType.Icon_Member then
    self._isListDescSort.member = not self._isListDescSort.member
    isDsce = self._isListDescSort.member
  elseif sortType == self._eRecordIconType.Icon_Death then
    self._isListDescSort.death = not self._isListDescSort.death
    isDsce = self._isListDescSort.death
  elseif sortType == self._eRecordIconType.Icon_OceanTent then
    self._isListDescSort.oceanTent = not self._isListDescSort.oceanTent
    isDsce = self._isListDescSort.oceanTent
  elseif sortType == self._eRecordIconType.Icon_GalleyShip then
    self._isListDescSort.galleyShip = not self._isListDescSort.galleyShip
    isDsce = self._isListDescSort.galleyShip
  elseif sortType == self._eRecordIconType.Icon_BigShip then
    self._isListDescSort.bigShip = not self._isListDescSort.bigShip
    isDsce = self._isListDescSort.bigShip
  elseif sortType == self._eRecordIconType.Icon_CarrackShip then
    self._isListDescSort.carrackShip = not self._isListDescSort.carrackShip
    isDsce = self._isListDescSort.carrackShip
  elseif sortType == self._eRecordIconType.Icon_BattleShip then
    self._isListDescSort.battleShip = not self._isListDescSort.battleShip
    isDsce = self._isListDescSort.battleShip
  elseif sortType == self._eRecordIconType.Icon_NormalShip then
    self._isListDescSort.normalShip = not self._isListDescSort.normalShip
    isDsce = self._isListDescSort.normalShip
  elseif sortType == self._eRecordIconType.Icon_DestroyMyShip then
    self._isListDescSort.destroyMyShip = not self._isListDescSort.destroyMyShip
    isDsce = self._isListDescSort.destroyMyShip
  end
  self:setSortIcon(sortType, isDsce)
  self:update()
end
local guildListCompareCommandCenter = function(w1, w2)
  if PaGlobal_GuildWarfareNew_All._isListDescSort.command then
    if w1.command < w2.command then
      return true
    end
  elseif w2.command < w1.command then
    return true
  end
end
local guildListCompareTower = function(w1, w2)
  if PaGlobal_GuildWarfareNew_All._isListDescSort.tower then
    if w1.tower < w2.tower then
      return true
    end
  elseif w2.tower < w1.tower then
    return true
  end
end
local guildListCompareCastleGate = function(w1, w2)
  if PaGlobal_GuildWarfareNew_All._isListDescSort.castlegate then
    if w1.castlegate < w2.castlegate then
      return true
    end
  elseif w2.castlegate < w1.castlegate then
    return true
  end
end
local guildListCompareSummons = function(w1, w2)
  if PaGlobal_GuildWarfareNew_All._isListDescSort.summons then
    if w1.summons < w2.summons then
      return true
    end
  elseif w2.summons < w1.summons then
    return true
  end
end
local guildListCompareInstallation = function(w1, w2)
  if PaGlobal_GuildWarfareNew_All._isListDescSort.installation then
    if w1.installation < w2.installation then
      return true
    end
  elseif w2.installation < w1.installation then
    return true
  end
end
local guildListCompareMember = function(w1, w2)
  if PaGlobal_GuildWarfareNew_All._isListDescSort.member then
    if w1.member < w2.member then
      return true
    end
  elseif w2.member < w1.member then
    return true
  end
end
local guildListCompareDeath = function(w1, w2)
  if PaGlobal_GuildWarfareNew_All._isListDescSort.death then
    if w1.death < w2.death then
      return true
    end
  elseif w2.death < w1.death then
    return true
  end
end
local guildListCompareCharName = function(w1, w2)
  if PaGlobal_GuildWarfareNew_All._isListDescSort.name then
    if w1.name < w2.name then
      return true
    end
  elseif w2.name < w1.name then
    return true
  end
end
local guildListCompareGalleyShip = function(w1, w2)
  if PaGlobal_GuildWarfareNew_All._isListDescSort.galleyShip then
    if w1.galleyShip < w2.galleyShip then
      return true
    end
  elseif w2.galleyShip < w1.galleyShip then
    return true
  end
end
local guildListCompareBigShip = function(w1, w2)
  if PaGlobal_GuildWarfareNew_All._isListDescSort.bigShip then
    if w1.bigShip < w2.bigShip then
      return true
    end
  elseif w2.bigShip < w1.bigShip then
    return true
  end
end
local guildListCompareCarrackShip = function(w1, w2)
  if PaGlobal_GuildWarfareNew_All._isListDescSort.carrackShip then
    if w1.carrackShip < w2.carrackShip then
      return true
    end
  elseif w2.carrackShip < w1.carrackShip then
    return true
  end
end
local guildListCompareBattleShip = function(w1, w2)
  if PaGlobal_GuildWarfareNew_All._isListDescSort.battleShip then
    if w1.battleShip < w2.battleShip then
      return true
    end
  elseif w2.battleShip < w1.battleShip then
    return true
  end
end
local guildListCompareNormalShip = function(w1, w2)
  if PaGlobal_GuildWarfareNew_All._isListDescSort.normalShip then
    if w1.normalShip < w2.normalShip then
      return true
    end
  elseif w2.normalShip < w1.normalShip then
    return true
  end
end
local guildListCompareDestroyMyShip = function(w1, w2)
  if PaGlobal_GuildWarfareNew_All._isListDescSort.destroyMyShip then
    if w1.destroyMyShip < w2.destroyMyShip then
      return true
    end
  elseif w2.destroyMyShip < w1.destroyMyShip then
    return true
  end
end
function PaGlobal_GuildWarfareNew_All:sortDataList()
  if Panel_GuildWarfareNew_All == nil then
    return
  end
  local personalDataListTemp = {}
  for index = 0, self._personalDataListSize - 1 do
    if self._personalDataList[index] ~= nil then
      personalDataListTemp[index + 1] = self._personalDataList[index]
    end
  end
  if self._selectedSortType == 0 then
    table.sort(personalDataListTemp, guildListCompareCharName)
  elseif self._selectedSortType == self._eRecordIconType.Icon_CommandCenter then
    table.sort(personalDataListTemp, guildListCompareCommandCenter)
  elseif self._selectedSortType == self._eRecordIconType.Icon_Tent then
    table.sort(personalDataListTemp, guildListCompareTower)
  elseif self._selectedSortType == self._eRecordIconType.Icon_CastleGate then
    table.sort(personalDataListTemp, guildListCompareCastleGate)
  elseif self._selectedSortType == self._eRecordIconType.Icon_Summon then
    table.sort(personalDataListTemp, guildListCompareSummons)
  elseif self._selectedSortType == self._eRecordIconType.Icon_Installation then
    table.sort(personalDataListTemp, guildListCompareInstallation)
  elseif self._selectedSortType == self._eRecordIconType.Icon_Member then
    table.sort(personalDataListTemp, guildListCompareMember)
  elseif self._selectedSortType == self._eRecordIconType.Icon_Death then
    table.sort(personalDataListTemp, guildListCompareDeath)
  elseif self._selectedSortType == self._eRecordIconType.Icon_OceanTent then
    table.sort(personalDataListTemp, guildListCompareTower)
  elseif self._selectedSortType == self._eRecordIconType.Icon_GalleyShip then
    table.sort(personalDataListTemp, guildListCompareGalleyShip)
  elseif self._selectedSortType == self._eRecordIconType.Icon_BigShip then
    table.sort(personalDataListTemp, guildListCompareBigShip)
  elseif self._selectedSortType == self._eRecordIconType.Icon_CarrackShip then
    table.sort(personalDataListTemp, guildListCompareCarrackShip)
  elseif self._selectedSortType == self._eRecordIconType.Icon_BattleShip then
    table.sort(personalDataListTemp, guildListCompareBattleShip)
  elseif self._selectedSortType == self._eRecordIconType.Icon_NormalShip then
    table.sort(personalDataListTemp, guildListCompareNormalShip)
  elseif self._selectedSortType == self._eRecordIconType.Icon_DestroyMyShip then
    table.sort(personalDataListTemp, guildListCompareDestroyMyShip)
  end
  self._ui.list2_Warfare:getElementManager():clearKey()
  for index = 0, self._personalDataListSize - 1 do
    if personalDataListTemp[index + 1] ~= nil then
      self._personalDataList[index] = personalDataListTemp[index + 1]
      self._ui.list2_Warfare:getElementManager():pushKey(toInt64(0, index))
    end
  end
end
function PaGlobal_GuildWarfareNew_All:initPersonalRecordListSort()
  self._selectedSortType = 0
  self._isListDescSort.name = true
  self:setSortIcon(self._selectedSortType, self._isListDescSort.name)
end
function PaGlobal_GuildWarfareNew_All:showRecordIconBySiegeTerritoryType(siegeTerritoryType)
  if Panel_GuildWarfareNew_All == nil then
    return
  end
  local isOceanSiege = siegeTerritoryType == __eSiegeTerritoryType_Ocean
  self._icons[0]:SetShow(true)
  self._icons[self._eRecordIconType.Icon_CommandCenter]:SetShow(isOceanSiege == false)
  self._icons[self._eRecordIconType.Icon_Tent]:SetShow(isOceanSiege == false)
  self._icons[self._eRecordIconType.Icon_CastleGate]:SetShow(isOceanSiege == false)
  self._icons[self._eRecordIconType.Icon_Summon]:SetShow(isOceanSiege == false)
  self._icons[self._eRecordIconType.Icon_Installation]:SetShow(isOceanSiege == false)
  self._icons[self._eRecordIconType.Icon_Member]:SetShow(isOceanSiege == false)
  self._icons[self._eRecordIconType.Icon_Death]:SetShow(isOceanSiege == false)
  self._icons[self._eRecordIconType.Icon_OceanTent]:SetShow(isOceanSiege == true)
  self._icons[self._eRecordIconType.Icon_GalleyShip]:SetShow(isOceanSiege == true)
  self._icons[self._eRecordIconType.Icon_BigShip]:SetShow(isOceanSiege == true)
  self._icons[self._eRecordIconType.Icon_CarrackShip]:SetShow(isOceanSiege == true)
  self._icons[self._eRecordIconType.Icon_BattleShip]:SetShow(isOceanSiege == true)
  self._icons[self._eRecordIconType.Icon_NormalShip]:SetShow(isOceanSiege == true)
  self._icons[self._eRecordIconType.Icon_DestroyMyShip]:SetShow(isOceanSiege == true)
end
