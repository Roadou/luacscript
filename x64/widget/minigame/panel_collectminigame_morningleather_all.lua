_route = {
  DOWN = 0,
  STRAIGHT = 1,
  UP = 2,
  COUNT = 3
}
PaGlobal_MiniGame_MorningLeather_All = {
  _ui = {
    _txt_resurtBG = nil,
    _stc_success = nil,
    _stc_fail = nil,
    _stc_leatherBG = nil,
    _stc_finishIcon = nil,
    _stc_finishLine = nil,
    _stc_knifeIcon = nil,
    _txt_desc = nil,
    _txt_jump = nil,
    _stc_down = nil,
    _stc_up = nil,
    _stc_straight = nil,
    _stc_AButton = nil,
    _stc_purpose = nil,
    _txt_purpose = nil
  },
  _routeTemplate = {},
  _curGameTime = 0,
  _maxGameTime = 20,
  _curResultTime = 0,
  _maxResultTime = 0.6,
  _eGameState = {
    GAME = 0,
    RESULT = 1,
    END = 2
  },
  _keyInputPerFrame = 0.03,
  _keyInputTime = 0,
  _templateCount = 11,
  _maxHeight = 2,
  _minHeight = -2,
  _isGameStart = false,
  _state = 0,
  _result = 0,
  _isConsole = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_MiniGame_MorningLeather_All_Init")
function FromClient_MiniGame_MorningLeather_All_Init()
  PaGlobal_MiniGame_MorningLeather_All:initialize()
end
function PaGlobal_MiniGame_MorningLeather_All:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._txt_resurtBG = UI.getChildControl(Panel_MiniGame_MorningLeather_All, "StaticText_Resurt_BG")
  self._ui._stc_success = UI.getChildControl(self._ui._txt_resurtBG, "Static_Success")
  self._ui._stc_fail = UI.getChildControl(self._ui._txt_resurtBG, "Static_Fail")
  self._ui._stc_leatherBG = UI.getChildControl(Panel_MiniGame_MorningLeather_All, "Static_LeatherBg")
  self._ui._stc_finishIcon = UI.getChildControl(self._ui._stc_leatherBG, "Static_FinishIcon")
  self._ui._stc_finishLine = UI.getChildControl(self._ui._stc_leatherBG, "Static_FinishLine")
  self._ui._stc_down = UI.getChildControl(self._ui._stc_leatherBG, "Static_Down_Template")
  self._ui._stc_up = UI.getChildControl(self._ui._stc_leatherBG, "Static_Up_Template")
  self._ui._stc_straight = UI.getChildControl(self._ui._stc_leatherBG, "Static_Straight_Template")
  self._ui._stc_knifeIcon = UI.getChildControl(self._ui._stc_leatherBG, "Static_KnifeIcon")
  self._ui._txt_desc = UI.getChildControl(self._ui._stc_leatherBG, "StaticText_Desc")
  self._ui._txt_jump = UI.getChildControl(self._ui._stc_leatherBG, "StaticText_Space")
  self._ui._stc_AButton = UI.getChildControl(self._ui._stc_leatherBG, "Static_A_ConsoleUI")
  self._ui._stc_purpose = UI.getChildControl(Panel_MiniGame_MorningLeather_All, "Static_Purpose")
  self._ui._txt_purpose = UI.getChildControl(self._ui._stc_purpose, "StaticText_Purpose")
  self:registEventHandler()
  self:validate()
  self:createRouteTemplate()
  self._initialize = true
end
function PaGlobal_MiniGame_MorningLeather_All:validate()
  if Panel_MiniGame_MorningLeather_All == nil then
    return
  end
  self._ui._txt_resurtBG:isValidate()
  self._ui._stc_success:isValidate()
  self._ui._stc_fail:isValidate()
  self._ui._stc_leatherBG:isValidate()
  self._ui._stc_finishIcon:isValidate()
  self._ui._stc_finishLine:isValidate()
  self._ui._stc_down:isValidate()
  self._ui._stc_up:isValidate()
  self._ui._stc_straight:isValidate()
  self._ui._stc_knifeIcon:isValidate()
  self._ui._txt_desc:isValidate()
  self._ui._txt_jump:isValidate()
  self._ui._stc_purpose:isValidate()
  self._ui._txt_purpose:isValidate()
end
function PaGlobal_MiniGame_MorningLeather_All:registEventHandler()
  if Panel_MiniGame_MorningLeather_All == nil then
    return
  end
  registerEvent("onScreenResize", "FromClient_MiniGame_MorningLeather_All_ResizePanel")
  Panel_MiniGame_MorningLeather_All:RegisterShowEventFunc(false, "PaGlobalFunc_CollectMiniGame_SetHideAnim(" .. __eCollectToolType_SkinKnife .. ")")
  self._ui._txt_desc:SetTextMode(__eTextMode_AutoWrap)
  if self._isConsole == true then
    self._ui._txt_desc:SetText(self._ui._txt_desc:GetText())
  end
  self._ui._txt_jump:SetShow(self._isConsole == false)
  self._ui._stc_AButton:SetShow(self._isConsole == true)
  self._ui._txt_purpose:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAME_LEATHER_PURPOSE"))
end
function PaGlobal_MiniGame_MorningLeather_All:prepareOpen()
  if Panel_MiniGame_MorningLeather_All == nil then
    return
  end
  PaGlobalFunc_CollectMiniGame_Start()
  self:clear()
  self:createRoute()
  if self._isConsole == false then
    self:setActionKeyText()
  end
  Panel_MiniGame_MorningLeather_All:RegisterUpdateFunc("PaGlobal_MiniGame_MorningLeather_All_Update")
  self:open()
end
function PaGlobal_MiniGame_MorningLeather_All:open()
  if Panel_MiniGame_MorningLeather_All == nil then
    return
  end
  Panel_MiniGame_MorningLeather_All:SetShow(true)
end
function PaGlobal_MiniGame_MorningLeather_All:prepareClose()
  if Panel_MiniGame_MorningLeather_All == nil then
    return
  end
  PaGlobalFunc_CollectMiniGame_End()
  self._state = self._eGameState.GAME
  Panel_MiniGame_MorningLeather_All:EraseAllEffect()
  Panel_MiniGame_MorningLeather_All:ClearUpdateLuaFunc()
  self:close()
end
function PaGlobal_MiniGame_MorningLeather_All:close()
  if Panel_MiniGame_MorningLeather_All == nil then
    return
  end
  Panel_MiniGame_MorningLeather_All:SetShow(false, true)
end
function PaGlobal_MiniGame_MorningLeather_All:clear()
  if Panel_MiniGame_MorningLeather_All == nil then
    return
  end
  Panel_MiniGame_MorningLeather_All:EraseAllEffect()
  Panel_MiniGame_MorningLeather_All:ClearUpdateLuaFunc()
  self._state = self._eGameState.GAME
  self._curGameTime = self._maxGameTime
  self._curResultTime = 0
  self._result = __eCollectMiniGameState_Cancle
  self._keyInputTime = self._keyInputPerFrame
  self._isGameStart = false
  self._ui._stc_knifeIcon:SetPosXY(80, 155)
  self._ui._txt_resurtBG:SetShow(false)
  self._ui._stc_success:SetShow(false)
  self._ui._stc_fail:SetShow(false)
  self._ui._stc_success:EraseAllEffect()
  self._ui._stc_fail:EraseAllEffect()
  self._ui._stc_leatherBG:SetShow(true)
  self._ui._stc_purpose:SetShow(true)
end
function PaGlobal_MiniGame_MorningLeather_All:setActionKeyText()
  local actionKey_jump = keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_Jump)
  local descText = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_MINIGAME_LEATHER_DESC_PC", "Space", actionKey_jump)
  self._ui._txt_desc:SetText(descText)
  self._ui._txt_jump:SetText(string.upper(actionKey_jump))
end
function PaGlobal_MiniGame_MorningLeather_All:createRouteTemplate()
  if Panel_MiniGame_MorningLeather_All == nil then
    return
  end
  for idx = 0, self._templateCount - 1 do
    local templates = {}
    templates[_route.DOWN] = UI.cloneControl(self._ui._stc_down, self._ui._stc_leatherBG, "Static_MiniGame_Leather_Template_" .. tostring(idx) .. "_Down")
    templates[_route.STRAIGHT] = UI.cloneControl(self._ui._stc_straight, self._ui._stc_leatherBG, "Static_MiniGame_Leather_Template_" .. tostring(idx) .. "_Straight")
    templates[_route.UP] = UI.cloneControl(self._ui._stc_up, self._ui._stc_leatherBG, "Static_MiniGame_Leather_Template_" .. tostring(idx) .. "_Up")
    templates[_route.COUNT] = nil
    self._routeTemplate[idx] = templates
  end
  self._ui._stc_down:SetShow(false)
  self._ui._stc_up:SetShow(false)
  self._ui._stc_straight:SetShow(false)
  self._ui._stc_leatherBG:SetChildIndex(self._ui._stc_knifeIcon, 9999)
end
function PaGlobal_MiniGame_MorningLeather_All:createRoute()
  if Panel_MiniGame_MorningLeather_All == nil then
    return
  end
  local startPosX = self._ui._stc_down:GetPosX()
  local startPosY = self._ui._stc_down:GetPosY()
  local templateSizeX = self._ui._stc_down:GetSizeX()
  local templateMoveSizeY = 27
  local prevRoute = _route.COUNT
  local currentHeight = 0
  for idx = 0, self._templateCount - 1 do
    local selectedRoute = _route.COUNT
    if currentHeight >= self._maxHeight then
      selectedRoute = math.random(0, 1)
    elseif currentHeight <= self._minHeight then
      selectedRoute = math.random(1, 2)
    else
      selectedRoute = math.random(0, 2)
    end
    if selectedRoute == _route.DOWN then
      currentHeight = currentHeight - 1
    elseif selectedRoute == _route.UP then
      currentHeight = currentHeight + 1
    end
    for routeIndex = 0, _route.COUNT - 1 do
      if selectedRoute == routeIndex then
        self._routeTemplate[idx][routeIndex]:SetShow(true)
        if prevRoute ~= _route.COUNT then
          if prevRoute == _route.DOWN then
            if selectedRoute == _route.DOWN then
              startPosY = startPosY + templateMoveSizeY
            end
          elseif prevRoute == _route.STRAIGHT then
            if selectedRoute == _route.DOWN then
              startPosY = startPosY + templateMoveSizeY
            end
          elseif prevRoute == _route.UP then
            if selectedRoute == _route.STRAIGHT or selectedRoute == _route.UP then
              startPosY = startPosY - templateMoveSizeY
            end
          else
            _PA_ASSERT(false, "\235\163\168\237\138\184\234\176\128 \235\172\180\236\161\176\234\177\180 \236\132\164\236\160\149\235\144\152\236\150\180\236\149\188\237\149\156\235\139\164")
          end
          startPosX = startPosX + templateSizeX
        end
        self._routeTemplate[idx][routeIndex]:SetPosXY(startPosX, startPosY)
      else
        self._routeTemplate[idx][routeIndex]:SetShow(false)
      end
    end
    self._routeTemplate[idx][_route.COUNT] = selectedRoute
    prevRoute = selectedRoute
  end
end
function PaGlobal_MiniGame_MorningLeather_All:isTouchLine()
  local currentRoute = _route.COUNT
  local currentControl
  for idx = 0, self._templateCount - 1 do
    local visibleControl = self._routeTemplate[idx][self._routeTemplate[idx][_route.COUNT]]
    local knifePosX = self._ui._stc_knifeIcon:GetPosX()
    if knifePosX >= visibleControl:GetPosX() and knifePosX < visibleControl:GetPosX() + visibleControl:GetSizeX() then
      currentRoute = self._routeTemplate[idx][_route.COUNT]
      currentControl = visibleControl
      break
    end
  end
  if currentControl == nil then
    return
  end
  local inclination = 0
  local y_interCept = 0
  local x = currentControl:GetPosX()
  local y = 0
  if currentRoute == _route.DOWN then
    inclination = 0.3626373626373626
    y = currentControl:GetPosY() + 10
  elseif currentRoute == _route.STRAIGHT then
    inclination = 0
    y = currentControl:GetPosY() + 33
  elseif currentRoute == _route.UP then
    inclination = -0.3626373626373626
    y = currentControl:GetPosY() + 33
  end
  y_interCept = y - inclination * x
  local knifeCenterX = self._ui._stc_knifeIcon:GetPosX() + self._ui._stc_knifeIcon:GetSizeX() * 0.5
  local knifeCenterY = self._ui._stc_knifeIcon:GetPosY() + self._ui._stc_knifeIcon:GetSizeY() * 0.5
  local upFunctionY = inclination * knifeCenterX + y_interCept
  local downFunctionY = inclination * knifeCenterX + y_interCept + 76
  if knifeCenterY >= upFunctionY and knifeCenterY <= downFunctionY then
    return false
  end
  return true
end
function PaGlobal_MiniGame_MorningLeather_All:update(deltaTime)
  if Panel_MiniGame_MorningLeather_All == nil then
    return
  end
  if self._state == self._eGameState.GAME then
    if isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_ESCAPE) == true then
      ToClient_CollectMiniGameEnd(__eCollectMiniGameState_Cancle)
      self:prepareClose()
      return
    end
    if self._isGameStart == false then
      local isKeyDown = self._isConsole == true and isPadDown(__eJoyPadInputType_A) == true or keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_Jump) == true
      if isKeyDown == true then
        self._isGameStart = true
        audioPostEvent_SystemUi(11, 133)
        _AudioPostEvent_SystemUiForXBOX(11, 133)
      end
    end
    self._curGameTime = self._curGameTime - deltaTime
    if self._curGameTime <= 0 then
      self._curGameTime = 0
      self._result = __eCollectMiniGameState_Fail
      self._state = self._eGameState.RESULT
    elseif self._isGameStart == true then
      self._keyInputTime = self._keyInputTime - deltaTime
      if 0 > self._keyInputTime then
        local isKeyPressed = self._isConsole == true and isPadPressed(__eJoyPadInputType_A) == true or keyCustom_IsPressed_Action(CppEnums.ActionInputType.ActionInputType_Jump) == true
        if isKeyPressed == true then
          self._ui._stc_knifeIcon:SetPosXY(self._ui._stc_knifeIcon:GetPosX() + 3.5, self._ui._stc_knifeIcon:GetPosY() - 3.5)
          PaGlobalFunc_CollectMiniGame_SetNotInputCheck(true)
        else
          self._ui._stc_knifeIcon:SetPosXY(self._ui._stc_knifeIcon:GetPosX() + 3.5, self._ui._stc_knifeIcon:GetPosY() + 1)
          PaGlobalFunc_CollectMiniGame_SetNotInputCheck(false)
        end
        self._keyInputTime = self._keyInputPerFrame
      end
      if self:isTouchLine() == true then
        self._result = __eCollectMiniGameState_Fail
        self._state = self._eGameState.RESULT
      end
      if self._ui._stc_knifeIcon:GetPosX() - self._ui._stc_knifeIcon:GetSizeX() * 0.5 > 810 then
        self._result = __eCollectMiniGameState_Success
        self._state = self._eGameState.RESULT
      end
    end
    if self._state == self._eGameState.RESULT then
      PaGlobalFunc_CollectMiniGame_UpdateResult(self._result, self._ui._stc_success, self._ui._stc_fail, self._ui._txt_resurtBG, self._ui._stc_purpose)
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
function PaGlobal_MiniGame_MorningLeather_All_Open()
  PaGlobal_MiniGame_MorningLeather_All:prepareOpen()
end
function PaGlobal_MiniGame_MorningLeather_All_Close()
  if Panel_MiniGame_MorningLeather_All ~= nil and Panel_MiniGame_MorningLeather_All:GetShow() == true then
    ToClient_CollectMiniGameEnd(__eCollectMiniGameState_Cancle)
  end
  PaGlobal_MiniGame_MorningLeather_All:prepareClose()
end
function PaGlobal_MiniGame_MorningLeather_All_Update(deltaTime)
  PaGlobal_MiniGame_MorningLeather_All:update(deltaTime)
end
function PaGlobal_MiniGame_MorningLeather_All_IsOpen()
  if Panel_MiniGame_MorningLeather_All == nil then
    return false
  end
  return Panel_MiniGame_MorningLeather_All:GetShow()
end
function FromClient_MiniGame_MorningLeather_All_ResizePanel()
  if Panel_MiniGame_MorningLeather_All == nil then
    return
  end
  Panel_MiniGame_MorningLeather_All:ComputePosAllChild()
end
