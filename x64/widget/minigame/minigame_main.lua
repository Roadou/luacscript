local MGT = CppEnums.MiniGameType
local IM = CppEnums.EProcessorInputMode
local currentMiniGame = -1
local lastUIMode
local minigame = {
  _config = {
    _limitKeyFrame = 60,
    _updateTerm = 0.016666666666666666,
    _keyInputType = {
      _downOnce = 0,
      _up = 1,
      _press = 2
    }
  },
  _isUpdate = true,
  _saveData = nil,
  _prevData = nil,
  _deltaTime = 0,
  _updateTime = 0,
  _tempFrame = 0,
  _isShowDebugMessage = true
}
local collectMiniGame = {
  _skillCommandShow = false,
  _isPlaying = false,
  _isNotInputCheck = false
}
function ActionMiniGame_Main(gameIndex)
  if gameIndex < MGT.MiniGameType_0 or MGT.MiniGameType_17 == gameIndex or gameIndex > MGT.MiniGameType_20 or currentMiniGame == gameIndex then
    return
  end
  if PaGlobal_GameExit_All ~= nil then
    PaGlobal_GameExit_All:prepareClose(true)
  end
  if MGT.MiniGameType_0 == gameIndex then
    PaGlobal_MiniGame_Gradient_All_StartGame()
  elseif MGT.MiniGameType_1 == gameIndex then
    if true == _ContentsGroup_NewUI_Fishing_All then
      PaGloabl_SinGauge_All_StartGame()
    else
      Panel_Minigame_SinGauge_Start()
    end
  elseif MGT.MiniGameType_2 == gameIndex then
    if true == _ContentsGroup_NewUI_Fishing_All then
      PaGloabl_Command_All_StartGame()
    else
      Panel_Minigame_Command_Start()
    end
  elseif MGT.MiniGameType_3 == gameIndex then
    PaGlobal_MiniGame_Rhythm_All_StartGame()
    minigame:checkUpdateCondition(minigame._config._keyInputType._press, CppEnums.MiniGameKeyType.MiniGameKeyType_M0)
  elseif MGT.MiniGameType_4 == gameIndex then
    PaGlobal_MiniGame_BattleGauge_All_StartGame()
  elseif MGT.MiniGameType_5 == gameIndex then
    Panel_Minigame_FillGauge_Start()
  elseif MGT.MiniGameType_6 == gameIndex then
    PaGlobal_MiniGame_GradientY_All_StartGame()
  elseif MGT.MiniGameType_7 == gameIndex then
    PaGlobal_MiniGame_Timing_All_StartGame()
  elseif MGT.MiniGameType_8 == gameIndex then
  elseif MGT.MiniGameType_9 == gameIndex then
  elseif MGT.MiniGameType_10 == gameIndex then
    Panel_Minigame_RhythmForAction_Start()
  elseif MGT.MiniGameType_11 == gameIndex then
    PaGlobal_MiniGame_HerbMachine_All_StartGame()
  elseif MGT.MiniGameType_12 == gameIndex then
    PaGlobal_MiniGame_Buoy_All_StartGame()
  elseif MGT.MiniGameType_13 == gameIndex then
    Panel_Minigame_Steal_Start()
  elseif MGT.MiniGameType_14 == gameIndex then
    PaGlobal_PowerControl_All_GameStart()
  elseif MGT.MiniGameType_15 == gameIndex then
    if true == _ContentsGroup_NewUI_Jaksal_All then
      PaGloabl_Jaksal_All_Start()
    else
      Panel_MiniGame_Jaksal_Start()
    end
  elseif MGT.MiniGameType_16 == gameIndex then
    PaGlobal_MiniGame_Rhythm_Drum_All_StartGame()
  elseif MGT.MiniGameType_17 == gameIndex then
    Panel_Minigame_SteeringWheel_Start()
  elseif MGT.MiniGameType_0 == gameIndex then
    Panel_Minigame_Gradient_Start(true)
  elseif MGT.MiniGameType_19 == gameIndex then
    PaGlobal_HammerGame:Start()
  elseif MGT.MiniGameType_20 == gameIndex then
    if true == _ContentsGroup_NewUI_MiniGame_Sniper_All then
      PaGlobal_MiniGame_SniperReload_All_Open()
    else
      PaGlobalFunc_SniperReload_Open()
    end
  end
  lastUIMode = GetUIMode()
  if false == _ContentsGroup_RenewUI_WorldMap and FGlobal_CloseWorldmapForLuaKeyHandling ~= nil then
    FGlobal_CloseWorldmapForLuaKeyHandling()
  elseif PaGlobalFunc_WorldMap_CloseForLuaKeyHandling ~= nil then
    PaGlobalFunc_WorldMap_CloseForLuaKeyHandling()
  end
  SetUIMode(Defines.UIMode.eUIMode_MiniGame)
  currentMiniGame = gameIndex
end
function ActionMiniGame_Stop()
  if currentMiniGame < MGT.MiniGameType_0 or MGT.MiniGameType_20 < currentMiniGame then
    return
  end
  if MGT.MiniGameType_0 == currentMiniGame then
    PaGlobal_MiniGame_Gradient_All_EndGame()
  elseif MGT.MiniGameType_1 == currentMiniGame then
    if true == _ContentsGroup_NewUI_Fishing_All then
      PaGloabl_SinGauge_All_EndGame()
    else
      Panel_Minigame_SinGauge_End()
    end
  elseif MGT.MiniGameType_2 == currentMiniGame then
    if true == _ContentsGroup_NewUI_Fishing_All then
      PaGloabl_Command_All_EndGame()
    else
      Panel_Minigame_Command_End()
    end
  elseif MGT.MiniGameType_3 == currentMiniGame then
    PaGlobal_MiniGame_Rhythm_All_EndGame()
  elseif MGT.MiniGameType_4 == currentMiniGame then
    PaGlobal_MiniGame_BattleGauge_All_EndGame()
  elseif MGT.MiniGameType_5 == currentMiniGame then
    Panel_Minigame_FillGauge_End()
  elseif MGT.MiniGameType_6 == currentMiniGame then
    PaGlobal_MiniGame_GradientY_All_EndGame()
  elseif MGT.MiniGameType_7 == currentMiniGame then
    PaGlobal_MiniGame_Timing_All_EndGame()
  elseif MGT.MiniGameType_8 == currentMiniGame then
  elseif MGT.MiniGameType_9 == currentMiniGame then
  elseif MGT.MiniGameType_10 == currentMiniGame then
    Panel_Minigame_RhythmForAction_End()
  elseif MGT.MiniGameType_11 == currentMiniGame then
    PaGlobal_MiniGame_HerbMachine_All_EndGame()
  elseif MGT.MiniGameType_12 == currentMiniGame then
    PaGlobal_MiniGame_Buoy_All_EndGame()
  elseif MGT.MiniGameType_13 == currentMiniGame then
    Panel_Minigame_Steal_End()
  elseif MGT.MiniGameType_14 == currentMiniGame then
    PaGlobal_PowerControl_All_GameEnd()
  elseif MGT.MiniGameType_15 == currentMiniGame then
    if true == _ContentsGroup_NewUI_Jaksal_All then
      PaGloabl_Jaksal_All_End()
    else
      Panel_MiniGame_Jaksal_End()
    end
  elseif MGT.MiniGameType_16 == currentMiniGame then
    PaGlobal_MiniGame_Rhythm_Drum_All_EndGame()
  elseif MGT.MiniGameType_17 == currentMiniGame then
    Panel_Minigame_SteeringWheel_End()
  elseif MGT.MiniGameType_18 == currentMiniGame then
    Panel_Minigame_Gradient_End()
  elseif MGT.MiniGameType_19 == currentMiniGame then
    PaGlobal_HammerGame:End()
  elseif MGT.MiniGameType_20 == gameIndex then
    if true == _ContentsGroup_NewUI_MiniGame_Sniper_All then
      PaGlobal_MiniGame_SniperReload_All_Close()
    else
      PaGlobalFunc_SniperReload_Close()
    end
  end
  SetUIMode(Defines.UIMode.eUIMode_Default)
  CheckChattingInput()
  lastUIMode = nil
  currentMiniGame = -1
  minigame:initialize()
end
local keyPressFunctorList = {}
function Panel_Minigame_EventKeyPress(keyType)
  if currentMiniGame < MGT.MiniGameType_0 or MGT.MiniGameType_20 < currentMiniGame then
    return
  end
  local pressFunction = keyPressFunctorList[currentMiniGame]
  if nil ~= pressFunction then
    if false == minigame:checkUpdateCondition(minigame._config._keyInputType._press, keyType) then
      return
    end
    pressFunction(keyType)
    return
  end
end
registerEvent("EventActionMiniGameKeyDownOnce", "EventActionMiniGameKeyDownOnce")
function Panel_Minigame_UpdateFunc(deltaTime)
  if currentMiniGame < MGT.MiniGameType_0 or MGT.MiniGameType_20 < currentMiniGame then
    return
  end
  if false == minigame:updatePerFrame(deltaTime) then
    return
  end
  deltaTime = minigame._updateTime
  if MGT.MiniGameType_0 == currentMiniGame then
    PaGlobal_MiniGame_Gradient_All_GaugeBarMoveCalc(deltaTime)
  elseif MGT.MiniGameType_1 == currentMiniGame then
    if true == _ContentsGroup_NewUI_Fishing_All then
      PaGlobal_SinGauge_All_UpdateGauge()
    else
      SinGaugeBar_UpdateGauge()
    end
  elseif MGT.MiniGameType_2 == currentMiniGame then
    if true == _ContentsGroup_NewUI_Fishing_All then
      PaGlobal_Command_All_UpdateText(deltaTime)
    else
      Command_UpdateText(deltaTime)
    end
  elseif MGT.MiniGameType_3 == currentMiniGame then
    PaGlobal_MiniGame_Rhythm_All_GameUpdate(deltaTime)
  elseif MGT.MiniGameType_4 == currentMiniGame then
    PaGlobal_MiniGame_BattleGauge_All_GameUpdate(deltaTime)
  elseif MGT.MiniGameType_5 == currentMiniGame then
    FillGauge_UpdatePerFrame(deltaTime)
  elseif MGT.MiniGameType_6 == currentMiniGame then
    PaGlobal_MiniGame_GradientY_All_GaugeBarMoveCalc(deltaTime)
  elseif MGT.MiniGameType_7 == currentMiniGame then
    PaGlobal_MiniGame_Timing_All_GameUpdate(deltaTime)
  elseif MGT.MiniGameType_8 == currentMiniGame then
    Panel_Minigame_Drag_PerFrame()
  elseif MGT.MiniGameType_9 == currentMiniGame then
  elseif MGT.MiniGameType_10 == currentMiniGame then
    RhythmGame_ForAction_UpdateFunc()
  elseif MGT.MiniGameType_11 == currentMiniGame then
    PaGlobal_MiniGame_HerbMachine_All_GameUpdate(deltaTime)
  elseif MGT.MiniGameType_12 == currentMiniGame then
    PaGlobal_MiniGame_Buoy_All_GameUpdate(deltaTime)
  elseif MGT.MiniGameType_13 == currentMiniGame then
    Minigame_Steal_KeyPressTimeCheck(deltaTime)
  elseif MGT.MiniGameType_14 == currentMiniGame then
    PaGlobal_PowerControl_All_UpdatePerframe(deltaTime)
  elseif MGT.MiniGameType_15 == currentMiniGame then
    if true == _ContentsGroup_NewUI_Jaksal_All then
      PaGlobal_Jaksal_All_UpdatePerframe(deltaTime)
    else
      Panel_MiniGame_PerFrameUpdate(deltaTime)
    end
  elseif MGT.MiniGameType_16 == currentMiniGame then
    PaGlobal_MiniGame_Rhythm_Drum_All_GameUpdate(deltaTime)
  elseif MGT.MiniGameType_17 == currentMiniGame then
    MiniGame_SteeringWhellMoveCalc(deltaTime)
  elseif MGT.MiniGameType_19 == currentMiniGame then
    PaGlobal_HammerGame:Update(deltaTime)
  elseif MGT.MiniGameType_20 == currentMiniGame then
    if true == _ContentsGroup_NewUI_MiniGame_Sniper_All then
      PaGlobal_MiniGame_SniperReload_All_UpdatePerFrame(deltaTime)
    else
      PaGlobalFunc_SniperReload_UpdatePerFrame(deltaTime)
    end
  end
  minigame._updateTime = 0
end
local keyDownFunctorList = {}
local keyUpFunctorList = {}
function AddMiniGameKeyPress(miniGameType, functor)
  keyDownFunctorList[miniGameType] = functor
end
function AddMiniGameKeyUp(miniGameType, functor)
  keyUpFunctorList[miniGameType] = functor
end
function EventActionMiniGameKeyDownOnce(keyType)
  local functor = keyDownFunctorList[currentMiniGame]
  if nil ~= functor then
    if false == minigame:checkUpdateCondition(minigame._config._keyInputType._downOnce, keyType) then
      return
    end
    functor(keyType)
  end
end
function EventActionMiniGameKeyUp(keyType)
  local functor = keyUpFunctorList[currentMiniGame]
  if nil ~= functor then
    if false == minigame:checkUpdateCondition(minigame._config._keyInputType._up, keyType) then
      return
    end
    functor(keyType)
  end
end
function minigame:initialize()
  keyDownFunctorList = {
    [MGT.MiniGameType_0] = PaGlobal_MiniGame_Gradient_KeyPress,
    [MGT.MiniGameType_1] = PaGlobal_MiniGame_SinGaugeKeyPress,
    [MGT.MiniGameType_2] = PaGlobal_MiniGame_CommandInput,
    [MGT.MiniGameType_3] = PaGlobal_MiniGame_Rhythm_KeyPress,
    [MGT.MiniGameType_4] = PaGlobal_MiniGame_BattleGauge_KeyPress,
    [MGT.MiniGameType_6] = PaGlobal_MiniGame_GradientY_KeyPress,
    [MGT.MiniGameType_7] = PaGlobal_MiniGame_Timing_KeyPress,
    [MGT.MiniGameType_10] = MiniGame_RhythmForAction_KeyPress,
    [MGT.MiniGameType_11] = PaGlobal_MiniGame_HerbMachine_KeyPress,
    [MGT.MiniGameType_12] = PaGlobal_MiniGame_Buoy_KeyPress,
    [MGT.MiniGameType_13] = Minigame_Steal_PressKey,
    [MGT.MiniGameType_15] = PaGlobal_MiniGame_Jaksal_KeyPress,
    [MGT.MiniGameType_16] = PaGlobal_MiniGame_Rhythm_Drum_KeyPress,
    [MGT.MiniGameType_17] = MiniGame_SteeringWheel_KeyPress,
    [MGT.MiniGameType_18] = MiniGame_Gradient_KeyPress,
    [MGT.MiniGameType_19] = PaGlobal_HammerGame_KeyFunc,
    [MGT.MiniGameType_20] = PaGlobal_MiniGame_Sniper_KeyPress
  }
  self:resetData()
end
function minigame:resetData()
  self._saveData = nil
  self._prevData = nil
  self._isUpdate = true
  self._updateTime = self._config._updateTerm
  self._deltaTime = 0
end
function minigame:checkUpdateCondition(inputType, keyType)
  if true == self._isShowDebugMessage then
    _PA_LOG("\236\157\180\235\139\164\237\152\156", "Frame : " .. self._tempFrame .. " CurrentDelta : " .. self._deltaTime .. " UpdateTerm : " .. self._config._updateTerm .. "  isUpdate?" .. tostring(self._isUpdate))
    _PA_LOG("\236\157\180\235\139\164\237\152\156", "inputType : " .. inputType .. " keyType : " .. keyType)
  end
  if false == self._isUpdate then
    if nil ~= self._prevData and self._prevData._inputType == self._config._keyInputType._press and (keyType ~= self._config._keyInputType._up or keyType ~= self._prevData._keyType) then
      return false
    end
    self._saveData = {_inputType = inputType, _keyType = keyType}
    return false
  else
    self._saveData = nil
    self._prevData = {_inputType = inputType, _keyType = keyType}
    self._isUpdate = false
  end
  if true == self._isShowDebugMessage then
    _PA_LOG("\236\157\180\235\139\164\237\152\156", "can calling Function")
  end
  return true
end
function minigame:updatePerFrame(deltaTime)
  local isUpdateTime = false
  self._updateTime = self._updateTime + deltaTime
  if self._config._updateTerm < self._updateTime then
    isUpdateTime = true
  end
  if false == self._isUpdate then
    self._deltaTime = self._deltaTime + deltaTime
    if self._deltaTime < self._config._updateTerm then
      return isUpdateTime
    else
      self._deltaTime = 0
      self._isUpdate = true
      if true == self._isShowDebugMessage then
        if 65535 < self._tempFrame then
          self._tempFrame = 0
        end
        self._tempFrame = self._tempFrame + 1
      end
    end
  end
  if self._saveData == nil or self._saveData._inputType == nil or self._saveData._keyType == nil then
    return isUpdateTime
  end
  self:callFunctionByInputType(self._saveData._inputType, self._saveData._keyType)
  return isUpdateTime
end
function minigame:callFunctionByInputType(inputType, keyType)
  if self._config._keyInputType._press == inputType then
    Panel_Minigame_EventKeyPress(keyType)
  elseif self._config._keyInputType._downOnce == inputType then
    EventActionMiniGameKeyDownOnce(keyType)
  elseif self._config._keyInputType._up == inputType then
    EventActionMiniGameKeyUp(keyType)
  end
end
function PaGlobal_MiniGame_SinGaugeKeyPress(keyType)
  if true == _ContentsGroup_NewUI_Fishing_All then
    PaGlobal_SinGauge_All_KeyPress(keyType)
  else
    MiniGame_SinGauge_KeyPress(keyType)
  end
end
function PaGlobal_MiniGame_CommandInput(keyType)
  if true == _ContentsGroup_NewUI_Fishing_All then
    PaGlobal_Command_All_CommandInput(keyType)
  else
    MiniGame_Command_ddukdition(keyType)
  end
end
function PaGlobal_MiniGame_Gradient_KeyPress(keyType)
  FromClient_Minigame_Gradient_All_KeyPress(keyType)
end
function PaGlobal_MiniGame_GradientY_KeyPress(keyType)
  FromClient_Minigame_GradientY_All_KeyPress(keyType)
end
function PaGlobal_MiniGame_BattleGauge_KeyPress(keyType)
  FromClient_Minigame_BattleGauge_All_KeyPress(keyType)
end
function PaGlobal_MiniGame_Timing_KeyPress(keyType)
  FromClient_Minigame_Timing_All_Freeze(keyType)
end
function PaGlobal_MiniGame_HerbMachine_KeyPress(keyType)
  FromClient_Minigame_HerbMachine_All_Freeze(keyType)
end
function PaGlobal_MiniGame_Buoy_KeyPress(keyType)
  FromClient_Minigame_Buoy_All_Freeze(keyType)
end
function PaGlobal_MiniGame_Jaksal_KeyPress(keyType)
  if true == _ContentsGroup_NewUI_Jaksal_All then
    PaGlobal_Jaksal_All_UpdateKeyPressCheck(keyType)
  else
    Panel_MiniGame_Jaksal_KeyPressCheck(keyType)
  end
end
function PaGlobal_MiniGame_Rhythm_KeyPress(keyType)
  FromClient_Minigame_Rhythm_All_KeyPress(keyType)
end
function PaGlobal_MiniGame_Rhythm_Drum_KeyPress(keyType)
  FromClient_Minigame_Rhythm_Drum_All_KeyPress(keyType)
end
function PaGlobal_MiniGame_Sniper_KeyPress(keyType)
  PaGlobal_MiniGame_SniperReload_All_KeyFunc(keyType)
end
function EventActionMiniGameLoadComplete()
  minigame:initialize()
end
function FromClient_CollectMiniGame_Start(collectToolType)
  if collectToolType == __eCollectToolType_ButcheryKnife then
    if PaGlobal_MiniGame_MorningSlaughter_All_Open ~= nil then
      PaGlobal_MiniGame_MorningSlaughter_All_Open()
    end
  elseif collectToolType == __eCollectToolType_Syringe then
    if PaGlobal_MiniGame_MorningSyringe_All_Open ~= nil then
      PaGlobal_MiniGame_MorningSyringe_All_Open()
    end
  elseif collectToolType == __eCollectToolType_SkinKnife then
    if PaGlobal_MiniGame_MorningLeather_All_Open ~= nil then
      PaGlobal_MiniGame_MorningLeather_All_Open()
    end
  elseif collectToolType == __eCollectToolType_Pickax then
    if PaGlobal_MiniGame_MorningMining_All_Open ~= nil then
      PaGlobal_MiniGame_MorningMining_All_Open()
    end
  elseif collectToolType == __eCollectToolType_Axe then
    if PaGlobal_MiniGame_MorningLogging_All_Open ~= nil then
      PaGlobal_MiniGame_MorningLogging_All_Open()
    end
  elseif collectToolType == __eCollectToolType_Hoe then
    if PaGlobal_MiniGame_MorningHomi_All_Open ~= nil then
      PaGlobal_MiniGame_MorningHomi_All_Open()
    end
  else
    ToClient_CollectMiniGameEnd(__eCollectMiniGameState_Cancle)
  end
end
function PaGlobalFunc_CollectMiniGame_Start()
  collectMiniGame._isPlaying = true
  collectMiniGame._isNotInputCheck = false
  if Panel_SkillCommand ~= nil then
    collectMiniGame._skillCommandShow = Panel_SkillCommand:GetShow()
    Panel_SkillCommand:SetShow(false)
  end
end
function PaGlobalFunc_CollectMiniGame_End()
  if Panel_SkillCommand ~= nil then
    Panel_SkillCommand:SetShow(collectMiniGame._skillCommandShow)
  end
  collectMiniGame._isPlaying = false
end
function PaGlobalFunc_CollectMiniGame_IsPlaying()
  return collectMiniGame._isPlaying
end
function PaGlobalFunc_CollectMiniGame_UpdateSkillCommandState(isShow)
  collectMiniGame._skillCommandShow = isShow
end
function PaGlobalFunc_CollectMiniGame_SetNotInputCheck(isNotInputCheck)
  collectMiniGame._isNotInputCheck = isNotInputCheck
end
function PaGlobalFunc_CollectMiniGame_IsNotInputCheck()
  return collectMiniGame._isNotInputCheck
end
function PaGlobalFunc_CollectMiniGame_UpdateResult(result, successControl, failControl, resurtBGControl, purposeControl, isCollectMiniGame)
  if result == __eCollectMiniGameState_Success then
    if successControl ~= nil then
      successControl:AddEffect("FUI_Morning_MiniGame_Success_01A", false, 0, 0)
      successControl:SetShow(true)
      ToClient_uiManagerSetUIConvertableState(CppEnums.UIConvertableType.eUIConvertableType_always, false)
      ToClient_uiManagerSetConvetableInputMode(CppEnums.EProcessorInputMode.eProcessorInputMode_GameMode)
    end
    audioPostEvent_SystemUi(11, 4)
    _AudioPostEvent_SystemUiForXBOX(11, 4)
  else
    if failControl ~= nil then
      failControl:AddEffect("FUI_Morning_MiniGame_Success_02A", false, 0, 0)
      failControl:SetShow(true)
      ToClient_uiManagerSetUIConvertableState(CppEnums.UIConvertableType.eUIConvertableType_always, false)
      ToClient_uiManagerSetConvetableInputMode(CppEnums.EProcessorInputMode.eProcessorInputMode_GameMode)
    end
    audioPostEvent_SystemUi(11, 7)
    _AudioPostEvent_SystemUiForXBOX(11, 7)
  end
  if resurtBGControl ~= nil then
    PaGlobalFunc_CollectMiniGame_ResultMessageAnim(resurtBGControl)
  end
  if purposeControl ~= nil then
    purposeControl:SetShow(false)
  end
  if isCollectMiniGame == nil or isCollectMiniGame == true then
    ToClient_CollectMiniGameEnd(result)
  end
  if collectMiniGame._isNotInputCheck == false then
    ToClient_uiManagerSetUIConvertableState(CppEnums.UIConvertableType.eUIConvertableType_always, false)
    ToClient_uiManagerSetConvetableInputMode(CppEnums.EProcessorInputMode.eProcessorInputMode_GameMode)
  end
end
function PaGlobalFunc_CollectMiniGame_UpdateNotInputCheck(isChangeInputMode)
  if collectMiniGame._isNotInputCheck == false then
    return
  end
  local isKeyUp = _ContentsGroup_UsePadSnapping == true and isPadUp(__eJoyPadInputType_A) == true or isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_SPACE) == true
  if isKeyUp == false then
    return
  end
  collectMiniGame._isNotInputCheck = false
  if isChangeInputMode == true then
    ToClient_uiManagerSetUIConvertableState(CppEnums.UIConvertableType.eUIConvertableType_always, false)
    ToClient_uiManagerSetConvetableInputMode(CppEnums.EProcessorInputMode.eProcessorInputMode_GameMode)
  end
end
function PaGlobalFunc_CollectMiniGame_ResultMessageAnim(control)
  if control == nil then
    return
  end
  control:ResetVertexAni()
  control:SetVertexAniRun("Ani_Scale_New", true)
  control:SetVertexAniRun("Ani_Move_Pos_New", true)
  control:SetShow(true)
end
function PaGlobalFunc_CollectMiniGame_SetHideAnim(collectToolType)
  local panel
  if collectToolType == __eCollectToolType_ButcheryKnife then
    panel = Panel_MiniGame_MorningSlaughter_All
  elseif collectToolType == __eCollectToolType_Syringe then
    panel = Panel_MiniGame_MorningSyringe_All
  elseif collectToolType == __eCollectToolType_SkinKnife then
    panel = Panel_MiniGame_MorningLeather_All
  elseif collectToolType == __eCollectToolType_Pickax then
    panel = Panel_MiniGame_MorningMining_All
  elseif collectToolType == __eCollectToolType_Axe then
    panel = Panel_MiniGame_MorningLogging_All
  elseif collectToolType == __eCollectToolType_Hoe then
    panel = Panel_MiniGame_MorningHomi_All
  end
  if panel == nil then
    return
  end
  panel:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local closeAni = panel:addColorAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  closeAni:SetStartColor(Defines.Color.C_FFFFFFFF)
  closeAni:SetEndColor(Defines.Color.C_00FFFFFF)
  closeAni:SetStartIntensity(3)
  closeAni:SetEndIntensity(1)
  closeAni.IsChangeChild = true
  closeAni:SetHideAtEnd(true)
  closeAni:SetDisableWhileAni(true)
end
function PaGlobalFunc_CollectMiniGame_IsShowCollectMiniGame()
  if PaGlobal_MiniGame_MorningSyringe_All_IsOpen ~= nil and PaGlobal_MiniGame_MorningSyringe_All_IsOpen() == true or PaGlobal_MiniGame_MorningHomi_All_IsOpen ~= nil and PaGlobal_MiniGame_MorningHomi_All_IsOpen() == true or PaGlobal_MiniGame_MorningLeather_All_IsOpen ~= nil and PaGlobal_MiniGame_MorningLeather_All_IsOpen() == true or PaGlobal_MiniGame_MorningLogging_All_IsOpen ~= nil and PaGlobal_MiniGame_MorningLogging_All_IsOpen() == true or PaGlobal_MiniGame_MorningMining_All_IsOpen ~= nil and PaGlobal_MiniGame_MorningMining_All_IsOpen() == true or PaGlobal_MiniGame_MorningSlaughter_All_IsOpen ~= nil and PaGlobal_MiniGame_MorningSlaughter_All_IsOpen() == true then
    return true
  end
  return false
end
registerEvent("EventStartActionMiniGame", "ActionMiniGame_Main")
registerEvent("EventEndActionMiniGame", "ActionMiniGame_Stop")
registerEvent("EventActionMiniGameKeyDownOnce", "Panel_Minigame_EventKeyPress")
registerEvent("EventActionMiniGameKeyUp", "EventActionMiniGameKeyUp")
registerEvent("FromClient_StartCollectMiniGame", "FromClient_CollectMiniGame_Start")
registerEvent("FromClient_luaLoadComplete", "EventActionMiniGameLoadComplete")
