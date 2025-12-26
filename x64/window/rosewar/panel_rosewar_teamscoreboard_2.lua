function PaGlobalFunc_RoseWarTeamScoreBoard_Open()
  local self = PaGlobal_RoseWarTeamScoreBoard
  if self == nil then
    return
  end
  ToClient_RequestOpenRoseWarTeamScoreBoardUI()
end
function PaGlobalFunc_RoseWarTeamScoreBoard_Close()
  local self = PaGlobal_RoseWarTeamScoreBoard
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_RoseWarTeamScoreBoard_IsShow()
  local panel = Panel_RoseWar_TeamScoreBoard
  if panel == nil then
    return false
  end
  return panel:GetShow()
end
function PaGlobalFunc_RoseWarTeamScoreBoard_OnCreateListContent(content, key)
  local self = PaGlobal_RoseWarTeamScoreBoard
  if self == nil or content == nil or key == nil then
    return
  end
  self:createScoreContent(content, key)
end
function HandleEventLUp_RoseWarTeamScoreBoard_OnClickedTab(tabType)
  local self = PaGlobal_RoseWarTeamScoreBoard
  if self == nil then
    return
  end
  self:changeTab(tabType)
end
function HandleEventLUp_RoseWarTeamScoreBoard_OnClickedReload()
  local self = PaGlobal_RoseWarTeamScoreBoard
  if self == nil then
    return
  end
  self:changeTab(self._lastSelectedTabType)
end
function HandleEventLUp_RoseWarTeamScoreBoard_OnClickedSort(sortOption)
  local self = PaGlobal_RoseWarTeamScoreBoard
  if self == nil then
    return
  end
  ToClient_SortRoseWarMemberData(self._lastSelectedTeamNo, sortOption)
end
function HandleEventLUp_RoseWarTeamScoreBoard_ComboBoxItem()
  local self = PaGlobal_RoseWarTeamScoreBoard
  if self == nil then
    return
  end
  self:changeTeam(self._ui._cbx_team:GetSelectIndex())
end
function HandleEventLUp_RoseWarTeamScoreBoard_ComboBox()
  local self = PaGlobal_RoseWarTeamScoreBoard
  if self == nil then
    return
  end
  self._ui._cbx_team:ToggleListbox()
end
function FromClient_RoseWarTeamScoreBoard_OnLoadComplete()
  local self = PaGlobal_RoseWarTeamScoreBoard
  if self == nil then
    return
  end
  self:prepareOpen()
end
function FromClient_RoseWarTeamScoreBoard_SortResult(sortOption, isAscending)
  local self = PaGlobal_RoseWarTeamScoreBoard
  if self == nil then
    return
  end
  if PaGlobalFunc_RoseWarTeamScoreBoard_IsShow() == false then
    return
  end
  local addString = ""
  if isAscending == true then
    addString = "\226\150\188"
  else
    addString = "\226\150\178"
  end
  self:resetRecordTitleText()
  if sortOption == __eRoseWarMemberDataSortOption_UserNickName then
    self._ui._stc_name:SetText(self._ui._stc_name:GetText() .. addString)
  elseif sortOption == __eRoseWarMemberDataSortOption_GradeType then
    self._ui._stc_rank:SetText(self._ui._stc_rank:GetText() .. addString)
  elseif sortOption == __eRoseWarMemberDataSortOption_Kill then
    self._ui._stc_kill:SetText(self._ui._stc_kill:GetText() .. addString)
  elseif sortOption == __eRoseWarMemberDataSortOption_Death then
    self._ui._stc_death:SetText(self._ui._stc_death:GetText() .. addString)
  else
    UI.ASSERT_NAME(false, "SortType\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  self:changeTab(self._lastSelectedTabType)
end
