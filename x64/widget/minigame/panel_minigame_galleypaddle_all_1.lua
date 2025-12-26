function PaGlobal_MiniGame_GalleyPaddle_All:initialize()
  if _ContentsGroup_ImprovedGalleyShip == false then
    return
  end
  if PaGlobal_MiniGame_GalleyPaddle_All._initialize == true then
    return
  end
  self._ui._stc_game = UI.getChildControl(Panel_MiniGame_GalleyPaddle_All, "Static_Game")
  self._ui._circularProgress_InputRange = UI.getChildControl(self._ui._stc_game, "CircularProgress_InputRange")
  self._ui._circularProgress_JudgementRange = UI.getChildControl(self._ui._stc_game, "CircularProgress_JudgementRange")
  self._ui._circularProgress_BorderRange = UI.getChildControl(self._ui._stc_game, "CircularProgress_BorderRange")
  self._ui._stc_paddle = UI.getChildControl(self._ui._stc_game, "Static_Paddle")
  self._ui._stc_ship = UI.getChildControl(self._ui._stc_game, "Static_Ship")
  self._ui._stc_noticeBox = UI.getChildControl(self._ui._stc_game, "Static_NoticeBox")
  self._ui._stc_spaceBar = UI.getChildControl(self._ui._stc_noticeBox, "Static_SpaceBar")
  self._ui._txt_noticeBox = UI.getChildControl(self._ui._stc_noticeBox, "MultilineText_1")
  self._ui._stc_result = UI.getChildControl(self._ui._stc_game, "Static_Result")
  self._ui._stc_resultBG = UI.getChildControl(Panel_MiniGame_GalleyPaddle_All, "StaticText_Result_BG")
  self._ui._stc_success = UI.getChildControl(self._ui._stc_resultBG, "Static_Success")
  self._ui._stc_fail = UI.getChildControl(self._ui._stc_resultBG, "Static_Fail")
  self._ui._stc_clear = UI.getChildControl(self._ui._stc_resultBG, "Static_Clear")
  self._ui._stc_purpose = UI.getChildControl(Panel_MiniGame_GalleyPaddle_All, "Static_Purpose")
  self._ui._txt_purpose = UI.getChildControl(self._ui._stc_purpose, "MultilineText_Purpose")
  self._ui._stc_gameResultBoard = UI.getChildControl(Panel_MiniGame_GalleyPaddle_All, "Static_GameResultBoard")
  for i = 1, self._maxRound do
    self._ui._stc_gameResultList[i] = {}
    self._ui._stc_gameResultList[i]._main = UI.getChildControl(self._ui._stc_gameResultBoard, "Static_GameResult_" .. i .. "")
    self._ui._stc_gameResultList[i]._perfect = UI.getChildControl(self._ui._stc_gameResultList[i]._main, "Static_Perfect")
    self._ui._stc_gameResultList[i]._good = UI.getChildControl(self._ui._stc_gameResultList[i]._main, "Static_Good")
    self._ui._stc_gameResultList[i]._bad = UI.getChildControl(self._ui._stc_gameResultList[i]._main, "Static_Bad")
    self._ui._stc_gameResultList[i]._sequence = UI.getChildControl(self._ui._stc_gameResultList[i]._main, "Static_Sequence")
    self._ui._stc_gameResultList[i]._num = UI.getChildControl(self._ui._stc_gameResultList[i]._main, "Static_Num")
    self._ui._stc_gameResultList[i]._perfect:SetShow(false)
    self._ui._stc_gameResultList[i]._good:SetShow(false)
    self._ui._stc_gameResultList[i]._bad:SetShow(false)
  end
  self._ui._stc_gameInfo = UI.getChildControl(self._ui._stc_gameResultBoard, "StaticText_1")
  self._ui._txt_timer = UI.getChildControl(self._ui._stc_game, "StaticText_Timer")
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._startGame = false
  self._startRound = false
  self._endRound = false
  self._currentRound = 0
  self._paddleDown = false
  self._canPushSpace = false
  self._innerTimer = 0
  self._paddleSpeed = 1
  self._judgeStartPaddleRadian = 0
  self._judgeEndPaddleRadian = 0
  self._inputStartPaddleRadian = 0
  self._inputEndPaddleRadian = 0
  self._score = 0
  self._scoreList[1] = ToClient_GetPaddleMiniGameExcellent()
  self._scoreList[2] = ToClient_GetPaddleMiniGameGood()
  self._scoreList[3] = ToClient_GetPaddleMiniGameBad()
  local actionKey_jump = keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_Jump)
  if self._isConsole == true then
    actionKey_jump = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MINIGAME_SPACE")
  end
  self._ui._stc_spaceBar:SetText(string.upper(actionKey_jump))
  self._ui._txt_noticeBox:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GALLYPADDLE_GUIDE", "KEY", actionKey_jump))
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_MiniGame_GalleyPaddle_All:registEventHandler()
  if Panel_MiniGame_GalleyPaddle_All == nil then
    return
  end
end
function PaGlobal_MiniGame_GalleyPaddle_All:clear()
  self._startGame = false
  self._startRound = false
  self._endRound = false
  self._endGame = false
  self._inputEnd = false
  self._isAFK = false
  self._paddleDown = true
  self._paddleStop = false
  self._canPushSpace = false
  self._pushSpace = false
  self._currentRound = 0
  self._innerTimer = 0
  self._inputStartPaddleRadian = 0
  self._inputEndPaddleRadian = 0
  self._score = 0
  for i = 1, self._maxRound do
    self._ui._stc_gameResultList[i]._perfect:SetShow(false)
    self._ui._stc_gameResultList[i]._good:SetShow(false)
    self._ui._stc_gameResultList[i]._bad:SetShow(false)
    self._ui._stc_gameResultList[i]._sequence:SetShow(false)
    self._resultList[i] = self._resultType.None
  end
  self._ui._stc_result:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_MiniGame_16.dds")
  self._ui._stc_result:SetShow(false)
  self:showGameResultBG(false)
  self._ui._stc_purpose:SetShow(true)
end
function PaGlobal_MiniGame_GalleyPaddle_All:prepareOpen()
  if Panel_MiniGame_GalleyPaddle_All == nil then
    return
  end
  if self._startGame == true then
    return
  end
  self:open()
  PaGlobal_MiniGame_GalleyPaddle_All:closeOtherPanel()
  Panel_MiniGame_GalleyPaddle_All:RegisterUpdateFunc("Panel_MiniGame_GalleyPaddle_All_UpdatePerFrame")
  self:startGame()
end
function PaGlobal_MiniGame_GalleyPaddle_All:open()
  if Panel_MiniGame_GalleyPaddle_All == nil then
    return
  end
  audioPostEvent_SystemUi(11, 129)
  _AudioPostEvent_SystemUiForXBOX(11, 129)
  Panel_MiniGame_GalleyPaddle_All:SetShow(true)
end
function PaGlobal_MiniGame_GalleyPaddle_All:prepareClose()
  if Panel_MiniGame_GalleyPaddle_All == nil then
    return
  end
  if Panel_MiniGame_GalleyPaddle_All:GetShow() == false then
    return
  end
  ToClient_uiManagerSetUIConvertableState(CppEnums.UIConvertableType.eUIConvertableType_always, false)
  ToClient_uiManagerSetConvetableInputMode(CppEnums.EProcessorInputMode.eProcessorInputMode_GameMode)
  PaGlobalFunc_CollectMiniGame_End()
  self:clear()
  self:close()
end
function PaGlobal_MiniGame_GalleyPaddle_All:close()
  if Panel_MiniGame_GalleyPaddle_All == nil then
    return
  end
  Panel_MiniGame_GalleyPaddle_All:SetShow(false)
end
function PaGlobal_MiniGame_GalleyPaddle_All:update(deltaTime)
  if self._startGame == true then
    self._innerTimer = self._innerTimer + deltaTime
    if self._isAFK == true then
      self._innerTimer = 0
      self._endRound = true
      self:calculateScore()
      self:endRound()
      return
    end
    if self._startRound == false then
      if self._currentRound ~= 1 or self._innerTimer > self._readyTime then
        self._innerTimer = 0
        self:startRound()
      end
    elseif self._startRound == true and self._endRound == false then
      self._outterTimer = self._outterTimer - deltaTime
      if 0 > self._outterTimer then
        self._outterTimer = 0
      end
      self:updatePaddleRotation(deltaTime)
      self:checkPaddle(deltaTime)
      if self._innerTimer > self._roundTime or self._isAFK == true then
        self._innerTimer = 0
        if self._pushSpace == false then
          self._isAFK = true
        end
        self._endRound = true
        self:calculateScore()
        if self._isAFK == true then
          self:endRound()
        end
      end
    elseif self._endRound == true and self._innerTimer > 2 then
      self._innerTimer = 0
      self:endRound()
    end
  end
  self:updatePurposeTxt()
  self._ui._txt_timer:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MINIGAME_SNIPERRELOAD_REMAINTIME", "Time", Util.Time.timeFormatting(math.ceil(self._outterTimer))))
  if self._endGame == true then
    self._innerTimer = self._innerTimer + deltaTime
    if self._innerTimer > 1 then
      self:endGame()
    end
  end
end
function PaGlobal_MiniGame_GalleyPaddle_All:updatePurposeTxt()
  if self._startGame == false then
    return
  end
  if self._startRound == false then
    self._ui._txt_purpose:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GALLYPADDLE_TIMER", "second", tostring(math.ceil(self._readyTime - self._innerTimer))))
  else
    self._ui._txt_purpose:SetText(PAGetStringParam3(Defines.StringSheet_GAME, "LUA_GALLYPADDLE_COUNT", "max", self._maxRound, "current", self._currentRound, "max2", self._maxRound))
  end
end
function PaGlobal_MiniGame_GalleyPaddle_All:updateKeyBindUI()
  if self._startRound == false then
    return
  end
  local isKeyUp = self._isConsole == true and isPadUp(__eJoyPadInputType_A) == true or keyCustom_IsUp_Action(CppEnums.ActionInputType.ActionInputType_Jump) == true
  local isKeyDown = self._isConsole == true and isPadDown(__eJoyPadInputType_A) == true or keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_Jump) == true
  if isKeyUp == true then
    self._ui._stc_spaceBar:ChangeTextureInfoTextureIDAsync("Combine_Etc_Spacebar_Guide_Normal")
    self._ui._stc_spaceBar:setRenderTexture(self._ui._stc_spaceBar:getBaseTexture())
  end
  if isKeyDown == true then
    self._ui._stc_spaceBar:ChangeTextureInfoTextureIDAsync("Combine_Etc_Spacebar_Guide_Click")
    self._ui._stc_spaceBar:setRenderTexture(self._ui._stc_spaceBar:getBaseTexture())
  end
end
function PaGlobal_MiniGame_GalleyPaddle_All:updatePaddleRotation(deltaTime)
  local paddleRadian = self._ui._stc_paddle:GetRotate()
  if paddleRadian == nil then
    return
  end
  local isKeyUp = self._isConsole == true and isPadUp(__eJoyPadInputType_A) == true or keyCustom_IsUp_Action(CppEnums.ActionInputType.ActionInputType_Jump) == true
  if self._pushSpace == true or isKeyUp == true then
    self._paddleSpeed = self._paddleSpeed + deltaTime * self._paddleAccelateConst
    if self._paddleSpeed >= self._maxPaddleSpeed then
      self._paddleSpeed = self._maxPaddleSpeed
    end
  end
  if self._paddleDown == true then
    local radian = math.pi / 4 * deltaTime * self._paddleSpeed
    paddleRadian = paddleRadian - radian
    if math.abs(self._endPaddleRadian) <= math.abs(paddleRadian) then
      paddleRadian = self._endPaddleRadian
      if self._pushSpace == true then
        self._endRound = true
        self._innerTimer = 0
        self:calculateScore()
      else
        if self._inputEnd == true then
          self._endRound = true
        end
        self._paddleDown = false
        self._canPushSpace = false
      end
    end
    self._ui._stc_paddle:SetRotate(paddleRadian)
  else
    local radian = math.pi / 4 * deltaTime * self._returnPaddleSpeed
    paddleRadian = paddleRadian + radian
    if paddleRadian >= self._startPaddleRadian then
      paddleRadian = self._startPaddleRadian
      self._paddleDown = true
      self._canPushSpace = true
    end
    self._ui._stc_paddle:SetRotate(paddleRadian)
  end
end
function PaGlobal_MiniGame_GalleyPaddle_All:checkPaddle(deltaTime)
  local paddleRadian = self._ui._stc_paddle:GetRotate()
  if paddleRadian == nil then
    return
  end
  local isKeyUp = self._isConsole == true and isPadUp(__eJoyPadInputType_A) == true or keyCustom_IsUp_Action(CppEnums.ActionInputType.ActionInputType_Jump) == true
  if self._canPushSpace == true and self._endRound == false then
    local isKeyDown = self._isConsole == true and isPadDown(__eJoyPadInputType_A) == true or keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_Jump) == true
    if isKeyDown then
      PaGlobalFunc_CollectMiniGame_SetNotInputCheck(false)
      self._paddleSpeed = self._minPaddleSpeed
      self._inputStartPaddleRadian = math.abs(paddleRadian) + self._offsetRadian
      self._pushSpace = true
      if self._inputStartPaddleRadian > math.pi then
        self._inputStartPaddleRadian = self._inputStartPaddleRadian - math.pi * 2
        self._isOverInputPiDegree = true
      end
      self._ui._circularProgress_InputRange:SetShow(true)
      self._ui._circularProgress_InputRange:SetStartRadian(self._inputStartPaddleRadian)
      self._ui._stc_game:AddEffect("FUI_Mini_Game_Galley_Paddle_01A", false, 0, 0)
      self:updateKeyBindUI()
    elseif isKeyUp and self._pushSpace == true then
      PaGlobalFunc_CollectMiniGame_SetNotInputCheck(true)
      self._paddleSpeed = self._startPaddleSpeed
      self._inputEndPaddleRadian = math.abs(paddleRadian) + self._offsetRadian
      if self._isOverInputPiDegree == true then
        self._inputEndPaddleRadian = self._inputEndPaddleRadian - math.pi * 2
      end
      self._pushSpace = false
      self._canPushSpace = false
      self._inputEnd = true
      self._endRound = true
      self._innerTimer = 0
      self:calculateScore()
      self._ui._stc_game:AddEffect("FUI_Mini_Game_Galley_Paddle_01A", false, 0, 0)
      self:updateKeyBindUI()
    end
  end
  if (self._pushSpace == true or isKeyUp == true) and self._inputEnd == false then
    local rate = (math.abs(paddleRadian) + self._offsetRadian - self._inputStartPaddleRadian) * 100 / (math.pi * 2)
    if self._isOverInputPiDegree == true then
      rate = rate - 100
    end
    self._ui._circularProgress_InputRange:SetProgressRate(rate)
  end
end
function PaGlobal_MiniGame_GalleyPaddle_All:calculateScore()
  if self._paddlePlayingAudioID ~= 0 then
    audioPostEvent_StopAudioByPlayingID(self._paddlePlayingAudioID, 0)
    self._paddlePlayingAudioID = 0
  end
  if self._paddlePlayingAudioIDConsole ~= 0 then
    audioPostEvent_StopAudioByPlayingID(self._paddlePlayingAudioIDConsole, 0)
    self._paddlePlayingAudioIDConsole = 0
  end
  self._ui._stc_gameResultList[self._currentRound]._sequence:SetShow(false)
  if self._inputStartPaddleRadian == 0 or self._inputEndPaddleRadian == 0 then
    self._resultList[self._currentRound] = self._resultType.Bad
    self._ui._stc_gameResultList[self._currentRound]._bad:SetShow(true)
    self._ui._stc_gameResultList[self._currentRound]._bad:AddEffect("FUI_Morning_MiniGame_Failed_01A", false, 0, 0)
    self._score = self._score + self._scoreList[3]
    if self._isAFK == false or self._currentRound == 5 then
      audioPostEvent_SystemUi(11, 136)
      _AudioPostEvent_SystemUiForXBOX(11, 136)
    end
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_result, 863, 714, 1228, 854)
    self._ui._stc_result:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui._stc_result:setRenderTexture(self._ui._stc_result:getBaseTexture())
    self._ui._stc_result:SetShow(true)
    self._ui._stc_result:AddEffect("FUI_Morning_MiniGame_Failed_01A", false, 0, 0)
    ToClient_RequestGuildShipPaddleMiniGameRoundResult(__eMiniGameResultType_Bad, self._currentRound)
    return
  end
  local targetStartRadian = self._judgeStartPaddleRadian
  local targetEndRadian = self._judgeEndPaddleRadian
  local inputStartRadian = self._inputStartPaddleRadian
  local inputEndRadian = self._inputEndPaddleRadian
  if self._isOverJudgePiDegree == false and self._isOverInputPiDegree == true then
    targetStartRadian = self._judgeStartPaddleRadian - math.pi * 2
    targetEndRadian = self._judgeEndPaddleRadian - math.pi * 2
  elseif self._isOverJudgePiDegree == true and self._isOverInputPiDegree == false then
    inputStartRadian = self._inputStartPaddleRadian - math.pi * 2
    inputEndRadian = self._inputEndPaddleRadian - math.pi * 2
  end
  local startCorrectionValue = self._judgeCorrctionValue
  if inputStartRadian < targetStartRadian - startCorrectionValue or inputEndRadian > targetEndRadian + self._judgeCorrctionValue then
    self._resultList[self._currentRound] = self._resultType.Bad
    self._ui._stc_gameResultList[self._currentRound]._bad:SetShow(true)
    self._ui._stc_gameResultList[self._currentRound]._bad:AddEffect("FUI_Morning_MiniGame_Failed_01A", false, 0, 0)
    self._score = self._score + self._scoreList[3]
    audioPostEvent_SystemUi(11, 136)
    _AudioPostEvent_SystemUiForXBOX(11, 136)
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_result, 863, 714, 1228, 854)
    self._ui._stc_result:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui._stc_result:setRenderTexture(self._ui._stc_result:getBaseTexture())
    self._ui._stc_result:SetShow(true)
    self._ui._stc_result:AddEffect("FUI_Morning_MiniGame_Failed_01A", false, 0, 0)
    self._ui._circularProgress_InputRange:ChangeTextureInfoTextureIDAsync("Combine_Etc_MiniGame_16_BG_Red")
    self._ui._circularProgress_InputRange:setRenderTexture(self._ui._circularProgress_InputRange:getBaseTexture())
    ToClient_RequestGuildShipPaddleMiniGameRoundResult(__eMiniGameResultType_Bad, self._currentRound)
    return
  end
  local targetAngle = targetEndRadian - targetStartRadian
  local paddleAngle = inputEndRadian - inputStartRadian + self._judgeCorrctionValue
  local percent = paddleAngle / targetAngle * 100
  if percent > self._resultRateList[1] then
    self._resultList[self._currentRound] = self._resultType.Perfect
    self._ui._stc_gameResultList[self._currentRound]._perfect:SetShow(true)
    self._ui._stc_gameResultList[self._currentRound]._perfect:AddEffect("FUI_Morning_MiniGame_Perfect_01A", false, 0, 0)
    self._score = self._score + self._scoreList[1]
    audioPostEvent_SystemUi(11, 138)
    _AudioPostEvent_SystemUiForXBOX(11, 138)
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_result, 863, 432, 1228, 572)
    self._ui._stc_result:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui._stc_result:setRenderTexture(self._ui._stc_result:getBaseTexture())
    self._ui._stc_result:SetShow(true)
    self._ui._stc_result:AddEffect("FUI_Morning_MiniGame_Perfect_01A", false, 0, 0)
    ToClient_RequestGuildShipPaddleMiniGameRoundResult(__eMiniGameResultType_Excellent, self._currentRound)
  elseif percent > self._resultRateList[2] then
    self._resultList[self._currentRound] = self._resultType.Good
    self._ui._stc_gameResultList[self._currentRound]._good:SetShow(true)
    self._ui._stc_gameResultList[self._currentRound]._good:AddEffect("FUI_Morning_MiniGame_Good_01A", false, 0, 0)
    self._score = self._score + self._scoreList[2]
    audioPostEvent_SystemUi(11, 137)
    _AudioPostEvent_SystemUiForXBOX(11, 137)
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_result, 863, 573, 1228, 713)
    self._ui._stc_result:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui._stc_result:setRenderTexture(self._ui._stc_result:getBaseTexture())
    self._ui._stc_result:SetShow(true)
    self._ui._stc_result:AddEffect("FUI_Morning_MiniGame_Good_01A", false, 0, 0)
    ToClient_RequestGuildShipPaddleMiniGameRoundResult(__eMiniGameResultType_Good, self._currentRound)
  else
    self._resultList[self._currentRound] = self._resultType.Bad
    self._ui._stc_gameResultList[self._currentRound]._bad:SetShow(true)
    self._ui._stc_gameResultList[self._currentRound]._bad:AddEffect("FUI_Morning_MiniGame_Failed_01A", false, 0, 0)
    self._score = self._score + self._scoreList[3]
    audioPostEvent_SystemUi(11, 136)
    _AudioPostEvent_SystemUiForXBOX(11, 136)
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_result, 863, 714, 1228, 854)
    self._ui._stc_result:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui._stc_result:setRenderTexture(self._ui._stc_result:getBaseTexture())
    self._ui._stc_result:SetShow(true)
    self._ui._stc_result:AddEffect("FUI_Morning_MiniGame_Failed_01A", false, 0, 0)
    ToClient_RequestGuildShipPaddleMiniGameRoundResult(__eMiniGameResultType_Bad, self._currentRound)
  end
end
function PaGlobal_MiniGame_GalleyPaddle_All:showGameResultBG(isShow)
  self._ui._stc_resultBG:SetShow(isShow)
  if isShow == true then
    self._ui._stc_success:SetShow(false)
    self._ui._stc_fail:SetShow(false)
    local lowScoreCount = 0
    for i = 1, self._maxRound do
      if self._resultList[i] == self._resultType.Bad or self._resultList[i] == self._resultType.None then
        lowScoreCount = lowScoreCount + 1
      end
    end
    local result
    if lowScoreCount > self._maxRound / 2 then
      result = __eCollectMiniGameState_Success
    else
      result = __eCollectMiniGameState_Success
    end
    PaGlobalFunc_CollectMiniGame_UpdateResult(result, self._ui._stc_clear, self._ui._stc_fail, self._ui._stc_resultBG, self._ui._stc_purpose, false)
  end
end
function PaGlobal_MiniGame_GalleyPaddle_All:closeOtherPanel()
  if InGameShop_CloseActual ~= nil then
    InGameShop_CloseActual()
  end
  if IngameCustomize_Hide ~= nil then
    IngameCustomize_Hide()
  end
  if PaGlobal_Dye_All_CloseFunction ~= nil then
    PaGlobal_Dye_All_CloseFunction()
  end
  if Panel_SkillTooltip_Hide ~= nil then
    Panel_SkillTooltip_Hide()
  end
  if FGlobal_PopCloseWorldMap ~= nil then
    FGlobal_PopCloseWorldMap()
  end
  if PaGlobalFunc_WorldMap_PopClose ~= nil then
    PaGlobalFunc_WorldMap_PopClose()
  end
  if PaGlobalFunc_Window_Knowledge_Exit ~= nil then
    PaGlobalFunc_Window_Knowledge_Exit()
  end
  if PaGlobalFunc_MentalGame_All_Close ~= nil then
    PaGlobalFunc_MentalGame_All_Close()
  end
  if _ContentsGroup_ShowOtherClassSkill == true then
    PaGlobalFunc_SkillGroup_All_Close()
  elseif PaGlobalFunc_SkillGroup_Close ~= nil then
    PaGlobalFunc_SkillGroup_Close()
  end
  if PaGlobalFunc_SkillGroup_CloseRenderMode ~= nil then
    PaGlobalFunc_SkillGroup_CloseRenderMode()
  end
  if Panel_Knowledge_Hide ~= nil then
    Panel_Knowledge_Hide()
  end
  if ToClient_PopBlackSpiritFlush ~= nil then
    ToClient_PopBlackSpiritFlush()
  end
  if PaGlobalFunc_RoseWarMenu_Close ~= nil then
    PaGlobalFunc_RoseWarMenu_Close()
    PaGlobal_RoseWarMenu:prepareClose()
  end
  if check_ShowWindow() == true then
    close_WindowPanelList()
    close_force_WindowPanelList()
  end
end
function PaGlobal_MiniGame_GalleyPaddle_All:startGame()
  self:clear()
  self._startGame = true
  PaGlobalFunc_CollectMiniGame_Start()
  ToClient_uiManagerSetUIConvertableState(CppEnums.UIConvertableType.eUIConvertableType_always, true)
  ToClient_uiManagerSetConvetableInputMode(CppEnums.EProcessorInputMode.eProcessorInputMode_UiModeNotInput)
  self:prepareRound()
end
function PaGlobal_MiniGame_GalleyPaddle_All:prepareRound()
  self._paddleDown = false
  self._paddleStop = false
  self._canPushSpace = false
  self._pushSpace = false
  self._isOverInputPiDegree = false
  self._isOverJudgePiDegree = false
  self._inputStartPaddleRadian = 0
  self._inputEndPaddleRadian = 0
  self._paddleSpeed = self._startPaddleSpeed
  self._innerTimer = 0
  self._outterTimer = self._roundTime
  self._currentRound = self._currentRound + 1
  for i = 1, self._maxRound do
    if i == self._currentRound then
      self._ui._stc_gameResultList[i]._num:ChangeTextureInfoTextureIDAsync("Combine_Etc_Gauge_Icon_On_0" .. i)
      self._ui._stc_gameResultList[i]._num:setRenderTexture(self._ui._stc_gameResultList[i]._num:getBaseTexture())
      self._ui._stc_gameResultList[i]._sequence:SetShow(true)
    else
      self._ui._stc_gameResultList[i]._num:ChangeTextureInfoTextureIDAsync("Combine_Etc_Gauge_Icon_Off_0" .. i)
      self._ui._stc_gameResultList[i]._num:setRenderTexture(self._ui._stc_gameResultList[i]._num:getBaseTexture())
      self._ui._stc_gameResultList[i]._sequence:SetShow(false)
    end
  end
  if self._isAFK == true then
    return
  end
  self._ui._stc_paddle:SetRotate(self._startPaddleRadian)
  if self._isDebugModeOn == true then
    if self._debugModeType == 0 then
      self._judgeStartPaddleRadian = self._minStartJudgeRangeRadian
      self._judgeEndPaddleRadian = self._maxEndJudgeRangeRadian
    elseif self._debugModeType == 1 then
      self._judgeStartPaddleRadian = self._minStartJudgeRangeRadian
      self._judgeEndPaddleRadian = self._minStartJudgeRangeRadian + self._minimumJudgeRangeRadian
    end
  else
    local startMin = self._minStartJudgeRangeRadian * 100000
    local startMax = (self._maxEndJudgeRangeRadian - self._minimumJudgeRangeRadian) * 100000
    local tempJudgeStartRadian = getRandomValue(startMin, startMax)
    local endMin = tempJudgeStartRadian + self._minimumJudgeRangeRadian * 100000
    local endMax = self._maxEndJudgeRangeRadian * 100000
    local tempJudgeEndRadian = getRandomValue(endMin, endMax)
    tempJudgeStartRadian = tempJudgeStartRadian / 100000
    tempJudgeEndRadian = tempJudgeEndRadian / 100000
    self._judgeStartPaddleRadian = tempJudgeStartRadian
    self._judgeEndPaddleRadian = tempJudgeEndRadian
  end
  if self._judgeStartPaddleRadian > math.pi then
    self._isOverJudgePiDegree = true
    self._judgeStartPaddleRadian = self._judgeStartPaddleRadian - math.pi * 2
    self._judgeEndPaddleRadian = self._judgeEndPaddleRadian - math.pi * 2
  end
  local judgementRangeRate = (self._judgeEndPaddleRadian - self._judgeStartPaddleRadian) * 100 / (math.pi * 2)
  self._ui._circularProgress_JudgementRange:SetStartRadian(self._judgeStartPaddleRadian)
  self._ui._circularProgress_JudgementRange:SetProgressRate(judgementRangeRate)
  self._ui._circularProgress_JudgementRange:SetShow(true)
  local borderRate = judgementRangeRate + self._borderLineDepth * 100 / math.pi
  self._ui._circularProgress_BorderRange:SetStartRadian(self._judgeStartPaddleRadian - self._borderLineDepth)
  self._ui._circularProgress_BorderRange:SetProgressRate(borderRate)
  self._ui._circularProgress_BorderRange:SetShow(true)
  self._ui._circularProgress_InputRange:SetStartRadian(0)
  self._ui._circularProgress_InputRange:SetProgressRate(0)
  self._ui._circularProgress_InputRange:SetShow(false)
  self._ui._stc_result:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_MiniGame_16.dds")
  self._ui._stc_result:SetShow(false)
  self._ui._circularProgress_InputRange:ChangeTextureInfoTextureIDAsync("Combine_Etc_MiniGame_16_BG_Yellow")
  self._ui._circularProgress_InputRange:setRenderTexture(self._ui._circularProgress_InputRange:getBaseTexture())
  self._ui._stc_spaceBar:ChangeTextureInfoTextureIDAsync("Combine_Etc_Spacebar_Guide_Normal")
  self._ui._stc_spaceBar:setRenderTexture(self._ui._stc_spaceBar:getBaseTexture())
end
function PaGlobal_MiniGame_GalleyPaddle_All:startRound()
  self._startGame = true
  self._startRound = true
  self._canPushSpace = false
  self._inputEnd = false
  self._paddlePlayingAudioID = audioPostEvent_SystemUi(11, 126)
  self._paddlePlayingAudioIDConsole = _AudioPostEvent_SystemUiForXBOX(11, 126)
end
function PaGlobal_MiniGame_GalleyPaddle_All:endRound()
  self._startRound = false
  self._endRound = false
  self._canPushSpace = false
  if self._currentRound == self._maxRound then
    self._startGame = false
    self._endGame = true
    return
  end
  self:prepareRound()
end
function PaGlobal_MiniGame_GalleyPaddle_All:endGame()
  Panel_MiniGame_GalleyPaddle_All:ClearUpdateLuaFunc()
  luaTimer_AddEvent(PaGloabl_MiniGame_GalleyPaddle_All_Close, 3000, false, 0)
  self:showGameResultBG(true)
  ToClient_RequestGuildShipPaddleMiniGameScore(self._score)
end
function PaGlobal_MiniGame_GalleyPaddle_All:validate()
  if Panel_MiniGame_GalleyPaddle_All == nil then
    return
  end
  self._ui._stc_game:isValidate()
  self._ui._circularProgress_InputRange:isValidate()
  self._ui._circularProgress_JudgementRange:isValidate()
  self._ui._stc_paddle:isValidate()
  self._ui._stc_ship:isValidate()
  self._ui._stc_noticeBox:isValidate()
  self._ui._stc_spaceBar:isValidate()
  self._ui._stc_result:isValidate()
  self._ui._stc_purpose:isValidate()
  self._ui._stc_resultBG:isValidate()
  self._ui._stc_gameResultBoard:isValidate()
  for i = 1, self._maxRound do
    self._ui._stc_gameResultList[i]._main:isValidate()
  end
  self._ui._stc_gameInfo:isValidate()
end
