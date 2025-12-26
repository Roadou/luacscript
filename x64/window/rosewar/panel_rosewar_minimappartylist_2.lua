function PaGlobalFunc_RoseWarMiniMapPartyList_Open(isCallByRoseWarMission)
  local self = PaGlobal_RoseWarMiniMapPartyList
  if self == nil then
    return
  end
  self:prepareOpen()
  PaGlobal_RoseWarMiniMap._ui._chk_togglePartyList:SetCheck(true)
  if isCallByRoseWarMission ~= nil and isCallByRoseWarMission == true then
    self:addEffectToMissionAcceptableParty()
  end
end
function PaGlobalFunc_RoseWarMiniMapPartyList_AddEffectToMissionAcceptableParty()
  local self = PaGlobal_RoseWarMiniMapPartyList
  if self == nil then
    return
  end
  self:addEffectToMissionAcceptableParty()
end
function PaGlobalFunc_RoseWarMiniMapPartyList_Close()
  local self = PaGlobal_RoseWarMiniMapPartyList
  if self == nil then
    return
  end
  self:prepareClose()
  PaGlobal_RoseWarMiniMap._ui._chk_togglePartyList:SetCheck(false)
end
function PaGlobalFunc_RoseWarMiniMapPartyList_IsShow()
  if Panel_RoseWar_MiniMapPartyList == nil then
    return false
  end
  return Panel_RoseWar_MiniMapPartyList:GetShow()
end
function HandleEventLUp_RoseWarMiniMapPartyList_ToggleSimpleMode()
  local self = PaGlobal_RoseWarMiniMapPartyList
  if self == nil then
    return
  end
  if self:isOpenRClickMenu() == true then
    self:closeRClickMenu()
  end
  self:refreshPartyList()
end
function HandleMouseLPress_RoseWarMiniMapPartyList_AlphaSlider()
  local self = PaGlobal_RoseWarMiniMapPartyList
  if self == nil then
    return
  end
  local currentControlPos = self._ui._stc_alphaSlider:GetControlPos()
  if self._lastAlphaSliderControlPos == currentControlPos then
    return
  end
  self:refreshAlphaSlider(currentControlPos)
end
function HandleEventLUp_RoseWarPartyList_SelectParty(partyDataKey)
  local self = PaGlobal_RoseWarMiniMapPartyList
  if self == nil then
    return
  end
  ToClient_AddRoseWarSelectIconListByPartyDataKey(partyDataKey)
  if PaGlobalFunc_RoseWarMission_IsShow() == true then
    PaGlobalFunc_RoseWarMission_AddParty(partyDataKey)
  end
end
function HandleEventRUp_RoseWarPartyList_ToggleRMenu(partyDataKey)
  local self = PaGlobal_RoseWarMiniMapPartyList
  if self == nil then
    return
  end
  if self:isOpenRClickMenu() == true then
    if self._rClickMenuData == nil then
      return
    end
    if self._rClickMenuData._partyDataKey == partyDataKey then
      self:closeRClickMenu()
    else
      self:openRClickMenu(partyDataKey)
    end
  else
    self:openRClickMenu(partyDataKey)
  end
end
function HandleEventOnOut_MiniMapPartyList_ShowRMenuTooltip(isShow, isSimpleMode, partyDataKey)
  local self = PaGlobal_RoseWarMiniMapPartyList
  if self == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  if IsSelfPlayerRoseWarGrade_Commander() == false then
    return
  end
  local control
  local name = ""
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_MINIMAP_PARTYLIST_TOOLTIP")
  if isSimpleMode == true then
    control = nil
  else
    control = nil
  end
  if isSimpleMode == true then
    for index = 0, self._simplePoolCount - 1 do
      local frameControl = self._simpleFrameControlPool[index]
      if frameControl ~= nil and frameControl._isSet == true then
        local partyDataWrapper = ToClient_GetRoseWarPartyDataWrapper(frameControl._partyDataIndex)
        if partyDataWrapper ~= nil and partyDataWrapper:getPartyDataKey() == partyDataKey then
          local isProgressMission = partyDataWrapper:isProgressMission()
          if isProgressMission == true then
            control = frameControl._bg
          end
          break
        end
      end
    end
  else
    for index = 0, self._originalPoolCount - 1 do
      local frameControl = self._originalFrameControlPool[index]
      if frameControl ~= nil and frameControl._isSet == true then
        local partyDataWrapper = ToClient_GetRoseWarPartyDataWrapper(frameControl._partyDataIndex)
        if partyDataWrapper ~= nil and partyDataWrapper:getPartyDataKey() == partyDataKey then
          local isProgressMission = partyDataWrapper:isProgressMission()
          if isProgressMission == true then
            control = frameControl._bg
          end
          break
        end
      end
    end
  end
  if control == nil then
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventLUp_RoseWarMiniMapPartyList_ForceCompleteMission(partyDataKey)
  local self = PaGlobal_RoseWarMiniMapPartyList
  if self == nil then
    return
  end
  if IsSelfPlayerRoseWarGrade_Commander() == false then
    return
  end
  local partyDataWrapper = ToClient_GetRoseWarPartyDataWrapperByKey(partyDataKey)
  if partyDataWrapper == nil then
    return
  end
  if partyDataWrapper:isProgressMission() == false then
    return
  end
  local function requestRoseWarMissionForceComplete()
    ToClient_RequestRoseWarMissionForceComplete(partyDataWrapper:getProgressMissionKey())
    if self:isOpenRClickMenu() == true then
      self:closeRClickMenu()
    end
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ROSEWAR_MISSIONCOMPLETE_FORCE"),
    content = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ROSEWAR_MISSIONCOMPLETE_FORCEDESC"),
    functionYes = requestRoseWarMissionForceComplete,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FromClient_RoseWarMiniMapPartyList_RefreshPartyMissionIcon(partyDataKey)
  local self = PaGlobal_RoseWarMiniMapPartyList
  if self == nil then
    return
  end
  if PaGlobalFunc_RoseWarMiniMapPartyList_IsShow() == false then
    return
  end
  self:refreshPartyMissionIcon(partyDataKey)
end
