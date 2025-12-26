PaGlobal_MiniGame_MorningLogging_All = {
  _ui = {
    _txt_resurtBG = nil,
    _stc_success = nil,
    _stc_fail = nil,
    _stc_treeArea = nil,
    _stc_progressBG = nil,
    _stc_progressGauge = nil,
    _stc_successArea = nil,
    _stc_barHead = nil,
    _txt_jump = nil,
    _txt_timer = nil,
    _stc_subResultBG = nil,
    _txt_desc = nil,
    _stc_purpose = nil,
    _txt_purpose = nil
  },
  _curGameTime = 0,
  _maxGameTime = 15,
  _effectTime = 0,
  _effectMaxTime = 0.5,
  _isSuccess = false,
  _curStageTime = 0,
  _maxStageTime = 2,
  _curResultTime = 0,
  _maxResultTime = 0.6,
  _stage = 1,
  _stageMax = 5,
  _stageInfo = {},
  _curFailIndex = 0,
  _failMax = 10,
  _failList = {},
  _eGameState = {
    GAME = 0,
    RESULT = 1,
    END = 2
  },
  _state = 0,
  _result = 0,
  _score = 0,
  _curSuccessAreaSpanY = 0,
  _baseSuccessAreaSizeY = 0,
  _baseSuccessAreaSpanY = 0,
  _baseBarHeadSpanY = 0,
  _barHeadGapY = 0,
  _baseHitPoinSpanY = 0,
  _isConsole = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_MiniGame_MorningLogging_All_Init")
function FromClient_MiniGame_MorningLogging_All_Init()
  PaGlobal_MiniGame_MorningLogging_All:initialize()
end
function PaGlobal_MiniGame_MorningLogging_All:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._txt_resurtBG = UI.getChildControl(Panel_MiniGame_MorningLogging_All, "StaticText_Resurt_BG")
  self._ui._stc_success = UI.getChildControl(self._ui._txt_resurtBG, "Static_Success")
  self._ui._stc_fail = UI.getChildControl(self._ui._txt_resurtBG, "Static_Fail")
  self._ui._stc_treeArea = UI.getChildControl(Panel_MiniGame_MorningLogging_All, "Static_TreeArea")
  self._ui._stc_progressBG = UI.getChildControl(self._ui._stc_treeArea, "Static_ProgressBg")
  self._ui._stc_successArea = UI.getChildControl(self._ui._stc_progressBG, "Static_SuccessArea")
  self._ui._stc_progressGauge = UI.getChildControl(self._ui._stc_progressBG, "Progress2_Logging")
  self._ui._stc_barHead = UI.getChildControl(self._ui._stc_treeArea, "Static_BarHead")
  self._ui._txt_jump = UI.getChildControl(self._ui._stc_treeArea, "StaticText_SpaceBar")
  self._ui._txt_timer = UI.getChildControl(self._ui._stc_treeArea, "StaticText_Timer")
  self._ui._stc_subResultBG = UI.getChildControl(self._ui._stc_treeArea, "Static_ResultBg")
  self._ui._txt_desc = UI.getChildControl(self._ui._stc_subResultBG, "StaticText_Desc")
  self._ui._stc_purpose = UI.getChildControl(Panel_MiniGame_MorningLogging_All, "Static_Purpose")
  self._ui._txt_purpose = UI.getChildControl(self._ui._stc_purpose, "StaticText_Purpose")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_MiniGame_MorningLogging_All:validate()
  if Panel_MiniGame_MorningLogging_All == nil then
    return
  end
  self._ui._txt_resurtBG:isValidate()
  self._ui._stc_success:isValidate()
  self._ui._stc_fail:isValidate()
  self._ui._stc_treeArea:isValidate()
  self._ui._stc_progressBG:isValidate()
  self._ui._stc_progressGauge:isValidate()
  self._ui._stc_successArea:isValidate()
  self._ui._stc_barHead:isValidate()
  self._ui._txt_jump:isValidate()
  self._ui._txt_timer:isValidate()
  self._ui._stc_subResultBG:isValidate()
  self._ui._txt_desc:isValidate()
  self._ui._stc_purpose:isValidate()
  self._ui._txt_purpose:isValidate()
  for ii = 1, self._stageMax do
    self._stageInfo[ii].checkButton:isValidate()
    self._stageInfo[ii].checkButton_Axe:isValidate()
    self._stageInfo[ii].goodControl:isValidate()
    self._stageInfo[ii].hitPoint:isValidate()
  end
  for ii = 1, self._failMax do
    self._failList[ii].hitPoint:isValidate()
  end
end
function PaGlobal_MiniGame_MorningLogging_All:registEventHandler()
  if Panel_MiniGame_MorningLogging_All == nil then
    return
  end
  registerEvent("onScreenResize", "FromClient_MiniGame_MorningLogging_All_ResizePanel")
  Panel_MiniGame_MorningLogging_All:RegisterShowEventFunc(false, "PaGlobalFunc_CollectMiniGame_SetHideAnim(" .. __eCollectToolType_Axe .. ")")
  local hitPointTmp = UI.getChildControl(self._ui._stc_treeArea, "Static_HitPoint_Template")
  hitPointTmp:SetShow(false)
  self._stageInfo = {}
  for ii = 1, self._stageMax do
    local hitPoint = UI.cloneControl(hitPointTmp, self._ui._stc_treeArea, "Static_HitPoint_" .. tostring(ii))
    local successIcon = UI.getChildControl(hitPoint, "Static_O")
    local failIcon = UI.getChildControl(hitPoint, "Static_X")
    local stageInfo = {
      checkButton = UI.getChildControl(self._ui._stc_subResultBG, "CheckButton_" .. tostring(ii)),
      checkButton_Axe = UI.getChildControl(self._ui._stc_subResultBG, "CheckButton_Axe_" .. tostring(ii)),
      goodControl = UI.getChildControl(self._ui._stc_subResultBG, "Static_Good_" .. tostring(ii)),
      hitPoint = hitPoint,
      successIcon = successIcon,
      failIcon = failIcon
    }
    self._stageInfo[ii] = stageInfo
  end
  self._failList = {}
  for ii = 1, self._failMax do
    local hitPoint = UI.cloneControl(hitPointTmp, self._ui._stc_treeArea, "Static_HitPointFail_" .. tostring(ii))
    local successIcon = UI.getChildControl(hitPoint, "Static_O")
    successIcon:SetShow(false)
    local failIcon = UI.getChildControl(hitPoint, "Static_X")
    failIcon:SetShow(true)
    local failInfo = {
      hitPoint = hitPoint,
      successIcon = successIcon,
      failIcon = failIcon
    }
    self._failList[ii] = failInfo
  end
  self._ui._txt_jump:SetShow(self._isConsole == false)
  self._ui._txt_desc:SetTextMode(__eTextMode_AutoWrap)
  if self._isConsole == true then
    self._ui._txt_desc:SetText(self._ui._txt_desc:GetText())
  end
  self._baseBarHeadSpanY = self._ui._stc_barHead:GetSpanSize().y
  self._baseHitPoinSpanY = hitPointTmp:GetSpanSize().y + (self._ui._stc_treeArea:GetSizeY() - self._ui._stc_progressBG:GetSizeY()) / 2
  self._baseSuccessAreaSizeY = self._ui._stc_successArea:GetSizeY()
  self._baseSuccessAreaSpanY = self._ui._stc_successArea:GetSpanSize().y
end
function PaGlobal_MiniGame_MorningLogging_All:prepareOpen()
  if Panel_MiniGame_MorningLogging_All == nil then
    return
  end
  PaGlobalFunc_CollectMiniGame_Start()
  self:clear()
  self:updateSuccessArea(true)
  if self._isConsole == false then
    self:setActionKeyText()
  end
  Panel_MiniGame_MorningLogging_All:RegisterUpdateFunc("PaGlobal_MiniGame_MorningLogging_All_Update")
  self:open()
end
function PaGlobal_MiniGame_MorningLogging_All:open()
  if Panel_MiniGame_MorningLogging_All == nil then
    return
  end
  Panel_MiniGame_MorningLogging_All:SetShow(true)
end
function PaGlobal_MiniGame_MorningLogging_All:prepareClose()
  if Panel_MiniGame_MorningLogging_All == nil then
    return
  end
  PaGlobalFunc_CollectMiniGame_End()
  self._state = self._eGameState.GAME
  Panel_MiniGame_MorningLogging_All:EraseAllEffect()
  Panel_MiniGame_MorningLogging_All:ClearUpdateLuaFunc()
  self:close()
end
function PaGlobal_MiniGame_MorningLogging_All:close()
  if Panel_MiniGame_MorningLogging_All == nil then
    return
  end
  Panel_MiniGame_MorningLogging_All:SetShow(false, true)
end
function PaGlobal_MiniGame_MorningLogging_All:clear()
  if Panel_MiniGame_MorningLogging_All == nil then
    return
  end
  Panel_MiniGame_MorningLogging_All:EraseAllEffect()
  Panel_MiniGame_MorningLogging_All:ClearUpdateLuaFunc()
  PaGlobalFunc_CollectMiniGame_SetNotInputCheck(false)
  self._state = self._eGameState.GAME
  self._stage = 1
  self._curGameTime = self._maxGameTime
  self._curResultTime = 0
  self._curStageTime = 0
  self._effectTime = 0
  self._isSuccess = false
  self._result = __eCollectMiniGameState_Fail
  self._score = 0
  self._ui._txt_resurtBG:SetShow(false)
  self._ui._stc_success:SetShow(false)
  self._ui._stc_fail:SetShow(false)
  self._ui._stc_success:EraseAllEffect()
  self._ui._stc_fail:EraseAllEffect()
  self:resetProgress()
  self._ui._stc_successArea:SetSize(self._ui._stc_successArea:GetSizeX(), self._baseSuccessAreaSizeY)
  self._ui._stc_successArea:SetSpanSize(self._ui._stc_successArea:GetSpanSize().x, self._baseSuccessAreaSpanY)
  self._ui._stc_barHead:SetSpanSize(self._ui._stc_barHead:GetSpanSize().x, self._baseBarHeadSpanY)
  for ii = 1, self._stageMax do
    local stageInfo = self._stageInfo[ii]
    if stageInfo ~= nil then
      stageInfo.checkButton:SetShow(true)
      stageInfo.checkButton:SetCheck(ii == 1)
      stageInfo.checkButton_Axe:SetShow(true)
      stageInfo.goodControl:SetShow(false)
      stageInfo.goodControl:EraseAllEffect()
      stageInfo.hitPoint:SetShow(false)
      stageInfo.hitPoint:SetSpanSize(stageInfo.hitPoint:GetSpanSize().x, self._baseHitPoinSpanY)
      stageInfo.successIcon:SetShow(false)
      stageInfo.failIcon:SetShow(false)
    end
  end
  self._curFailIndex = 0
  for ii = 1, self._failMax do
    self._failList[ii].hitPoint:SetShow(false)
  end
  self._curSuccessAreaSpanY = 0
  self._ui._txt_purpose:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MINIGAME_LOGGING_PURPOSE", "currentCount", tostring(self._stage - 1)))
  self._ui._stc_purpose:SetShow(true)
end
function PaGlobal_MiniGame_MorningLogging_All:setActionKeyText()
  local actionKey_jump = keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_Jump)
  local descText = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_MINIGAME_LOGGING_DESC_PC", "Space", actionKey_jump)
  self._ui._txt_desc:SetText(descText)
  self._ui._txt_jump:SetText(string.upper(actionKey_jump))
end
function PaGlobal_MiniGame_MorningLogging_All:update(deltaTime)
  if Panel_MiniGame_MorningLogging_All == nil then
    return
  end
  if self._state == self._eGameState.GAME then
    if isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_ESCAPE) == true then
      ToClient_CollectMiniGameEnd(__eCollectMiniGameState_Cancle)
      self:prepareClose()
      return
    end
    if self._effectTime > 0 then
      self._effectTime = self._effectTime - deltaTime
      if self._effectTime <= 0 then
        self._effectTime = 0
        local isUpdateArea = true
        if self._isSuccess == true then
          self._stage = self._stage + 1
          if self._stage > self._stageMax then
            self._result = __eCollectMiniGameState_Success
            self._state = self._eGameState.RESULT
            isUpdateArea = false
          end
          self._ui._txt_purpose:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MINIGAME_LOGGING_PURPOSE", "currentCount", tostring(self._stage - 1)))
        end
        for ii = 1, self._stageMax do
          if self._stageInfo[ii].checkButton ~= nil then
            self._stageInfo[ii].checkButton:SetCheck(self._stage == ii)
          end
        end
        if isUpdateArea == true then
          self:updateSuccessArea(false)
          self:resetProgress()
          self._curStageTime = 0
        end
        PaGlobalFunc_CollectMiniGame_UpdateNotInputCheck(false)
      end
    else
      self._curGameTime = self._curGameTime - deltaTime
      if 0 >= self._curGameTime then
        self._curGameTime = 0
        self._result = __eCollectMiniGameState_Fail
        self._state = self._eGameState.RESULT
      else
        local progressRate = math.sin(self._curStageTime / self._maxStageTime * 3.14)
        self._ui._stc_progressGauge:SetProgressRate(progressRate * 100)
        local progressSizeY = self._ui._stc_progressBG:GetSizeY()
        self._ui._stc_barHead:SetSpanSize(self._ui._stc_barHead:GetSpanSize().x, self._baseBarHeadSpanY + progressSizeY * progressRate)
        local isKeyDown = false
        if self._isConsole == true then
          isKeyDown = isPadDown(__eJoyPadInputType_A)
        else
          isKeyDown = keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_Jump)
        end
        if isKeyDown == true then
          local successBGSizeY = self._ui._stc_successArea:GetSizeY()
          local successMax = (progressSizeY - self._ui._stc_successArea:GetSpanSize().y) / progressSizeY
          local successMin = successMax - successBGSizeY / progressSizeY
          self._isSuccess = progressRate >= successMin and progressRate <= successMax
          local stageInfo = self._stageInfo[self._stage]
          if stageInfo ~= nil then
            stageInfo.checkButton_Axe:SetShow(self._isSuccess == false)
            stageInfo.goodControl:SetShow(self._isSuccess == true)
            if self._isSuccess == true then
              stageInfo.goodControl:AddEffect("FUI_Morning_MiniGame_Good_01A", false, 0, 0)
            end
            stageInfo.hitPoint:SetSpanSize(stageInfo.hitPoint:GetSpanSize().x, self._baseHitPoinSpanY + self._ui._stc_progressBG:GetSizeY() * progressRate)
            stageInfo.successIcon:SetShow(self._isSuccess == true)
            stageInfo.failIcon:SetShow(self._isSuccess == false)
            stageInfo.hitPoint:SetShow(self._isSuccess == true)
          end
          if self._isSuccess == false then
            self._curFailIndex = self._curFailIndex + 1
            if self._curFailIndex > self._failMax then
              self._curFailIndex = 1
            end
            self._failList[self._curFailIndex].hitPoint:SetShow(true)
            self._failList[self._curFailIndex].hitPoint:SetSpanSize(self._failList[self._curFailIndex].hitPoint:GetSpanSize().x, self._baseHitPoinSpanY + self._ui._stc_progressBG:GetSizeY() * progressRate)
          end
          audioPostEvent_SystemUi(11, 133)
          _AudioPostEvent_SystemUiForXBOX(11, 133)
          self._effectTime = self._effectMaxTime
          PaGlobalFunc_CollectMiniGame_SetNotInputCheck(true)
        else
          self._curStageTime = self._curStageTime + deltaTime
          if self._curStageTime > self._maxStageTime then
            self._curStageTime = 0
          end
        end
      end
    end
    self._ui._txt_timer:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MINIGAME_POWERCONTROL_REMAINTIME", "gameEndTimer", math.floor(self._curGameTime)))
    if self._state == self._eGameState.RESULT then
      PaGlobalFunc_CollectMiniGame_UpdateResult(self._result, self._ui._stc_success, self._ui._stc_fail, self._ui._txt_resurtBG, self._ui._stc_purpose)
      self:resetProgress()
    end
  elseif self._state == self._eGameState.RESULT then
    PaGlobalFunc_CollectMiniGame_UpdateNotInputCheck(true)
    self._curResultTime = self._curResultTime + deltaTime
    if self._curResultTime < self._maxResultTime then
      return
    end
    self._state = self._eGameState.END
    self:prepareClose()
  end
end
function PaGlobal_MiniGame_MorningLogging_All:updateSuccessArea(isFirst)
  if Panel_MiniGame_MorningLogging_All == nil then
    return
  end
  local gapY = (self._stage - 1) * 10
  local successAreaSizeY = self._baseSuccessAreaSizeY - gapY
  self._ui._stc_successArea:SetSize(self._ui._stc_successArea:GetSizeX(), successAreaSizeY)
  if isFirst == true then
    local randomY = 20
    local maxY = self._ui._stc_progressBG:GetSizeY() * 0.5 - successAreaSizeY * 0.5
    if maxY > 0 then
      randomY = math.random(randomY, maxY)
    end
    self._curSuccessAreaSpanY = self._baseSuccessAreaSpanY + randomY
    self._ui._stc_successArea:SetSpanSize(self._ui._stc_successArea:GetSpanSize().x, self._curSuccessAreaSpanY)
  else
    self._ui._stc_successArea:SetSpanSize(self._ui._stc_successArea:GetSpanSize().x, self._curSuccessAreaSpanY + gapY * 0.5)
  end
end
function PaGlobal_MiniGame_MorningLogging_All:resetProgress()
  if Panel_MiniGame_MorningLogging_All == nil then
    return
  end
  self._ui._stc_progressGauge:SetSmoothMode(false)
  self._ui._stc_progressGauge:SetProgressRate(0)
  self._ui._stc_progressGauge:SetSmoothMode(true)
end
function PaGlobal_MiniGame_MorningLogging_All_Open()
  PaGlobal_MiniGame_MorningLogging_All:prepareOpen()
end
function PaGlobal_MiniGame_MorningLogging_All_Close()
  if Panel_MiniGame_MorningLogging_All ~= nil and Panel_MiniGame_MorningLogging_All:GetShow() == true then
    ToClient_CollectMiniGameEnd(__eCollectMiniGameState_Cancle)
  end
  PaGlobal_MiniGame_MorningLogging_All:prepareClose()
end
function PaGlobal_MiniGame_MorningLogging_All_Update(deltaTime)
  PaGlobal_MiniGame_MorningLogging_All:update(deltaTime)
end
function PaGlobal_MiniGame_MorningLogging_All_IsOpen()
  if Panel_MiniGame_MorningLogging_All == nil then
    return false
  end
  return Panel_MiniGame_MorningLogging_All:GetShow()
end
function FromClient_MiniGame_MorningLogging_All_ResizePanel()
  if Panel_MiniGame_MorningLogging_All == nil then
    return
  end
  Panel_MiniGame_MorningLogging_All:ComputePosAllChild()
end
