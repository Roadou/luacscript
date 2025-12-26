function PaGlobalFunc_RoseWarMiniMap_Open()
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  self:prepareOpen()
  RoseWarMiniMap_MoveMapToSelfPlayer()
end
function PaGlobalFunc_RoseWarMiniMap_Close()
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_RoseWarMiniMap_IsShow()
  if Panel_RoseWar_MiniMap == nil then
    return false
  end
  return Panel_RoseWar_MiniMap:GetShow()
end
function PaGlobalFunc_RoseWarMiniMap_AddPingAndMarker(commandEventType, worldPosition)
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  self:addPingAndMarker(commandEventType, worldPosition)
end
function PaGlobalFunc_RoseWarMiniMap_GetMiniMapViewLeftTopPos()
  local rv = float2(0, 0)
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return rv
  end
  rv.x = self._ui._stc_miniMapBg:GetParentPosX()
  rv.y = self._ui._stc_miniMapBg:GetParentPosY()
  return rv
end
function PaGlobalFunc_RoseWarMiniMap_GetMiniMapViewRightBottomPos()
  local rv = float2(0, 0)
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return rv
  end
  rv.x = self._ui._stc_miniMapBg:GetParentPosX() + self._ui._stc_miniMapBg:GetSizeX()
  rv.y = self._ui._stc_miniMapBg:GetParentPosY() + self._ui._stc_miniMapBg:GetSizeY()
  return rv
end
function PaGlobalFunc_RoseWarMiniMap_GetMiniMapViewCenterPos()
  local rv = float2(0, 0)
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return rv
  end
  rv.x = self._ui._stc_miniMapBg:GetParentPosX() + self._ui._stc_miniMapBg:GetSizeX() / 2
  rv.y = self._ui._stc_miniMapBg:GetParentPosY() + self._ui._stc_miniMapBg:GetSizeY() / 2
  return rv
end
function PaGlobalFunc_RoseWarMiniMap_GetFierceBattleObjectIconCenterPosRB(fierceBattleKeyRaw)
  local rv = float2(0, 0)
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return rv
  end
  local control = self:getFierceBattleObjectIcon(fierceBattleKeyRaw)
  if control == nil then
    return rv
  end
  rv.x = control:GetParentPosX() + control:GetSizeX()
  rv.y = control:GetParentPosY() + control:GetSizeY()
  return rv
end
function PaGlobalFunc_RoseWarMiniMap_GetBossIconCenterPosRB(roseWarTeamNo)
  local rv = float2(0, 0)
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return rv
  end
  local bossIconData = self._miniMapBossIconList[roseWarTeamNo]
  if bossIconData == nil then
    return rv
  end
  local control = bossIconData._control
  if control == nil then
    return rv
  end
  rv.x = control:GetParentPosX() + control:GetSizeX()
  rv.y = control:GetParentPosY() + control:GetSizeY()
  return rv
end
function PaGlobalFunc_RoseWarMiniMap_GetFierceBattleObjectIconCenterPos(fierceBattleKeyRaw)
  local self = PaGlobal_RoseWarMiniMap
  if self == nil or fierceBattleKeyRaw == nil then
    return nil
  end
  local control = self:getFierceBattleObjectIcon(fierceBattleKeyRaw)
  if control == nil then
    return nil
  end
  rv = {
    x = control:GetParentPosX() + control:GetSizeX() / 2,
    y = control:GetParentPosY() + control:GetSizeY() / 2
  }
  return rv
end
function PaGlobalFunc_RoseWarMiniMap_GetMiniMapLTRB()
  return PaGlobal_RoseWarMiniMap:getMiniMapLTRB()
end
function RoseWarMiniMap_Update_Always(deltaTime)
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  self:update_always(deltaTime)
end
function RoseWarMiniMap_MouseScroll(isUp)
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  self:processMiniMapScroll(isUp)
  self:setTooltipPos()
end
function RoseWarMiniMap_MoveMapToSelfPlayer()
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  self:aniationMoveMiniMap(selfPlayer:getUserNo())
end
function RoseWarMiniMap_ShowToolTip_MoveMapToSelfPlayerButton(isShow)
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local control = self._ui._btn_moveMapToSelfPlayerPos
  local name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_INMYPOSITION")
  local desc = ""
  TooltipSimple_Show(control, name, desc)
end
function RoseWarMiniMap_MouseLDown()
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  if PaGlobalFunc_RoseWarTeamSkillManager_isUsingSkill() == true then
    local mousePosRate = self:getCurrentMousePosRateOnMiniMap()
    local worldPosition = ToClient_ConvertMinimapPosRateToWorldMapPos(mousePosRate.x, mousePosRate.y)
    PaGlobalFunc_RoseWarTeamSkillManager_UpdatePosition(worldPosition)
    PaGlobalFunc_RoseWarTeamSkillManager_UseRoseWarSkill(__eRoseWarSkillType_Scan)
    PaGlobalFunc_RoseWarTeamSkillManager_UseRoseWarSkill(__eRoseWarSkillType_Conceal)
    return
  end
  PaGlobalFunc_RoseWarCommand_Close()
end
function RoseWarMiniMap_MouseRUp()
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  if ToClient_IsRoseWarObserveMode() == true then
    return
  end
  if ToClient_IsParticipateInRoseWar() == false then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local selfPlayerRoseWarGradeType = selfPlayerWrapper:getRoseWarGradeType()
  if isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_MENU) == true then
    if selfPlayerRoseWarGradeType == __eRoseWarPlayerGradeType_Commander or selfPlayerRoseWarGradeType == __eRoseWarPlayerGradeType_SubCommander then
      if PaGlobalFunc_RoseWarCommand_IsShow() == true then
        PaGlobalFunc_RoseWarCommand_Close()
      else
        local mousePosRate = self:getCurrentMousePosRateOnMiniMap()
        local worldPosition = self:calcMiniMapPosRateToActorPosition(mousePosRate.x, mousePosRate.y)
        PaGlobalFunc_RoseWarCommand_OpenByMiniMap(selfPlayerRoseWarGradeType, worldPosition)
      end
    elseif selfPlayerRoseWarGradeType == __eRoseWarPlayerGradeType_GuildPartyLeader then
      return
    elseif selfPlayerRoseWarGradeType == __eRoseWarPlayerGradeType_GuildMember then
      return
    elseif selfPlayerRoseWarGradeType == __eRoseWarPlayerGradeType_MercenaryPartyLeader then
      return
    elseif selfPlayerRoseWarGradeType == __eRoseWarPlayerGradeType_Mercenary then
      return
    else
      UI.ASSERT_NAME(false, "\235\130\152\236\157\152 \236\158\165\235\175\184\236\160\132\236\159\129 GradeType\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164!", "\236\157\180\236\163\188")
      return
    end
  elseif selfPlayerRoseWarGradeType == __eRoseWarPlayerGradeType_Commander and ToClient_GetRoseWarSelectIconListCount() > 0 then
    local mousePosRate = self:getCurrentMousePosRateOnMiniMap()
    local worldPosition = self:calcMiniMapPosRateToActorPosition(mousePosRate.x, mousePosRate.y)
    ToClient_ProcessRoseWarCommandEvent(__eRoseWarCommandEventType_Move, worldPosition, false)
    self:showMiniMapMovePin(mousePosRate)
  else
    if ToClient_IsShowNaviGuideGroup(0) == true then
      self:hideMiniMapPin()
      ToClient_clearShowAALineList()
      ToClient_DeleteNaviGuideByGroup(0)
      return
    end
    local mousePosRate = self:getCurrentMousePosRateOnMiniMap()
    local worldPosition = self:calcMiniMapPosRateToActorPosition(mousePosRate.x, mousePosRate.y)
    local drawNaviKey = ToClient_WorldMapNaviStart(worldPosition, NavigationGuideParam(), false, true)
    if drawNaviKey ~= -1 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PROCMESSAGE_QUEST_ALEADY_FINDWAY"))
      self:showMiniMapPin(mousePosRate)
    end
  end
end
function PaGlobalFunc_RoseWarMiniMap_ConvertWorldMapPosToMinimapBGRate(worldPos)
  local self = PaGlobal_RoseWarMiniMap
  if self == nil or worldPos == nil or worldPos.x == nil or worldPos.y == nil then
    return nil
  end
  local worldPosXZ = {
    x = worldPos.x,
    z = worldPos.y
  }
  local totalMiniMapPosRate = self:calcWorldPositionToMiniMapPosRate(worldPosXZ)
  local rv = {
    x = self._miniMapControl:GetParentPosX() + self:getMiniMapSizeX() * totalMiniMapPosRate.x,
    y = self._miniMapControl:GetParentPosY() + self:getMiniMapSizeY() * totalMiniMapPosRate.y
  }
  return rv
end
function RoseWarMiniMap_SetNavigation(fromUserNo, worldPosition)
  local self = PaGlobal_RoseWarMiniMap
  if self == nil or fromUserNo == nil or worldPosition == nil then
    return
  end
  if getSelfPlayer():get():getUserNo() ~= fromUserNo then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoReceivedRoseWarMiniMapNavigation"))
  end
  RoseWarMiniMap_SetNavigationWithoutFromUserNo(worldPosition, false)
end
function RoseWarMiniMap_SetNavigationWithoutFromUserNo(worldPosition, useNotify)
  local self = PaGlobal_RoseWarMiniMap
  if self == nil or worldPosition == nil then
    return
  end
  if ToClient_IsShowNaviGuideGroup(0) == true then
    self:hideMiniMapPin()
    ToClient_clearShowAALineList()
    ToClient_DeleteNaviGuideByGroup(0)
  end
  local posRate = self:calcWorldPositionToMiniMapPosRate(worldPosition)
  local drawNaviKey = ToClient_WorldMapNaviStart(worldPosition, NavigationGuideParam(), false, false)
  audioPostEvent_SystemUi(0, 14)
  _AudioPostEvent_SystemUiForXBOX(0, 14)
  if useNotify == true and drawNaviKey ~= -1 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PROCMESSAGE_QUEST_ALEADY_FINDWAY"))
  end
  self:showMiniMapPin(posRate)
end
function PaGlobalFunc_RoseWarMiniMap_GetGradeTypeString(gradeType)
  if gradeType == __eRoseWarPlayerGradeType_Commander then
    return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ROSEWAR_WORLDMAP_TOOLTIP_COMMANDER")
  elseif gradeType == __eRoseWarPlayerGradeType_SubCommander then
    return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ROSEWAR_WORLDMAP_TOOLTIP_SUBCOMMANDER")
  elseif gradeType == __eRoseWarPlayerGradeType_GuildPartyLeader or gradeType == __eRoseWarPlayerGradeType_MercenaryPartyLeader then
    return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ROSEWAR_WORLDMAP_TOOLTIP_CAPTAIN")
  elseif gradeType == __eRoseWarPlayerGradeType_GuildMember then
    return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ROSEWAR_WORLDMAP_TOOLTIP_GUILDMEMBER")
  elseif gradeType == __eRoseWarPlayerGradeType_Mercenary then
    return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ROSEWAR_WORLDMAP_TOOLTIP_MERCENARY")
  elseif gradeType == __eRoseWarPlayerGradeType_EnemyCommander then
    return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ROSEWAR_WORLDMAP_TOOLTIP_ENEMYCOMMANDER")
  elseif gradeType == __eRoseWarPlayerGradeType_EnemySubCommander then
    return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ROSEWAR_WORLDMAP_TOOLTIP_ENEMYSUBCOMMANDER")
  elseif gradeType == __eRoseWarPlayerGradeType_EnemyGuildPartyLeader or gradeType == __eRoseWarPlayerGradeType_EnemyMercenaryPartyLeader then
    return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ROSEWAR_WORLDMAP_TOOLTIP_ENEMYCAPTAIN")
  elseif gradeType == __eRoseWarPlayerGradeType_EnemyGuildMember then
    return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ROSEWAR_WORLDMAP_TOOLTIP_ENEMYMEMBER")
  elseif gradeType == __eRoseWarPlayerGradeType_EnemyMercenary then
    return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ROSEWAR_WORLDMAP_TOOLTIP_ENEMYMERCENARY")
  else
    UI.ASSERT_NAME(false, "RoseWarGradeType\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164. \237\131\128\236\158\133\236\157\180 \236\182\148\234\176\128\235\144\152\235\169\180 \236\151\172\234\184\176\235\143\132 \236\158\145\236\151\133\237\149\180\236\163\188\236\132\184\236\154\148.", "\236\157\180\236\163\188")
    return nil
  end
end
function FromClient_RoseWarMiniMap_OnScreenSize()
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  if ToClient_IsParticipateInRoseWar() == false and ToClient_IsRoseWarObserveMode() == false then
    return
  end
  self:ComputePanelSize()
  self:InitializeMiniMapView()
end
function FromClient_RoseWarMiniMap_ChangeRoseWarState(state)
  local self = PaGlobal_RoseWarMiniMap
  if self == nil or state == nil then
    return
  end
  if state == __eRoseWar_Start then
    ToClient_RequestRoseWarFierceBattleObjectInfo()
    ToClient_RequestRoseWarBossInfotList()
  elseif state == __eRoseWar_Stop then
    ToClient_ClearRoseWarFierceBattleObjectInfo()
    PaGlobalFunc_RoseWarMinimap_RemoveAllPing()
    self:InitializeMiniMapView()
  end
end
function FromClient_RoseWarCreateActorIcon(userNo, gradeType, isSelf)
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  self:activateActorIcon(userNo, gradeType, isSelf)
  self._ui._stc_miniMapBg:SetDepthSort()
  self._ui._stc_miniMapBg:SetRectClipOnArea(float2(0, 0), float2(self._ui._stc_miniMapBg:GetSizeX(), self._ui._stc_miniMapBg:GetSizeY()))
  self:updateAllHpBarXXX()
end
function FromClient_RoseWarRemoveActorIcon(removeUserNo)
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  self:deactivateActorIcon(removeUserNo)
end
function FromClient_RoseWarUpdateActorIcon()
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  if Panel_RoseWar_MiniMap:GetShow() == false then
    return
  end
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  self:refreshActorIcon(false)
end
function FromClient_RoseWarClearActorIcon()
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  self:clearActorIconList()
end
function FromClient_RoseWarCreateVehicleIcon(actorKeyRaw)
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  self:activateVehicleIcon(actorKeyRaw)
  self._ui._stc_miniMapBg:SetDepthSort()
  self._ui._stc_miniMapBg:SetRectClipOnArea(float2(0, 0), float2(self._ui._stc_miniMapBg:GetSizeX(), self._ui._stc_miniMapBg:GetSizeY()))
  self:updateAllHpBarXXX()
end
function FromClient_RoseWarRemoveVehicleIcon(actorKeyRaw)
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  self:deactivateVehicleIcon(actorKeyRaw)
end
function FromClient_RoseWarUpdateVehicleIcon()
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  if Panel_RoseWar_MiniMap:GetShow() == false then
    return
  end
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  self:refreshVehicleIcon(false)
end
function FromClient_RoseWarClearVehicleIcon()
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  self:clearVehicleIconList()
end
function FromClient_RoseWarAddSelectActorIcon(userNo64)
  local self = PaGlobal_RoseWarMiniMap
  if self == nil or userNo64 == nil then
    return
  end
  self:showSelectedActorIcon(userNo64)
end
function FromClient_RoseWarClearSelectActorIcon()
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  self:hideSelectedActorIcon()
end
function FromClient_RoseWarMiniMap_SetRoseWarObserveMode()
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
end
function FromClient_RoseWarMiniMap_UnsetRoseWarObserveMode()
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  self:ComputePanelSize()
  self:InitializeMiniMapView()
end
function FromClient_RoseWarCreateFierceBattleObjectIcon(fierceBattleKeyRaw, roseWarTeamNo, position)
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  self:activateFierceBattleObjectIcon(fierceBattleKeyRaw, roseWarTeamNo, position)
  self._ui._stc_miniMapBg:SetDepthSort()
  self._ui._stc_miniMapBg:SetRectClipOnArea(float2(0, 0), float2(self._ui._stc_miniMapBg:GetSizeX(), self._ui._stc_miniMapBg:GetSizeY()))
  self:updateAllHpBarXXX()
end
function FromClient_RoseWarClearFierceBattleObjectIcon()
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  self:deactivateFierceBattleObjectIconAll()
  self:deactivateBossIconAll()
end
function FromClient_UpdateRoseWarFierceBattleInfo(fierceBattleKeyRaw)
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  self:updateFierceBattleObjectIcon(fierceBattleKeyRaw)
end
function HandleEventLUp_RoseWarMiniMap_ClickedActorIcon(userNo64)
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
end
function HandleEventOnOut_RoseWarMiniMap_OnOutActorIcon(isOn, userNo32)
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  if isOn == true then
    local actorIconData = self:getActorIconDataByUserNo(userNo32)
    if actorIconData == nil then
      return
    end
    local actorIconDataWrapper = ToClient_GetRoseWarMiniMapIconDataWrapper(toInt64(0, userNo32))
    if actorIconDataWrapper == nil then
      return
    end
    local classTypeString = NewClassData.newClass_String[actorIconDataWrapper:getClassTypeRaw()]._classType2String
    if classTypeString == nil then
      classTypeString = ""
    end
    local gradeTypeString = PaGlobalFunc_RoseWarMiniMap_GetGradeTypeString(actorIconDataWrapper:getGradeType())
    local control = actorIconData._actorIcon
    local name = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDLIST_FAMILYNAME", "name", actorIconDataWrapper:getUserName())
    local desc = "- " .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_WORLDMAP_TOOLTIP_DUTY", "param", gradeTypeString) .. "\n" .. "- " .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_WORLDMAP_TOOLTIP_CLASS", "param", classTypeString) .. "\n" .. "- " .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_WORLDMAP_TOOLTIP_LEVEL", "param", actorIconDataWrapper:getLevel())
    if control ~= nil then
      TooltipSimple_Show(control, name, desc)
    end
  else
    TooltipSimple_Hide()
  end
end
function HandleEventOnOut_RoseWarMiniMap_OnOutVehicleIcon(isOn, actorKeyRaw)
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  if isOn == true then
    local vehicleIconData = self:getVehicleIconDataByActorKeyRaw(actorKeyRaw)
    if vehicleIconData == nil then
      return
    end
    local vehicleIconDataWrapper = ToClient_GetRoseWarMiniMapVehicleIconDataWrapper(actorKeyRaw)
    if vehicleIconDataWrapper == nil then
      return
    end
    local vehicleType = vehicleIconDataWrapper:getVehicleType()
    local vehicleSubType = vehicleIconDataWrapper:getVehicleSubType()
    local vehicleString
    if vehicleType == __eVehicleType_Cannon and vehicleSubType == 0 then
      vehicleString = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_WORLDMAP_TOOLTIP_WARWEAPON_0")
    elseif vehicleType == __eVehicleType_Ballista and vehicleSubType == 0 then
      vehicleString = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_WORLDMAP_TOOLTIP_WARWEAPON_1")
    elseif vehicleType == __eVehicleType_Tank and vehicleSubType == 0 then
      vehicleString = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_WORLDMAP_TOOLTIP_WARWEAPON_2")
    elseif vehicleType == __eVehicleType_MonsterRide and vehicleSubType == 0 then
      vehicleString = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_WORLDMAP_TOOLTIP_WARWEAPON_3")
    elseif vehicleType == __eVehicleType_Elephant and vehicleSubType == 0 then
      vehicleString = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_WORLDMAP_TOOLTIP_WARWEAPON_4")
    else
      UI.ASSERT_NAME(false, "\236\158\165\235\175\184\236\160\132\236\159\129 \235\175\184\235\139\136\235\167\181 \234\179\181\236\132\177\235\179\145\234\184\176 \236\149\132\236\157\180\236\189\152 \237\131\128\236\158\133\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164! \236\151\172\234\184\176\235\143\132 \236\178\152\235\166\172\237\149\180\236\163\188\236\132\184\236\154\148.", "\236\157\180\236\163\188")
      return
    end
    local control = vehicleIconData._vehicleIcon
    local name = vehicleString
    local desc = ""
    if control ~= nil then
      TooltipSimple_Show(control, name, desc)
    end
  else
    TooltipSimple_Hide()
  end
end
function HandleEventRUp_RoseWarMiniMap_VehicleIcon(actorKeyRaw)
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  if ToClient_IsRoseWarObserveMode() == true then
    return
  end
  local vehicleIconDataWrapper = ToClient_GetRoseWarMiniMapVehicleIconDataWrapper(actorKeyRaw)
  if vehicleIconDataWrapper == nil then
    return
  end
  if ToClient_IsShowNaviGuideGroup(0) == true then
    self:hideMiniMapPin()
    ToClient_clearShowAALineList()
    ToClient_DeleteNaviGuideByGroup(0)
  end
  local worldPosition = vehicleIconDataWrapper:getPosition()
  RoseWarMiniMap_SetNavigationWithoutFromUserNo(worldPosition, true)
end
function HandleEventLUp_RoseWarMiniMap_ClickedMarkerIcon(index)
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local selfPlayerRoseWarGradeType = selfPlayerWrapper:getRoseWarGradeType()
  if selfPlayerRoseWarGradeType ~= __eRoseWarPlayerGradeType_Commander then
    return
  end
  local markerIconData = self._miniMapMarkerList[index]
  if markerIconData == nil then
    return
  end
  if markerIconData._eventType < __eRoseWarCommandEventType_Ping_Red or markerIconData._eventType > __eRoseWarCommandEventType_Ping_Yellow then
    return
  end
  ToClient_RequestRemoveRoseWarPing(markerIconData._eventType)
end
function HandleEventOnOut_RoseWarMiniMap_OnOutMarkerIcon(isOn, index)
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
end
function HandleEventLUp_RoseWarMiniMap_ClickedFierceBattleObjectIcon(fierceBattleKeyRaw, isGimmick)
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  if IsSelfPlayerRoseWarGrade_Commander() == false and IsSelfPlayerRoseWarGrade_SubCommander() == false then
    return
  end
  if IsSelfPlayerRoseWarGrade_Commander() == true and PaGlobalFunc_RoseWarTeamSkillManager_isUsingSkill() == true and isGimmick == false then
    PaGlobalFunc_RoseWarTeamSkillManager_UpdateFierceBattleKey(fierceBattleKeyRaw)
    PaGlobalFunc_RoseWarTeamSkillManager_UseRoseWarSkill(__eRoseWarSkillType_Recall)
    PaGlobalFunc_RoseWarTeamSkillManager_UseRoseWarSkill(__eRoseWarSkillType_Bombard)
    PaGlobalFunc_RoseWarTeamSkillManager_UseRoseWarSkill(__eRoseWarSkillType_Summon)
    PaGlobalFunc_RoseWarTeamSkillManager_UseRoseWarSkill(__eRoseWarSkillType_Zonya)
    PaGlobalFunc_RoseWarTeamSkillManager_UseRoseWarSkill(__eRoseWarSkillType_FixedResurrection)
    return
  end
  if isGimmick == true then
    PaGlobalFunc_RoseWarMission_Open(PaGlobal_RoseWarMission._eOpenMode._SET_GIMMICK_FIERCE, fierceBattleKeyRaw)
  else
    PaGlobalFunc_RoseWarMission_Open(PaGlobal_RoseWarMission._eOpenMode._SET_FIERCE_BATTLE, fierceBattleKeyRaw)
  end
end
function HandleEventOnOut_RoseWarMiniMap_OnOutFierceBattleObjectIcon(fierceBattleKeyRaw, isShow)
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  local fierceBattleIconData = PaGlobal_RoseWarMiniMap:getFierceBattleObjectIconData(fierceBattleKeyRaw)
  if fierceBattleIconData == nil then
    return
  end
  RoseWarMinimap_ShowFierceBattleObjectTooltip(false, -1, fierceBattleKeyRaw, isShow)
  fierceBattleIconData._isFocused = isShow
end
function HandleEventRUp_RoseWarMiniMap_RClickedFierceBattleObjectIcon(fierceBattleKeyRaw)
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  if ToClient_IsRoseWarObserveMode() == true then
    return
  end
  if self._miniMapFierceBattleIconList == nil then
    return
  end
  local fierceBattleObjectInfoWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapper(fierceBattleKeyRaw)
  if fierceBattleObjectInfoWrapper == nil then
    return
  end
  if ToClient_IsShowNaviGuideGroup(0) == true then
    self:hideMiniMapPin()
    ToClient_clearShowAALineList()
    ToClient_DeleteNaviGuideByGroup(0)
  end
  local worldPosition = fierceBattleObjectInfoWrapper:getPosition()
  RoseWarMiniMap_SetNavigationWithoutFromUserNo(worldPosition, true)
end
function HandleEventRUp_RoseWarMiniMap_RClickedRoseWarBossIcon(teamNo)
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  if ToClient_IsRoseWarObserveMode() == true then
    return
  end
  local iconData = self._miniMapBossIconList[teamNo]
  if iconData == nil then
    return
  end
  if ToClient_IsShowNaviGuideGroup(0) == true then
    self:hideMiniMapPin()
    ToClient_clearShowAALineList()
    ToClient_DeleteNaviGuideByGroup(0)
    return
  end
  local worldPosition = iconData._position
  RoseWarMiniMap_SetNavigationWithoutFromUserNo(worldPosition, true)
end
function PaGlobalFunc_RoseWarMiniMap_UpdatePreblendSightInfo(deltaTime)
  PaGlobal_RoseWarMiniMap:updatePreblendSightInfo(deltaTime)
end
function PaGlobalFunc_RoseWarMiniMap_UpdateFierceBattleObjectIconTextureAll()
  PaGlobal_RoseWarMiniMap:updateFierceBattleObjectIconTextureAll()
end
function HandleEventLUp_RoseWarMiniMap_LClickedBossIcon(roseWarTeamNo)
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  if ToClient_IsRoseWarObserveMode() == true then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local selfPlayerTeamNo = selfPlayerWrapper:getRoseWarTeamNo()
  if selfPlayerTeamNo == roseWarTeamNo then
    PaGlobalFunc_RoseWarMission_Open(PaGlobal_RoseWarMission._eOpenMode._SET_MY_CASTLE, roseWarTeamNo)
  else
    PaGlobalFunc_RoseWarMission_Open(PaGlobal_RoseWarMission._eOpenMode._SET_ENEMY_CASTLE, roseWarTeamNo)
  end
end
function HandleEventOnOut_RoseWarMiniMap_OnOutBossIcon(roseWarTeamNo, isShow)
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  RoseWarMinimap_ShowFierceBattleObjectTooltip(true, roseWarTeamNo, -1, isShow)
end
function RoseWarMinimap_ShowFierceBattleObjectTooltip(isCommander, teamNo, fierceBattleKeyRaw, isShow)
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  self:setShowMiniMapFierceBattleObjectTooltip(isCommander, teamNo, fierceBattleKeyRaw, isShow)
end
function RoseWarMinimap_GetRoseWarGimicFierceBattleObjectBuffIcon(roseWarGimicFierceBattleBuffType)
  if roseWarGimicFierceBattleBuffType == __eRoseWarGimicFierceBattleBuffType_Skill then
    return "Combine_Etc_RoseWar_Command_Wight_Icon_Buff_1"
  elseif roseWarGimicFierceBattleBuffType == __eRoseWarGimicFierceBattleBuffType_Spawn then
    return "Combine_Etc_RoseWar_Command_Wight_Icon_Buff_2"
  elseif roseWarGimicFierceBattleBuffType == __eRoseWarGimicFierceBattleBuffType_Item then
    return "Combine_Etc_RoseWar_Command_Wight_Icon_Buff_3"
  elseif roseWarGimicFierceBattleBuffType == __eRoseWarGimicFierceBattleBuffType_Count then
    return ""
  end
end
function FromClient_RoseWarUpdateBossInfo(roseWarTeamNo)
  local roseWarBossInfo = ToClient_GetRoseWarBossInfoXXX(roseWarTeamNo)
  if roseWarBossInfo ~= nil then
    PaGlobal_RoseWarMiniMap:updateMiniMapBossObject(roseWarTeamNo)
  end
end
function PaGlobalFunc_RoseWarMiniMap_HideMinimapPin()
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  self:hideMiniMapPin()
end
function PaGlobalFunc_RoseWarMinimap_ShowMinimapPin(posRate)
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  self:showMiniMapPin(posRate)
end
function PaGlobalFunc_RoseWarMinimap_RemoveAllPing()
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  for pingType = 0, __eRoseWarCommandEventType_Count do
    self:removePingAndMarkerByPingType(pingType)
  end
end
function PaGlobalFunc_RoseWarMiniMap_ToggleChattingUI(setForceRelease)
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  local doIgnore = false
  if setForceRelease ~= nil and setForceRelease == true then
    doIgnore = false
  else
    doIgnore = self._ui._chk_toggleChatting:IsCheck() == false
  end
  Panel_Chat0:SetIgnoreRenderAndEvent(doIgnore)
  Panel_Chat1:SetIgnoreRenderAndEvent(doIgnore)
  Panel_Chat2:SetIgnoreRenderAndEvent(doIgnore)
  Panel_Chat3:SetIgnoreRenderAndEvent(doIgnore)
  Panel_Chat4:SetIgnoreRenderAndEvent(doIgnore)
end
function FromClient_ResponseRoseWarFierceBattleMonsterDead(fierceBattleKeyRaw, nextRespawnTime)
  PaGlobal_RoseWarMiniMap:setFierceBattleObjectRespawnTime(fierceBattleKeyRaw, nextRespawnTime)
end
function FromClient_ResponseRoseWarGimmickFierceBattleObjectAdrenalin(fierceBattleKeyRaw, adrenalinPoint)
  PaGlobal_RoseWarMiniMap:updateGimmickFierceBattleObjectIcon(fierceBattleKeyRaw, adrenalinPoint)
  PaGlobal_RoseWarMiniMap:updateHpBarFireceBattleObjectTooltip(fierceBattleKeyRaw, false)
end
function FromClient_RoseWarRemovePing(pingType)
  local self = PaGlobal_RoseWarMiniMap
  if self == nil then
    return
  end
  self:removePingAndMarkerByPingType(pingType)
end
