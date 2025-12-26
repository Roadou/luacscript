registerEvent("FromClient_luaLoadComplete", "FromClient_InitSequenceKeyGuide")
local _stc_keyGuideBg, _stc_keyGuideSub
local _keyGuideSubTick = 0
local _keyGuideSubAlpha = 0
local _keyToVirtualKey = {
  _attack1 = {
    _value = __eActionInputType_Attack1,
    _value2 = nil,
    _on = nil,
    _off = nil
  },
  _attack2 = {
    _value = __eActionInputType_Attack2,
    _value2 = nil,
    _on = nil,
    _off = nil
  },
  _crouch = {
    _value = __eActionInputType_CrouchOrSkill,
    _value2 = nil,
    _on = nil,
    _off = nil
  },
  _moveFront = {
    _value = __eActionInputType_MoveFront,
    _value2 = nil,
    _on = nil,
    _off = nil
  },
  _moveLeft = {
    _value = __eActionInputType_MoveLeft,
    _value2 = nil,
    _on = nil,
    _off = nil
  },
  _moveBack = {
    _value = __eActionInputType_MoveBack,
    _value2 = nil,
    _on = nil,
    _off = nil
  },
  _moveRight = {
    _value = __eActionInputType_MoveRight,
    _value2 = nil,
    _on = nil,
    _off = nil
  },
  _moveFrontLeft = {
    _value = __eActionInputType_MoveFront,
    _value2 = __eActionInputType_MoveLeft,
    _on = nil,
    _off = nil
  },
  _moveFrontRight = {
    _value = __eActionInputType_MoveFront,
    _value2 = __eActionInputType_MoveRight,
    _on = nil,
    _off = nil
  },
  _moveBackLeft = {
    _value = __eActionInputType_MoveBack,
    _value2 = __eActionInputType_MoveLeft,
    _on = nil,
    _off = nil
  },
  _moveBackRight = {
    _value = __eActionInputType_MoveBack,
    _value2 = __eActionInputType_MoveRight,
    _on = nil,
    _off = nil
  },
  _interaction = {
    _value = __eActionInputType_Interaction,
    _value2 = nil,
    _on = nil,
    _off = nil
  },
  _autorun = {
    _value = __eActionInputType_AutoRun,
    _value2 = nil,
    _on = nil,
    _off = nil
  },
  _grab = {
    _value = __eActionInputType_GrabOrGuard,
    _value2 = nil,
    _on = nil,
    _off = nil
  },
  _kick = {
    _value = __eActionInputType_Kick,
    _value2 = nil,
    _on = nil,
    _off = nil
  },
  _servantOrder3 = {
    _value = __eActionInputType_ServantOrder3,
    _value2 = nil,
    _on = nil,
    _off = nil
  },
  _weaponInOut = {
    _value = __eActionInputType_WeaponInOut,
    _value2 = nil,
    _on = nil,
    _off = nil
  },
  _dash = {
    _value = __eActionInputType_Dash,
    _value2 = nil,
    _on = nil,
    _off = nil
  },
  _jump = {
    _value = __eActionInputType_Jump,
    _value2 = nil,
    _on = nil,
    _off = nil
  }
}
local _cameraMove = {
  _front = {
    _value = __eJoyPadInputType_RightStick_Up,
    _value2 = nil,
    _on = nil
  },
  _left = {
    _value = __eJoyPadInputType_RightStick_Left,
    _value2 = nil,
    _on = nil
  },
  _back = {
    _value = __eJoyPadInputType_RightStick_Down,
    _value2 = nil,
    _on = nil
  },
  _right = {
    _value = __eJoyPadInputType_RightStick_Right,
    _value2 = nil,
    _on = nil
  },
  _frontLeft = {
    _value = __eJoyPadInputType_RightStick_Up,
    _value2 = __eJoyPadInputType_RightStick_Left,
    _on = nil
  },
  _frontRight = {
    _value = __eJoyPadInputType_RightStick_Up,
    _value2 = __eJoyPadInputType_RightStick_Right,
    _on = nil
  },
  _backLeft = {
    _value = __eJoyPadInputType_RightStick_Down,
    _value2 = __eJoyPadInputType_RightStick_Left,
    _on = nil
  },
  _backRight = {
    _value = __eJoyPadInputType_RightStick_Down,
    _value2 = __eJoyPadInputType_RightStick_Right,
    _on = nil
  }
}
local _keyGuideSubChild = {
  _stc_TextBG_WASD = nil,
  _stc_TextBG_Tab = nil,
  _stc_TextBG_Shift = nil,
  _stc_TextBG_R = nil,
  _stc_TextBG_MB = nil,
  _stc_TextBG_Space = nil,
  _stc_Line_WASD = nil,
  _stc_Line_Tab = nil,
  _stc_Line_Shift = nil,
  _stc_Line_R = nil,
  _stc_Line_MB = nil,
  _stc_Line_Space = nil,
  _stc_Console_Left = nil,
  _stc_Console_Left_LT = nil,
  _stc_Console_Left_LB = nil,
  _stc_Console_Right = nil,
  _stc_Console_Right_RT = nil,
  _stc_Console_Right_RB = nil,
  _stc_Console_Btn_D = nil,
  _stc_Console_Btn_D_Y = nil,
  _stc_Console_Btn_D_B = nil,
  _stc_Console_Btn_D_A = nil,
  _stc_Console_Btn_D_X = nil,
  _stc_Console_Btn_R = nil,
  _stc_Console_Btn_R_RS = nil,
  _stc_Console_Move = nil,
  _stc_Console_Move_Move = nil
}
function FromClient_InitSequenceKeyGuide()
  InitializeKeyGuide()
  registerEvent("FromClient_PlaySequence", "FromClient_PlaySequence_KeyGuide")
  registerEvent("FromClient_StopSequence", "FromClient_StopSequence_KeyGuide")
  registerEvent("FromClient_ShowSequenceKeyGuide", "FromClient_ShowSequenceKeyGuide")
  registerEvent("onScreenResize", "FromClient_ResizeSequenceKeyGuide")
  _stc_keyGuideBg:SetShow(true)
  resizeScreenSequenceKeyGuide()
end
function FromClient_ShowSequenceKeyGuide(onOff)
  resizeScreenSequenceKeyGuide()
  Panel_Sequence_KeyGuide:SetShow(onOff)
  if onOff == true then
    if _stc_keyGuideSub ~= nil then
      _keyGuideSubTick = 0
      _keyGuideSubAlpha = 0
    end
    Panel_Sequence_KeyGuide:RegisterUpdateFunc("Panel_Sequence_KeyGuideUpdatePerFrame")
  end
end
function Panel_Sequence_KeyGuideUpdatePerFrame(delta)
  if Panel_Sequence_KeyGuide == nil then
    return
  end
  updateKeyInputUI()
  updateCameraInputUI()
  updateKeyGuideDesc(delta)
end
function updateKeyGuideDesc(delta)
  if _stc_keyGuideSub == nil then
    return
  end
  if _stc_keyGuideSub:GetShow() == true then
    if IsSelfPlayerWaitAction() == false then
      _stc_keyGuideSub:SetShow(false)
      return
    end
    _keyGuideSubTick = _keyGuideSubTick + delta
    if _keyGuideSubTick < 0.5 then
      return
    end
    _keyGuideSubAlpha = _keyGuideSubAlpha + delta
    if _keyGuideSubAlpha > 1 then
      _keyGuideSubAlpha = 1
    end
    keyGuideSubSetAlpha(_keyGuideSubAlpha)
    if _keyGuideSubAlpha >= 1 then
      _stc_keyGuideSub:SetShow(true)
    end
  elseif IsSelfPlayerWaitAction() == true then
    _keyGuideSubTick = 0
    _keyGuideSubAlpha = 0
    keyGuideSubSetAlpha(_keyGuideSubAlpha)
    _stc_keyGuideSub:SetShow(true)
    return
  end
end
function keyGuideSubSetAlpha(alpha)
  for k, v in pairs(_keyGuideSubChild) do
    if v ~= nil then
      v:SetAlpha(alpha)
      v:SetFontAlpha(alpha)
    end
  end
end
function updateKeyInputUI()
  for key, value in pairs(_keyToVirtualKey) do
    local isPressValue1 = keyCustom_IsPressed_Action(value._value)
    local isPressValue2 = true
    if value._value2 ~= nil then
      isPressValue2 = keyCustom_IsPressed_Action(value._value2)
    end
    if _ContentsGroup_UsePadSnapping == true then
      local isMoveFront = value._value == __eActionInputType_MoveFront and value._value2 == nil
      local isMoveLeft = value._value == __eActionInputType_MoveLeft and value._value2 == nil
      local isMoveBack = value._value == __eActionInputType_MoveBack and value._value2 == nil
      local isMoveRight = value._value == __eActionInputType_MoveRight and value._value2 == nil
      if isMoveFront == true then
        local isMoveFrontLeft = keyCustom_IsPressed_Action(__eActionInputType_MoveFront) == true and keyCustom_IsPressed_Action(__eActionInputType_MoveLeft) == true
        local isMoveFrontRight = keyCustom_IsPressed_Action(__eActionInputType_MoveFront) == true and keyCustom_IsPressed_Action(__eActionInputType_MoveRight) == true
        if isMoveFrontLeft == true or isMoveFrontRight == true then
          isPressValue1 = false
          isPressValue2 = false
        end
      elseif isMoveLeft == true then
        local isMoveFrontLeft = keyCustom_IsPressed_Action(__eActionInputType_MoveFront) == true and keyCustom_IsPressed_Action(__eActionInputType_MoveLeft) == true
        local isMoveBackLeft = keyCustom_IsPressed_Action(__eActionInputType_MoveBack) == true and keyCustom_IsPressed_Action(__eActionInputType_MoveLeft) == true
        if isMoveFrontLeft == true or isMoveBackLeft == true then
          isPressValue1 = false
          isPressValue2 = false
        end
      elseif isMoveBack == true then
        local isMoveBackLeft = keyCustom_IsPressed_Action(__eActionInputType_MoveBack) == true and keyCustom_IsPressed_Action(__eActionInputType_MoveLeft) == true
        local isMoveBackRight = keyCustom_IsPressed_Action(__eActionInputType_MoveBack) == true and keyCustom_IsPressed_Action(__eActionInputType_MoveRight) == true
        if isMoveBackLeft == true or isMoveBackRight == true then
          isPressValue1 = false
          isPressValue2 = false
        end
      elseif isMoveRight == true then
        local isMoveFrontRight = keyCustom_IsPressed_Action(__eActionInputType_MoveFront) == true and keyCustom_IsPressed_Action(__eActionInputType_MoveRight) == true
        local isMoveBackRight = keyCustom_IsPressed_Action(__eActionInputType_MoveBack) == true and keyCustom_IsPressed_Action(__eActionInputType_MoveRight) == true
        if isMoveFrontRight == true or isMoveBackRight == true then
          isPressValue1 = false
          isPressValue2 = false
        end
      end
    end
    if isPressValue1 == true and isPressValue2 == true then
      if value._on ~= nil then
        value._on:SetAlpha(1)
      end
      if value._off ~= nil then
        value._off:SetAlpha(0)
      end
    else
      if value._on ~= nil then
        value._on:SetAlpha(0)
      end
      if value._off ~= nil then
        value._off:SetAlpha(1)
      end
    end
  end
end
function updateCameraInputUI()
  if _ContentsGroup_UsePadSnapping == false then
    return
  end
  for key, value in pairs(_cameraMove) do
    local isPressValue1 = isPadPressed(value._value)
    local isPressValue2 = true
    if value._value2 ~= nil then
      isPressValue2 = isPadPressed(value._value2)
    end
    local isCameraFront = value._value == __eJoyPadInputType_RightStick_Up and value._value2 == nil
    local isCameraLeft = value._value == __eJoyPadInputType_RightStick_Left and value._value2 == nil
    local isCameraBack = value._value == __eJoyPadInputType_RightStick_Down and value._value2 == nil
    local isCameraRight = value._value == __eJoyPadInputType_RightStick_Right and value._value2 == nil
    if isCameraFront == true then
      local isCameraFrontLeft = isPadPressed(__eJoyPadInputType_RightStick_Up) == true and isPadPressed(__eJoyPadInputType_RightStick_Left) == true
      local isCameraFrontRight = isPadPressed(__eJoyPadInputType_RightStick_Up) == true and isPadPressed(__eJoyPadInputType_RightStick_Right) == true
      if isCameraFrontLeft == true or isCameraFrontRight == true then
        isPressValue1 = false
        isPressValue2 = false
      end
    elseif isCameraLeft == true then
      local isCameraFrontLeft = isPadPressed(__eJoyPadInputType_RightStick_Up) == true and isPadPressed(__eJoyPadInputType_RightStick_Left) == true
      local isCameraBackLeft = isPadPressed(__eJoyPadInputType_RightStick_Down) == true and isPadPressed(__eJoyPadInputType_RightStick_Left) == true
      if isCameraFrontLeft == true or isCameraBackLeft == true then
        isPressValue1 = false
        isPressValue2 = false
      end
    elseif isCameraBack == true then
      local isCameraBackLeft = isPadPressed(__eJoyPadInputType_RightStick_Down) == true and isPadPressed(__eJoyPadInputType_RightStick_Left) == true
      local isCameraBackRight = isPadPressed(__eJoyPadInputType_RightStick_Down) == true and isPadPressed(__eJoyPadInputType_RightStick_Right) == true
      if isCameraBackLeft == true or isCameraBackRight == true then
        isPressValue1 = false
        isPressValue2 = false
      end
    elseif isCameraRight == true then
      local isCameraFrontRight = isPadPressed(__eJoyPadInputType_RightStick_Up) == true and isPadPressed(__eJoyPadInputType_RightStick_Right) == true
      local isCameraBackRight = isPadPressed(__eJoyPadInputType_RightStick_Down) == true and isPadPressed(__eJoyPadInputType_RightStick_Right) == true
      if isCameraFrontRight == true or isCameraBackRight == true then
        isPressValue1 = false
        isPressValue2 = false
      end
    end
    if isPressValue1 == true and isPressValue2 == true then
      if value._on ~= nil then
        value._on:SetAlpha(1)
      end
    elseif value._on ~= nil then
      value._on:SetAlpha(0)
    end
  end
end
function InitializeKeyGuide()
  UI.getChildControl(Panel_Sequence_KeyGuide, "Static_KeyGuide_XB"):SetShow(false)
  UI.getChildControl(Panel_Sequence_KeyGuide, "Static_KeyGuide"):SetShow(false)
  UI.getChildControl(Panel_Sequence_KeyGuide, "Static_KeyGuide_PS5"):SetShow(false)
  if _ContentsGroup_UsePadSnapping == true then
    if ToClient_isPS5() == true then
      _stc_keyGuideBg = UI.getChildControl(Panel_Sequence_KeyGuide, "Static_KeyGuide_PS5")
    else
      _stc_keyGuideBg = UI.getChildControl(Panel_Sequence_KeyGuide, "Static_KeyGuide_XB")
    end
    _keyToVirtualKey._attack1._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_Attack1")
    _keyToVirtualKey._attack2._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_Attack2")
    _keyToVirtualKey._crouch._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_Crouch")
    _keyToVirtualKey._moveFront._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_MoveFront")
    _keyToVirtualKey._moveLeft._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_MoveLeft")
    _keyToVirtualKey._moveBack._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_MoveBack")
    _keyToVirtualKey._moveRight._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_MoveRight")
    _keyToVirtualKey._moveFrontLeft._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_MoveFront_Left")
    _keyToVirtualKey._moveFrontRight._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_MoveFront_Right")
    _keyToVirtualKey._moveBackLeft._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_MoveBack_Left")
    _keyToVirtualKey._moveBackRight._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_MoveBack_Right")
    _keyToVirtualKey._interaction._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_Interaction")
    _keyToVirtualKey._grab._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_Grab")
    _keyToVirtualKey._kick._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_Kick")
    _keyToVirtualKey._servantOrder3._on = nil
    _keyToVirtualKey._weaponInOut._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_WeaponInOut")
    _keyToVirtualKey._dash._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_Dash")
    _keyToVirtualKey._jump._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_Jump")
    _keyToVirtualKey._attack1._off = nil
    _keyToVirtualKey._attack2._off = nil
    _keyToVirtualKey._crouch._off = nil
    _keyToVirtualKey._moveFront._off = nil
    _keyToVirtualKey._moveLeft._off = nil
    _keyToVirtualKey._moveBack._off = nil
    _keyToVirtualKey._moveRight._off = nil
    _keyToVirtualKey._moveFrontLeft._off = nil
    _keyToVirtualKey._moveFrontRight._off = nil
    _keyToVirtualKey._moveBackLeft._off = nil
    _keyToVirtualKey._moveBackRight._off = nil
    _keyToVirtualKey._interaction._off = nil
    _keyToVirtualKey._grab._off = nil
    _keyToVirtualKey._kick._off = nil
    _keyToVirtualKey._servantOrder3._off = nil
    _keyToVirtualKey._weaponInOut._off = nil
    _keyToVirtualKey._dash._off = nil
    _keyToVirtualKey._jump._off = nil
    _cameraMove._front._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_CameraFront")
    _cameraMove._left._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_CameraLeft")
    _cameraMove._back._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_CameraBack")
    _cameraMove._right._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_CameraRight")
    _cameraMove._frontLeft._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_CameraFront_Left")
    _cameraMove._frontRight._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_CameraFront_Right")
    _cameraMove._backLeft._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_CameraBack_Left")
    _cameraMove._backRight._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_CameraBack_Right")
    _keyGuideSubChild._stc_Console_Left = UI.getChildControl(_stc_keyGuideBg, "StaticText_Left")
    _keyGuideSubChild._stc_Console_Left_LT = UI.getChildControl(_keyGuideSubChild._stc_Console_Left, "StaticText_LT")
    _keyGuideSubChild._stc_Console_Left_LB = UI.getChildControl(_keyGuideSubChild._stc_Console_Left, "StaticText_LB")
    _keyGuideSubChild._stc_Console_Right = UI.getChildControl(_stc_keyGuideBg, "StaticText_Right")
    _keyGuideSubChild._stc_Console_Right_RT = UI.getChildControl(_keyGuideSubChild._stc_Console_Right, "StaticText_RT")
    _keyGuideSubChild._stc_Console_Right_RB = UI.getChildControl(_keyGuideSubChild._stc_Console_Right, "StaticText_RB")
    _keyGuideSubChild._stc_Console_Btn_D = UI.getChildControl(_stc_keyGuideBg, "StaticText_Btn_D")
    _keyGuideSubChild._stc_Console_Btn_D_Y = UI.getChildControl(_keyGuideSubChild._stc_Console_Btn_D, "StaticText_Y")
    _keyGuideSubChild._stc_Console_Btn_D_B = UI.getChildControl(_keyGuideSubChild._stc_Console_Btn_D, "StaticText_B")
    _keyGuideSubChild._stc_Console_Btn_D_A = UI.getChildControl(_keyGuideSubChild._stc_Console_Btn_D, "StaticText_A")
    _keyGuideSubChild._stc_Console_Btn_D_X = UI.getChildControl(_keyGuideSubChild._stc_Console_Btn_D, "StaticText_X")
    _keyGuideSubChild._stc_Console_Btn_R = UI.getChildControl(_stc_keyGuideBg, "StaticText_Btn_R")
    _keyGuideSubChild._stc_Console_Btn_R_RS = UI.getChildControl(_keyGuideSubChild._stc_Console_Btn_R, "StaticText_RS")
    _keyGuideSubChild._stc_Console_Move = UI.getChildControl(_stc_keyGuideBg, "StaticText_KeyGuide_Move")
    _keyGuideSubChild._stc_Console_Move_Move = UI.getChildControl(_keyGuideSubChild._stc_Console_Move, "StaticText_Move")
    _stc_keyGuideSub = _keyGuideSubChild._stc_Console_Left
  else
    _stc_keyGuideBg = UI.getChildControl(Panel_Sequence_KeyGuide, "Static_KeyGuide")
    _keyToVirtualKey._attack1._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_M0_2")
    _keyToVirtualKey._attack2._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_M1_2")
    _keyToVirtualKey._crouch._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_Btn_Q_2")
    _keyToVirtualKey._moveFront._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_Btn_W_2")
    _keyToVirtualKey._moveLeft._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_Btn_A_2")
    _keyToVirtualKey._moveBack._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_Btn_S_2")
    _keyToVirtualKey._moveRight._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_Btn_D_2")
    _keyToVirtualKey._moveFrontLeft._on = nil
    _keyToVirtualKey._moveFrontRight._on = nil
    _keyToVirtualKey._moveBackLeft._on = nil
    _keyToVirtualKey._moveBackRight._on = nil
    _keyToVirtualKey._interaction._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_Btn_R_2")
    _keyToVirtualKey._autorun._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_Btn_T_2")
    _keyToVirtualKey._grab._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_Btn_E_2")
    _keyToVirtualKey._kick._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_Btn_F_2")
    _keyToVirtualKey._servantOrder3._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_Btn_C_2")
    _keyToVirtualKey._weaponInOut._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_Btn_Tab_2")
    _keyToVirtualKey._dash._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_Btn_Shift_2")
    _keyToVirtualKey._jump._on = UI.getChildControl(_stc_keyGuideBg, "StaticText_Btn_Space_2")
    _keyToVirtualKey._attack1._off = UI.getChildControl(_stc_keyGuideBg, "StaticText_M0")
    _keyToVirtualKey._attack2._off = UI.getChildControl(_stc_keyGuideBg, "StaticText_M1")
    _keyToVirtualKey._crouch._off = UI.getChildControl(_stc_keyGuideBg, "StaticText_Btn_Q")
    _keyToVirtualKey._moveFront._off = UI.getChildControl(_stc_keyGuideBg, "StaticText_Btn_W")
    _keyToVirtualKey._moveLeft._off = UI.getChildControl(_stc_keyGuideBg, "StaticText_Btn_A")
    _keyToVirtualKey._moveBack._off = UI.getChildControl(_stc_keyGuideBg, "StaticText_Btn_S")
    _keyToVirtualKey._moveRight._off = UI.getChildControl(_stc_keyGuideBg, "StaticText_Btn_D")
    _keyToVirtualKey._moveFrontLeft._off = nil
    _keyToVirtualKey._moveFrontRight._off = nil
    _keyToVirtualKey._moveBackLeft._off = nil
    _keyToVirtualKey._moveBackRight._off = nil
    _keyToVirtualKey._interaction._off = UI.getChildControl(_stc_keyGuideBg, "StaticText_Btn_R")
    _keyToVirtualKey._autorun._off = UI.getChildControl(_stc_keyGuideBg, "StaticText_Btn_T")
    _keyToVirtualKey._grab._off = UI.getChildControl(_stc_keyGuideBg, "StaticText_Btn_E")
    _keyToVirtualKey._kick._off = UI.getChildControl(_stc_keyGuideBg, "StaticText_Btn_F")
    _keyToVirtualKey._servantOrder3._off = UI.getChildControl(_stc_keyGuideBg, "StaticText_Btn_C")
    _keyToVirtualKey._weaponInOut._off = UI.getChildControl(_stc_keyGuideBg, "StaticText_Btn_Tab")
    _keyToVirtualKey._dash._off = UI.getChildControl(_stc_keyGuideBg, "StaticText_Btn_Shift")
    _keyToVirtualKey._jump._off = UI.getChildControl(_stc_keyGuideBg, "StaticText_Btn_Space")
    _stc_keyGuideSub = UI.getChildControl(_stc_keyGuideBg, "Static_KeyGuide_Sub")
    _keyGuideSubChild._stc_TextBG_WASD = UI.getChildControl(_stc_keyGuideSub, "StaticText_TextBG_WASD")
    _keyGuideSubChild._stc_TextBG_Tab = UI.getChildControl(_stc_keyGuideSub, "StaticText_TextBG_Tab")
    _keyGuideSubChild._stc_TextBG_Shift = UI.getChildControl(_stc_keyGuideSub, "StaticText_TextBG_Shift")
    _keyGuideSubChild._stc_TextBG_R = UI.getChildControl(_stc_keyGuideSub, "StaticText_TextBG_R")
    _keyGuideSubChild._stc_TextBG_T = UI.getChildControl(_stc_keyGuideSub, "StaticText_TextBG_T")
    _keyGuideSubChild._stc_TextBG_MB = UI.getChildControl(_stc_keyGuideSub, "StaticText_TextBG_MB")
    _keyGuideSubChild._stc_TextBG_Space = UI.getChildControl(_stc_keyGuideSub, "StaticText_TextBG_Space")
    _keyGuideSubChild._stc_Line_WASD = UI.getChildControl(_stc_keyGuideSub, "Static_Line_WASD")
    _keyGuideSubChild._stc_Line_Tab = UI.getChildControl(_stc_keyGuideSub, "Static_Line_Tab")
    _keyGuideSubChild._stc_Line_Shift = UI.getChildControl(_stc_keyGuideSub, "Static_Line_Shift")
    _keyGuideSubChild._stc_Line_R = UI.getChildControl(_stc_keyGuideSub, "Static_Line_R")
    _keyGuideSubChild._stc_Line_T = UI.getChildControl(_stc_keyGuideSub, "Static_Line_T")
    _keyGuideSubChild._stc_Line_MB = UI.getChildControl(_stc_keyGuideSub, "Static_Line_MB")
    _keyGuideSubChild._stc_Line_Space = UI.getChildControl(_stc_keyGuideSub, "Static_Line_Space")
  end
end
function resizeScreenSequenceKeyGuide()
  local screenX = getScreenSizeX()
  Panel_Sequence_KeyGuide:SetSize(screenX, Panel_Sequence_KeyGuide:GetSizeY())
  Panel_Sequence_KeyGuide:ComputePosAllChild()
end
function FromClient_PlaySequence_KeyGuide()
  Panel_Sequence_KeyGuide:SetShow(false)
  Panel_Sequence_KeyGuide:ClearUpdateLuaFunc()
end
function FromClient_StopSequence_KeyGuide()
  Panel_Sequence_KeyGuide:SetShow(false)
  Panel_Sequence_KeyGuide:ClearUpdateLuaFunc()
end
function FromClient_ResizeSequenceKeyGuide()
  resizeScreenSequenceKeyGuide()
end
