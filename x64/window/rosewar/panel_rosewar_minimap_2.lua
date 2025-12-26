function PaGlobal_RoseWarMiniMap:makeMiniMap(teamNo)
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  local teamStr
  if teamNo == Defines.RoseWarTeamNo.KAMASYLVIA then
    teamStr = "kama"
  elseif teamNo == Defines.RoseWarTeamNo.ODYLLITA then
    teamStr = "odil"
  else
    UI.ASSERT_NAME(false, "[a] \236\158\165\235\175\184\236\160\132\236\159\129 \235\175\184\235\139\136\235\167\181 \236\131\157\236\132\177 \236\139\164\237\140\168! RoseWarTeamNo \234\176\146\236\157\180 \235\185\132\236\160\149\236\131\129\236\157\180\235\139\164!", "\236\157\180\236\163\188")
  end
  local newImageSize = math.floor(self._currentMiniMapRate * self._miniMapSectorGridTextureSize)
  self._miniMapImageSizeXY.x = (math.abs(self._endSectorIndexXZ.x - self._beginSectorIndexXZ.x) + 1) * newImageSize
  self._miniMapImageSizeXY.y = (math.abs(self._endSectorIndexXZ.y - self._beginSectorIndexXZ.y) + 1) * newImageSize
  local controlImagePath = "New_UI_Common_forLua/Widget/Rader/ElfWar/ElfWarMap_" .. tostring(self._beginSectorIndexXZ.x) .. "_" .. tostring(self._beginSectorIndexXZ.y) .. "_" .. tostring(self._endSectorIndexXZ.x) .. "_" .. tostring(self._endSectorIndexXZ.y) .. "_" .. tostring(teamStr) .. ".dds"
  local newControl = UI.createControl(__ePAUIControl_Static, self._ui._stc_miniMapBg, "Static_MiniMap_Image_" .. tostring(teamStr))
  if newControl == nil then
    UI.ASSERT_NAME(false, "\236\158\165\235\175\184\236\160\132\236\159\129 \235\175\184\235\139\136\235\167\181 \234\181\172\236\132\177 \236\187\168\237\138\184\235\161\164 \236\131\157\236\132\177 \236\139\164\237\140\168. \236\136\152\236\160\149\236\157\180 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164. \235\176\156\236\131\157\236\139\156 \236\160\156\235\179\180 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  newControl:SetShow(true)
  newControl:SetIgnore(true)
  newControl:SetSize(self._miniMapImageSizeXY.x, self._miniMapImageSizeXY.y)
  newControl:SetPosX(0)
  newControl:SetPosY(0)
  newControl:SetColor(4294967295)
  newControl:SetDepth(self._eRenderOrder.MINIMAP_TEXTURE)
  newControl:ChangeTextureInfoNameForRadarBackground(controlImagePath)
  local teamStr
  if teamNo == Defines.RoseWarTeamNo.KAMASYLVIA then
    UI.ASSERT_NAME(self._miniMapBgTexture_Kamasilvia == nil, "\236\185\180\235\167\136\236\139\164\235\185\132\236\149\132 \237\133\141\236\138\164\236\179\144\234\176\128 \236\157\180\235\175\184 \235\167\140\235\147\164\236\150\180\236\160\184\236\158\136\235\139\164! \235\176\156\236\131\157\236\139\156 \236\160\156\235\179\180 \235\176\148\235\158\140!", "\236\157\180\236\163\188")
    self._miniMapBgTexture_Kamasilvia = newControl
  elseif teamNo == Defines.RoseWarTeamNo.ODYLLITA then
    UI.ASSERT_NAME(self._miniMapBgTexture_Odilita == nil, "\236\152\164\235\148\156\235\166\172\237\131\128 \237\133\141\236\138\164\236\179\144\234\176\128 \236\157\180\235\175\184 \235\167\140\235\147\164\236\150\180\236\160\184\236\158\136\235\139\164! \235\176\156\236\131\157\236\139\156 \236\160\156\235\179\180 \235\176\148\235\158\140!", "\236\157\180\236\163\188")
    self._miniMapBgTexture_Odilita = newControl
  else
    UI.ASSERT_NAME(false, "[b] \236\158\165\235\175\184\236\160\132\236\159\129 \235\175\184\235\139\136\235\167\181 \236\131\157\236\132\177 \236\139\164\237\140\168! RoseWarTeamNo \234\176\146\236\157\180 \235\185\132\236\160\149\236\131\129\236\157\180\235\139\164!", "\236\157\180\236\163\188")
  end
end
function PaGlobal_RoseWarMiniMap:makeMiniMapPinData()
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  self._miniMapPinData = {
    _control = UI.getChildControl(self._ui._stc_miniMapBg, "Static_Pin_FindWay"),
    _lastCalcPosRate = float2(0, 0)
  }
end
function PaGlobal_RoseWarMiniMap:makeMiniMapMovePinData()
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  self._miniMapMovePinData = {
    _control = UI.getChildControl(self._ui._stc_miniMapBg, "Static_Pin_Move"),
    _lastCalcPosRate = float2(0, 0)
  }
end
function PaGlobal_RoseWarMiniMap:makeMiniMapDragSelectData()
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  self._miniMapDragSelectData = {
    _control = UI.getChildControl(self._ui._stc_miniMapBg, "Static_SelectArea"),
    _beginWorldPos = float3(0, 0, 0),
    _endWorldPos = float3(0, 0, 0)
  }
  self._miniMapDragSelectData._control:SetSize(0, 0)
  self._miniMapDragSelectData._control:SetAlpha(1)
  self._miniMapDragSelectData._control:SetShow(false)
end
function PaGlobal_RoseWarMiniMap:getMiniMapRowCount()
  if Panel_RoseWar_MiniMap == nil then
    return nil
  end
  return self._endSectorIndexXZ.x - self._beginSectorIndexXZ.x + 1
end
function PaGlobal_RoseWarMiniMap:getMiniMapColCount()
  if Panel_RoseWar_MiniMap == nil then
    return nil
  end
  return self._beginSectorIndexXZ.y - self._endSectorIndexXZ.y + 1
end
function PaGlobal_RoseWarMiniMap:getCurrentImageSize()
  local rv = float2(0, 0)
  if Panel_RoseWar_MiniMap == nil then
    return rv
  end
  rv.x = math.floor(self._currentMiniMapRate * self._miniMapImageSizeXY.x)
  rv.y = math.floor(self._currentMiniMapRate * self._miniMapImageSizeXY.y)
  return rv
end
function PaGlobal_RoseWarMiniMap:getMiniMapSizeX()
  if Panel_RoseWar_MiniMap == nil then
    return nil
  end
  return self:getCurrentImageSize().x
end
function PaGlobal_RoseWarMiniMap:getMiniMapSizeY()
  if Panel_RoseWar_MiniMap == nil then
    return nil
  end
  return self:getCurrentImageSize().y
end
function PaGlobal_RoseWarMiniMap:getMiniMapScrollRate()
  if Panel_RoseWar_MiniMap == nil then
    return nil
  end
  local maxRate = self._miniMapImageRateMax - self._miniMapImageRateMin
  local curRate = self._currentMiniMapRate - self._miniMapImageRateMin
  return curRate / maxRate
end
function PaGlobal_RoseWarMiniMap:getMiniMapCenterPosX()
  if Panel_RoseWar_MiniMap == nil then
    return 0
  end
  return self._ui._stc_miniMapBg:GetPosX() + self._ui._stc_miniMapBg:GetSizeX() / 2
end
function PaGlobal_RoseWarMiniMap:getMiniMapCenterPosY()
  if Panel_RoseWar_MiniMap == nil then
    return 0
  end
  return self._ui._stc_miniMapBg:GetPosY() + self._ui._stc_miniMapBg:GetSizeY() / 2
end
function PaGlobal_RoseWarMiniMap:getMiniMapControlMinPosX()
  if Panel_RoseWar_MiniMap == nil then
    return -1
  end
  return math.abs(self:getMiniMapSizeX() - self._ui._stc_miniMapBg:GetSizeX())
end
function PaGlobal_RoseWarMiniMap:getMiniMapControlMinPosY()
  if Panel_RoseWar_MiniMap == nil then
    return -1
  end
  return math.abs(self:getMiniMapSizeY() - self._ui._stc_miniMapBg:GetSizeY())
end
function PaGlobal_RoseWarMiniMap:getCurrentMousePosRateOnMiniMap()
  local rv = float2(0, 0)
  if Panel_RoseWar_MiniMap == nil then
    return rv
  end
  if self._miniMapControl == nil then
    return rv
  end
  local minimap_left = self._ui._stc_miniMapBg:GetPosX()
  local minimap_top = self._ui._stc_miniMapBg:GetPosY()
  local minimap_right = minimap_left + self._ui._stc_miniMapBg:GetSizeX()
  local minimap_bottom = minimap_top + self._ui._stc_miniMapBg:GetSizeY()
  local currentMousePosX = getMousePosX() - minimap_left
  if minimap_left > currentMousePosX then
    currentMousePosX = minimap_left
  elseif minimap_right < currentMousePosX then
    currentMousePosX = minimap_right
  end
  local currentMousePosY = getMousePosY() - minimap_top
  if minimap_top > currentMousePosY then
    currentMousePosY = minimap_top
  elseif minimap_bottom < currentMousePosY then
    currentMousePosY = minimap_bottom
  end
  rv.x = (math.abs(self._miniMapControl:GetPosX()) + currentMousePosX) / self:getMiniMapSizeX()
  rv.y = (math.abs(self._miniMapControl:GetPosY()) + currentMousePosY) / self:getMiniMapSizeY()
  return rv
end
function PaGlobal_RoseWarMiniMap:getMiniMapLTRB()
  local rv = {
    left = self._ui._stc_miniMapBg:GetPosX(),
    top = self._ui._stc_miniMapBg:GetPosY(),
    right = self._ui._stc_miniMapBg:GetPosX() + self._ui._stc_miniMapBg:GetSizeX(),
    bottom = self._ui._stc_miniMapBg:GetPosY() + self._ui._stc_miniMapBg:GetSizeY()
  }
  return rv
end
function PaGlobal_RoseWarMiniMap:ComputePanelSize()
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  self._ui._stc_miniMapBg:SetSize(getScreenSizeX() * 0.96875, getScreenSizeY() * 0.91296)
  self._ui._stc_miniMapBg:SetIgnore(false)
  self._ui._stc_miniMapBg:SetDepthSort()
  self._ui._stc_miniMapBg:SetRectClipOnArea(float2(0, 0), float2(self._ui._stc_miniMapBg:GetSizeX(), self._ui._stc_miniMapBg:GetSizeY()))
  self._ui._stc_miniMapNavigationGuideBg:SetSize(self._ui._stc_miniMapBg:GetSizeX(), self._ui._stc_miniMapBg:GetSizeY())
  local keyGuides = Array.new()
  keyGuides:push_back(self._ui._chk_togglePartyList)
  keyGuides:push_back(self._ui._chk_toggleEditParty)
  keyGuides:push_back(self._ui._chk_toggleRoseWarMission)
  keyGuides:push_back(self._ui._chk_toggleChatting)
  keyGuides:push_back(self._ui._chk_toggleScoreBoard)
  keyGuides:push_back(self._ui._stc_naviGuide)
  keyGuides:push_back(self._ui._stc_dragGuide)
  keyGuides:push_back(self._ui._stc_pingGuide)
  local guideSpanTerm = 20
  local guideSpanX = 55
  local showCount = 0
  for index = 1, #keyGuides do
    local guide = keyGuides[index]
    if guide ~= nil and guide:GetShow() == true then
      local txt_desc = UI.getChildControl(guide, "StaticText_Desc")
      txt_desc:SetSize(txt_desc:GetTextSizeX(), guide:GetSizeY())
      guide:SetSpanSize(guideSpanX, guide:GetSpanSize().y)
      showCount = showCount + 1
      guideSpanX = guideSpanX + txt_desc:GetSpanSize().x + txt_desc:GetSizeX() + guideSpanTerm
    end
  end
  self._ui._btn_moveMapToSelfPlayerPos:SetPosX(self._ui._stc_miniMapBg:GetPosX() + self._ui._stc_miniMapBg:GetSizeX() - self._ui._btn_moveMapToSelfPlayerPos:GetSizeX() - 10)
  self._ui._btn_moveMapToSelfPlayerPos:SetPosY(self._ui._stc_miniMapBg:GetPosY() + self._ui._stc_miniMapBg:GetSizeY() - self._ui._btn_moveMapToSelfPlayerPos:GetSizeY() - 10)
  Panel_RoseWar_MiniMap:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_RoseWar_MiniMap:ComputePosAllChild()
  self._miniMapBGLimitMinXY.x = 0
  self._miniMapBGLimitMinXY.y = 0
  self._miniMapBGLimitMaxXY.x = self._ui._stc_miniMapBg:GetSizeX()
  self._miniMapBGLimitMaxXY.y = self._ui._stc_miniMapBg:GetSizeY()
end
function PaGlobal_RoseWarMiniMap:InitializeMiniMapView()
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  self._currentMiniMapRate = 1
  self:refreshMiniMapImagePos(true)
  self:updateMiniMapPinPos()
  self:updateMiniMapMovePinPos()
  self:refreshMiniMapActorIconPos(true)
  self:refreshMiniMapVehicleIconPos(true)
  self:refreshMiniMapMarkerIconPos(true)
  self:refreshMiniMapFierceBattleObjectIconPos(true)
end
function PaGlobal_RoseWarMiniMap:requestUpdateMiniMapToServer(deltaTime)
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  self._accumulatedDeltaTime = self._accumulatedDeltaTime + deltaTime
  if self._updateCycleTime < self._accumulatedDeltaTime then
    ToClient_RequestUpdateRoseWarMiniMap()
    self._accumulatedDeltaTime = 0
  end
end
function PaGlobal_RoseWarMiniMap:clearDragControl()
  self._miniMapDragSelectData._control:SetSize(0, 0)
  self._miniMapDragSelectData._control:SetShow(false)
end
function PaGlobal_RoseWarMiniMap:updateMiniMapInputProcess_SkillMode(deltaTime)
  self:clearDragControl()
  local isPressed_W = isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_W)
  local isPressed_A = isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_A)
  local isPressed_S = isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_S)
  local isPressed_D = isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_D)
  local isPressed_LButton = isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_LBUTTON)
  local isKeyUp_1 = isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_1)
  local isKeyUp_2 = isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_2)
  local isKeyUp_3 = isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_3)
  local isKeyUp_4 = isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_4)
  local isKeyUp_5 = isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_5)
  local isKeyUp_6 = isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_6)
  local isKeyUp_7 = isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_7)
  local isKeyUp_M = isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_M)
  local isKeyUp_ESC = isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_ESCAPE)
  local isSkillBoundKeys = isKeyUp_1 == true or isKeyUp_2 == true or isKeyUp_3 == true or isKeyUp_4 == true or isKeyUp_5 == true or isKeyUp_6 == true or isKeyUp_7 == true or isKeyUp_ESC == true
  local isMouseMove = isMouseMove() and isPressed_LButton == true
  local isKeyboardMoveKeys = isPressed_W == true or isPressed_A == true or isPressed_S == true or isPressed_D == true
  if isKeyUp_M == true then
    PaGlobalFunc_RoseWarMain_Close()
  elseif isSkillBoundKeys == true then
    local selectedSkillType
    if isKeyUp_ESC == true then
    elseif isKeyUp_1 == true then
      selectedSkillType = __eRoseWarSkillType_Scan
    elseif isKeyUp_2 == true then
      selectedSkillType = __eRoseWarSkillType_Recall
    elseif isKeyUp_3 == true then
      selectedSkillType = __eRoseWarSkillType_Bombard
    elseif isKeyUp_4 == true then
      selectedSkillType = __eRoseWarSkillType_Summon
    elseif isKeyUp_5 == true then
      selectedSkillType = __eRoseWarSkillType_Conceal
    elseif isKeyUp_6 == true then
      selectedSkillType = __eRoseWarSkillType_Zonya
    elseif isKeyUp_7 == true then
      selectedSkillType = __eRoseWarSkillType_FixedResurrection
    else
      return
    end
    if isKeyUp_ESC == true or selectedSkillType == PaGlobalFunc_RoseWarTeamSkillManager_GetSelectedSkillType() then
      PaGlobalFunc_RoseWarTeamSkillManager_Clear()
    else
      PaGlobalFunc_RoseWarTeamSkillManager_SelectSkillType(selectedSkillType)
    end
  elseif isMouseMove == true then
    local mouseMoveX = getMouseMoveX()
    local mouseMoveY = getMouseMoveY()
    if mouseMoveX ~= 0 or mouseMoveY ~= 0 then
      self:moveMiniMap(mouseMoveX, mouseMoveY, false)
    end
  elseif isKeyboardMoveKeys == true then
    local moveX = 0
    local moveY = 0
    local moveValue = 10
    if isPressed_W == true then
      moveY = moveY + moveValue
    elseif isPressed_S == true then
      moveY = moveY - moveValue
    end
    if isPressed_A == true then
      moveX = moveX + moveValue
    elseif isPressed_D == true then
      moveX = moveX - moveValue
    end
    if moveX ~= 0 or moveY ~= 0 then
      self:moveMiniMap(moveX, moveY, false)
    end
  end
end
function PaGlobal_RoseWarMiniMap:updateMiniMapMoveAnimation(deltaTime)
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  if self:isMiniMapMoveAnimation() == false then
    return
  end
  self._miniMapMoveAnimationInfo._timeRatio = self._miniMapMoveAnimationInfo._timeRatio + deltaTime / self._miniMapMoveAnimationInfo._animationDeltaTime
  if self._miniMapMoveAnimationInfo._timeRatio >= 1 then
    self:clearMiniMapMoveAnimationInfo()
    return
  end
  local moveX = self._miniMapMoveAnimationInfo._moveX * self._miniMapMoveAnimationInfo._timeRatio
  local moveY = self._miniMapMoveAnimationInfo._moveY * self._miniMapMoveAnimationInfo._timeRatio
  self:moveMiniMap(moveX, moveY, false)
  self._miniMapMoveAnimationInfo._moveX = self._miniMapMoveAnimationInfo._moveX - moveX
  self._miniMapMoveAnimationInfo._moveY = self._miniMapMoveAnimationInfo._moveY - moveY
end
function PaGlobal_RoseWarMiniMap:updateMiniMapInputProcess(deltaTime)
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  if Panel_RoseWar_Mission:CheckDrag() == true then
    return
  end
  if Panel_RoseWar_MiniMapPartyList:CheckDrag() == true then
    return
  end
  if Panel_RoseWar_ScoreBoard:CheckDrag() == true then
    return
  end
  local isMiniMapMoveAnimation = self:isMiniMapMoveAnimation()
  local isCommander = IsSelfPlayerRoseWarGrade_Commander()
  local isSubCommander = IsSelfPlayerRoseWarGrade_SubCommander()
  local isMissionMaker = isCommander == true or isSubCommander == true
  local isShowEditPartyUI = PaGlobalFunc_RoseWarEditParty_IsShow()
  local isInMouseMissionUI = IsMouseInRoseWarPanel(Panel_RoseWar_Mission)
  local isInMousePartyListUI = IsMouseInRoseWarPanel(Panel_RoseWar_MiniMapPartyList)
  local isInMouseScoreBoard = IsMouseInRoseWarPanel(Panel_RoseWar_ScoreBoard)
  local isPressed_Alt = isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_MENU)
  local isPressed_LButton = isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_LBUTTON)
  local isKeyUp_Alt = isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_MENU)
  local isKeyUp_LButton = isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_LBUTTON)
  local isKeyUp_SpaceBar = isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_SPACE)
  local isPressed_W = isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_W)
  local isPressed_A = isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_A)
  local isPressed_S = isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_S)
  local isPressed_D = isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_D)
  local isKeyUp_M = isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_M)
  local isKeyUp_F1 = isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_F1)
  local isKeyUp_F2 = isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_F2)
  local isKeyUp_F3 = isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_F3)
  local isKeyUp_F4 = isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_F4)
  local isKeyUp_F5 = isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_F5)
  local isKeyUp_1 = isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_1)
  local isKeyUp_2 = isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_2)
  local isKeyUp_3 = isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_3)
  local isKeyUp_4 = isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_4)
  local isKeyUp_5 = isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_5)
  local isKeyUp_6 = isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_6)
  local isKeyUp_7 = isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_7)
  local isSkillBoundKeys = isKeyUp_1 == true or isKeyUp_2 == true or isKeyUp_3 == true or isKeyUp_4 == true or isKeyUp_5 == true or isKeyUp_6 == true or isKeyUp_7 == true
  local isMouseMove = isMouseMove()
  local isAreaSelectingMode = self._miniMapDragSelectData._control:GetShow() == true and self._mouseDragStartPos ~= nil
  local inputProcessType = self._eMiniMapInputProcessType.NONE
  local isChattingInputShow = Panel_Chatting_Input ~= nil and Panel_Chatting_Input:GetShow() == true
  if isShowEditPartyUI == false and (PaGlobalFunc_RoseWarTeamSkillManager_isUsingSkill() == true or isSkillBoundKeys == true) then
    if isChattingInputShow == false then
      self:updateMiniMapInputProcess_SkillMode()
    end
    return
  end
  if isMiniMapMoveAnimation == false and isShowEditPartyUI == false and isCommander == true and isPressed_Alt == true and isPressed_LButton == true then
    inputProcessType = self._eMiniMapInputProcessType.SELECT_AREA_BEGIN
  elseif isMiniMapMoveAnimation == false and isInMouseMissionUI == false and isInMousePartyListUI == false and isInMouseScoreBoard == false and isShowEditPartyUI == false and isPressed_LButton == true and isMouseMove == true then
    inputProcessType = self._eMiniMapInputProcessType.MOVE_MAP_MOUSE
  elseif isMiniMapMoveAnimation == false and isShowEditPartyUI == false and isCommander == true and isAreaSelectingMode == true and (isKeyUp_LButton == true or isKeyUp_Alt == true) then
    inputProcessType = self._eMiniMapInputProcessType.SELECT_AREA_END
  elseif isMiniMapMoveAnimation == false and isShowEditPartyUI == false and isPressed_W == true or isPressed_A == true or isPressed_S == true or isPressed_D == true then
    inputProcessType = self._eMiniMapInputProcessType.MOVE_MAP_KEYBOARD
  elseif isShowEditPartyUI == false and isMissionMaker == true and isKeyUp_F1 == true then
    inputProcessType = self._eMiniMapInputProcessType.TOGGLE_PARTY_LIST
  elseif isKeyUp_F2 == true then
    inputProcessType = self._eMiniMapInputProcessType.TOGGLE_PARTY_EDIT
  elseif isShowEditPartyUI == false and isMissionMaker == true and isKeyUp_F3 == true then
    inputProcessType = self._eMiniMapInputProcessType.TOGGLE_MISSION
  elseif isShowEditPartyUI == false and isKeyUp_F4 == true then
    inputProcessType = self._eMiniMapInputProcessType.TOGGLE_CHATTING
  elseif isShowEditPartyUI == false and isKeyUp_F5 == true then
    inputProcessType = self._eMiniMapInputProcessType.TOGGLE_SCOREBOARD
  elseif isShowEditPartyUI == false and isKeyUp_M == true then
    inputProcessType = self._eMiniMapInputProcessType.CLOSE_MINIMAP
  elseif isShowEditPartyUI == false and isKeyUp_SpaceBar == true then
    inputProcessType = self._eMiniMapInputProcessType.MOVE_MAP_TO_SELFPLAYER
  elseif isShowEditPartyUI == false and isCommander == true and isInMouseMissionUI == false and isInMousePartyListUI == false and isInMouseScoreBoard == false and isKeyUp_LButton == true and self._miniMapMouseMoveFlag == false then
    inputProcessType = self._eMiniMapInputProcessType.CLEAR_SELECT_ICON
  end
  if isKeyUp_LButton == true and self._miniMapMouseMoveFlag == true then
    self._miniMapMouseMoveFlag = false
  end
  if inputProcessType == self._eMiniMapInputProcessType.SELECT_AREA_BEGIN then
    if self._miniMapDragSelectData._control:GetShow() == false then
      local startPosX = getMousePosX() - self._ui._stc_miniMapBg:GetPosX()
      local startPosY = getMousePosY() - self._ui._stc_miniMapBg:GetPosY()
      self._miniMapDragSelectData._control:SetPosXY(startPosX, startPosY)
      self._miniMapDragSelectData._control:SetShow(true)
      local currentMousePosRate = self:getCurrentMousePosRateOnMiniMap()
      self._miniMapDragSelectData._beginWorldPos = self:calcMiniMapPosRateToActorPosition(currentMousePosRate.x, currentMousePosRate.y)
      self._mouseDragStartPos = {
        x = getMousePosX(),
        y = getMousePosY()
      }
    end
    local uiScale = ToClient_GetUIScale()
    local newSizeX = self._miniMapDragSelectData._control:GetSizeX() + getMouseMoveX() / uiScale
    local newSizeY = self._miniMapDragSelectData._control:GetSizeY() + getMouseMoveY() / uiScale
    self._miniMapDragSelectData._control:SetSize(newSizeX, newSizeY)
  elseif inputProcessType == self._eMiniMapInputProcessType.SELECT_AREA_END then
    self._miniMapDragSelectData._control:SetSize(0, 0)
    self._miniMapDragSelectData._control:SetShow(false)
    local captureArea = {
      l = self._mouseDragStartPos.x,
      t = self._mouseDragStartPos.y,
      r = getMousePosX(),
      b = getMousePosY()
    }
    if captureArea.r < captureArea.l then
      local temp = captureArea.l
      captureArea.l = captureArea.r
      captureArea.r = temp
    end
    if captureArea.b < captureArea.t then
      local temp = captureArea.t
      captureArea.t = captureArea.b
      captureArea.b = temp
    end
    self:captrueMiniMapActorIcon(captureArea)
    self._mouseDragStartPos = nil
  elseif inputProcessType == self._eMiniMapInputProcessType.MOVE_MAP_MOUSE then
    local mouseMoveX = getMouseMoveX()
    local mouseMoveY = getMouseMoveY()
    if mouseMoveX ~= 0 or mouseMoveY ~= 0 then
      self:moveMiniMap(mouseMoveX, mouseMoveY, false)
    end
    self._miniMapMouseMoveFlag = true
  elseif inputProcessType == self._eMiniMapInputProcessType.MOVE_MAP_KEYBOARD then
    if isChattingInputShow == false then
      local moveX = 0
      local moveY = 0
      local moveValue = 10
      if isPressed_W == true then
        moveY = moveY + moveValue
      elseif isPressed_S == true then
        moveY = moveY - moveValue
      end
      if isPressed_A == true then
        moveX = moveX + moveValue
      elseif isPressed_D == true then
        moveX = moveX - moveValue
      end
      if moveX ~= 0 or moveY ~= 0 then
        self:moveMiniMap(moveX, moveY, false)
      end
    end
  elseif inputProcessType == self._eMiniMapInputProcessType.CLOSE_MINIMAP then
    if self._closeFlag_m == true then
      if isChattingInputShow == false then
        PaGlobalFunc_RoseWarMain_Close()
      end
    else
      self._closeFlag_m = true
    end
  elseif inputProcessType == self._eMiniMapInputProcessType.TOGGLE_PARTY_LIST then
    if PaGlobalFunc_RoseWarMiniMapPartyList_IsShow() == true then
      PaGlobalFunc_RoseWarMiniMapPartyList_Close()
    else
      PaGlobalFunc_RoseWarMiniMapPartyList_Open(false)
    end
  elseif inputProcessType == self._eMiniMapInputProcessType.TOGGLE_PARTY_EDIT then
    if PaGlobalFunc_RoseWarEditParty_IsShow() == true then
      PaGlobalFunc_RoseWarEditParty_Close()
    else
      if PaGlobalFunc_RoseWarMiniMapPartyList_IsShow() == true then
        PaGlobalFunc_RoseWarMiniMapPartyList_Close()
      end
      if PaGlobalFunc_RoseWarMission_IsShow() == true then
        PaGlobalFunc_RoseWarMission_Close()
      end
      if PaGlobalFunc_RoseWarScoreBoard_IsShow() == true then
        PaGlobalFunc_RoseWarScoreBoard_Close()
      end
      PaGlobalFunc_RoseWarEditParty_Open()
    end
  elseif inputProcessType == self._eMiniMapInputProcessType.TOGGLE_MISSION then
    if PaGlobalFunc_RoseWarMission_IsShow() == true then
      PaGlobalFunc_RoseWarMission_Close()
    else
      PaGlobalFunc_RoseWarMission_Open(PaGlobal_RoseWarMission._eOpenMode._SET_CLEAR)
    end
  elseif inputProcessType == self._eMiniMapInputProcessType.TOGGLE_CHATTING then
    if self._ui._chk_toggleChatting:IsCheck() == true then
      self._ui._chk_toggleChatting:SetCheck(false)
    else
      self._ui._chk_toggleChatting:SetCheck(true)
    end
    PaGlobalFunc_RoseWarMiniMap_ToggleChattingUI(false)
  elseif inputProcessType == self._eMiniMapInputProcessType.TOGGLE_SCOREBOARD then
    if PaGlobalFunc_RoseWarScoreBoard_IsShow() == true then
      PaGlobalFunc_RoseWarScoreBoard_Close()
    else
      PaGlobalFunc_RoseWarScoreBoard_Open()
    end
  elseif inputProcessType == self._eMiniMapInputProcessType.MOVE_MAP_TO_SELFPLAYER then
    if isChattingInputShow == false then
      RoseWarMiniMap_MoveMapToSelfPlayer()
    end
  elseif inputProcessType == self._eMiniMapInputProcessType.CLEAR_SELECT_ICON then
    if 0 < ToClient_GetRoseWarSelectIconListCount() then
      ToClient_ClearRoseWarSelectIconList()
      return
    end
  else
    return
  end
end
function PaGlobal_RoseWarMiniMap:moveMiniMap(moveX, moveY, doCorrect)
  if Panel_RoseWar_MiniMap == nil or moveX == nil or moveY == nil then
    return
  end
  if self._miniMapControl == nil then
    return
  end
  local isMovableX = false
  local isMovableY = false
  local minPosX = self:getMiniMapControlMinPosX() * -1
  local maxPosX = 0
  local minPosY = self:getMiniMapControlMinPosY() * -1
  local maxPosY = 0
  local currentPosX = self._miniMapControl:GetPosX()
  local currentPosY = self._miniMapControl:GetPosY()
  if moveX ~= 0 then
    local newPosX = currentPosX + moveX
    if doCorrect ~= nil and doCorrect == true then
      if minPosX > newPosX then
        newPosX = minPosX
      elseif maxPosX < newPosX then
        newPosX = maxPosX
      end
      moveX = newPosX - currentPosX
      if moveX ~= 0 then
        isMovableX = true
      end
    elseif minPosX <= newPosX and maxPosX >= newPosX then
      isMovableX = true
    end
  end
  if moveY ~= 0 then
    local newPosY = currentPosY + moveY
    if doCorrect ~= nil and doCorrect == true then
      if minPosY > newPosY then
        newPosY = minPosY
      elseif maxPosY < newPosY then
        newPosY = maxPosY
      end
      moveY = newPosY - currentPosY
      if moveY ~= 0 then
        isMovableY = true
      end
    elseif minPosY <= newPosY and maxPosY >= newPosY then
      isMovableY = true
    end
  end
  if isMovableX == true or isMovableY == true then
    if isMovableX == true then
      self._miniMapControl:SetPosX(self._miniMapControl:GetPosX() + moveX)
    end
    if isMovableY == true then
      self._miniMapControl:SetPosY(self._miniMapControl:GetPosY() + moveY)
    end
    self:updateMiniMapMovePinPos()
    self:updateMiniMapPinPos()
    self:refreshMiniMapActorIconPos(false)
    self:refreshMiniMapVehicleIconPos(false)
    self:refreshMiniMapMarkerIconPos(false)
    self:refreshMiniMapFierceBattleObjectIconPos(false)
  end
end
function PaGlobal_RoseWarMiniMap:processMiniMapScroll(isUp)
  if Panel_RoseWar_MiniMap == nil or isUp == nil then
    return
  end
  local isRefreshMiniMap = false
  local prevMiniMapRate = self._currentMiniMapRate
  local newMiniMapRate = 0
  if isUp == true then
    if self._miniMapImageRateMax <= self._currentMiniMapRate then
      self._currentMiniMapRate = self._miniMapImageRateMax
      return
    end
    newMiniMapRate = math.min(self._currentMiniMapRate + self._mouseScrollVariable, self._miniMapImageRateMax)
    isRefreshMiniMap = true
  else
    if self._currentMiniMapRate <= self._miniMapImageRateMin then
      self._currentMiniMapRate = self._miniMapImageRateMin
      return
    end
    newMiniMapRate = math.max(self._currentMiniMapRate - self._mouseScrollVariable, self._miniMapImageRateMin)
    isRefreshMiniMap = true
  end
  if prevMiniMapRate ~= newMiniMapRate and isRefreshMiniMap == true then
    self:refreshMiniMap(newMiniMapRate, false)
  end
end
function PaGlobal_RoseWarMiniMap:refreshMiniMap(newMiniMapRate, isForce)
  if Panel_RoseWar_MiniMap == nil or newMiniMapRate == nil or isForce == nil then
    return
  end
  if isForce == false and self:checkValidMiniMapRate(newMiniMapRate) == false then
    return
  end
  local currentMousePosRate = self:getCurrentMousePosRateOnMiniMap()
  self._currentMiniMapRate = newMiniMapRate
  self:refreshMiniMapImagePos(false)
  self:refreshMiniMapScrollPosRate(currentMousePosRate)
  self:updateMiniMapPinPos()
  self:updateMiniMapMovePinPos()
  self:refreshMiniMapActorIconPos(true)
  self:refreshMiniMapVehicleIconPos(true)
  self:refreshMiniMapMarkerIconPos(true)
  self:refreshMiniMapFierceBattleObjectIconPos(true)
end
function PaGlobal_RoseWarMiniMap:checkValidMiniMapRate(miniMapRateValue)
  if Panel_RoseWar_MiniMap == nil or miniMapRateValue == nil then
    return false
  end
  local newMapSizeX = math.floor(miniMapRateValue * self._miniMapImageSizeXY.x)
  local newMapSizeY = math.floor(miniMapRateValue * self._miniMapImageSizeXY.y)
  if newMapSizeX < self._ui._stc_miniMapBg:GetSizeX() then
    return false
  end
  if newMapSizeY < self._ui._stc_miniMapBg:GetSizeY() then
    return false
  end
  return true
end
function PaGlobal_RoseWarMiniMap:refreshMiniMapImagePos(isForce, varX, varY)
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  if self._miniMapControl == nil then
    return
  end
  local newImageSize = self:getCurrentImageSize()
  if isForce == false and newImageSize.x == self._currentMiniMapImageSizeXY.x and newImageSize.y == self._currentMiniMapImageSizeXY.y then
    return
  end
  self._currentMiniMapImageSizeXY = newImageSize
  local addSizeValueX = self._currentMiniMapImageSizeXY.x - self._miniMapControl:GetSizeX()
  local addSizeValueY = self._currentMiniMapImageSizeXY.y - self._miniMapControl:GetSizeY()
  local pivotPosX = self._miniMapControl:GetPosX()
  local pivotPosY = self._miniMapControl:GetPosY()
  local isMovableX = false
  local isMovableY = false
  local rowCount = self:getMiniMapRowCount()
  local colCount = self:getMiniMapColCount()
  local minPosX = self:getMiniMapControlMinPosX() * -1
  local maxPosX = 0
  local minPosY = self:getMiniMapControlMinPosY() * -1
  local maxPosY = 0
  local targetPosX, targetPosY
  if varX == nil then
    targetPosX = pivotPosX - addSizeValueX
  else
    targetPosX = pivotPosX + varX
  end
  if varY == nil then
    targetPosY = pivotPosY - addSizeValueY
  else
    targetPosY = pivotPosY + varY
  end
  if minPosX <= targetPosX and maxPosX >= targetPosX then
    isMovableX = true
  elseif minPosX > targetPosX then
    targetPosX = minPosX
    isMovableX = true
  elseif maxPosX < targetPosX then
    targetPosX = maxPosX
    isMovableX = true
  end
  if minPosY <= targetPosY and maxPosY >= targetPosY then
    isMovableY = true
  elseif minPosY > targetPosY then
    targetPosY = minPosY
    isMovableY = true
  elseif maxPosY < targetPosY then
    targetPosY = maxPosY
    isMovableY = true
  end
  if isMovableX == true or isMovableY == true then
    self._miniMapControl:SetSize(self._currentMiniMapImageSizeXY.x, self._currentMiniMapImageSizeXY.y)
    if isMovableX == true then
      self._miniMapControl:SetPosX(targetPosX)
    end
    if isMovableY == true then
      self._miniMapControl:SetPosY(targetPosY)
    end
  end
end
function PaGlobal_RoseWarMiniMap:refreshMiniMapScrollPosRate(mousePosRate)
  if Panel_RoseWar_MiniMap == nil or mousePosRate == nil then
    return
  end
  local currentMousePosRate = self:getCurrentMousePosRateOnMiniMap()
  if currentMousePosRate == nil then
    return
  end
  local ratio_x = math.abs(mousePosRate.x - currentMousePosRate.x)
  local ratio_y = math.abs(mousePosRate.y - currentMousePosRate.y)
  local ratioToSize = float2(0, 0)
  if mousePosRate.x < currentMousePosRate.x and mousePosRate.y < currentMousePosRate.y then
    ratioToSize.x = self:getMiniMapSizeX() * ratio_x
    ratioToSize.y = self:getMiniMapSizeY() * ratio_y
  elseif currentMousePosRate.x < mousePosRate.x and currentMousePosRate.y < mousePosRate.y then
    ratioToSize.x = self:getMiniMapSizeX() * ratio_x * -1
    ratioToSize.y = self:getMiniMapSizeY() * ratio_y * -1
  else
    return
  end
  self:refreshMiniMapImagePos(true, ratioToSize.x, ratioToSize.y)
end
function PaGlobal_RoseWarMiniMap:showMiniMapPin(posRate)
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  self._miniMapPinData._control:SetShow(true)
  self._miniMapPinData._lastCalcPosRate.x = posRate.x
  self._miniMapPinData._lastCalcPosRate.y = posRate.y
  self:updateMiniMapPinPos()
end
function PaGlobal_RoseWarMiniMap:hideMiniMapPin()
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  self._miniMapPinData._control:SetShow(false)
  self._miniMapPinData._lastCalcPosRate.x = 0
  self._miniMapPinData._lastCalcPosRate.y = 0
end
function PaGlobal_RoseWarMiniMap:showMiniMapMovePin(posRate)
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  self._miniMapMovePinData._control:SetShow(true)
  self._miniMapMovePinData._control:AddEffect("fUI_RoseWar_Arrow_01A", false, 0, self._miniMapMovePinData._control:GetSizeY() / 2)
  self._miniMapMovePinData._lastCalcPosRate.x = posRate.x
  self._miniMapMovePinData._lastCalcPosRate.y = posRate.y
  self:updateMiniMapMovePinPos()
end
function PaGlobal_RoseWarMiniMap:updateMiniMapPinPos()
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  if self._miniMapControl == nil then
    return
  end
  local newPosX = self._miniMapControl:GetPosX() + self:getMiniMapSizeX() * self._miniMapPinData._lastCalcPosRate.x - self._miniMapPinData._control:GetSizeX() / 2
  local newPosY = self._miniMapControl:GetPosY() + self:getMiniMapSizeY() * self._miniMapPinData._lastCalcPosRate.y - self._miniMapPinData._control:GetSizeY()
  self._miniMapPinData._control:SetPosX(newPosX)
  self._miniMapPinData._control:SetPosY(newPosY)
end
function PaGlobal_RoseWarMiniMap:updateMiniMapMovePinPos()
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  if self._miniMapControl == nil then
    return
  end
  local newPosX = self._miniMapControl:GetPosX() + self:getMiniMapSizeX() * self._miniMapMovePinData._lastCalcPosRate.x - self._miniMapMovePinData._control:GetSizeX() / 2
  local newPosY = self._miniMapControl:GetPosY() + self:getMiniMapSizeY() * self._miniMapMovePinData._lastCalcPosRate.y - self._miniMapMovePinData._control:GetSizeY()
  self._miniMapMovePinData._control:SetPosX(newPosX)
  self._miniMapMovePinData._control:SetPosY(newPosY)
end
function PaGlobal_RoseWarMiniMap:updateMiniMapNavigationGuide()
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  if self._miniMapPinData._control:GetShow() == false then
    return
  end
  local pathSize = ToClient_getRenderPathSize()
  if pathSize == 0 then
    return
  end
  if self._miniMapControl == nil then
    return
  end
  ToClient_clearShowAALineList()
  local color = float4(0.6, 0.8, 1, 1)
  local colorBG = float4(0.3, 0.3, 0.6, 0.5)
  local unRenderCount = 0
  for ii = 0, pathSize - 1 do
    local pathPosition = ToClient_getRenderPathByIndex(ii)
    local actorPosRate = self:calcWorldPositionToMiniMapPosRate(pathPosition)
    local isShow = true
    local posX = self._miniMapControl:GetPosX() + self:getMiniMapSizeX() * actorPosRate.x
    local posY = self._miniMapControl:GetPosY() + self:getMiniMapSizeY() * actorPosRate.y
    ToClient_addShowAALineList(float3(posX, posY, 0))
  end
  ToClient_setColorShowAALineList(color)
  ToClient_setBGColorShowAALineList(colorBG)
end
function PaGlobal_RoseWarMiniMap:aniationMoveMiniMap(userNo)
  if Panel_RoseWar_MiniMap == nil or userNo == nil then
    return
  end
  if self._miniMapControl == nil then
    return
  end
  local actorIconData = self:getActorIconDataByUserNo(Int64toInt32(userNo))
  if actorIconData == nil then
    return
  end
  local currentScreenCenterPosX = math.abs(self._miniMapControl:GetPosX()) + self:getMiniMapCenterPosX()
  local currentScreenCenterPosY = math.abs(self._miniMapControl:GetPosY()) + self:getMiniMapCenterPosY()
  local currentActorIconPosX = self:getMiniMapSizeX() * actorIconData._lastCalcPosRate.x
  local currentActorIconPosY = self:getMiniMapSizeY() * actorIconData._lastCalcPosRate.y
  local moveX = 0
  local moveY = 0
  if currentScreenCenterPosX < currentActorIconPosX then
    moveX = math.abs(currentActorIconPosX - currentScreenCenterPosX) * -1
  elseif currentScreenCenterPosX > currentActorIconPosX then
    moveX = math.abs(currentScreenCenterPosX - currentActorIconPosX)
  end
  if currentScreenCenterPosY < currentActorIconPosY then
    moveY = math.abs(currentActorIconPosY - currentScreenCenterPosY) * -1
  elseif currentScreenCenterPosY > currentActorIconPosY then
    moveY = math.abs(currentScreenCenterPosY - currentActorIconPosY)
  end
  local moveAnimationInfo = {
    _timeRatio = 0,
    _animationDeltaTime = 0.5,
    _moveX = moveX,
    _moveY = moveY
  }
  self._miniMapMoveAnimationInfo = moveAnimationInfo
end
function PaGlobal_RoseWarMiniMap:isMiniMapMoveAnimation()
  if Panel_RoseWar_MiniMap == nil then
    return false
  end
  return self._miniMapMoveAnimationInfo ~= nil
end
function PaGlobal_RoseWarMiniMap:clearMiniMapMoveAnimationInfo()
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  self._miniMapMoveAnimationInfo = nil
end
function PaGlobal_RoseWarMiniMap:initMiniMapPinPos()
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  local pathSize = ToClient_getRenderPathSize()
  if pathSize ~= 0 then
    local pathTarget = ToClient_getRenderPathByIndex(pathSize - 1)
    local targetPosRate = self:calcWorldPositionToMiniMapPosRate(pathTarget)
    self:showMiniMapPin(targetPosRate)
  else
    self:hideMiniMapPin()
  end
end
