PaGlobal_TutorialPhase_SnowMountainBasicMove = {
  _phaseNo = 9,
  _currentStep = 0,
  _nextStep = nil,
  _currentProgress = 1,
  _updateTime = 0,
  _questCheckDelayTime = 0,
  _isPhaseOpen = true,
  _isSkippable = true,
  _regionKeyRawList = {890},
  _startLimitLevel = 5,
  _interactionCharacterKey = 426,
  _state = 0,
  _questList = {
    [1] = {_questGroupNo = 14001, _questId = 2},
    [2] = {_questGroupNo = 14001, _questId = 3}
  },
  eStepType = {eNoneStep = 0, eBasicMove = 1},
  eProgressType = {
    eShowMoveKeyGuide = 1,
    eCheckInteraction = 2,
    eCheckQuestClear = 3
  }
}
function PaGlobal_TutorialPhase_SnowMountainBasicMove:setState(state)
  self._state = state
end
function PaGlobal_TutorialPhase_SnowMountainBasicMove:getState()
  return self._state
end
function PaGlobal_TutorialPhase_SnowMountainBasicMove:checkPossibleForPhaseStart()
  if false == self._isPhaseOpen then
    return false
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return false
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    return false
  end
  if self._startLimitLevel < selfPlayer:getLevel() then
    return false
  end
  local currentRegionKeyRaw = selfPlayerWrapper:getRegionKeyRaw()
  local isPossiblePhaseRegion = false
  for index, value in pairs(self._regionKeyRawList) do
    if value == currentRegionKeyRaw then
      isPossiblePhaseRegion = true
      break
    end
  end
  if false == isPossiblePhaseRegion then
    return false
  end
  return true
end
function PaGlobal_TutorialPhase_SnowMountainBasicMove:checkSkippablePhase()
  if true == self._isSkippable and true == PaGlobal_TutorialManager:checkHaveOverLevelCharacter() then
    return true
  end
  return false
end
function PaGlobal_TutorialPhase_SnowMountainBasicMove:checkProgressQuest()
  for index, value in pairs(self._questList) do
    if true == questList_hasProgressQuest(value._questGroupNo, value._questId) then
      return true
    end
  end
  return false
end
function PaGlobal_TutorialPhase_SnowMountainBasicMove:startPhase(stepNo)
  if false == self:checkPossibleForPhaseStart() then
    return
  end
  if true == PaGlobal_SummonBossTutorial_Manager:isDoingSummonBossTutorial() then
    PaGlobal_SummonBossTutorial_Manager:endTutorial()
  end
  if true == self:checkSkippablePhase() and false == PaGlobal_TutorialManager:isDoingTutorial() then
    PaGlobal_TutorialManager:questionPhaseSkip(self, stepNo)
  else
    self:startPhaseXXX(stepNo)
  end
end
function PaGlobal_TutorialPhase_SnowMountainBasicMove:startPhaseXXX(stepNo)
  PaGlobal_TutorialManager:setCurrentPhaseNo(self._phaseNo)
  PaGlobal_TutorialManager:setDoingTutorial(true)
  self._currentStep = stepNo
  self._currentProgress = self.eProgressType.eShowMoveKeyGuide
  self._updateTime = 0
  self._questCheckDelayTime = 0
  Panel_Tutorial_Renew:SetShow(true, true)
  ToClient_DeleteNaviGuideByGroup()
  PaGlobal_TutorialUiManager:repositionScreen()
  PaGlobal_TutorialUiManager:hideAllTutorialUi()
  self:setState(PaGlobal_TutorialState.eState_Start)
end
function PaGlobal_TutorialPhase_SnowMountainBasicMove:endPhase()
  self._currentStep = self.eStepType.eNoneStep
  self._nextStep = nil
  self._updateTime = 0
  self._questCheckDelayTime = 0
  Panel_Tutorial_Renew:SetShow(false)
  PaGlobal_TutorialManager:endTutorial()
end
function PaGlobal_TutorialPhase_SnowMountainBasicMove:updatePerFrame(deltaTime)
  if self.eStepType.eBasicMove == self._currentStep then
    self:Step01_BasicMove(deltaTime)
  else
    self:endPhase()
  end
end
function PaGlobal_TutorialPhase_SnowMountainBasicMove:Step01_BasicMove(deltaTime)
  local currentState = self:getState()
  if PaGlobal_TutorialState.eState_Start == currentState then
    self:Step01_BasicMove_Prepare()
  elseif PaGlobal_TutorialState.eState_Do == currentState then
    self:Step01_BasicMove_DoStep(deltaTime)
  elseif PaGlobal_TutorialState.eState_Done == currentState then
    self:Step01_BasicMove_Done()
  end
end
function PaGlobal_TutorialPhase_SnowMountainBasicMove:Step01_BasicMove_Prepare()
  self:setState(PaGlobal_TutorialState.eState_Do)
end
function PaGlobal_TutorialPhase_SnowMountainBasicMove:Step01_BasicMove_DoStep(deltaTime)
  if self._updateTime < 0.2 then
    self._updateTime = self._updateTime + deltaTime
    return
  else
    self._updateTime = 0
  end
  self._questCheckDelayTime = self._questCheckDelayTime - deltaTime
  if 0 <= self._questCheckDelayTime then
    if false == self:checkProgressQuest() then
      self:setState(PaGlobal_TutorialState.eState_Done)
      return
    end
  else
    self._questCheckDelayTime = 1
  end
  if self.eProgressType.eShowMoveKeyGuide == self._currentProgress then
    local message = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_OBSIDIAN_TEXT_101")
    PaGlobal_TutorialUiManager:getUiBlackSpirit():setSpiritUiForTutorial_Desc(message)
    PaGlobal_TutorialUiBlackSpirit:setSpiritKeyGuideShow(0)
    if false == PaGlobal_TutorialUiBlackSpirit._ui._static_KeyGuideBg:GetShow() then
      PaGlobal_TutorialUiBlackSpirit._ui._static_KeyGuideBg:SetShow(true)
    end
    self._currentProgress = self.eProgressType.eCheckInteraction
  elseif self.eProgressType.eCheckInteraction == self._currentProgress then
    if true == Panel_Interaction:GetShow() then
      local actor = interaction_getInteractable()
      if nil ~= actor and self._interactionCharacterKey == actor:getCharacterKeyRaw() then
        local message = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_OBSIDIAN_TEXT_103")
        PaGlobal_TutorialUiManager:getUiBlackSpirit():setSpiritUiForTutorial_Desc(message)
        PaGlobal_TutorialUiBlackSpirit:setSpiritKeyGuideShow(5)
        if false == PaGlobal_TutorialUiBlackSpirit._ui._static_KeyGuideBg:GetShow() then
          PaGlobal_TutorialUiBlackSpirit._ui._static_KeyGuideBg:SetShow(true)
        end
        self._currentProgress = self.eProgressType.eCheckQuestClear
      end
    end
  elseif self.eProgressType.eCheckQuestClear == self._currentProgress then
    if false == Panel_Interaction:GetShow() then
      self._currentProgress = self.eProgressType.eShowMoveKeyGuide
    else
      local actor = interaction_getInteractable()
      if nil == actor or self._interactionCharacterKey ~= actor:getCharacterKeyRaw() then
        self._currentProgress = self.eProgressType.eShowMoveKeyGuide
      end
    end
  end
end
function PaGlobal_TutorialPhase_SnowMountainBasicMove:Step01_BasicMove_Done()
  self._updateTime = 0
  self._questCheckDelayTime = 0
  self._currentProgress = self.eProgressType.eShowMoveKeyGuide
  if nil ~= self._nextStep then
    self._currentStep = self._nextStep
  else
    self._currentStep = self.eStepType.eNoneStep
  end
  self:setState(PaGlobal_TutorialState.eState_Start)
end
