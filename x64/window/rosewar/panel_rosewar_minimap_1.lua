function PaGlobal_RoseWarMiniMap:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._gimmickRespawnTime = ToClient_GetRoseWarGimmickFierceBattleObjectRespawnTime()
  self._ui._stc_miniMapNavigationGuideBg = UI.getChildControl(self._ui._stc_miniMapBg, "Static_NavigationGuideBg")
  self._ui._stc_miniMapNavigationGuideBg:SetShowAALineList(false)
  self._ui._stc_miniMapNavigationGuideBg:SetRoseWarMiniMapAALineList(true)
  self._ui._stc_miniMapNavigationGuideBg:SetRoseWarMiniMapLines(true)
  self._ui._stc_miniMapNavigationGuideBg:SetDepth(self._eRenderOrder.MINIMAP_LINES)
  self._ui._chk_toggleChatting:SetCheck(true)
  self._miniMapActorIconPoolCount = self._eInitPoolCount.ACTOR_ICON
  self._miniMapVehicleIconPoolCount = self._eInitPoolCount.VEHICLE_ICON
  self._miniMapMarkerPoolCount = self._eInitPoolCount.MINIMAP_MARKER
  self._miniMapFierceBattleIconPoolCount = self._eInitPoolCount.MINIMAP_FIERCEBATTLE_OBJECT
  self:makeMiniMap(Defines.RoseWarTeamNo.KAMASYLVIA)
  self:makeMiniMap(Defines.RoseWarTeamNo.ODYLLITA)
  self._miniMapControl = self._miniMapBgTexture_Kamasilvia
  self:makeMiniMapPinData()
  self:makeMiniMapMovePinData()
  self:makeMiniMapDragSelectData()
  self:makeActorIcon()
  self:makeVehicleIcon()
  self:makeMiniMapMarker()
  self:makeMiniMapFierceBattleObject()
  self:makeMiniMapGimmickFierceBattleObject()
  self:makeMiniMapFierceBattleObjectTooltip()
  self:ComputePanelSize()
  self:registEventHandler()
  self:validate()
  self._initialize = true
  FromClient_RoseWarMiniMap_ChangeRoseWarState(ToClient_GetRoseWarState())
end
function PaGlobal_RoseWarMiniMap:update_always(deltaTime)
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  if ToClient_IsParticipateInRoseWar() == false and ToClient_IsRoseWarObserveMode() == false then
    return
  end
  if Panel_RoseWar_MiniMap:GetShow() == true then
    self:update_onlyShow(deltaTime)
  end
end
function PaGlobal_RoseWarMiniMap:update_onlyShow(deltaTime)
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  self:updateMiniMapMoveAnimation(deltaTime)
  self:updateMiniMapInputProcess(deltaTime)
  self:requestUpdateMiniMapToServer(deltaTime)
  self:updateMiniMapNavigationGuide()
  self:updateChildIconsMiniMapPosRate()
  self:updateFierceBattleObjectRespawnTime(deltaTime)
  self:updateTooltipProgressUI()
end
function PaGlobal_RoseWarMiniMap:updateChildIconsMiniMapPosRate()
  for index = 0, self._miniMapActorIconPoolCount - 1 do
    local actorIconData = self._miniMapActorIconList[index]
    if actorIconData ~= nil and actorIconData._isSet == true then
      local actorIconDataWrapper = ToClient_GetRoseWarMiniMapIconDataWrapperXXX(actorIconData._userNo_s64)
      if actorIconDataWrapper ~= nil then
        local iconDataPtr = actorIconDataWrapper:getXXX()
        if iconDataPtr ~= nil and actorIconData._control:GetShow() == true then
          iconDataPtr._roseWarMinimapPosRate.x = actorIconData._control:GetPosX() + actorIconData._control:GetSizeX() / 2
          iconDataPtr._roseWarMinimapPosRate.y = actorIconData._control:GetPosY() + actorIconData._control:GetSizeY() / 2
        end
      end
    end
  end
  for index = 0, self._miniMapFierceBattleIconPoolCount - 1 do
    local iconData = self._miniMapFierceBattleIconList[index]
    if iconData ~= nil and iconData._isSet == true then
      local objectInfo = ToClient_GetRoseWarFierceBattleObjectInfoWrapper(iconData._fierceBattleKeyRaw)
      if objectInfo ~= nil then
        local object = objectInfo:getXXX()
        if object ~= nil then
          local controlBg = iconData._control
          if controlBg:GetShow() == true then
            object._roseWarMinimapPosRate.x = controlBg:GetPosX() + controlBg:GetSizeX() / 2
            object._roseWarMinimapPosRate.y = controlBg:GetPosY() + controlBg:GetSizeY() / 2
          end
        end
      end
    end
  end
end
function PaGlobal_RoseWarMiniMap:registEventHandler()
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  self._ui._stc_miniMapBg:addInputEvent("Mouse_LDown", "RoseWarMiniMap_MouseLDown()")
  self._ui._stc_miniMapBg:addInputEvent("Mouse_RUp", "RoseWarMiniMap_MouseRUp()")
  self._ui._stc_miniMapBg:addInputEvent("Mouse_UpScroll", "RoseWarMiniMap_MouseScroll(true)")
  self._ui._stc_miniMapBg:addInputEvent("Mouse_DownScroll", "RoseWarMiniMap_MouseScroll(false)")
  self._ui._btn_moveMapToSelfPlayerPos:addInputEvent("Mouse_LUp", "RoseWarMiniMap_MoveMapToSelfPlayer()")
  self._ui._btn_moveMapToSelfPlayerPos:addInputEvent("Mouse_On", "RoseWarMiniMap_ShowToolTip_MoveMapToSelfPlayerButton(true)")
  self._ui._btn_moveMapToSelfPlayerPos:addInputEvent("Mouse_Out", "RoseWarMiniMap_ShowToolTip_MoveMapToSelfPlayerButton(false)")
  registerEvent("onScreenResize", "FromClient_RoseWarMiniMap_OnScreenSize")
  registerEvent("FromClient_ChangeRoseWarState", "FromClient_RoseWarMiniMap_ChangeRoseWarState")
  registerEvent("FromClient_RoseWarCreateActorIcon", "FromClient_RoseWarCreateActorIcon")
  registerEvent("FromClient_RoseWarRemoveActorIcon", "FromClient_RoseWarRemoveActorIcon")
  registerEvent("FromClient_RoseWarUpdateActorIcon", "FromClient_RoseWarUpdateActorIcon")
  registerEvent("FromClient_RoseWarClearActorIcon", "FromClient_RoseWarClearActorIcon")
  registerEvent("FromClient_RoseWarCreateVehicleIcon", "FromClient_RoseWarCreateVehicleIcon")
  registerEvent("FromClient_RoseWarRemoveVehicleIcon", "FromClient_RoseWarRemoveVehicleIcon")
  registerEvent("FromClient_RoseWarUpdateVehicleIcon", "FromClient_RoseWarUpdateVehicleIcon")
  registerEvent("FromClient_RoseWarClearVehicleIcon", "FromClient_RoseWarClearVehicleIcon")
  registerEvent("FromClient_RoseWarAddSelectActorIcon", "FromClient_RoseWarAddSelectActorIcon")
  registerEvent("FromClient_RoseWarClearSelectActorIcon", "FromClient_RoseWarClearSelectActorIcon")
  registerEvent("FromClient_SetRoseWarObserveMode", "FromClient_RoseWarMiniMap_SetRoseWarObserveMode")
  registerEvent("FromClient_UnsetRoseWarObserveMode", "FromClient_RoseWarMiniMap_UnsetRoseWarObserveMode")
  registerEvent("FromClient_RoseWarCreateFierceBattleObjectIcon", "FromClient_RoseWarCreateFierceBattleObjectIcon")
  registerEvent("FromClient_RoseWarClearFierceBattleObjectIcon", "FromClient_RoseWarClearFierceBattleObjectIcon")
  registerEvent("FromClient_UpdateRoseWarFierceBattleInfo", "FromClient_UpdateRoseWarFierceBattleInfo")
  registerEvent("FromClient_RoseWarUpdateBossInfo", "FromClient_RoseWarUpdateBossInfo")
  registerEvent("FromClient_ResponseRoseWarFierceBattleMonsterDead", "FromClient_ResponseRoseWarFierceBattleMonsterDead")
  registerEvent("FromClient_ResponseRoseWarGimmickFierceBattleObjectAdrenalin", "FromClient_ResponseRoseWarGimmickFierceBattleObjectAdrenalin")
  registerEvent("FromClient_RoseWarRemovePing", "FromClient_RoseWarRemovePing")
end
function PaGlobal_RoseWarMiniMap:prepareOpen()
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  self._miniMapBgTexture_Kamasilvia:SetShow(false)
  self._miniMapBgTexture_Odilita:SetShow(false)
  local teamNo = selfPlayerWrapper:getRoseWarTeamNo()
  if ToClient_IsRoseWarObserveMode() == true then
    teamNo = ToClient_GetRoseObserveTeamNo()
  end
  if teamNo == Defines.RoseWarTeamNo.KAMASYLVIA then
    self._miniMapControl = self._miniMapBgTexture_Kamasilvia
  elseif teamNo == Defines.RoseWarTeamNo.ODYLLITA then
    self._miniMapControl = self._miniMapBgTexture_Odilita
  else
    UI.ASSERT_NAME(false, "RoseWarTeamNo\234\176\128 \235\185\132\236\160\149\236\131\129\236\157\180\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  self._miniMapControl:SetShow(true)
  ToClient_setRoseWarFogTextureParentUI(self._miniMapControl)
  if PaGlobalFunc_RoseWarCommand_IsShow() == true then
    PaGlobalFunc_RoseWarCommand_Close()
  end
  if PaGlobalFunc_RoseWarMiniMapPartyList_IsShow() == true then
    PaGlobalFunc_RoseWarMiniMapPartyList_Close()
  end
  if PaGlobalFunc_RoseWarEditParty_IsShow() == true then
    PaGlobalFunc_RoseWarEditParty_Close()
  end
  if PaGlobalFunc_RoseWarMission_IsShow() == true then
    PaGlobalFunc_RoseWarMission_Close()
  end
  if PaGlobalFunc_RoseWarScoreBoard_IsShow() == true then
    PaGlobalFunc_RoseWarScoreBoard_Close()
  end
  if ToClient_IsRoseWarObserveMode() == true then
    self._ui._chk_togglePartyList:SetShow(false)
    self._ui._chk_toggleEditParty:SetShow(false)
    self._ui._chk_toggleRoseWarMission:SetShow(false)
    self._ui._chk_toggleChatting:SetShow(true)
    self._ui._chk_toggleScoreBoard:SetShow(true)
    self._ui._stc_naviGuide:SetShow(false)
    self._ui._stc_dragGuide:SetShow(false)
    self._ui._stc_pingGuide:SetShow(false)
    self._ui._btn_moveMapToSelfPlayerPos:SetShow(false)
  elseif IsSelfPlayerRoseWarGrade_Commander() == true then
    self._ui._chk_togglePartyList:SetShow(true)
    self._ui._chk_toggleEditParty:SetShow(true)
    self._ui._chk_toggleRoseWarMission:SetShow(true)
    self._ui._chk_toggleChatting:SetShow(true)
    self._ui._chk_toggleScoreBoard:SetShow(true)
    self._ui._stc_naviGuide:SetShow(true)
    self._ui._stc_dragGuide:SetShow(true)
    self._ui._stc_pingGuide:SetShow(true)
    self._ui._btn_moveMapToSelfPlayerPos:SetShow(true)
    local openInfo = {
      _x = self._ui._stc_miniMapBg:GetParentPosX() + self._ui._stc_miniMapBg:GetSizeX() / 2,
      _y = self._ui._stc_miniMapBg:GetParentPosY() + self._ui._stc_miniMapBg:GetSizeY(),
      _align = "CB"
    }
    PaGlobalFunc_RoseWarTeamSkill_Open(openInfo)
  elseif IsSelfPlayerRoseWarGrade_SubCommander() == true then
    self._ui._chk_togglePartyList:SetShow(true)
    self._ui._chk_toggleEditParty:SetShow(true)
    self._ui._chk_toggleRoseWarMission:SetShow(true)
    self._ui._chk_toggleChatting:SetShow(true)
    self._ui._chk_toggleScoreBoard:SetShow(true)
    self._ui._stc_naviGuide:SetShow(true)
    self._ui._stc_dragGuide:SetShow(false)
    self._ui._stc_pingGuide:SetShow(false)
    self._ui._btn_moveMapToSelfPlayerPos:SetShow(true)
  else
    self._ui._chk_togglePartyList:SetShow(false)
    self._ui._chk_toggleEditParty:SetShow(true)
    self._ui._chk_toggleRoseWarMission:SetShow(false)
    self._ui._chk_toggleChatting:SetShow(true)
    self._ui._chk_toggleScoreBoard:SetShow(true)
    self._ui._stc_naviGuide:SetShow(true)
    self._ui._stc_dragGuide:SetShow(false)
    self._ui._stc_pingGuide:SetShow(false)
    self._ui._btn_moveMapToSelfPlayerPos:SetShow(true)
  end
  self._closeFlag_m = false
  self:refreshMiniMap(self._currentMiniMapRate, true)
  self._accumulatedDeltaTime = self._updateCycleTime
  PaGlobalRoseWarTeamBuff_Open()
  PaGlobalFunc_RoseWarMiniMap_ToggleChattingUI(false)
  ToClient_SetUseAlphaForAALine(false)
  self:ComputePanelSize()
  ToClient_RequestRoseWarFierceBattleObjectInfo()
  ToClient_RequestRoseWarBossInfotList()
  self:gimmickFierceBattleComputeProgressValue()
  self:open()
  self:initMiniMapPinPos()
end
function PaGlobal_RoseWarMiniMap:open()
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  Panel_RoseWar_MiniMap:SetShow(true)
end
function PaGlobal_RoseWarMiniMap:prepareClose()
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  if IsSelfPlayerRoseWarGrade_SubCommander() == true then
    PaGlobalFunc_RoseWarCommand_Open(__eRoseWarPlayerGradeType_SubCommander)
  end
  ToClient_SetUseAlphaForAALine(true)
  PaGlobalFunc_RoseWarTeamSkill_Close()
  PaGlobalFunc_RoseWarMiniMap_ToggleChattingUI(true)
  TooltipSimple_Hide()
  self._miniMapDragSelectData._beginWorldPos = float3(0, 0, 0)
  self._miniMapDragSelectData._endWorldPos = float3(0, 0, 0)
  self._miniMapDragSelectData._control:SetSize(0, 0)
  self._miniMapDragSelectData._control:SetShow(false)
  self:clearMiniMapMoveAnimationInfo()
  self:close()
end
function PaGlobal_RoseWarMiniMap:close()
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  Panel_RoseWar_MiniMap:SetShow(false)
end
function PaGlobal_RoseWarMiniMap:validate()
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  self._ui._stc_miniMapBg:isValidate()
  self._ui._chk_togglePartyList:isValidate()
  self._ui._chk_toggleEditParty:isValidate()
  self._ui._chk_toggleRoseWarMission:isValidate()
  self._ui._chk_toggleChatting:isValidate()
  self._ui._chk_toggleScoreBoard:isValidate()
  self._ui._stc_naviGuide:isValidate()
  self._ui._stc_dragGuide:isValidate()
  self._ui._stc_pingGuide:isValidate()
  self._ui._stc_objectTooltip:isValidate()
  self._ui._btn_moveMapToSelfPlayerPos:isValidate()
end
