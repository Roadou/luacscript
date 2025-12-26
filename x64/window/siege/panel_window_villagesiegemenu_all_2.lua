function PaGlobalFunc_VillageSiegeMenu_Open()
  local self = PaGlobal_VillageSiegeMenu
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_VillageSiegeMenu_Close()
  local self = PaGlobal_VillageSiegeMenu
  if self == nil then
    return
  end
  self:prepareClose()
end
function HandleEventLUp_VillageSiegeMenu_ChangeSiegeTerritoryType(siegeTerritoryType)
  local self = PaGlobal_VillageSiegeMenu
  if self == nil then
    return
  end
  self:changeTab(self._currentTabType, siegeTerritoryType)
end
function HandleEventLUp_VillageSiegeMenu_ApplyOrCancel(groupType)
  local self = PaGlobal_VillageSiegeMenu
  if self == nil then
    return
  end
  local currentGroupNo = ToClient_GetParicipateGroupNoVillageSiege2024()
  local currentTerritoryRaw = ToClient_GetParicipateTerritoryKeyVillageSiege2024()
  local isParticipated = currentGroupNo >= 0 and currentTerritoryRaw == ToClient_GetNotMatchedTerritoryKeySiege()
  if isParticipated == true then
    ToClient_RequestCancelParicipateVillageSiege2024(groupType)
  else
    ToClient_RequestParicipateVillageSiege2024(groupType)
  end
end
function HandleEventLUp_VillageSiegeMenu_ApplyOrCancelOceanSiege(groupType)
  local self = PaGlobal_VillageSiegeMenu
  if self == nil then
    return
  end
  local currentGroupNo = ToClient_GetParicipateGroupNoOceanSiege()
  local currentTerritoryRaw = ToClient_GetParicipateTerritoryKeyOceanSiege()
  local isParticipated = currentGroupNo >= 0 and currentTerritoryRaw == ToClient_GetNotMatchedTerritoryKeySiege()
  if isParticipated == true then
    ToClient_RequestCancelParicipateOceanSiege(groupType)
  else
    ToClient_RequestParicipateOceanSiege(groupType)
  end
end
function HandleEventOnOut_VillageSiegeMenu_ApplyOrCancel(isOn, isOceanSiege, groupType, territoryKeyRaw)
  local self = PaGlobal_VillageSiegeMenu
  if self == nil then
    return
  end
  local territoryParticipationData = self:getTerritoryParticipationData(groupType)
  if territoryParticipationData == nil then
    return
  end
  if isOn == true then
    self:changeTexture(territoryParticipationData._control, "Combine_Etc_StrongholdWar_CampBG_Select", 0)
    self:showFocusGroup(isOceanSiege, groupType, territoryKeyRaw)
  else
    self:changeTexture(territoryParticipationData._control, "Combine_Etc_StrongholdWar_CampBG_Normal", 0)
    self:showFocusGroup(isOceanSiege, nil, territoryKeyRaw)
  end
end
function HandleEventLUp_VillageSiegeMenu_ApplyOrCancelForDevXXXXX(groupType, territoryKeyRaw)
  local self = PaGlobal_VillageSiegeMenu
  if self == nil then
    return
  end
  local self = PaGlobal_VillageSiegeMenu
  if self == nil then
    return
  end
  if ToClient_IsDevelopment() == false and isRealServiceMode() == true then
    return
  end
  local function do_join()
    ToClient_RequestParicipateVillageSiege2024ForQA(groupType, territoryKeyRaw)
  end
  local function do_unjoin()
    ToClient_RequestCancelParicipateVillageSiege2024ForQA(groupType, territoryKeyRaw)
  end
  local descString = ""
  local functionYes
  local currentGroupNo = ToClient_GetParicipateGroupNoVillageSiege2024()
  local currentTerritoryRaw = ToClient_GetParicipateTerritoryKeyVillageSiege2024()
  local isParticipated = currentGroupNo >= 0 and currentTerritoryRaw >= 0
  if isParticipated == true then
    descString = "[DEV] (\234\177\176\236\160\144\236\160\132) \236\132\160\237\131\157\237\149\156 \236\152\129\236\167\128\235\161\156 \236\139\160\236\178\173 \236\183\168\236\134\140 \237\149\152\236\139\156\234\178\160\236\138\181\235\139\136\234\185\140?"
    functionYes = do_unjoin
  else
    descString = "[DEV] (\234\177\176\236\160\144\236\160\132) \236\132\160\237\131\157\237\149\156 \236\152\129\236\167\128\235\161\156 \236\176\184\236\151\172 \236\139\160\236\178\173 \237\149\152\236\139\156\234\178\160\236\138\181\235\139\136\234\185\140?"
    functionYes = do_join
  end
  local messageboxData = {
    title = "[DEV] (\234\177\176\236\160\144\236\160\132) \234\176\156\235\176\156\236\154\169 \234\184\176\235\138\165",
    content = descString,
    functionYes = functionYes,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW,
    exitButton = true
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_VillageSiegeMenu_ApplyOrCancelOceanSieceForDevXXXXX(groupType, territoryKeyRaw)
  local self = PaGlobal_VillageSiegeMenu
  if self == nil then
    return
  end
  local self = PaGlobal_VillageSiegeMenu
  if self == nil then
    return
  end
  if ToClient_IsDevelopment() == false and isRealServiceMode() == true then
    return
  end
  local function do_join()
    ToClient_RequestParicipateOceanSiegeForQA(groupType, territoryKeyRaw)
  end
  local function do_unjoin()
    ToClient_RequestCancelParicipateOceanSiege2024ForQA(groupType, territoryKeyRaw)
  end
  local descString = ""
  local functionYes
  local currentGroupNo = ToClient_GetParicipateGroupNoOceanSiege()
  local currentTerritoryRaw = ToClient_GetParicipateTerritoryKeyOceanSiege()
  local isParticipated = currentGroupNo >= 0 and currentTerritoryRaw >= 0
  if isParticipated == true then
    descString = "[DEV] (\237\145\184\235\165\184 \236\160\132\236\158\165) \236\132\160\237\131\157\237\149\156 \236\152\129\236\167\128\235\161\156 \236\139\160\236\178\173 \236\183\168\236\134\140 \237\149\152\236\139\156\234\178\160\236\138\181\235\139\136\234\185\140?"
    functionYes = do_unjoin
  else
    descString = "[DEV] (\237\145\184\235\165\184 \236\160\132\236\158\165) \236\132\160\237\131\157\237\149\156 \236\152\129\236\167\128\235\161\156 \236\176\184\236\151\172 \236\139\160\236\178\173 \237\149\152\236\139\156\234\178\160\236\138\181\235\139\136\234\185\140?"
    functionYes = do_join
  end
  local messageboxData = {
    title = "[DEV] (\237\145\184\235\165\184 \236\160\132\236\158\165) \234\176\156\235\176\156\236\154\169 \234\184\176\235\138\165",
    content = descString,
    functionYes = functionYes,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW,
    exitButton = true
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_VillageSiegeMenu_StartSiegeForQA()
  local self = PaGlobal_VillageSiegeMenu
  if self == nil then
    return
  end
  if ToClient_IsDevelopment() == false and isRealServiceMode() == true then
    return
  end
  ToClient_StartSiege2024ForQA()
end
function HandleEventLUp_VillageSiegeMenu_StopSiegeForQA()
  local self = PaGlobal_VillageSiegeMenu
  if self == nil then
    return
  end
  if ToClient_IsDevelopment() == false and isRealServiceMode() == true then
    return
  end
  ToClient_StopSiege2024ForQA()
end
function HandleEventLUp_VillageSiegeMenu_ResetApplyCountForQA()
  local self = PaGlobal_VillageSiegeMenu
  if self == nil then
    return
  end
  if ToClient_IsDevelopment() == false and isRealServiceMode() == true then
    return
  end
  ToClient_ResetApplyCountSiege2024ForQA()
end
function HandleEventLUp_VillageSiegeMenu_ResetApplyCountAllForQA()
  local self = PaGlobal_VillageSiegeMenu
  if self == nil then
    return
  end
  if ToClient_IsDevelopment() == false and isRealServiceMode() == true then
    return
  end
  ToClient_ResetApplyCountAllSiege2024ForQA()
end
function HandleEventLUp_VillageSiegeMenu_ChangeSiegeApplyNeedCountForQA()
  local self = PaGlobal_VillageSiegeMenu
  if self == nil then
    return
  end
  if ToClient_IsDevelopment() == false and isRealServiceMode() == true then
    return
  end
  ToClient_ChangeSiegeApplyNeedCountSiege2024ForQA()
end
function HandleEventLBRB_VillageSiegeMenu_ChangeTabByPadMode(isLeft)
  local self = PaGlobal_VillageSiegeMenu
  if self == nil or isLeft == nil then
    return
  end
  local currentTabType = self._currentTabType
  local tabTypeMin = self._eTabType.APPLY
  local tabTypeMax = self._eTabType.APPLY_LIST
  if isLeft == true then
    currentTabType = currentTabType - 1
  else
    currentTabType = currentTabType + 1
  end
  if tabTypeMin > currentTabType then
    currentTabType = tabTypeMin
  elseif tabTypeMax < currentTabType then
    currentTabType = tabTypeMax
  end
  self:changeTab(currentTabType, nil)
end
function FromClient_UpdateVillageSiegeMenuUI()
  local self = PaGlobal_VillageSiegeMenu
  if self == nil then
    return
  end
  if Panel_Window_VillageSiegeMenu_All:GetShow() == false then
    return
  end
  if self._currentTabType == self._eTabType.APPLY then
    self:refreshApplyScene()
  elseif self._currentTabType == self._eTabType.APPLY_LIST then
    self:refreshApplyListScene()
  else
    return
  end
end
function FromClient_SetMinorSiege(minorSiegeMode, guildOrAllianceName)
  local self = PaGlobal_VillageSiegeMenu
  if self == nil then
    return
  end
  for key, value in pairs(self._territoryParticipationList) do
    if value ~= nil then
      local siegeOptionStatic = ToClient_GetSiegeTerritoryOptionStaticStatusWrapper(value._groupType)
      if siegeOptionStatic ~= nil then
        local limitADString = ""
        if ToClient_GetMinorSiegeModeByGroupNo(value._groupType) == __eMinorSiegeModeOccupy then
          limitADString = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_VILLAGESIEGEMENU_PROGRESSDESC", "way", PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MSGBOX_RADIOBTN_SIEGE_1"))
        else
          limitADString = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_VILLAGESIEGEMENU_PROGRESSDESC", "way", PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MSGBOX_RADIOBTN_SIEGE_2"))
        end
        value._txt_limitAD:SetText(limitADString)
      end
    end
  end
  if guildOrAllianceName ~= nil then
    local siegeWay = ""
    if minorSiegeMode == __eMinorSiegeModeOccupy then
      siegeWay = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MSGBOX_RADIOBTN_SIEGE_1")
    elseif minorSiegeMode == __eMinorSiegeModeBuilding then
      siegeWay = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MSGBOX_RADIOBTN_SIEGE_2")
    end
    local mainStr = PAGetStringParam2(Defines.StringSheet_RESOURCE, "PANEL_VILLAGESIEGEMENU_CHANGEMETHOD", "guildname", guildOrAllianceName, "way", siegeWay)
    ToClient_RequestNakMessageRenewelWithString(__eNakMessage_SiegeChangeThod, mainStr)
  end
end
function HandleEventLUp_VillageSiegeMenu_SetMinorSiedeMode()
  local self = PaGlobal_VillageSiegeMenu
  if self == nil then
    return
  end
  if self._ui._rdo_before:IsCheck() == true then
    ToClient_SetMinorSiegeMode(__eMinorSiegeModeBuilding)
  elseif self._ui._rdo_current:IsCheck() == true then
    ToClient_SetMinorSiegeMode(__eMinorSiegeModeOccupy)
  end
  self._ui._stc_selectedBg:SetShow(false)
end
function HandleEventLUp_VillageSiegeMenu_OpenOrCloseMinorSiegeMode(isShow)
  local self = PaGlobal_VillageSiegeMenu
  if self == nil then
    return
  end
  self._ui._stc_selectedBg:SetShow(isShow)
  if isShow == true then
    self._ui._rdo_before:SetCheck(false)
    self._ui._rdo_current:SetCheck(false)
  end
end
function PaGlobal_VillageSiegeMenu_Tooltip(isShow)
  if isShow == true then
    local name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_VILLAGESIEGEMENU_BTN_CHANGE")
    TooltipSimple_Show(PaGlobal_VillageSiegeMenu._ui._btn_Change, name, desc)
  else
    TooltipSimple_Hide()
  end
end
