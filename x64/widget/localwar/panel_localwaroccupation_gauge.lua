ToClient_SetUIRedBattleFieldOccupationStatusPanel(Panel_LocalWar_OccupationGauge)
ToClient_InitializeUIRedBattleFieldOccupationStatusPanelPool(5)
registerEvent("RedBattleFieldOccupationPanelCreated", "FromClient_LocalWarOccupation_CreatedPanel")
registerEvent("FromClient_RedBattleFieldOccupationUpdateObjectState", "FromClient_LocalWarOccupation_Gauge_Update")
registerEvent("FromClient_RedBattleFieldOccupationUpdateDistance", "FromClient_RedBattleFieldOccupationUpdateDistance")
registerEvent("FromClient_RedBattleFieldOccupationShowClosestObjectState", "FromClient_RedBattleFieldOccupationShowClosestObjectState")
registerEvent("FromClient_JoinRedBattleField", "FromClient_LocalWarOccupation_JoinLocalWarOccupation")
PaGlobal_LocalWarOccupation_Gauge = {
  _initialize = false,
  _controlList = {},
  _currentControlSize = 0,
  _maxUICount = 5,
  _maxGauge = 5,
  _currentOccuStateUI = {
    state_NoneBg = nil,
    state_BlackBg = nil,
    state_RedBg = nil,
    state_numberTable = Array.new(),
    blackTime = Array.new(),
    redTime = Array.new(),
    effect = nil,
    debuffBg = nil
  },
  _currentShowingActorKey = nil,
  _eOCCUPATIONTYPE = {
    BLACK = 0,
    RED = 1,
    NONE = 2
  },
  _towerColorForRadar = {
    _WHITE = 4294967295,
    _BLUE = 4286432511,
    _RED = 4294930775,
    _RedBLIND = 4288186924
  },
  _noneTowerTextureUV = {
    [1] = {
      x1 = 289,
      y1 = 500,
      x2 = 339,
      y2 = 550
    },
    [2] = {
      x1 = 340,
      y1 = 500,
      x2 = 390,
      y2 = 550
    },
    [3] = {
      x1 = 391,
      y1 = 500,
      x2 = 441,
      y2 = 550
    },
    [4] = {
      x1 = 442,
      y1 = 500,
      x2 = 492,
      y2 = 550
    },
    [5] = {
      x1 = 493,
      y1 = 500,
      x2 = 543,
      y2 = 550
    }
  },
  _redTowerTextureUV = {
    [1] = {
      x1 = 289,
      y1 = 551,
      x2 = 339,
      y2 = 601
    },
    [2] = {
      x1 = 340,
      y1 = 551,
      x2 = 390,
      y2 = 601
    },
    [3] = {
      x1 = 391,
      y1 = 551,
      x2 = 441,
      y2 = 601
    },
    [4] = {
      x1 = 442,
      y1 = 551,
      x2 = 492,
      y2 = 601
    },
    [5] = {
      x1 = 493,
      y1 = 551,
      x2 = 543,
      y2 = 601
    }
  },
  _blackTowerTextureUV = {
    [1] = {
      x1 = 289,
      y1 = 602,
      x2 = 339,
      y2 = 652
    },
    [2] = {
      x1 = 340,
      y1 = 602,
      x2 = 390,
      y2 = 652
    },
    [3] = {
      x1 = 391,
      y1 = 602,
      x2 = 441,
      y2 = 652
    },
    [4] = {
      x1 = 442,
      y1 = 602,
      x2 = 492,
      y2 = 652
    },
    [5] = {
      x1 = 493,
      y1 = 602,
      x2 = 543,
      y2 = 652
    }
  }
}
registerEvent("FromClient_luaLoadComplete", "FromClient_LocalWarOccupation_Gauge_Init")
registerEvent("FromClient_luaLoadCompleteLateUdpate", "FromClient_LocalWarOccupation_JoinLocalWarOccupation()")
function FromClient_LocalWarOccupation_Gauge_Init()
  PaGlobal_LocalWarOccupation_Gauge:initialize()
end
function PaGlobal_LocalWarOccupation_Gauge:initialize()
  if true == self._initialize or nil == Panel_LocalWar_OccupationGauge or nil == Panel_LocalWar_CurrentOccupationGauge then
    return
  end
  self._currentOccuStateUI.state_NoneBg = UI.getChildControl(Panel_LocalWar_CurrentOccupationGauge, "Static_Gauge_Bg_None")
  self._currentOccuStateUI.state_BlackBg = UI.getChildControl(Panel_LocalWar_CurrentOccupationGauge, "Static_Gauge_Bg_Blue")
  self._currentOccuStateUI.state_RedBg = UI.getChildControl(Panel_LocalWar_CurrentOccupationGauge, "Static_Gauge_Bg_Red")
  self._currentOccuStateUI.txt_savedScore = UI.getChildControl(Panel_LocalWar_CurrentOccupationGauge, "StaticText_Score")
  self._currentOccuStateUI.state_numberTable = Array.new()
  self._currentOccuStateUI.currentIndex = 1
  for idx = 1, self._maxUICount do
    local currentControl = UI.getChildControl(Panel_LocalWar_CurrentOccupationGauge, "Static_Tower_None_" .. tostring(idx))
    self._currentOccuStateUI.state_numberTable:push_back(currentControl)
    currentControl:SetShow(false)
    local blueControl = UI.getChildControl(Panel_LocalWar_CurrentOccupationGauge, "Static_Bar_Blue" .. tostring(idx))
    self._currentOccuStateUI.blackTime:push_back(blueControl)
    local redControl = UI.getChildControl(Panel_LocalWar_CurrentOccupationGauge, "Static_Bar_Red" .. tostring(idx))
    self._currentOccuStateUI.redTime:push_back(redControl)
  end
  self._currentOccuStateUI.effect = UI.getChildControl(Panel_LocalWar_CurrentOccupationGauge, "Static_Effect")
  self._currentOccuStateUI.debuffBg = UI.getChildControl(Panel_LocalWar_CurrentOccupationGauge, "Static_Debuff")
  PaGlobal_LocalWarOccupation_Gauge:registEventHandler()
  self._initialize = true
  PaGlobalFunc_LocalWarOccupation_UnRenderPanel()
end
function PaGlobal_LocalWarOccupation_Gauge:registEventHandler()
end
function FromClient_LocalWarOccupation_JoinLocalWarOccupation()
  ToClient_getAllOccupationInfoReq()
  PaGlobalFunc_LocalWarOccupation_UnRenderPanel()
end
function FromClient_LocalWarOccupation_CreatedPanel(actorKeyRaw, panel, actorType, actorWrapper)
  local actorProxyWrapper = getActor(actorKeyRaw)
  if nil == actorProxyWrapper then
    return
  end
  if nil == panel then
    return
  end
  local tempTable = {
    _savedActorKey = actorKeyRaw,
    _blackTeamTime = Array.new(),
    _redTeamTime = Array.new(),
    _towerBlackTeam = nil,
    _towerRedTeam = nil,
    _towerNone = nil,
    _indexFromServer = nil,
    _distance = nil,
    _panel = nil,
    _direction = nil,
    _radarControl = nil,
    _isTextureSet = false,
    _saveScoreControl = nil,
    _savedScore = 0
  }
  for idx = 1, PaGlobal_LocalWarOccupation_Gauge._maxUICount do
    local control = UI.getChildControl(panel, "Static_Bar_Blue" .. tostring(idx))
    tempTable._blackTeamTime:push_back(control)
  end
  for idx = 1, PaGlobal_LocalWarOccupation_Gauge._maxUICount do
    local control = UI.getChildControl(panel, "Static_Bar_Red" .. tostring(idx))
    tempTable._redTeamTime:push_back(control)
  end
  tempTable._panel = panel
  tempTable._direction = UI.getChildControl(panel, "Static_Direction")
  tempTable._towerBlackTeam = UI.getChildControl(panel, "Static_Tower_Blue")
  tempTable._towerRedTeam = UI.getChildControl(panel, "Static_Tower_Red")
  tempTable._towerNone = UI.getChildControl(panel, "Static_Tower_None")
  tempTable._towerNone:SetShow(true)
  tempTable._distance = UI.getChildControl(panel, "StaticText_Distance")
  tempTable._distance:SetText("")
  local listSize = PaGlobal_LocalWarOccupation_Gauge._currentControlSize
  if nil ~= PaGlobal_LocalWarOccupation_Gauge._blackTowerTextureUV[listSize] then
    local texture = PaGlobal_LocalWarOccupation_Gauge._blackTowerTextureUV[listSize]
    tempTable._towerBlackTeam:ChangeTextureInfoNameAsync("combine/etc/combine_etc_redbattlefield_war_wight.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(tempTable._towerBlackTeam, texture.x1, texture.y1, texture.x2, texture.y2)
    tempTable._towerBlackTeam:getBaseTexture():setUV(x1, y1, x2, y2)
    tempTable._towerBlackTeam:setRenderTexture(tempTable._towerBlackTeam:getBaseTexture())
  end
  if nil ~= PaGlobal_LocalWarOccupation_Gauge._redTowerTextureUV[listSize] then
    local texture = PaGlobal_LocalWarOccupation_Gauge._redTowerTextureUV[listSize]
    tempTable._towerRedTeam:ChangeTextureInfoNameAsync("combine/etc/combine_etc_redbattlefield_war_wight.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(tempTable._towerRedTeam, texture.x1, texture.y1, texture.x2, texture.y2)
    tempTable._towerRedTeam:getBaseTexture():setUV(x1, y1, x2, y2)
    tempTable._towerRedTeam:setRenderTexture(tempTable._towerRedTeam:getBaseTexture())
  end
  if nil ~= PaGlobal_LocalWarOccupation_Gauge._noneTowerTextureUV[listSize] then
    local texture = PaGlobal_LocalWarOccupation_Gauge._noneTowerTextureUV[listSize]
    tempTable._towerNone:ChangeTextureInfoNameAsync("combine/etc/combine_etc_redbattlefield_war_wight.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(tempTable._towerNone, texture.x1, texture.y1, texture.x2, texture.y2)
    tempTable._towerNone:getBaseTexture():setUV(x1, y1, x2, y2)
    tempTable._towerNone:setRenderTexture(tempTable._towerNone:getBaseTexture())
  end
  PaGlobal_LocalWarOccupation_Gauge._controlList[actorKeyRaw] = tempTable
  PaGlobal_LocalWarOccupation_Gauge._currentControlSize = PaGlobal_LocalWarOccupation_Gauge._currentControlSize + 1
  panel:SetShow(true)
end
function FromClient_LocalWarOccupation_Gauge_Update(actorKeyRaw, occupationType, blackOccupiedTime, redOccupiedTime, isBlackTeamExist, isRedTeamExist, indexFromServer, grade, maxGaugeTime)
  local actorProxyWrapper = getActor(actorKeyRaw)
  if nil == actorProxyWrapper then
    return
  end
  local self = PaGlobal_LocalWarOccupation_Gauge
  local div = maxGaugeTime / self._maxUICount
  local isColorBlindMode = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eColorBlindMode)
  if nil ~= self._controlList[actorKeyRaw] then
    local contorlList = self._controlList[actorKeyRaw]
    if false == contorlList._radarControl:GetShow() then
      contorlList._radarControl:SetShow(true)
    end
    if false == contorlList._isTextureSet then
      if nil ~= self._blackTowerTextureUV[indexFromServer] then
        local texture = self._blackTowerTextureUV[indexFromServer]
        local x1, y1, x2, y2 = setTextureUV_Func(contorlList._towerBlackTeam, texture.x1, texture.y1, texture.x2, texture.y2)
        contorlList._towerBlackTeam:getBaseTexture():setUV(x1, y1, x2, y2)
        contorlList._towerBlackTeam:setRenderTexture(contorlList._towerBlackTeam:getBaseTexture())
        contorlList._radarControl:getBaseTexture():setUV(x1, y1, x2, y2)
        contorlList._radarControl:setRenderTexture(contorlList._radarControl:getBaseTexture())
      end
      if nil ~= self._redTowerTextureUV[indexFromServer] then
        local texture = self._redTowerTextureUV[indexFromServer]
        local x1, y1, x2, y2 = setTextureUV_Func(contorlList._towerRedTeam, texture.x1, texture.y1, texture.x2, texture.y2)
        contorlList._towerRedTeam:getBaseTexture():setUV(x1, y1, x2, y2)
        contorlList._towerRedTeam:setRenderTexture(contorlList._towerRedTeam:getBaseTexture())
        contorlList._radarControl:getBaseTexture():setUV(x1, y1, x2, y2)
        contorlList._radarControl:setRenderTexture(contorlList._radarControl:getBaseTexture())
      end
      if nil ~= self._noneTowerTextureUV[indexFromServer] then
        local texture = self._noneTowerTextureUV[indexFromServer]
        local x1, y1, x2, y2 = setTextureUV_Func(contorlList._towerNone, texture.x1, texture.y1, texture.x2, texture.y2)
        contorlList._towerNone:getBaseTexture():setUV(x1, y1, x2, y2)
        contorlList._towerNone:setRenderTexture(contorlList._towerNone:getBaseTexture())
        contorlList._radarControl:getBaseTexture():setUV(x1, y1, x2, y2)
        contorlList._radarControl:setRenderTexture(contorlList._radarControl:getBaseTexture())
      end
      contorlList._isTextureSet = true
    end
    local isBlackTowerShowing = contorlList._towerBlackTeam:GetShow()
    local isRedTowerShowing = contorlList._towerRedTeam:GetShow()
    local isNoneTowerShowing = contorlList._towerNone:GetShow()
    contorlList._towerBlackTeam:SetShow(self._eOCCUPATIONTYPE.BLACK == occupationType)
    contorlList._towerRedTeam:SetShow(self._eOCCUPATIONTYPE.RED == occupationType)
    contorlList._towerNone:SetShow(self._eOCCUPATIONTYPE.NONE == occupationType)
    if nil ~= contorlList._radarControl then
      if self._eOCCUPATIONTYPE.BLACK == occupationType then
        contorlList._radarControl:SetColor(self._towerColorForRadar._BLUE)
      elseif self._eOCCUPATIONTYPE.RED == occupationType then
        if 1 == isColorBlindMode then
          contorlList._radarControl:SetColor(self._towerColorForRadar._RedBLIND)
        else
          contorlList._radarControl:SetColor(self._towerColorForRadar._RED)
        end
      elseif self._eOCCUPATIONTYPE.NONE == occupationType then
        contorlList._radarControl:SetColor(self._towerColorForRadar._WHITE)
      end
    end
    if nil == contorlList._indexFromServer then
      contorlList._indexFromServer = indexFromServer
    end
    for subIdx = 1, self._maxUICount do
      local needTime = div * subIdx
      contorlList._blackTeamTime[subIdx]:SetShow(blackOccupiedTime >= needTime)
      contorlList._redTeamTime[subIdx]:SetShow(redOccupiedTime >= needTime)
    end
    contorlList._panel:EraseAllEffect()
    if true == isBlackTeamExist and true == isRedTeamExist then
      contorlList._panel:AddEffect("fUI_Panel_LocalWar_Battle_01A", true, 0, 0)
    elseif true == contorlList._towerRedTeam:GetShow() and true == isBlackTeamExist then
      contorlList._panel:AddEffect("fUI_Panel_LocalWar_Battle_01A", true, 0, 0)
    elseif true == contorlList._towerBlackTeam:GetShow() and true == isRedTeamExist then
      contorlList._panel:AddEffect("fUI_Panel_LocalWar_Battle_01A", true, 0, 0)
    elseif false == isBlackTowerShowing and true == contorlList._towerBlackTeam:GetShow() or true == isNoneTowerShowing and true == contorlList._towerBlackTeam:GetShow() or true == isRedTowerShowing and true == contorlList._towerBlackTeam:GetShow() then
      contorlList._panel:AddEffect("fUI_Panel_LocalWar_Blue_01A", false, 0, 0)
    elseif false == isRedTowerShowing and true == contorlList._towerRedTeam:GetShow() or true == isNoneTowerShowing and true == contorlList._towerRedTeam:GetShow() or true == isBlackTowerShowing and true == contorlList._towerRedTeam:GetShow() then
      contorlList._panel:AddEffect("fUI_Panel_LocalWar_Red_01A", false, 0, 0)
    end
    if nil ~= PaGlobalFunc_LocalWarOccupation_UpdateState then
      PaGlobalFunc_LocalWarOccupation_UpdateState(indexFromServer, occupationType, isBlackTeamExist, isRedTeamExist)
    end
  end
  if true == Panel_LocalWar_CurrentOccupationGauge:GetShow() and nil ~= self._currentShowingActorKey and self._currentShowingActorKey == actorKeyRaw then
    local isShowingBlackState = self._currentOccuStateUI.state_BlackBg:GetShow()
    local isShowingRedState = self._currentOccuStateUI.state_RedBg:GetShow()
    local isShowingNoneState = self._currentOccuStateUI.state_NoneBg:GetShow()
    self._currentOccuStateUI.state_NoneBg:SetShow(self._eOCCUPATIONTYPE.NONE == occupationType)
    self._currentOccuStateUI.state_BlackBg:SetShow(self._eOCCUPATIONTYPE.BLACK == occupationType)
    self._currentOccuStateUI.state_RedBg:SetShow(self._eOCCUPATIONTYPE.RED == occupationType)
    local myTeamIndex = ToClient_GetMyTeamNoRedBattleField()
    self._currentOccuStateUI.debuffBg:SetShow(false)
    if 1 == myTeamIndex and self._eOCCUPATIONTYPE.BLACK == occupationType then
      self._currentOccuStateUI.debuffBg:SetShow(true)
    elseif 2 == myTeamIndex and self._eOCCUPATIONTYPE.RED == occupationType then
      self._currentOccuStateUI.debuffBg:SetShow(true)
    end
    for subIdx = 1, self._maxUICount do
      local needTime = div * subIdx
      self._currentOccuStateUI.blackTime[subIdx]:SetShow(blackOccupiedTime >= needTime)
      self._currentOccuStateUI.redTime[subIdx]:SetShow(redOccupiedTime >= needTime)
      self._currentOccuStateUI.state_numberTable[subIdx]:SetShow(subIdx == indexFromServer)
    end
    if nil ~= self._currentOccuStateUI.state_numberTable[indexFromServer] then
      if self._eOCCUPATIONTYPE.NONE == occupationType then
        self._currentOccuStateUI.state_numberTable[indexFromServer]:SetColor(self._towerColorForRadar._WHITE)
      elseif self._eOCCUPATIONTYPE.BLACK == occupationType then
        self._currentOccuStateUI.state_numberTable[indexFromServer]:SetColor(self._towerColorForRadar._BLUE)
      else
        self._currentOccuStateUI.state_numberTable[indexFromServer]:SetColor(self._towerColorForRadar._RED)
      end
    end
    Panel_LocalWar_CurrentOccupationGauge:EraseAllEffect()
    if true == isBlackTeamExist and true == isRedTeamExist then
      Panel_LocalWar_CurrentOccupationGauge:AddEffect("fUI_Panel_LocalWar_Battle_01A", true, 0, 0)
    elseif true == self._currentOccuStateUI.state_RedBg:GetShow() and true == isBlackTeamExist then
      Panel_LocalWar_CurrentOccupationGauge:AddEffect("fUI_Panel_LocalWar_Battle_01A", true, 0, 0)
    elseif true == self._currentOccuStateUI.state_BlackBg:GetShow() and true == isRedTeamExist then
      Panel_LocalWar_CurrentOccupationGauge:AddEffect("fUI_Panel_LocalWar_Battle_01A", true, 0, 0)
    elseif false == isShowingBlackState and true == self._currentOccuStateUI.state_BlackBg:GetShow() or true == isShowingNoneState and true == self._currentOccuStateUI.state_BlackBg:GetShow() then
      Panel_LocalWar_CurrentOccupationGauge:AddEffect("fUI_Panel_LocalWar_Blue_01A", false, 0, 0)
    elseif false == isShowingRedState and true == self._currentOccuStateUI.state_RedBg:GetShow() or true == isShowingNoneState and true == self._currentOccuStateUI.state_RedBg:GetShow() then
      Panel_LocalWar_CurrentOccupationGauge:AddEffect("fUI_Panel_LocalWar_Red_01A", false, 0, 0)
    end
  end
end
function PaGlobalFunc_LocalWarOccupation_UpdateSavedScore(actorKeyRaw, savedScore)
  local self = PaGlobal_LocalWarOccupation_Gauge
  if nil ~= self._controlList[actorKeyRaw] then
    local contorlList = self._controlList[actorKeyRaw]
    contorlList._savedScore = savedScore
    if nil ~= contorlList._indexFromServer then
      PaGlobalFunc_LocalWarOccupation_UpdateSavingScore(contorlList._indexFromServer, savedScore)
    end
    local isClosestObjectPanelShow = PaGlobal_LocalWarOccupation_Gauge._currentShowingActorKey == actorKeyRaw
    if true == isClosestObjectPanelShow then
      PaGlobal_LocalWarOccupation_Gauge._currentOccuStateUI.txt_savedScore:SetShow(isClosestObjectPanelShow)
      PaGlobal_LocalWarOccupation_Gauge._currentOccuStateUI.txt_savedScore:SetText(savedScore)
    end
  end
end
function FromClient_RedBattleFieldOccupationUpdateDistance(actorKeyRaw, distance, angle)
  local self = PaGlobal_LocalWarOccupation_Gauge
  if nil ~= self._controlList[actorKeyRaw] then
    local contorlList = self._controlList[actorKeyRaw]
    contorlList._distance:SetText(distance)
    contorlList._direction:SetRotate(angle)
  end
end
function FromClient_RedBattleFieldOccupationShowClosestObjectState(actorKeyRaw, isShow)
  local self = PaGlobal_LocalWarOccupation_Gauge
  if false == isShow then
    PaGlobal_LocalWarOccupation_Gauge._currentShowingActorKey = nil
    Panel_LocalWar_CurrentOccupationGauge:SetShow(false)
    PaGlobal_LocalWarOccupation_Gauge._currentOccuStateUI.txt_savedScore:SetShow(false)
    return
  end
  local canShowUI = false
  if nil ~= self._controlList[actorKeyRaw] then
    canShowUI = true
    local contorlList = self._controlList[actorKeyRaw]
    self._currentOccuStateUI.state_NoneBg:SetShow(contorlList._towerNone:GetShow())
    self._currentOccuStateUI.state_BlackBg:SetShow(contorlList._towerBlackTeam:GetShow())
    self._currentOccuStateUI.state_RedBg:SetShow(contorlList._towerRedTeam:GetShow())
    self._currentOccuStateUI.debuffBg:SetShow(false)
    local myTeamIndex = ToClient_GetMyTeamNoRedBattleField()
    if 1 == myTeamIndex and true == contorlList._towerBlackTeam:GetShow() then
      self._currentOccuStateUI.debuffBg:SetShow(true)
    elseif 2 == myTeamIndex and true == contorlList._towerRedTeam:GetShow() then
      self._currentOccuStateUI.debuffBg:SetShow(true)
    end
    for subIdx = 1, self._maxUICount do
      self._currentOccuStateUI.blackTime[subIdx]:SetShow(contorlList._blackTeamTime[subIdx]:GetShow())
      self._currentOccuStateUI.redTime[subIdx]:SetShow(contorlList._redTeamTime[subIdx]:GetShow())
      self._currentOccuStateUI.state_numberTable[subIdx]:SetShow(subIdx == contorlList._indexFromServer)
    end
    if nil ~= self._currentOccuStateUI.state_numberTable[contorlList._indexFromServer] then
      if true == contorlList._towerNone:GetShow() then
        self._currentOccuStateUI.state_numberTable[contorlList._indexFromServer]:SetColor(self._towerColorForRadar._WHITE)
      elseif true == contorlList._towerBlackTeam:GetShow() then
        self._currentOccuStateUI.state_numberTable[contorlList._indexFromServer]:SetColor(self._towerColorForRadar._BLUE)
      else
        self._currentOccuStateUI.state_numberTable[contorlList._indexFromServer]:SetColor(self._towerColorForRadar._RED)
      end
    end
  end
  PaGlobal_LocalWarOccupation_Gauge._currentShowingActorKey = actorKeyRaw
  Panel_LocalWar_CurrentOccupationGauge:SetShow(isShow)
end
function PaGlobalFunc_LocalWarOccupation_AddRadarControl(actorKeyRaw, control)
  if nil == Panel_LocalWar_OccupationGauge then
    return
  end
  local self = PaGlobal_LocalWarOccupation_Gauge
  if nil ~= self._controlList[actorKeyRaw] then
    local contorlList = self._controlList[actorKeyRaw]
    if nil == _radarControl then
      contorlList._radarControl = control
      contorlList._radarControl:ChangeTextureInfoNameAsync("combine/etc/combine_etc_redbattlefield_war_wight.dds")
    end
  end
end
function PaGlobalFunc_LocalWarOccupation_UnRenderPanel()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local bHide = false
  local hideCondition = {
    ToClient_IsOccupationModeInRedBattleField()
  }
  for k, v in ipairs(hideCondition) do
    if true == v then
      bHide = true
    end
  end
  local targetPanel = Array.new()
  targetPanel:push_back(Panel_PersonalIcon_Left)
  targetPanel:push_back(Panel_MainQuest)
  targetPanel:push_back(Panel_CheckedQuest)
  for idx = 1, #targetPanel do
    if nil ~= targetPanel[idx] then
      targetPanel[idx]:SetRenderAndEventHide(bHide)
    end
  end
end
function PaGlobalFunc_LocalWarOccupation_GetTextureUV(occupationType, indexFromServer)
  if PaGlobal_LocalWarOccupation_Gauge._eOCCUPATIONTYPE.NONE == occupationType then
    if nil ~= PaGlobal_LocalWarOccupation_Gauge._noneTowerTextureUV[indexFromServer] then
      return PaGlobal_LocalWarOccupation_Gauge._noneTowerTextureUV[indexFromServer]
    end
  elseif PaGlobal_LocalWarOccupation_Gauge._eOCCUPATIONTYPE.BLACK == occupationType then
    if nil ~= PaGlobal_LocalWarOccupation_Gauge._blackTowerTextureUV[indexFromServer] then
      return PaGlobal_LocalWarOccupation_Gauge._blackTowerTextureUV[indexFromServer]
    end
  elseif nil ~= PaGlobal_LocalWarOccupation_Gauge._redTowerTextureUV[indexFromServer] then
    return PaGlobal_LocalWarOccupation_Gauge._redTowerTextureUV[indexFromServer]
  end
  return nil
end
