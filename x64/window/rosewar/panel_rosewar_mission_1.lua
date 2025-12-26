function PaGlobal_RoseWarMission:initialize()
  if self._initialize == true then
    return
  end
  self._ui._stc_titleArea = UI.getChildControl(Panel_RoseWar_Mission, "Static_TitleArea")
  self._ui._btn_close = UI.getChildControl(self._ui._stc_titleArea, "Button_Close")
  self._ui._stc_mainArea = UI.getChildControl(Panel_RoseWar_Mission, "Static_ContentsArea")
  local missionTypeArea = UI.getChildControl(self._ui._stc_mainArea, "Static_MissionType")
  self._ui._btn_missionTypeAttack = UI.getChildControl(missionTypeArea, "RadioButton_Type1")
  self._ui._btn_missionTypeDefense = UI.getChildControl(missionTypeArea, "RadioButton_Type2")
  self._ui._btn_missionTypeKill = UI.getChildControl(missionTypeArea, "RadioButton_Type3")
  local missionConditionArea = UI.getChildControl(self._ui._stc_mainArea, "Static_MissionCondition")
  self._ui._txt_missionLimitTime = UI.getChildControl(missionConditionArea, "StaticText_LimitTime")
  self._ui._txt_missionRewardCount = UI.getChildControl(missionConditionArea, "StaticText_RoseWarCoin")
  self._ui._btn_createMission = UI.getChildControl(self._ui._stc_mainArea, "Button_MissionDirection")
  self._ui._cbx_target = UI.getChildControl(self._ui._stc_mainArea, "Combobox2_Target")
  self._ui._stc_targetList = UI.getChildControl(self._ui._cbx_target, "Combobox_1_List")
  self._ui._txt_missionRewardCount:SetIgnore(false)
  self:createAddPartyButtonDataList()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_RoseWarMission:activateTargetComboBox(missionType)
  if Panel_RoseWar_Mission == nil then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local selfPlayerTeamNo = selfPlayerWrapper:getRoseWarTeamNo()
  local initSelectIndex = 0
  self._ui._cbx_target:GetListControl():AddSelectEvent("HandleEventLUp_RoseWarMission_SelectTarget()")
  self._ui._cbx_target:DeleteAllItem(0)
  self._ui._cbx_target:setListTextHorizonCenter()
  if self._selectedMissionType == __eRoseWarMissionType_FierceAttack then
    local targetCount = ToClient_GetRoseWarFierceBattleObjectCount()
    local findIndex = 0
    for index = 0, targetCount - 1 do
      local fierceBattleObjectInfoWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapperByIndex(index)
      if fierceBattleObjectInfoWrapper ~= nil and selfPlayerTeamNo ~= fierceBattleObjectInfoWrapper:getTeamNo() and ToClient_IsRoseWarGimicFierceBattle(fierceBattleObjectInfoWrapper:getCharacterKeyRaw()) == false then
        self._ui._cbx_target:AddItem(fierceBattleObjectInfoWrapper:getName())
        if self._selectedTargetFierceBattleKeyRaw ~= nil and self._selectedTargetFierceBattleKeyRaw == fierceBattleObjectInfoWrapper:getFierceBattleKeyRaw() then
          initSelectIndex = findIndex
        end
        findIndex = findIndex + 1
      end
    end
  elseif self._selectedMissionType == __eRoseWarMissionType_FierceDefence then
    local targetCount = ToClient_GetRoseWarFierceBattleObjectCount()
    local findIndex = 0
    for index = 0, targetCount - 1 do
      local fierceBattleObjectInfoWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapperByIndex(index)
      if fierceBattleObjectInfoWrapper ~= nil and selfPlayerTeamNo == fierceBattleObjectInfoWrapper:getTeamNo() and ToClient_IsRoseWarGimicFierceBattle(fierceBattleObjectInfoWrapper:getCharacterKeyRaw()) == false then
        self._ui._cbx_target:AddItem(fierceBattleObjectInfoWrapper:getName())
        if self._selectedTargetFierceBattleKeyRaw ~= nil and self._selectedTargetFierceBattleKeyRaw == fierceBattleObjectInfoWrapper:getFierceBattleKeyRaw() then
          initSelectIndex = findIndex
        end
        findIndex = findIndex + 1
      end
    end
  elseif self._selectedMissionType == __eRoseWarMissionType_Kill then
    self._ui._cbx_target:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_MISSIONTYPE_KILLALL"))
  elseif self._selectedMissionType == __eRoseWarMissionType_CastleAttack then
    if selfPlayerTeamNo == __eRoseWarTeam_Kamasylvia then
      self._ui._cbx_target:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_CASTLE_ODYL"))
    elseif selfPlayerTeamNo == __eRoseWarTeam_Odyllita then
      self._ui._cbx_target:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_CASTLE_KAMA"))
    end
  elseif self._selectedMissionType == __eRoseWarMissionType_CastleDefence then
    if selfPlayerTeamNo == __eRoseWarTeam_Kamasylvia then
      self._ui._cbx_target:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_CASTLE_KAMA"))
    elseif selfPlayerTeamNo == __eRoseWarTeam_Odyllita then
      self._ui._cbx_target:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_CASTLE_ODYL"))
    end
  elseif self._selectedMissionType == __eRoseWarMissionType_GimmikAttack then
    local targetCount = ToClient_GetRoseWarFierceBattleObjectCount()
    local findIndex = 0
    for index = 0, targetCount - 1 do
      local fierceBattleObjectInfoWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapperByIndex(index)
      if fierceBattleObjectInfoWrapper ~= nil and ToClient_IsRoseWarGimicFierceBattle(fierceBattleObjectInfoWrapper:getCharacterKeyRaw()) == true then
        self._ui._cbx_target:AddItem(fierceBattleObjectInfoWrapper:getName())
        if self._selectedTargetFierceBattleKeyRaw ~= nil and self._selectedTargetFierceBattleKeyRaw == fierceBattleObjectInfoWrapper:getFierceBattleKeyRaw() then
          initSelectIndex = findIndex
        end
        findIndex = findIndex + 1
      end
    end
  else
    return
  end
  self._ui._cbx_target:SetIgnore(false)
  self._ui._cbx_target:SetMonoTone(false)
  self._ui._cbx_target:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarMission_ToggleTargetList()")
  self._ui._cbx_target:SetSelectItemIndex(initSelectIndex)
  HandleEventLUp_RoseWarMission_SelectTarget()
end
function PaGlobal_RoseWarMission:deactivateTargetComboBox(doSetDefaultIndex)
  if Panel_RoseWar_Mission == nil then
    return
  end
  self._ui._cbx_target:GetListControl():AddSelectEvent("HandleEventLUp_RoseWarMission_SelectTarget()")
  self._ui._cbx_target:DeleteAllItem(0)
  self._ui._cbx_target:setListTextHorizonCenter()
  self._ui._cbx_target:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_SELECTMEMBER_DIABLE"))
  self._ui._cbx_target:SetIgnore(true)
  self._ui._cbx_target:SetMonoTone(true)
  if doSetDefaultIndex == true then
    self._ui._cbx_target:SetSelectItemIndex(0)
  end
end
function PaGlobal_RoseWarMission:createAddPartyButtonDataList()
  if Panel_RoseWar_Mission == nil then
    return
  end
  if self._addPartyButtonDataList == nil then
    self._addPartyButtonDataList = {}
  end
  for index = 0, self._addPartyButtonCount - 1 do
    local buttonData = {
      _button = nil,
      _addButton = nil,
      _removeButton = nil,
      _partyDataKey = nil
    }
    buttonData._button = UI.getChildControl(self._ui._stc_mainArea, "Button_AddParty_" .. tostring(index))
    buttonData._addButton = UI.getChildControl(buttonData._button, "Static_Plus")
    buttonData._removeButton = UI.getChildControl(buttonData._button, "Button_Remove")
    buttonData._button:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarMission_AddMissionParty()")
    buttonData._button:addInputEvent("Mouse_On", "HandleEventOnOut_RoseWarMission_ShowAddPartyTooltip(true, " .. tostring(index) .. ")")
    buttonData._button:addInputEvent("Mouse_Out", "HandleEventOnOut_RoseWarMission_ShowAddPartyTooltip(false, " .. tostring(index) .. ")")
    buttonData._button:SetShow(true)
    buttonData._button:SetIgnore(false)
    buttonData._addButton:SetShow(true)
    buttonData._addButton:SetIgnore(true)
    buttonData._removeButton:SetShow(false)
    buttonData._removeButton:SetIgnore(false)
    self._addPartyButtonDataList[index] = buttonData
  end
end
function PaGlobal_RoseWarMission:isExistAddPartyData(partyDataKey)
  if Panel_RoseWar_Mission == nil then
    return false
  end
  if partyDataKey == nil then
    return false
  end
  for index = 0, self._addPartyButtonCount - 1 do
    local buttonData = self._addPartyButtonDataList[index]
    if buttonData ~= nil and buttonData._partyDataKey == partyDataKey then
      return true
    end
  end
  return false
end
function PaGlobal_RoseWarMission:getAddPartyDataCount()
  if Panel_RoseWar_Mission == nil then
    return 0
  end
  local validCount = 0
  for index = 0, self._addPartyButtonCount - 1 do
    local buttonData = self._addPartyButtonDataList[index]
    if buttonData ~= nil and buttonData._partyDataKey ~= nil then
      validCount = validCount + 1
    end
  end
  return validCount
end
function PaGlobal_RoseWarMission:addPartyData(partyDataKey)
  if Panel_RoseWar_Mission == nil then
    return
  end
  if self:isExistAddPartyData(partyDataKey) == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoAlreadySelectedRoseWarMissionParty"))
    return
  end
  local roseWarPartyDataWrapper = ToClient_GetRoseWarPartyDataWrapperByKey(partyDataKey)
  if roseWarPartyDataWrapper == nil then
    return
  end
  if roseWarPartyDataWrapper:getPartyType() ~= __eRoseWarPartyType_Mercenary then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantCreateRoseWarMissionByOnlyMercenaryParty"))
    return
  end
  if roseWarPartyDataWrapper:isProgressMission() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantCreateRoseWarMissionByAlreadyMissionParty"))
    return
  end
  local isSuccess = false
  for index = 0, self._addPartyButtonCount - 1 do
    local buttonData = self._addPartyButtonDataList[index]
    if buttonData ~= nil and buttonData._partyDataKey == nil then
      local partyMemo = roseWarPartyDataWrapper:getPartyMemo()
      if partyMemo == nil or partyMemo == "" then
        partyMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_PARTY_NAME", "num", roseWarPartyDataWrapper:getPartyIndex() + 1)
      end
      buttonData._button:SetText(partyMemo)
      buttonData._partyDataKey = partyDataKey
      buttonData._addButton:SetShow(false)
      buttonData._removeButton:SetShow(true)
      buttonData._removeButton:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarMission_RemoveSelectedParty(" .. tostring(index) .. ")")
      local randomSoundIndex = math.floor(math.random(1, 2))
      if randomSoundIndex == 1 then
        audioPostEvent_SystemUi(36, 64)
        _AudioPostEvent_SystemUiForXBOX(36, 64)
      elseif randomSoundIndex == 2 then
        audioPostEvent_SystemUi(36, 65)
        _AudioPostEvent_SystemUiForXBOX(36, 65)
      end
      isSuccess = true
      break
    end
  end
  if isSuccess == true then
    self:updateBottomText()
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoMentalNoMoreAddCard"))
    return
  end
end
function PaGlobal_RoseWarMission:removePartyData(partyDataKey)
  if Panel_RoseWar_Mission == nil then
    return
  end
  if partyDataKey == nil then
    return
  end
  for index = 0, self._addPartyButtonCount - 1 do
    local buttonData = self._addPartyButtonDataList[index]
    if buttonData ~= nil and buttonData._partyDataKey == partyDataKey then
      buttonData._button:SetText("")
      buttonData._partyDataKey = nil
      buttonData._addButton:SetShow(true)
      buttonData._removeButton:SetShow(false)
      self:updateBottomText()
      break
    end
  end
end
function PaGlobal_RoseWarMission:clearPartyData()
  if Panel_RoseWar_Mission == nil then
    return
  end
  for index = 0, self._addPartyButtonCount - 1 do
    local buttonData = self._addPartyButtonDataList[index]
    if buttonData ~= nil then
      buttonData._button:SetText("")
      buttonData._partyDataKey = nil
      buttonData._addButton:SetShow(true)
      buttonData._removeButton:SetShow(false)
    end
  end
end
function PaGlobal_RoseWarMission:registEventHandler()
  if Panel_RoseWar_Mission == nil then
    return
  end
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_RoseWarMission_Close()")
  self._ui._btn_createMission:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarMission_RequestCreateMission()")
  registerEvent("FromClient_ReceivedNewRoseWarMissionToCommander", "FromClient_RoseWarMission_ReceivedNewMission")
  registerEvent("FromClient_UpdateRoseWarTeamCoinCount", "FromClient_RoseWarMission_ReceivedNewMission")
end
function PaGlobal_RoseWarMission:prepareOpen(openMode, param, doRecalcPanelPos)
  if Panel_RoseWar_Mission == nil then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  self:resetUI()
  if openMode == self._eOpenMode._SET_CLEAR then
    if doRecalcPanelPos == true then
      local minimapPos_RB = PaGlobalFunc_RoseWarMiniMap_GetMiniMapViewRightBottomPos()
      local minimapPos_Center = PaGlobalFunc_RoseWarMiniMap_GetMiniMapViewCenterPos()
      Panel_RoseWar_Mission:SetPosX(minimapPos_RB.x - Panel_RoseWar_Mission:GetSizeX() - 10)
      Panel_RoseWar_Mission:SetPosY(minimapPos_Center.y - Panel_RoseWar_Mission:GetSizeY() / 2)
    end
  elseif openMode == self._eOpenMode._SET_FIERCE_BATTLE then
    local selfPlayerTeamNo = selfPlayerWrapper:getRoseWarTeamNo()
    local fierceBattleKeyRaw = param
    if fierceBattleKeyRaw ~= nil then
      local targetCount = ToClient_GetRoseWarFierceBattleObjectCount()
      for index = 0, targetCount - 1 do
        local fierceBattleObjectInfoWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapperByIndex(index)
        if fierceBattleObjectInfoWrapper ~= nil and fierceBattleObjectInfoWrapper:getFierceBattleKeyRaw() == fierceBattleKeyRaw then
          self:setSelectedTargetFierceBattleKeyRaw(fierceBattleKeyRaw)
          local fierceBattleTeamNo = fierceBattleObjectInfoWrapper:getTeamNo()
          if fierceBattleTeamNo == selfPlayerTeamNo then
            HandleEventLUp_RoseWarMission_SelectMissionType(__eRoseWarMissionType_FierceDefence, false)
            break
          end
          HandleEventLUp_RoseWarMission_SelectMissionType(__eRoseWarMissionType_FierceAttack, false)
          break
        end
      end
    end
    if doRecalcPanelPos == true then
      local fierceBattleIconPos_RB = PaGlobalFunc_RoseWarMiniMap_GetFierceBattleObjectIconCenterPosRB(fierceBattleKeyRaw)
      Panel_RoseWar_Mission:SetPosX(fierceBattleIconPos_RB.x)
      Panel_RoseWar_Mission:SetPosY(fierceBattleIconPos_RB.y)
    end
  elseif openMode == self._eOpenMode._SET_MY_CASTLE then
    self:setSelectedTargetFierceBattleKeyRaw(nil)
    HandleEventLUp_RoseWarMission_SelectMissionType(__eRoseWarMissionType_CastleDefence, false)
    if doRecalcPanelPos == true then
      local bossIconPos_RB = PaGlobalFunc_RoseWarMiniMap_GetBossIconCenterPosRB(param)
      Panel_RoseWar_Mission:SetPosX(bossIconPos_RB.x)
      Panel_RoseWar_Mission:SetPosY(bossIconPos_RB.y)
    end
  elseif openMode == self._eOpenMode._SET_ENEMY_CASTLE then
    self:setSelectedTargetFierceBattleKeyRaw(nil)
    HandleEventLUp_RoseWarMission_SelectMissionType(__eRoseWarMissionType_CastleAttack, false)
    if doRecalcPanelPos == true then
      local bossIconPos_RB = PaGlobalFunc_RoseWarMiniMap_GetBossIconCenterPosRB(param)
      Panel_RoseWar_Mission:SetPosX(bossIconPos_RB.x)
      Panel_RoseWar_Mission:SetPosY(bossIconPos_RB.y)
    end
  elseif openMode == self._eOpenMode._SET_GIMMICK_FIERCE then
    local selfPlayerTeamNo = selfPlayerWrapper:getRoseWarTeamNo()
    local fierceBattleKeyRaw = param
    if fierceBattleKeyRaw ~= nil then
      local targetCount = ToClient_GetRoseWarFierceBattleObjectCount()
      for index = 0, targetCount - 1 do
        local fierceBattleObjectInfoWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapperByIndex(index)
        if fierceBattleObjectInfoWrapper ~= nil and fierceBattleObjectInfoWrapper:getFierceBattleKeyRaw() == fierceBattleKeyRaw then
          self:setSelectedTargetFierceBattleKeyRaw(fierceBattleKeyRaw)
          HandleEventLUp_RoseWarMission_SelectMissionType(__eRoseWarMissionType_GimmikAttack, false)
          break
        end
      end
    end
    if doRecalcPanelPos == true then
      local fierceBattleIconPos_RB = PaGlobalFunc_RoseWarMiniMap_GetFierceBattleObjectIconCenterPosRB(fierceBattleKeyRaw)
      Panel_RoseWar_Mission:SetPosX(fierceBattleIconPos_RB.x)
      Panel_RoseWar_Mission:SetPosY(fierceBattleIconPos_RB.y)
    end
  else
    return
  end
  self:updateMissionTypeButtonFromOpenMode(openMode)
  self:open()
end
function PaGlobal_RoseWarMission:updateMissionTypeButtonFromOpenMode(openMode)
  if Panel_RoseWar_Mission == nil then
    return
  end
  self._ui._btn_missionTypeAttack:SetIgnore(true)
  self._ui._btn_missionTypeAttack:SetMonoTone(true)
  self._ui._btn_missionTypeAttack:removeInputEvent("Mouse_LUp")
  self._ui._btn_missionTypeAttack:removeInputEvent("Mouse_On")
  self._ui._btn_missionTypeAttack:removeInputEvent("Mouse_Out")
  self._ui._btn_missionTypeDefense:SetIgnore(true)
  self._ui._btn_missionTypeDefense:SetMonoTone(true)
  self._ui._btn_missionTypeDefense:removeInputEvent("Mouse_LUp")
  self._ui._btn_missionTypeDefense:removeInputEvent("Mouse_On")
  self._ui._btn_missionTypeDefense:removeInputEvent("Mouse_Out")
  self._ui._btn_missionTypeKill:SetIgnore(false)
  self._ui._btn_missionTypeKill:SetMonoTone(false)
  self._ui._btn_missionTypeKill:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarMission_SelectMissionType(" .. tostring(__eRoseWarMissionType_Kill) .. ", true)")
  self._ui._btn_missionTypeKill:addInputEvent("Mouse_On", "HandleEventOnOut_RoseWarMission_ShowMissionTypeTooltip(true, " .. tostring(__eRoseWarMissionType_Kill) .. ")")
  self._ui._btn_missionTypeKill:addInputEvent("Mouse_Out", "HandleEventOnOut_RoseWarMission_ShowMissionTypeTooltip(false, " .. tostring(__eRoseWarMissionType_Kill) .. ")")
  if openMode == self._eOpenMode._SET_CLEAR or openMode == self._eOpenMode._SET_FIERCE_BATTLE then
    self._ui._btn_missionTypeAttack:SetIgnore(false)
    self._ui._btn_missionTypeAttack:SetMonoTone(false)
    self._ui._btn_missionTypeAttack:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarMission_SelectMissionType(" .. tostring(__eRoseWarMissionType_FierceAttack) .. ", true)")
    self._ui._btn_missionTypeAttack:addInputEvent("Mouse_On", "HandleEventOnOut_RoseWarMission_ShowMissionTypeTooltip(true, " .. tostring(__eRoseWarMissionType_FierceAttack) .. ")")
    self._ui._btn_missionTypeAttack:addInputEvent("Mouse_Out", "HandleEventOnOut_RoseWarMission_ShowMissionTypeTooltip(false, " .. tostring(__eRoseWarMissionType_FierceAttack) .. ")")
    self._ui._btn_missionTypeDefense:SetIgnore(false)
    self._ui._btn_missionTypeDefense:SetMonoTone(false)
    self._ui._btn_missionTypeDefense:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarMission_SelectMissionType(" .. tostring(__eRoseWarMissionType_FierceDefence) .. ", true)")
    self._ui._btn_missionTypeDefense:addInputEvent("Mouse_On", "HandleEventOnOut_RoseWarMission_ShowMissionTypeTooltip(true, " .. tostring(__eRoseWarMissionType_FierceDefence) .. ")")
    self._ui._btn_missionTypeDefense:addInputEvent("Mouse_Out", "HandleEventOnOut_RoseWarMission_ShowMissionTypeTooltip(false, " .. tostring(__eRoseWarMissionType_FierceDefence) .. ")")
  elseif openMode == self._eOpenMode._SET_MY_CASTLE then
    self._ui._btn_missionTypeDefense:SetIgnore(false)
    self._ui._btn_missionTypeDefense:SetMonoTone(false)
    self._ui._btn_missionTypeDefense:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarMission_SelectMissionType(" .. tostring(__eRoseWarMissionType_CastleDefence) .. ", true)")
    self._ui._btn_missionTypeDefense:addInputEvent("Mouse_On", "HandleEventOnOut_RoseWarMission_ShowMissionTypeTooltip(true, " .. tostring(__eRoseWarMissionType_CastleDefence) .. ")")
    self._ui._btn_missionTypeDefense:addInputEvent("Mouse_Out", "HandleEventOnOut_RoseWarMission_ShowMissionTypeTooltip(false, " .. tostring(__eRoseWarMissionType_CastleDefence) .. ")")
  elseif openMode == self._eOpenMode._SET_ENEMY_CASTLE then
    self._ui._btn_missionTypeAttack:SetIgnore(false)
    self._ui._btn_missionTypeAttack:SetMonoTone(false)
    self._ui._btn_missionTypeAttack:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarMission_SelectMissionType(" .. tostring(__eRoseWarMissionType_CastleAttack) .. ", true)")
    self._ui._btn_missionTypeAttack:addInputEvent("Mouse_On", "HandleEventOnOut_RoseWarMission_ShowMissionTypeTooltip(true, " .. tostring(__eRoseWarMissionType_CastleAttack) .. ")")
    self._ui._btn_missionTypeAttack:addInputEvent("Mouse_Out", "HandleEventOnOut_RoseWarMission_ShowMissionTypeTooltip(false, " .. tostring(__eRoseWarMissionType_CastleAttack) .. ")")
  elseif openMode == self._eOpenMode._SET_GIMMICK_FIERCE then
    self._ui._btn_missionTypeAttack:SetIgnore(false)
    self._ui._btn_missionTypeAttack:SetMonoTone(false)
    self._ui._btn_missionTypeAttack:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarMission_SelectMissionType(" .. tostring(__eRoseWarMissionType_GimmikAttack) .. ", true)")
    self._ui._btn_missionTypeAttack:addInputEvent("Mouse_On", "HandleEventOnOut_RoseWarMission_ShowMissionTypeTooltip(true, " .. tostring(__eRoseWarMissionType_GimmikAttack) .. ")")
    self._ui._btn_missionTypeAttack:addInputEvent("Mouse_Out", "HandleEventOnOut_RoseWarMission_ShowMissionTypeTooltip(false, " .. tostring(__eRoseWarMissionType_GimmikAttack) .. ")")
  end
end
function PaGlobal_RoseWarMission:open()
  if Panel_RoseWar_Mission == nil then
    return
  end
  local currentSizeX = Panel_RoseWar_Mission:GetSizeX()
  local currentSizeY = Panel_RoseWar_Mission:GetSizeY()
  local currentPosX = Panel_RoseWar_Mission:GetPosX()
  local currentPosY = Panel_RoseWar_Mission:GetPosY()
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  if currentPosX < 10 then
    currentPosX = 10
  elseif screenSizeX < currentPosX + currentSizeX then
    currentPosX = screenSizeX - currentSizeX - 10
  end
  if currentPosY < 10 then
    currentPosY = 10
  elseif screenSizeY < currentPosY + currentSizeY then
    currentPosY = screenSizeY - currentSizeY - 10
  end
  if currentPosX ~= Panel_RoseWar_Mission:GetPosX() then
    Panel_RoseWar_Mission:SetPosX(currentPosX)
  end
  if currentPosY ~= Panel_RoseWar_Mission:GetPosY() then
    Panel_RoseWar_Mission:SetPosY(currentPosY)
  end
  Panel_RoseWar_Mission:SetShow(true)
end
function PaGlobal_RoseWarMission:prepareClose()
  if Panel_RoseWar_Mission == nil then
    return
  end
  if self._ui._stc_targetList:GetShow() == true then
    self._ui._cbx_target:ToggleListbox()
  end
  TooltipSimple_Hide()
  self:close()
end
function PaGlobal_RoseWarMission:close()
  if Panel_RoseWar_Mission == nil then
    return
  end
  Panel_RoseWar_Mission:SetShow(false)
end
function PaGlobal_RoseWarMission:validate()
  if Panel_RoseWar_Mission == nil then
    return
  end
end
function PaGlobal_RoseWarMission:resetUI()
  if Panel_RoseWar_Mission == nil then
    return
  end
  self._selectedMissionType = nil
  self._ui._btn_missionTypeAttack:SetCheck(false)
  self._ui._btn_missionTypeDefense:SetCheck(false)
  self._ui._btn_missionTypeKill:SetCheck(false)
  self:setSelectedTargetFierceBattleKeyRaw(nil)
  self:deactivateTargetComboBox(true)
  self:clearPartyData()
  self:updateBottomText()
end
function PaGlobal_RoseWarMission:updateBottomText()
  if Panel_RoseWar_Mission == nil then
    return
  end
  local missionLimitTimeSec = ToClient_GetRoseWarMissionTimeLimit()
  local minute = missionLimitTimeSec / 60
  local second = missionLimitTimeSec % 60
  local minuteString = tostring(minute)
  local secondString = tostring(second)
  if minute < 10 then
    minuteString = "0" .. minuteString
  end
  if second < 10 then
    secondString = "0" .. secondString
  end
  self._ui._txt_missionLimitTime:SetText(minuteString .. ":" .. secondString)
  local totalSelectedPartyMemberCount = 0
  for index = 0, self._addPartyButtonCount - 1 do
    local buttonData = self._addPartyButtonDataList[index]
    if buttonData ~= nil and buttonData._partyDataKey ~= nil then
      local partyDataWrapper = ToClient_GetRoseWarPartyDataWrapperByKey(buttonData._partyDataKey)
      if partyDataWrapper ~= nil then
        totalSelectedPartyMemberCount = totalSelectedPartyMemberCount + partyDataWrapper:getInvitedMemberCount()
      end
    end
  end
  local missionRewardCoinCount = ToClient_GetRoseWarMissionRewardCount()
  local currentHaveCoinCount = ToClient_GetRoseWarTeamCoinCount()
  local needCoinCount = totalSelectedPartyMemberCount * missionRewardCoinCount
  local coinCountString = ""
  if needCoinCount == 0 then
    coinCountString = tostring(currentHaveCoinCount)
  elseif currentHaveCoinCount < needCoinCount then
    coinCountString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ROSEWAR_COIN_DISABLE", "current", currentHaveCoinCount, "consume", needCoinCount)
  else
    coinCountString = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_ROSEWAR_COIN_ABLE", "current", currentHaveCoinCount, "consume", needCoinCount, "last", currentHaveCoinCount - needCoinCount)
  end
  self._ui._txt_missionRewardCount:SetText(coinCountString)
  self._ui._txt_missionRewardCount:SetSize(self._ui._txt_missionRewardCount:GetTextSizeX(), self._ui._txt_missionRewardCount:GetSizeY())
  self._ui._txt_missionRewardCount:ComputePos()
  self._ui._txt_missionRewardCount:addInputEvent("Mouse_On", "HandleEventOnOut_RoseWarMission_ShowMissionRewardTooltip(true, " .. tostring(totalSelectedPartyMemberCount) .. ", " .. tostring(missionRewardCoinCount) .. ")")
  self._ui._txt_missionRewardCount:addInputEvent("Mouse_Out", "HandleEventOnOut_RoseWarMission_ShowMissionRewardTooltip(false, " .. tostring(totalSelectedPartyMemberCount) .. ", " .. tostring(missionRewardCoinCount) .. ")")
end
function PaGlobal_RoseWarMission:setSelectedTargetFierceBattleKeyRaw(fierceBattleKeyRaw)
  if Panel_RoseWar_Mission == nil then
    return
  end
  if self._selectedTargetFierceBattleKeyRaw ~= nil then
    local targetControl = PaGlobal_RoseWarMiniMap:getFierceBattleObjectIcon(self._selectedTargetFierceBattleKeyRaw)
    if targetControl ~= nil then
      targetControl:SetCheck(false)
    end
  end
  self._selectedTargetFierceBattleKeyRaw = fierceBattleKeyRaw
  if fierceBattleKeyRaw ~= nil then
    local targetControl = PaGlobal_RoseWarMiniMap:getFierceBattleObjectIcon(fierceBattleKeyRaw)
    if targetControl ~= nil then
      targetControl:SetCheck(true)
    end
  end
end
