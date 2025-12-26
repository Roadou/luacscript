function HandleEventLUp_GuildWarfareNew_IconToolTip_Show(iconNo, isOn)
  local self = PaGlobal_GuildWarfareNew_All
  if self == nil then
    return
  end
  local mouse_posX = getMousePosX()
  local mouse_posY = getMousePosY()
  local panel_posX = PaGlobal_GuildMain_All._ui.stc_Warfare_Bg:GetParentPosX()
  local panel_posY = PaGlobal_GuildMain_All._ui.stc_Warfare_Bg:GetParentPosY()
  if iconNo == self._eRecordIconType.Icon_CommandCenter then
    self._ui.txt_IconHelper:SetShow(true)
    self._ui.txt_IconHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TXT_WARFARE_HELP_COMMAND"))
  elseif iconNo == self._eRecordIconType.Icon_Tent then
    self._ui.txt_IconHelper:SetShow(true)
    self._ui.txt_IconHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TXT_WARFARE_HELP_TOWER"))
  elseif iconNo == self._eRecordIconType.Icon_CastleGate then
    self._ui.txt_IconHelper:SetShow(true)
    self._ui.txt_IconHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TXT_WARFARE_HELP_DOOR"))
  elseif iconNo == self._eRecordIconType.Icon_Summon then
    self._ui.txt_IconHelper:SetShow(true)
    self._ui.txt_IconHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TXT_WARFARE_HELP_SUMMON"))
  elseif iconNo == self._eRecordIconType.Icon_Installation then
    self._ui.txt_IconHelper:SetShow(true)
    self._ui.txt_IconHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TXT_WARFARE_HELP_OBJECT"))
  elseif iconNo == self._eRecordIconType.Icon_Member then
    self._ui.txt_IconHelper:SetShow(true)
    self._ui.txt_IconHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TXT_WARFARE_HELP_MEMBER"))
  elseif iconNo == self._eRecordIconType.Icon_Death then
    self._ui.txt_IconHelper:SetShow(true)
    self._ui.txt_IconHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TXT_WARFARE_HELP_DEATH"))
  elseif iconNo == self._eRecordIconType.Icon_OceanTent then
    self._ui.txt_IconHelper:SetShow(true)
    self._ui.txt_IconHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TXT_WARFARE_HELP_OCEANTENT"))
  elseif iconNo == self._eRecordIconType.Icon_GalleyShip then
    self._ui.txt_IconHelper:SetShow(true)
    self._ui.txt_IconHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TXT_WARFARE_HELP_GALLEYSHIP"))
  elseif iconNo == self._eRecordIconType.Icon_BigShip then
    self._ui.txt_IconHelper:SetShow(true)
    self._ui.txt_IconHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TXT_WARFARE_HELP_BIGSHIP"))
  elseif iconNo == self._eRecordIconType.Icon_CarrackShip then
    self._ui.txt_IconHelper:SetShow(true)
    self._ui.txt_IconHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TXT_WARFARE_HELP_CARRACKSHIP"))
  elseif iconNo == self._eRecordIconType.Icon_BattleShip then
    self._ui.txt_IconHelper:SetShow(true)
    self._ui.txt_IconHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TXT_WARFARE_HELP_BATTLESHIP"))
  elseif iconNo == self._eRecordIconType.Icon_NormalShip then
    self._ui.txt_IconHelper:SetShow(true)
    self._ui.txt_IconHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TXT_WARFARE_HELP_NORMALSHIP"))
  elseif iconNo == self._eRecordIconType.Icon_DestroyMyShip then
    self._ui.txt_IconHelper:SetShow(true)
    self._ui.txt_IconHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TXT_WARFARE_HELP_DESTROYMYSHIP"))
  end
  self._ui.txt_IconHelper:SetSize(self._ui.txt_IconHelper:GetTextSizeX() + 20, self._ui.txt_IconHelper:GetSizeY())
  self._ui.txt_IconHelper:SetPosX(mouse_posX - panel_posX)
  self._ui.txt_IconHelper:SetPosY(mouse_posY - panel_posY + 15)
  self._ui.txt_IconHelper:SetShow(isOn)
end
function HandleEventLUp_GuildWarfareNew_Select_SortType(sortType)
  PaGlobal_GuildWarfareNew_All:selectSortType(sortType)
end
function PaGlobalFunc_GuildWarfareNew_All_Update()
  local self = PaGlobal_GuildWarfareNew_All
  if self == nil then
    return
  end
  local isShowList = self._ui.list_history:GetShow()
  if isShowList == true then
    self._ui.btn_history:SetCheck(false)
    self._ui.list_history:SetShow(false)
    ToClient_padSnapChangeToTarget(self._ui.btn_history)
  end
  PaGlobal_GuildWarfareNew_All:initPersonalRecordListSort()
  PaGlobal_GuildWarfareNew_All:update()
  ToClient_padSnapChangeToTarget(PaGlobal_GuildWarfareNew_All._ui.btn_history)
  PaGlobal_GuildWarfareNew_All_ResetScrollData()
  if self._currentHistoryListIndex ~= 0 then
    self._currentHistoryListIndex = 0
    self:onChangeSiegeRecordListSelect()
  end
  if self._isFirstOpenTab == true then
    self._isFirstOpenTab = false
    ToClient_reqestRecentSiegeHistory()
  end
end
function PaGlobalFunc_GuildWarfareNew_All_ResetAll()
  local self = PaGlobal_GuildWarfareNew_All
  if self == nil then
    return
  end
  self._isFirstOpenTab = true
  local isShow = false
  if nil ~= Panel_GuildWarfareNew_All then
    isShow = Panel_GuildWarfareNew_All:GetShow()
  end
  if isShow == true then
    PaGlobalFunc_GuildWarfareNew_All_Update()
  end
end
function PaGlobal_GuildWarfareNew_CreateContents_All(contents, key)
  PaGlobal_GuildWarfareNew_All:createListContents(contents, key)
end
function PaGlobal_GuildWarfareNew_All_HistoryList(contents, key)
  PaGlobal_GuildWarfareNew_All:createHistoryListContents(contents, key)
end
function PaGlobal_GuildWarfareNew_All_ResetScrollData()
  PaGlobal_GuildWarfareNew_All._scrollData._pos = nil
  PaGlobal_GuildWarfareNew_All._scrollData._idx = nil
end
function PaGlobal_GuildWarfare_All_SaveScrollData()
  PaGlobal_GuildWarfareNew_All._scrollData._pos = PaGlobal_GuildWarfareNew_All._ui.list2_Warfare:GetVScroll():GetControlPos()
  PaGlobal_GuildWarfareNew_All._scrollData._idx = PaGlobal_GuildWarfareNew_All._ui.list2_Warfare:getCurrenttoIndex()
end
function PaGlobal_GuildWarfareNew_All_LoadScrollData()
  if nil == PaGlobal_GuildWarfareNew_All._scrollData._pos or nil == PaGlobal_GuildWarfareNew_All._scrollData._idx then
    return
  end
  PaGlobal_GuildWarfareNew_All._ui.list2_Warfare:GetVScroll():SetControlPos(PaGlobal_GuildWarfareNew_All._scrollData._pos)
  PaGlobal_GuildWarfareNew_All._ui.list2_Warfare:setCurrenttoIndex(PaGlobal_GuildWarfareNew_All._scrollData._idx)
end
function PaGlobal_GuildWarfareNew_All_ProgressingScoreUpdate()
  local self = PaGlobal_GuildWarfareNew_All
  if self == nil then
    return
  end
  if self._currentHistoryListIndex < 0 then
    return
  end
  local data = self._listData[self._currentHistoryListIndex]
  if data == nil then
    return
  end
  if data._type ~= self._type.eProgressing then
    return
  end
  self:updateSiegePersonalRecordList()
  self:sortDataList()
  PaGlobal_GuildWarfareNew_All_LoadScrollData()
end
function HandleEventLUp_GuildWarfareNew_UpdateRecordList(key)
  local self = PaGlobal_GuildWarfareNew_All
  if self == nil then
    return
  end
  local index = Int64toInt32(key)
  if self._currentHistoryListIndex == index then
    PaGlobal_GuildWarfare_All_ToggleList()
    return
  end
  self._currentHistoryListIndex = index
  self:onChangeSiegeRecordListSelect()
  PaGlobal_GuildWarfare_All_ToggleList()
end
function PaGlobal_GuildWarfareNew_All_HistoryRefresh()
  local self = PaGlobal_GuildWarfareNew_All
  if self == nil then
    return
  end
  ToClient_reqestNewestSiegeHistory()
end
function PaGlobal_GuildWarfareNew_All_HistoryResult()
  local self = PaGlobal_GuildWarfareNew_All
  if self == nil then
    return
  end
  local siegeTerritoryType = __eSiegeTerritoryType_Default
  local data = self._listData[self._currentHistoryListIndex]
  if data ~= nil and data._type == self._type.eHistory then
    local siegeHistoryRecordIndex = data._historyIndex
    local siegeHistoryWrapper = ToClient_getGuildSiegeHistoryRecordRecord(siegeHistoryRecordIndex)
    if siegeHistoryWrapper ~= nil then
      siegeTerritoryType = siegeHistoryWrapper:getSiegeTerritoryType()
    end
  end
  local currentHistoryListIndex = self._currentHistoryListIndex
  if self._currentSiegeHistoryState == self.ENUM_SIEGE_RECORD_COMBOBOX_STATE.PROGRESSING_NOLAST or self._currentSiegeHistoryState == self.ENUM_SIEGE_RECORD_COMBOBOX_STATE.PROGRESSING_LAST then
    currentHistoryListIndex = self._currentHistoryListIndex - 1
  end
  if siegeTerritoryType == __eSiegeTerritoryType_Ocean then
    PaGlobalFunc_OceanSiegeResult_All_Open(true, currentHistoryListIndex)
  else
    PaGlobalFunc_SiegeResult_All_Open(true, currentHistoryListIndex)
  end
end
function PaGlobal_GuildWarfareNew_All_HistoryRecordUpdate()
  local self = PaGlobal_GuildWarfareNew_All
  if self == nil then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_WARFAREINFO_NOTICE_REFRESH"))
  self._currentHistoryListIndex = -1
  PaGlobalFunc_GuildWarfareNew_All_Update()
end
function PaGlobal_GuildWarfareNew_All_PersonalRecordUpdate()
  local self = PaGlobal_GuildWarfareNew_All
  if self == nil then
    return
  end
  self:updateSiegePersonalRecordList()
  self:sortDataList()
  PaGlobal_GuildWarfare_All_LoadScrollData()
end
function HandleEventOnOut_GuildWarfareNew_All_RefershShowTooltip(isShow)
  if nil == isShow then
    TooltipSimple_Hide()
    return
  end
  local control, name, desc
  control = Panel_GuildWarfareNew_All
  name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_WARFAREINFO_REFRESH_BTN")
  desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_WARFAREINFO_REFRESH_DESC")
  if isShow == true then
    TooltipSimple_Show(control, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function PaGlobal_GuildWarfare_All_ToggleList()
  local self = PaGlobal_GuildWarfareNew_All
  if self == nil then
    return
  end
  local isShowList = self._ui.list_history:GetShow()
  if isShowList == true then
    self._ui.btn_history:SetCheck(false)
    self._ui.list_history:SetShow(false)
    ToClient_padSnapChangeToTarget(self._ui.btn_history)
  else
    self._ui.btn_history:SetCheck(true)
    self._ui.list_history:SetShow(true)
    ToClient_padSnapChangeToTarget(self._ui.list_history)
  end
end
