PaGlobal_MiniGame_MorningMining_All = {
  _ui = {
    _txt_resurtBG = nil,
    _stc_success = nil,
    _stc_fail = nil,
    _stc_rockBG = nil,
    _stc_pointArea1 = nil,
    _stc_pointArea2 = nil,
    _stc_curWeakPoint = nil,
    _stc_clickEffect = nil,
    _stc_pickaxBG = nil,
    _stc_pickax = nil,
    _stc_successArea = nil,
    _stc_progressBG = nil,
    _stc_leftTimeBar = nil,
    _txt_leftTime = nil,
    _txt_desc = nil,
    _stc_keyGuide_PC = nil,
    _txt_key_Up = nil,
    _txt_key_Left = nil,
    _txt_key_Down = nil,
    _txt_key_Rgiht = nil,
    _txt_key_Jump = nil,
    _stc_purpose = nil,
    _txt_purpose = nil
  },
  _curGameTime = 0,
  _maxGameTime = 20,
  _curResultTime = 0,
  _maxResultTime = 0.6,
  _clickEffectTime = 0,
  _clickEffectMaxTime = 0.5,
  _breakPointIndex = 0,
  _breakPointMax = 7,
  _breakPoint = {},
  _weekPointCount = 0,
  _weekPointIndex = 0,
  _weekPointMax = 5,
  _weekPoint = {},
  _eGameState = {
    GAME = 0,
    RESULT = 1,
    END = 2
  },
  _state = 0,
  _result = 0,
  _moveState = {x = 0, y = 0},
  _moveSpeed = 500,
  _isBreakWeekPoint = false,
  _basePickAxPosition = {x = 0, y = 0},
  _isConsole = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_MiniGame_MorningMining_All_Init")
function FromClient_MiniGame_MorningMining_All_Init()
  PaGlobal_MiniGame_MorningMining_All:initialize()
end
function PaGlobal_MiniGame_MorningMining_All:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._txt_resurtBG = UI.getChildControl(Panel_MiniGame_MorningMining_All, "StaticText_Resurt_BG")
  self._ui._stc_success = UI.getChildControl(self._ui._txt_resurtBG, "Static_Success")
  self._ui._stc_fail = UI.getChildControl(self._ui._txt_resurtBG, "Static_Fail")
  self._ui._stc_rockBG = UI.getChildControl(Panel_MiniGame_MorningMining_All, "Static_RockBg")
  self._ui._stc_pointArea1 = UI.getChildControl(self._ui._stc_rockBG, "Static_PointArea1")
  self._ui._stc_pointArea2 = UI.getChildControl(self._ui._stc_rockBG, "Static_PointArea2")
  self._ui._stc_curWeakPoint = UI.getChildControl(self._ui._stc_rockBG, "Static_CurrentWeakPoint")
  self._ui._stc_clickEffect = UI.getChildControl(self._ui._stc_rockBG, "Static_ClickEffect")
  self._ui._stc_pickaxBG = UI.getChildControl(self._ui._stc_rockBG, "Static_PickaxBG")
  self._ui._stc_pickax = UI.getChildControl(self._ui._stc_pickaxBG, "Static_Pickax")
  self._ui._stc_successArea = UI.getChildControl(self._ui._stc_pickaxBG, "Static_SuccessArea")
  self._ui._stc_progressBG = UI.getChildControl(self._ui._stc_rockBG, "Static_ProgressBg")
  self._ui._stc_leftTimeBar = UI.getChildControl(self._ui._stc_progressBG, "Progress2_LeftTime")
  self._ui._txt_leftTime = UI.getChildControl(self._ui._stc_rockBG, "StaticText_LeftTime")
  self._ui._txt_desc = UI.getChildControl(self._ui._stc_rockBG, "StaticText_Desc")
  self._ui._stc_keyGuide_PC = UI.getChildControl(self._ui._stc_rockBG, "Static_KeyGuideBG_PC")
  self._ui._txt_key_Up = UI.getChildControl(self._ui._stc_keyGuide_PC, "StaticText_W")
  self._ui._txt_key_Left = UI.getChildControl(self._ui._stc_keyGuide_PC, "StaticText_A")
  self._ui._txt_key_Down = UI.getChildControl(self._ui._stc_keyGuide_PC, "StaticText_S")
  self._ui._txt_key_Right = UI.getChildControl(self._ui._stc_keyGuide_PC, "StaticText_D")
  self._ui._txt_key_Jump = UI.getChildControl(self._ui._stc_keyGuide_PC, "StaticText_Space")
  self._ui._stc_purpose = UI.getChildControl(Panel_MiniGame_MorningMining_All, "Static_Purpose")
  self._ui._txt_purpose = UI.getChildControl(self._ui._stc_purpose, "StaticText_Purpose")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_MiniGame_MorningMining_All:validate()
  if Panel_MiniGame_MorningMining_All == nil then
    return
  end
  self._ui._txt_resurtBG:isValidate()
  self._ui._stc_success:isValidate()
  self._ui._stc_fail:isValidate()
  self._ui._stc_rockBG:isValidate()
  self._ui._stc_pointArea1:isValidate()
  self._ui._stc_pointArea2:isValidate()
  self._ui._stc_curWeakPoint:isValidate()
  self._ui._stc_clickEffect:isValidate()
  self._ui._stc_pickaxBG:isValidate()
  self._ui._stc_pickax:isValidate()
  self._ui._stc_successArea:isValidate()
  self._ui._stc_progressBG:isValidate()
  self._ui._stc_leftTimeBar:isValidate()
  self._ui._txt_leftTime:isValidate()
  self._ui._txt_key_Up:isValidate()
  self._ui._txt_key_Left:isValidate()
  self._ui._txt_key_Down:isValidate()
  self._ui._txt_key_Right:isValidate()
  self._ui._txt_key_Jump:isValidate()
  self._ui._stc_purpose:isValidate()
  self._ui._txt_purpose:isValidate()
  for ii = 1, self._weekPointMax do
    self._weekPoint[ii]:isValidate()
  end
  for ii = 1, self._breakPointMax do
    self._breakPoint[ii]:isValidate()
  end
end
function PaGlobal_MiniGame_MorningMining_All:registEventHandler()
  if Panel_MiniGame_MorningMining_All == nil then
    return
  end
  registerEvent("onScreenResize", "FromClient_MiniGame_MorningMining_All_ResizePanel")
  Panel_MiniGame_MorningMining_All:RegisterShowEventFunc(false, "PaGlobalFunc_CollectMiniGame_SetHideAnim(" .. __eCollectToolType_Pickax .. ")")
  local weakPointBG = UI.getChildControl(self._ui._stc_rockBG, "Static_WeakPointBG")
  local weakPointTmp = UI.getChildControl(weakPointBG, "Static_WeakPoint_Template")
  local brokenPointTmp = UI.getChildControl(weakPointBG, "Static_BrokenPoint_Template")
  self._weekPoint = {}
  for ii = 1, self._weekPointMax do
    local weekPoint = UI.cloneControl(weakPointTmp, weakPointBG, "Static_WeakPoint_" .. tostring(ii))
    weekPoint:SetDepth(9999)
    self._weekPoint[ii] = weekPoint
  end
  self._breakPoint = {}
  for ii = 1, self._breakPointMax do
    local brokenPoint = UI.cloneControl(brokenPointTmp, weakPointBG, "Static_BrokenPoint_" .. tostring(ii))
    brokenPoint:SetDepth(9999)
    self._breakPoint[ii] = brokenPoint
  end
  self._basePickAxPosition.x = self._ui._stc_pickaxBG:GetPosX()
  self._basePickAxPosition.y = self._ui._stc_pickaxBG:GetPosY()
  self._ui._txt_desc:SetTextMode(__eTextMode_AutoWrap)
  if self._isConsole == true then
    self._ui._txt_desc:SetText(self._ui._txt_desc:GetText())
  end
  self._ui._txt_purpose:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAME_MINNIG_PURPOSE"))
end
function PaGlobal_MiniGame_MorningMining_All:prepareOpen()
  if Panel_MiniGame_MorningMining_All == nil then
    return
  end
  PaGlobalFunc_CollectMiniGame_Start()
  self:clear()
  self:resetWeekPoint()
  self:findNextWeekPoint()
  if self._isConsole == false then
    self:setActionKeyText()
  end
  Panel_MiniGame_MorningMining_All:RegisterUpdateFunc("PaGlobal_MiniGame_MorningMining_All_Update")
  self:open()
end
function PaGlobal_MiniGame_MorningMining_All:open()
  if Panel_MiniGame_MorningMining_All == nil then
    return
  end
  Panel_MiniGame_MorningMining_All:SetShow(true)
end
function PaGlobal_MiniGame_MorningMining_All:prepareClose()
  if Panel_MiniGame_MorningMining_All == nil then
    return
  end
  PaGlobalFunc_CollectMiniGame_End()
  self._state = self._eGameState.GAME
  Panel_MiniGame_MorningMining_All:EraseAllEffect()
  Panel_MiniGame_MorningMining_All:ClearUpdateLuaFunc()
  self:close()
end
function PaGlobal_MiniGame_MorningMining_All:close()
  if Panel_MiniGame_MorningMining_All == nil then
    return
  end
  Panel_MiniGame_MorningMining_All:SetShow(false, true)
end
function PaGlobal_MiniGame_MorningMining_All:clear()
  if Panel_MiniGame_MorningMining_All == nil then
    return
  end
  Panel_MiniGame_MorningMining_All:EraseAllEffect()
  Panel_MiniGame_MorningMining_All:ClearUpdateLuaFunc()
  self._state = self._eGameState.GAME
  self._curGameTime = self._maxGameTime
  self._curResultTime = 0
  self._result = __eCollectMiniGameState_Cancle
  self._weekPointCount = 0
  self._weekPointIndex = 0
  self._breakPointIndex = 0
  self._clickEffectTime = 0
  self._isBreakWeekPoint = false
  self._ui._stc_leftTimeBar:SetSmoothMode(false)
  self._ui._stc_leftTimeBar:SetProgressRate(1)
  self._ui._stc_leftTimeBar:SetSmoothMode(true)
  self._ui._txt_resurtBG:SetShow(false)
  self._ui._stc_success:SetShow(false)
  self._ui._stc_fail:SetShow(false)
  self._ui._stc_success:EraseAllEffect()
  self._ui._stc_fail:EraseAllEffect()
  self._ui._stc_clickEffect:SetShow(false)
  for ii = 1, self._weekPointMax do
    self._weekPoint[ii]:SetShow(false)
  end
  for ii = 1, self._breakPointMax do
    self._breakPoint[ii]:SetShow(false)
  end
  self._ui._stc_curWeakPoint:SetShow(false)
  self._ui._stc_pickaxBG:SetPosX(self._basePickAxPosition.x)
  self._ui._stc_pickaxBG:SetPosY(self._basePickAxPosition.y)
  self:resetKeyGuideTexture()
  self._ui._stc_purpose:SetShow(true)
end
function PaGlobal_MiniGame_MorningMining_All:setActionKeyText()
  local actionKey_moveFront = keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_MoveFront)
  local actionKey_moveLeft = keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_MoveLeft)
  local actionKey_moveBack = keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_MoveBack)
  local actionKey_moveRight = keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_MoveRight)
  local actionKey_jump = keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_Jump)
  self._ui._txt_key_Up:SetText(string.upper(actionKey_moveFront))
  self._ui._txt_key_Left:SetText(string.upper(actionKey_moveLeft))
  self._ui._txt_key_Down:SetText(string.upper(actionKey_moveBack))
  self._ui._txt_key_Right:SetText(string.upper(actionKey_moveRight))
  self._ui._txt_key_Jump:SetText(string.upper(actionKey_jump))
  local descText = PAGetStringParam5(Defines.StringSheet_RESOURCE, "PANEL_MINIGAME_MINING_DESC_PC", "W", actionKey_moveFront, "A", actionKey_moveLeft, "S", actionKey_moveBack, "D", actionKey_moveRight, "Space", actionKey_jump)
  self._ui._txt_desc:SetText(descText)
end
function PaGlobal_MiniGame_MorningMining_All:update(deltaTime)
  if Panel_MiniGame_MorningMining_All == nil then
    return
  end
  if self._state == self._eGameState.GAME then
    if self._clickEffectTime > 0 then
      self._clickEffectTime = self._clickEffectTime - deltaTime
      if self._clickEffectTime <= 0 then
        self._clickEffectTime = 0
        self._ui._stc_clickEffect:SetShow(false)
        self._ui._stc_pickax:ResetVertexAni()
        if self._state == self._eGameState.GAME and self._isBreakWeekPoint == true then
          self._isBreakWeekPoint = false
          if self._breakPointIndex >= self._breakPointMax then
            self._result = __eCollectMiniGameState_Success
            self._state = self._eGameState.RESULT
          end
        end
      else
        PaGlobalFunc_CollectMiniGame_UpdateNotInputCheck(false)
      end
    else
      if isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_ESCAPE) == true then
        ToClient_CollectMiniGameEnd(__eCollectMiniGameState_Cancle)
        self:prepareClose()
        return
      end
      self._curGameTime = self._curGameTime - deltaTime
      if 0 >= self._curGameTime then
        self._curGameTime = 0
        self._result = __eCollectMiniGameState_Fail
        self._state = self._eGameState.RESULT
      elseif self._clickEffectTime <= 0 then
        if self._isConsole == false then
          local texture_A = self._ui._txt_key_Left:getBaseTexture()
          local texture_D = self._ui._txt_key_Right:getBaseTexture()
          local texture_W = self._ui._txt_key_Up:getBaseTexture()
          local texture_S = self._ui._txt_key_Down:getBaseTexture()
          local texture_Space = self._ui._txt_key_Jump:getBaseTexture()
          if keyCustom_IsPressed_Action(CppEnums.ActionInputType.ActionInputType_MoveLeft) == true then
            self._moveState.x = -1
            texture_A = self._ui._txt_key_Left:getOnTexture()
          elseif keyCustom_IsPressed_Action(CppEnums.ActionInputType.ActionInputType_MoveRight) == true then
            self._moveState.x = 1
            texture_D = self._ui._txt_key_Right:getOnTexture()
          else
            self._moveState.x = 0
          end
          if keyCustom_IsPressed_Action(CppEnums.ActionInputType.ActionInputType_MoveFront) == true then
            self._moveState.y = -1
            texture_W = self._ui._txt_key_Up:getOnTexture()
          elseif keyCustom_IsPressed_Action(CppEnums.ActionInputType.ActionInputType_MoveBack) == true then
            self._moveState.y = 1
            texture_S = self._ui._txt_key_Down:getOnTexture()
          else
            self._moveState.y = 0
          end
          if keyCustom_IsPressed_Action(CppEnums.ActionInputType.ActionInputType_Jump) == true then
            texture_Space = self._ui._txt_key_Jump:getOnTexture()
          end
          self._ui._txt_key_Left:setRenderTexture(texture_A)
          self._ui._txt_key_Right:setRenderTexture(texture_D)
          self._ui._txt_key_Up:setRenderTexture(texture_W)
          self._ui._txt_key_Down:setRenderTexture(texture_S)
          self._ui._txt_key_Jump:setRenderTexture(texture_Space)
        else
          if isPadPressed(__eJoyPadInputType_LeftStick_Left) then
            self._moveState.x = -1
          elseif isPadPressed(__eJoyPadInputType_LeftStick_Right) then
            self._moveState.x = 1
          else
            self._moveState.x = 0
          end
          if isPadPressed(__eJoyPadInputType_LeftStick_Up) then
            self._moveState.y = -1
          elseif isPadPressed(__eJoyPadInputType_LeftStick_Down) then
            self._moveState.y = 1
          else
            self._moveState.y = 0
          end
        end
        self._ui._stc_pickaxBG:SetPosX(self._ui._stc_pickaxBG:GetPosX() + self._moveState.x * self._moveSpeed * deltaTime)
        self._ui._stc_pickaxBG:SetPosY(self._ui._stc_pickaxBG:GetPosY() + self._moveState.y * self._moveSpeed * deltaTime)
        local isKeyDown = false
        if self._isConsole == true then
          isKeyDown = isPadDown(__eJoyPadInputType_A)
        else
          isKeyDown = keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_Jump)
        end
        if isKeyDown == true then
          self._ui._stc_pickax:ResetVertexAni()
          self._ui._stc_pickax:SetVertexAniRun("Ani_Move_Pos_New", true)
          local findTarget = false
          for ii = 1, self._weekPointMax do
            local targetWeekPoint = self._weekPoint[ii]
            if targetWeekPoint ~= nil and targetWeekPoint:GetShow() == true then
              local targetInfo = {
                minX = targetWeekPoint:GetPosX(),
                minY = targetWeekPoint:GetPosY(),
                maxX = targetWeekPoint:GetPosX() + targetWeekPoint:GetSizeX(),
                maxY = targetWeekPoint:GetPosY() + targetWeekPoint:GetSizeY()
              }
              local currentInfo = {
                minX = self._ui._stc_pickaxBG:GetPosX() + self._ui._stc_successArea:GetPosX(),
                minY = self._ui._stc_pickaxBG:GetPosY() + self._ui._stc_successArea:GetPosY(),
                maxX = self._ui._stc_pickaxBG:GetPosX() + self._ui._stc_successArea:GetPosX() + self._ui._stc_successArea:GetSizeX(),
                maxY = self._ui._stc_pickaxBG:GetPosY() + self._ui._stc_successArea:GetPosY() + self._ui._stc_successArea:GetSizeY()
              }
              if targetInfo.minX >= currentInfo.minX and targetInfo.maxX <= currentInfo.maxX and targetInfo.minY >= currentInfo.minY and targetInfo.maxY <= currentInfo.maxY then
                audioPostEvent_SystemUi(11, 41)
                _AudioPostEvent_SystemUiForXBOX(11, 41)
                if ii == self._weekPointIndex then
                  self._isBreakWeekPoint = true
                  self._breakPointIndex = self._breakPointIndex + 1
                  do
                    local curWeekPoint = self._weekPoint[self._weekPointIndex]
                    local breakPoint = self._breakPoint[self._breakPointIndex]
                    if breakPoint ~= nil and curWeekPoint ~= nil then
                      local gapX = breakPoint:GetSizeX() - curWeekPoint:GetSizeX()
                      local gapY = breakPoint:GetSizeY() - curWeekPoint:GetSizeY()
                      breakPoint:SetPosX(curWeekPoint:GetPosX() - gapX / 2 + math.random(-30, 30))
                      breakPoint:SetPosY(curWeekPoint:GetPosY() - gapY / 2 + math.random(-30, 30))
                      breakPoint:SetShow(true)
                    end
                    local gapX = self._ui._stc_clickEffect:GetSizeX() - targetWeekPoint:GetSizeX()
                    local gapY = self._ui._stc_clickEffect:GetSizeY() - targetWeekPoint:GetSizeY()
                    self._ui._stc_clickEffect:SetPosX(targetWeekPoint:GetPosX() - gapX / 2)
                    self._ui._stc_clickEffect:SetPosY(targetWeekPoint:GetPosY() - gapY / 2)
                    self._ui._stc_clickEffect:SetShow(true)
                  end
                  break
                end
                targetWeekPoint:SetShow(false)
                break
              end
            end
          end
          self:resetKeyGuideTexture()
          self._clickEffectTime = self._clickEffectMaxTime
          PaGlobalFunc_CollectMiniGame_SetNotInputCheck(true)
        end
      end
    end
    self._ui._txt_leftTime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MINIGAME_POWERCONTROL_REMAINTIME", "gameEndTimer", math.floor(self._curGameTime)))
    self._ui._stc_leftTimeBar:SetProgressRate(self._curGameTime / self._maxGameTime * 100)
    if self._state == self._eGameState.RESULT then
      PaGlobalFunc_CollectMiniGame_UpdateResult(self._result, self._ui._stc_success, self._ui._stc_fail, self._ui._txt_resurtBG, self._ui._stc_purpose)
      self._ui._stc_clickEffect:SetShow(false)
      self._clickEffectTime = 0
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
function PaGlobal_MiniGame_MorningMining_All:resetKeyGuideTexture()
  if Panel_MiniGame_MorningMining_All == nil then
    return
  end
  if self._isConsole == true then
  else
    self._ui._txt_key_Left:setRenderTexture(self._ui._txt_key_Left:getBaseTexture())
    self._ui._txt_key_Right:setRenderTexture(self._ui._txt_key_Right:getBaseTexture())
    self._ui._txt_key_Up:setRenderTexture(self._ui._txt_key_Up:getBaseTexture())
    self._ui._txt_key_Down:setRenderTexture(self._ui._txt_key_Down:getBaseTexture())
    self._ui._txt_key_Jump:setRenderTexture(self._ui._txt_key_Jump:getBaseTexture())
  end
end
function PaGlobal_MiniGame_MorningMining_All:resetWeekPoint()
  if Panel_MiniGame_MorningMining_All == nil then
    return
  end
  local typeCount = 0
  for ii = 1, self._weekPointMax do
    local weekPos = {x = 0, y = 0}
    if typeCount == 0 then
      weekPos.x = math.random(200, 320)
      weekPos.y = math.random(210, 410)
      typeCount = 1
    else
      weekPos.x = math.random(320, 870)
      weekPos.y = math.random(120, 420)
    end
    self._weekPoint[ii]:SetPosX(weekPos.x)
    self._weekPoint[ii]:SetPosY(weekPos.y)
    self._weekPoint[ii]:SetShow(true)
  end
end
function PaGlobal_MiniGame_MorningMining_All:findNextWeekPoint()
  if Panel_MiniGame_MorningMining_All == nil then
    return
  end
  local selectIndex = math.random(1, self._weekPointMax)
  if self._weekPoint[selectIndex] == nil then
    return
  end
  self._weekPointIndex = selectIndex
  local targetWeekPoint = self._weekPoint[self._weekPointIndex]
end
function PaGlobal_MiniGame_MorningMining_All_Open()
  PaGlobal_MiniGame_MorningMining_All:prepareOpen()
end
function PaGlobal_MiniGame_MorningMining_All_Close()
  if Panel_MiniGame_MorningMining_All ~= nil and Panel_MiniGame_MorningMining_All:GetShow() == true then
    ToClient_CollectMiniGameEnd(__eCollectMiniGameState_Cancle)
  end
  PaGlobal_MiniGame_MorningMining_All:prepareClose()
end
function PaGlobal_MiniGame_MorningMining_All_Update(deltaTime)
  PaGlobal_MiniGame_MorningMining_All:update(deltaTime)
end
function PaGlobal_MiniGame_MorningMining_All_IsOpen()
  if Panel_MiniGame_MorningMining_All == nil then
    return false
  end
  return Panel_MiniGame_MorningMining_All:GetShow()
end
function FromClient_MiniGame_MorningMining_All_ResizePanel()
  if Panel_MiniGame_MorningMining_All == nil then
    return
  end
  Panel_MiniGame_MorningMining_All:ComputePosAllChild()
end
