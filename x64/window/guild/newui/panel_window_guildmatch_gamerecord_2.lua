function PaGlobalFunc_GuildMatchGameRecord_Open()
  local self = PaGlobal_GuildMatchGameRecord
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_GuildMatchGameRecord_Close()
  local self = PaGlobal_GuildMatchGameRecord
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_GuildMatchGameRecord_IsShow()
  local panel = Panel_Window_GuildMatch_GameRecord
  if panel == nil then
    return false
  end
  return panel:GetShow()
end
function PaGlobalFunc_GuildMatchGameRecord_OnCreateListContent(content, key)
  local self = PaGlobal_GuildMatchGameRecord
  if self == nil or content == nil or key == nil then
    return
  end
  self:createPersonalRecordContent(content, key)
end
function HandleEventLUp_GuildMatchGameRecord_UpdateRecordList()
  local self = PaGlobal_GuildMatchGameRecord
  if self == nil then
    return
  end
  ToClient_ClearGuildMatchPersonalRecordSortInfo()
  self:resetRecordTitleText(nil)
  self._currentGameIndex = self._ui._cbx_gameList:GetSelectIndex()
  self:updateRecordList()
end
function HandleEventLUp_GuildMatchGameRecord_ToggleComboBox()
  local self = PaGlobal_GuildMatchGameRecord
  if self == nil then
    return
  end
  self._ui._cbx_gameList:ToggleListbox()
end
function HandleEventLUp_GuildMatchGameRecord_UpdateList()
  local self = PaGlobal_GuildMatchGameRecord
  if self == nil then
    return
  end
  self:updateRecordList()
end
function HandleEventLUp_GuildMatchGameRecord_Sort(guildIndex, sortType)
  local self = PaGlobal_GuildMatchGameRecord
  if self == nil then
    return
  end
  ToClient_SortGuildMatchPersonalRecord(self._currentGameIndex, guildIndex, sortType)
end
function HandleEventLUp_GuildMatchGameRecord_ShowLimitTextToolTip(isShow, isMyGuild, index)
  local self = PaGlobal_GuildMatchGameRecord
  if self == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local control
  if isMyGuild == true then
    if index == 1 then
      control = self._ui._stc_myGuild_killDeath
    elseif index == 2 then
      control = self._ui._stc_myGuild_heal
    elseif index == 3 then
      control = self._ui._stc_myGuild_takeDamage
    elseif index == 4 then
      control = self._ui._stc_myGuild_giveDamage
    elseif index == 5 then
      control = self._ui._stc_myGuild_ccCount
    end
  elseif index == 1 then
    control = self._ui._stc_enemyGuild_killDeath
  elseif index == 2 then
    control = self._ui._stc_enemyGuild_heal
  elseif index == 3 then
    control = self._ui._stc_enemyGuild_takeDamage
  elseif index == 4 then
    control = self._ui._stc_enemyGuild_giveDamage
  elseif index == 5 then
    control = self._ui._stc_enemyGuild_ccCount
  end
  if control ~= nil then
    TooltipSimple_Show(control, control:GetText(), "")
  end
end
function FromClient_GuildMatchPersonalRecordSortResult(guildIndex, sortType, isAscending)
  local self = PaGlobal_GuildMatchGameRecord
  if self == nil then
    return
  end
  local isMyGuild = guildIndex == 0
  local addString = ""
  if isAscending == true then
    addString = "\226\150\188"
  else
    addString = "\226\150\178"
  end
  self:resetRecordTitleText(guildIndex)
  if sortType == __eGuildMatchPersonalRecordSortOption_KillDeath then
    if isMyGuild == true then
      self._ui._stc_myGuild_killDeath:SetText(self._ui._stc_myGuild_killDeath:GetText() .. addString)
    else
      self._ui._stc_enemyGuild_killDeath:SetText(self._ui._stc_enemyGuild_killDeath:GetText() .. addString)
    end
  elseif sortType == __eGuildMatchPersonalRecordSortOption_Recovery then
    if isMyGuild == true then
      self._ui._stc_myGuild_heal:SetText(self._ui._stc_myGuild_heal:GetText() .. addString)
    else
      self._ui._stc_enemyGuild_heal:SetText(self._ui._stc_enemyGuild_heal:GetText() .. addString)
    end
  elseif sortType == __eGuildMatchPersonalRecordSortOption_TakeDamage then
    if isMyGuild == true then
      self._ui._stc_myGuild_takeDamage:SetText(self._ui._stc_myGuild_takeDamage:GetText() .. addString)
    else
      self._ui._stc_enemyGuild_takeDamage:SetText(self._ui._stc_enemyGuild_takeDamage:GetText() .. addString)
    end
  elseif sortType == __eGuildMatchPersonalRecordSortOption_GiveDamage then
    if isMyGuild == true then
      self._ui._stc_myGuild_giveDamage:SetText(self._ui._stc_myGuild_giveDamage:GetText() .. addString)
    else
      self._ui._stc_enemyGuild_giveDamage:SetText(self._ui._stc_enemyGuild_giveDamage:GetText() .. addString)
    end
  elseif sortType == __eGuildMatchPersonalRecordSortOption_CCCount then
    if isMyGuild == true then
      self._ui._stc_myGuild_ccCount:SetText(self._ui._stc_myGuild_ccCount:GetText() .. addString)
    else
      self._ui._stc_enemyGuild_ccCount:SetText(self._ui._stc_enemyGuild_ccCount:GetText() .. addString)
    end
  else
    UI.ASSERT_NAME(false, "SortType\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  if isMyGuild == true then
    self:updateMyGuildRecordList()
  else
    self:updateEnemyGuildRecordList()
  end
end
