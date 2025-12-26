PaGlobal_MiniGame_MorningSyringe_All = {
  _ui = {
    _txt_resurtBG = nil,
    _stc_success = nil,
    _stc_fail = nil,
    _stc_syringeArea = nil,
    _stc_progressBG = nil,
    _stc_progressGauge = nil,
    _stc_goodArea = nil,
    _stc_perfectArea = nil,
    _stc_barHead = nil,
    _stc_progressSyringe = nil,
    _stc_syringeBarHead = nil,
    _stc_subResultBG = nil,
    _txt_desc = nil,
    _txt_jump = nil,
    _stc_purpose = nil,
    _txt_purpose = nil
  },
  _curStageTime = 0,
  _maxStageTime = 1.8,
  _curResultTime = 0,
  _maxResultTime = 0.6,
  _clickEffectTime = 0,
  _clickEffectMaxTime = 1,
  _stage = 1,
  _stageMax = 5,
  _stageInfo = {},
  _scoreTable = {
    [0] = 40,
    [1] = 30,
    [2] = 0
  },
  _eStageResult = {
    PERFECT = 0,
    GOOD = 1,
    FAIL = 2
  },
  _eGameState = {
    GAME = 0,
    RESULT = 1,
    END = 2
  },
  _state = 0,
  _result = 0,
  _score = 0,
  _maxScore = 100,
  _keyInputCheck = false,
  _baseBarHeadSpanY = 0,
  _isConsole = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_MiniGame_MorningSyringe_All_Init")
function FromClient_MiniGame_MorningSyringe_All_Init()
  PaGlobal_MiniGame_MorningSyringe_All:initialize()
end
function PaGlobal_MiniGame_MorningSyringe_All:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._txt_resurtBG = UI.getChildControl(Panel_MiniGame_MorningSyringe_All, "StaticText_Resurt_BG")
  self._ui._stc_success = UI.getChildControl(self._ui._txt_resurtBG, "Static_Success")
  self._ui._stc_fail = UI.getChildControl(self._ui._txt_resurtBG, "Static_Fail")
  self._ui._stc_syringeArea = UI.getChildControl(Panel_MiniGame_MorningSyringe_All, "Static_SyringeArea")
  self._ui._stc_progressBG = UI.getChildControl(self._ui._stc_syringeArea, "Static_ProgressBg")
  self._ui._stc_progressGauge = UI.getChildControl(self._ui._stc_syringeArea, "Progress2_PowerGauge")
  self._ui._stc_goodArea = UI.getChildControl(self._ui._stc_syringeArea, "Static_SuccessArea_Good")
  self._ui._stc_perfectArea = UI.getChildControl(self._ui._stc_syringeArea, "Static_SuccessArea_Perfect")
  self._ui._stc_barHead = UI.getChildControl(self._ui._stc_syringeArea, "Static_BarHead")
  self._ui._stc_progressSyringe = UI.getChildControl(self._ui._stc_syringeArea, "Progress2_Syringe")
  self._ui._stc_syringeBarHead = UI.getChildControl(self._ui._stc_progressSyringe, "Progress2_1_Bar_Head")
  self._ui._stc_subResultBG = UI.getChildControl(self._ui._stc_syringeArea, "Static_ResultBg")
  self._ui._txt_desc = UI.getChildControl(self._ui._stc_syringeArea, "StaticText_Desc")
  self._ui._txt_jump = UI.getChildControl(self._ui._stc_syringeArea, "StaticText_SpaceBar")
  self._ui._stc_purpose = UI.getChildControl(Panel_MiniGame_MorningSyringe_All, "Static_Purpose")
  self._ui._txt_purpose = UI.getChildControl(self._ui._stc_purpose, "StaticText_Purpose")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_MiniGame_MorningSyringe_All:validate()
  if Panel_MiniGame_MorningSyringe_All == nil then
    return
  end
  self._ui._txt_resurtBG:isValidate()
  self._ui._stc_success:isValidate()
  self._ui._stc_fail:isValidate()
  self._ui._stc_syringeArea:isValidate()
  self._ui._stc_progressBG:isValidate()
  self._ui._stc_progressGauge:isValidate()
  self._ui._stc_goodArea:isValidate()
  self._ui._stc_perfectArea:isValidate()
  self._ui._stc_barHead:isValidate()
  self._ui._stc_progressSyringe:isValidate()
  self._ui._stc_syringeBarHead:isValidate()
  self._ui._stc_subResultBG:isValidate()
  self._ui._txt_desc:isValidate()
  self._ui._txt_jump:isValidate()
  self._ui._stc_purpose:isValidate()
  self._ui._txt_purpose:isValidate()
  for ii = 1, self._stageMax do
    self._stageInfo[ii].checkButton:isValidate()
    self._stageInfo[ii].checkButtonWait:isValidate()
    self._stageInfo[ii].perfectControl:isValidate()
    self._stageInfo[ii].goodControl:isValidate()
    self._stageInfo[ii].failControl:isValidate()
  end
end
function PaGlobal_MiniGame_MorningSyringe_All:registEventHandler()
  if Panel_MiniGame_MorningSyringe_All == nil then
    return
  end
  registerEvent("onScreenResize", "FromClient_MiniGame_MorningSyringe_All_ResizePanel")
  Panel_MiniGame_MorningSyringe_All:RegisterShowEventFunc(false, "PaGlobalFunc_CollectMiniGame_SetHideAnim(" .. __eCollectToolType_Syringe .. ")")
  self._stageInfo = {}
  for ii = 1, self._stageMax do
    local stageInfo = {
      checkButton = UI.getChildControl(self._ui._stc_subResultBG, "CheckButton_" .. tostring(ii)),
      checkButtonWait = UI.getChildControl(self._ui._stc_subResultBG, "CheckButton_Wait_" .. tostring(ii)),
      perfectControl = UI.getChildControl(self._ui._stc_subResultBG, "Static_Perfect_" .. tostring(ii)),
      goodControl = UI.getChildControl(self._ui._stc_subResultBG, "Static_Good_" .. tostring(ii)),
      failControl = UI.getChildControl(self._ui._stc_subResultBG, "Static_Failed_" .. tostring(ii))
    }
    self._stageInfo[ii] = stageInfo
  end
  self._ui._txt_jump:SetShow(self._isConsole == false)
  self._ui._txt_desc:SetTextMode(__eTextMode_AutoWrap)
  if self._isConsole == true then
    self._ui._txt_desc:SetText(self._ui._txt_desc:GetText())
  end
  self._baseBarHeadSpanY = self._ui._stc_barHead:GetSpanSize().y
end
function PaGlobal_MiniGame_MorningSyringe_All:prepareOpen()
  if Panel_MiniGame_MorningSyringe_All == nil then
    return
  end
  PaGlobalFunc_CollectMiniGame_Start()
  self:clear()
  if self._isConsole == false then
    self:setActionKeyText()
  end
  Panel_MiniGame_MorningSyringe_All:RegisterUpdateFunc("PaGlobal_MiniGame_MorningSyringe_All_Update")
  self:open()
end
function PaGlobal_MiniGame_MorningSyringe_All:open()
  if Panel_MiniGame_MorningSyringe_All == nil then
    return
  end
  Panel_MiniGame_MorningSyringe_All:SetShow(true)
end
function PaGlobal_MiniGame_MorningSyringe_All:prepareClose()
  if Panel_MiniGame_MorningSyringe_All == nil then
    return
  end
  PaGlobalFunc_CollectMiniGame_End()
  self._state = self._eGameState.GAME
  Panel_MiniGame_MorningSyringe_All:EraseAllEffect()
  Panel_MiniGame_MorningSyringe_All:ClearUpdateLuaFunc()
  self:close()
end
function PaGlobal_MiniGame_MorningSyringe_All:close()
  if Panel_MiniGame_MorningSyringe_All == nil then
    return
  end
  Panel_MiniGame_MorningSyringe_All:SetShow(false, true)
end
function PaGlobal_MiniGame_MorningSyringe_All:clear()
  if Panel_MiniGame_MorningSyringe_All == nil then
    return
  end
  Panel_MiniGame_MorningSyringe_All:EraseAllEffect()
  Panel_MiniGame_MorningSyringe_All:ClearUpdateLuaFunc()
  self._state = self._eGameState.GAME
  self._stage = 1
  self._curGameTime = self._maxGameTime
  self._curResultTime = 0
  self._curStageTime = 0
  self._clickEffectTime = 0
  self._result = __eCollectMiniGameState_Fail
  self._score = 0
  self._stage = 1
  self._keyInputCheck = false
  self._ui._txt_resurtBG:SetShow(false)
  self._ui._stc_success:SetShow(false)
  self._ui._stc_fail:SetShow(false)
  self._ui._stc_success:EraseAllEffect()
  self._ui._stc_fail:EraseAllEffect()
  self:resetProgress()
  self._ui._stc_progressSyringe:SetSmoothMode(false)
  self._ui._stc_progressSyringe:SetProgressRate(0)
  self._ui._stc_progressSyringe:SetSmoothMode(true)
  self._ui._stc_barHead:SetSpanSize(self._ui._stc_barHead:GetSpanSize().x, self._baseBarHeadSpanY)
  for ii = 1, self._stageMax do
    self._stageInfo[ii].checkButton:SetCheck(ii == 1)
    self._stageInfo[ii].checkButton:SetShow(true)
    self._stageInfo[ii].checkButtonWait:SetShow(true)
    self._stageInfo[ii].perfectControl:SetShow(false)
    self._stageInfo[ii].goodControl:SetShow(false)
    self._stageInfo[ii].failControl:SetShow(false)
    self._stageInfo[ii].perfectControl:EraseAllEffect()
    self._stageInfo[ii].goodControl:EraseAllEffect()
    self._stageInfo[ii].failControl:EraseAllEffect()
  end
  self._ui._txt_purpose:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MINIGAME_SYRINGE_PURPOSE", "currentPercent", tostring(self._score)))
  self._ui._stc_purpose:SetShow(true)
end
function PaGlobal_MiniGame_MorningSyringe_All:setActionKeyText()
  local actionKey_jump = keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_Jump)
  local descText = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_MINIGAME_SYRINGE_DESC_PC", "Space", actionKey_jump) .. "\n" .. PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_MINIGAME_SYRINGE_DESC2_PC", "Space", actionKey_jump)
  self._ui._txt_desc:SetText(descText)
  self._ui._txt_jump:SetText(string.upper(actionKey_jump))
end
function PaGlobal_MiniGame_MorningSyringe_All:update(deltaTime)
  if Panel_MiniGame_MorningSyringe_All == nil then
    return
  end
  if self._state == self._eGameState.GAME then
    if isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_ESCAPE) == true then
      ToClient_CollectMiniGameEnd(__eCollectMiniGameState_Cancle)
      self:prepareClose()
      return
    end
    if self._keyInputCheck == false then
      local isKeyDown = self._isConsole == true and isPadDown(__eJoyPadInputType_A) == true or keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_Jump) == true
      if isKeyDown == true then
        self._keyInputCheck = true
        self._curStageTime = 0
        self._clickEffectTime = 0
        self:resetProgress()
      else
        if 0 < self._clickEffectTime then
          self._clickEffectTime = self._clickEffectTime - deltaTime
          if 0 >= self._clickEffectTime then
            self._clickEffectTime = 0
          end
        end
        local targetRate = self._ui._stc_progressSyringe:GetProgressRate()
        local curAnimRate = self._ui._stc_progressSyringe:GetCurrentProgressRate()
        if targetRate == curAnimRate and 0 >= self._clickEffectTime then
          self._curStageTime = 0
          self:resetProgress()
          self._ui._stc_barHead:SetSpanSize(self._ui._stc_barHead:GetSpanSize().x, self._baseBarHeadSpanY)
        end
      end
      return
    end
    self._curStageTime = self._curStageTime + deltaTime
    if self._curStageTime > self._maxStageTime then
      self._curStageTime = 0
    end
    local progressRate = math.sin(self._curStageTime / self._maxStageTime * 3.14)
    self._ui._stc_progressGauge:SetProgressRate(progressRate * 100)
    self._ui._stc_barHead:SetSpanSize(self._ui._stc_barHead:GetSpanSize().x, self._baseBarHeadSpanY + self._ui._stc_progressGauge:GetSizeY() * progressRate)
    local isKeyUp = self._isConsole == true and isPadUp(__eJoyPadInputType_A) == true or keyCustom_IsUp_Action(CppEnums.ActionInputType.ActionInputType_Jump) == true
    if isKeyUp == true then
      local checkType = self._eStageResult.FAIL
      local prevScore = self._score
      self._stageInfo[self._stage].checkButtonWait:SetShow(false)
      if progressRate >= 0.7 and progressRate <= 0.8 then
        checkType = self._eStageResult.PERFECT
        self._score = self._score + self._scoreTable[self._eStageResult.PERFECT]
        self._stageInfo[self._stage].perfectControl:SetShow(true)
        self._stageInfo[self._stage].perfectControl:AddEffect("FUI_Morning_MiniGame_Perfect_01A", false, 0, 0)
      elseif progressRate >= 0.6 and progressRate <= 0.87 then
        checkType = self._eStageResult.GOOD
        self._score = self._score + self._scoreTable[self._eStageResult.GOOD]
        self._stageInfo[self._stage].goodControl:SetShow(true)
        self._stageInfo[self._stage].goodControl:AddEffect("FUI_Morning_MiniGame_Good_01A", false, 0, 0)
      else
        checkType = self._eStageResult.FAIL
        self._score = self._score + self._scoreTable[self._eStageResult.FAIL]
        self._stageInfo[self._stage].failControl:SetShow(true)
        self._stageInfo[self._stage].failControl:AddEffect("FUI_Morning_MiniGame_Failed_01A", false, 0, 0)
      end
      if self._score >= self._maxScore then
        self._score = self._maxScore
      end
      if prevScore ~= self._score then
        audioPostEvent_SystemUi(11, 134)
        _AudioPostEvent_SystemUiForXBOX(11, 134)
      end
      self._ui._stc_progressSyringe:SetProgressRate(self._score)
      for ii = 1, self._stageMax do
        local checkButton = self._stageInfo[ii].checkButton
        if checkButton ~= nil then
          checkButton:SetCheck(self._stage + 1 == ii)
        end
      end
      if self._score >= self._maxScore then
        self._state = self._eGameState.RESULT
        self._result = __eCollectMiniGameState_Success
      elseif self._score + (self._stageMax - self._stage) * self._scoreTable[self._eStageResult.PERFECT] < self._maxScore then
        self._state = self._eGameState.RESULT
        self._result = __eCollectMiniGameState_Fail
      else
        self._stage = self._stage + 1
        if self._stage > self._stageMax then
          self._state = self._eGameState.RESULT
          self._result = __eCollectMiniGameState_Fail
        else
          self._keyInputCheck = false
        end
        self._ui._txt_purpose:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MINIGAME_SYRINGE_PURPOSE", "currentPercent", tostring(self._score)))
      end
      self._clickEffectTime = self._clickEffectMaxTime
    end
    if self._state == self._eGameState.RESULT then
      PaGlobalFunc_CollectMiniGame_UpdateResult(self._result, self._ui._stc_success, self._ui._stc_fail, self._ui._txt_resurtBG, self._ui._stc_purpose)
      self:resetProgress()
    end
  elseif self._state == self._eGameState.RESULT then
    self._curResultTime = self._curResultTime + deltaTime
    if self._curResultTime < self._maxResultTime then
      return
    end
    self._state = self._eGameState.END
    self:prepareClose()
  end
end
function PaGlobal_MiniGame_MorningSyringe_All:resetProgress()
  if Panel_MiniGame_MorningSyringe_All == nil then
    return
  end
  self._ui._stc_progressGauge:SetSmoothMode(false)
  self._ui._stc_progressGauge:SetProgressRate(0)
  self._ui._stc_progressGauge:SetSmoothMode(true)
end
function PaGlobal_MiniGame_MorningSyringe_All_Open()
  PaGlobal_MiniGame_MorningSyringe_All:prepareOpen()
end
function PaGlobal_MiniGame_MorningSyringe_All_Close()
  if Panel_MiniGame_MorningSyringe_All ~= nil and Panel_MiniGame_MorningSyringe_All:GetShow() == true then
    ToClient_CollectMiniGameEnd(__eCollectMiniGameState_Cancle)
  end
  PaGlobal_MiniGame_MorningSyringe_All:prepareClose()
end
function PaGlobal_MiniGame_MorningSyringe_All_Update(deltaTime)
  PaGlobal_MiniGame_MorningSyringe_All:update(deltaTime)
end
function PaGlobal_MiniGame_MorningSyringe_All_IsOpen()
  if Panel_MiniGame_MorningSyringe_All == nil then
    return false
  end
  return Panel_MiniGame_MorningSyringe_All:GetShow()
end
function FromClient_MiniGame_MorningSyringe_All_ResizePanel()
  if Panel_MiniGame_MorningSyringe_All == nil then
    return
  end
  Panel_MiniGame_MorningSyringe_All:ComputePosAllChild()
end
