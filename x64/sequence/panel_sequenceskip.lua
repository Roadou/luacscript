local _circleProgress_PressBG, _circularProgress_Press, _static_InteractionKey_R, _staticText_SkipAnno, _staticText_CantSkip
local _keyPressTime = 0
local _keyPressMaxTime = 1.2
local _sequenceNo = toUint64(0, 0)
local _skipDataID = toUint64(0, 0)
local _useBlockSkip = false
local _pressedKeyR = false
local _checkDownKeyR = false
local _isConsole = ToClient_isConsole()
local _showCantSkipTextTime = 0
local _showCantSkipTextMaxTime = 2
local _useSpeedPlaybackMode = true
local _checkBtn_playbackMode, _staticText_playbackMode_desc
local _inventoryCloseFlag = false
local _rSkipUICloseFlag = false
local _isExitCharacterSelect = false
local _isPartySequence = false
local _joyPadKeyList = {
  __eJoyPadInputType_LeftStick_Up,
  __eJoyPadInputType_LeftStick_Down,
  __eJoyPadInputType_LeftStick_Left,
  __eJoyPadInputType_LeftStick_Right,
  __eJoyPadInputType_RightStick_Up,
  __eJoyPadInputType_RightStick_Down,
  __eJoyPadInputType_RightStick_Left,
  __eJoyPadInputType_RightStick_Right,
  __eJoyPadInputType_LeftTrigger,
  __eJoyPadInputType_RightTrigger,
  __eJoyPadInputType_DPad_Up,
  __eJoyPadInputType_DPad_Down,
  __eJoyPadInputType_DPad_Left,
  __eJoyPadInputType_DPad_Right,
  __eJoyPadInputType_Start,
  __eJoyPadInputType_Back,
  __eJoyPadInputType_LeftThumb,
  __eJoyPadInputType_RightThumb,
  __eJoyPadInputType_LeftShoulder,
  __eJoyPadInputType_RightShoulder,
  __eJoyPadInputType_A,
  __eJoyPadInputType_B,
  __eJoyPadInputType_X,
  __eJoyPadInputType_Y
}
registerEvent("FromClient_luaLoadComplete", "FromClient_InitSequenceSkip")
local function CircleProgressControlOnOff(onOff)
  _circleProgress_PressBG:SetShow(onOff)
  _circularProgress_Press:SetShow(onOff)
  _static_InteractionKey_R:SetShow(onOff)
end
local function SequencePlaybackModeControlOnOff(onOff)
  _checkBtn_playbackMode:SetShow(onOff)
  _staticText_playbackMode_desc:SetShow(onOff and _isPartySequence == false)
end
function FromClient_InitSequenceSkip()
  Panel_SequenceSkip:SetPosX(0)
  Panel_SequenceSkip:SetPosY(0)
  Panel_SequenceSkip:SetShow(false)
  Panel_SequenceSkip:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_SequenceSkip:ComputePosAllChild()
  Panel_SequenceSkip:SetIgnore(true)
  Panel_SequenceSkip:SetFadeOverRender()
  registerEvent("FromClient_PlaySequence", "FromClient_OpenSequenceSkip")
  registerEvent("FromClient_StopSequence", "FromClient_CloseSequenceSkip")
  registerEvent("onScreenResize", "FromClient_ResizeScreenSequenceSkip")
  registerEvent("FromClient_ShowSequenceSkip", "FromClient_ShowSequenceSkip")
  registerEvent("EventSelfPlayerDeadInSequence", "FromClient_SelfPlayerDeadSequenceSkip")
  Panel_SequenceSkip:ClearUpdateLuaFunc()
  _staticText_SkipAnno = UI.getChildControl(Panel_SequenceSkip, "StaticText_SkipAnno")
  _staticText_CantSkip = UI.getChildControl(Panel_SequenceSkip, "StaticText_CantSkip")
  _circleProgress_PressBG = UI.getChildControl(Panel_SequenceSkip, "Static_CircleProgress_PressBG")
  _circularProgress_Press = UI.getChildControl(_circleProgress_PressBG, "CircularProgress_Press")
  _staticText_playbackMode_desc = UI.getChildControl(Panel_SequenceSkip, "StaticText_FastDesc")
  local btn_fast_pc = UI.getChildControl(Panel_SequenceSkip, "CheckButton_Fast")
  local btn_fast_xb = UI.getChildControl(Panel_SequenceSkip, "CheckButton_Fast_Xbox")
  local btn_fast_ps = UI.getChildControl(Panel_SequenceSkip, "CheckButton_Fast_Ps")
  btn_fast_pc:SetShow(false)
  btn_fast_xb:SetShow(false)
  btn_fast_ps:SetShow(false)
  if _ContentsGroup_UsePadSnapping == true then
    if ToClient_isConsole() == true and ToClient_isPS() == true then
      _checkBtn_playbackMode = btn_fast_ps
    else
      _checkBtn_playbackMode = btn_fast_xb
    end
  else
    _checkBtn_playbackMode = btn_fast_pc
  end
  if _ContentsGroup_UsePadSnapping == true then
    _static_InteractionKey_R = UI.getChildControl(_circleProgress_PressBG, "Static_InteractionKey_PadY")
  else
    _static_InteractionKey_R = UI.getChildControl(_circleProgress_PressBG, "Static_InteractionKey_R")
  end
  _staticText_SkipAnno:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CUTSCENE_SKIP_DESC"))
  SequencePlaybackModeControlOnOff(_useSpeedPlaybackMode)
  CircleProgressControlOnOff(false)
end
function Panel_PerFrameUpdateSequenceSkip(deltaTime)
  if Panel_SequenceSkipPopUp ~= nil and Panel_SequenceSkipPopUp:GetShow() == true then
    return
  end
  if Panel_Sequence_R_SkipMessageBox ~= nil and Panel_Sequence_R_SkipMessageBox:GetShow() == true then
    return
  end
  if Panel_SequenceSkipEscPopUp ~= nil and Panel_SequenceSkipEscPopUp:GetShow() == true then
    return
  end
  if Panel_Sequence_DeadMessage ~= nil and Panel_Sequence_DeadMessage:GetShow() == true then
    return
  end
  if _staticText_CantSkip:GetShow() == true then
    _showCantSkipTextTime = _showCantSkipTextTime + deltaTime
  end
  if _showCantSkipTextMaxTime < _showCantSkipTextTime then
    _showCantSkipTextTime = 0
    _staticText_CantSkip:SetShow(false)
  end
  local isProgressR = false
  local isShowRSkipUI = false
  local isShowEscSkipUI = false
  if _useBlockSkip == true then
    local isKeyDown_Y = false
    local isKeyUp_Y = false
    local isKeyPress_Y = false
    if _isConsole == true then
      isKeyDown_Y = isPadDown(__eJoyPadInputType_Y)
      isKeyUp_Y = isPadUp(__eJoyPadInputType_Y)
      isKeyPress_Y = isPadPressed(__eJoyPadInputType_Y)
    elseif _ContentsGroup_UsePadSnapping == true then
      isKeyDown_Y = isPadDown(__eJoyPadInputType_Y) or keyCustom_IsDown_Action(CppEnums.ActionInputType.ActionInputType_Interaction)
      isKeyUp_Y = isPadUp(__eJoyPadInputType_Y) or keyCustom_IsUp_Action(CppEnums.ActionInputType.ActionInputType_Interaction)
      isKeyPress_Y = isPadPressed(__eJoyPadInputType_Y) or keyCustom_IsPressed_Action(CppEnums.ActionInputType.ActionInputType_Interaction)
    else
      isKeyDown_Y = keyCustom_IsDown_Action(CppEnums.ActionInputType.ActionInputType_Interaction)
      isKeyUp_Y = keyCustom_IsUp_Action(CppEnums.ActionInputType.ActionInputType_Interaction)
      isKeyPress_Y = keyCustom_IsPressed_Action(CppEnums.ActionInputType.ActionInputType_Interaction)
    end
    if isKeyDown_Y == true then
      CircleProgressControlOnOff(true)
      _staticText_SkipAnno:SetShow(false)
      _pressedKeyR = true
      _checkDownKeyR = true
    end
    if isKeyUp_Y == true then
      CircleProgressControlOnOff(false)
      _staticText_SkipAnno:SetShow(true)
      _circularProgress_Press:SetCurrentControlPos(0)
      _circularProgress_Press:SetProgressRate(0)
      _keyPressTime = 0
      _pressedKeyR = false
      _checkDownKeyR = false
      isProgressR = false
    end
    if _checkDownKeyR == true and isKeyPress_Y == true then
      _keyPressTime = _keyPressTime + deltaTime
      _circularProgress_Press:SetProgressRate(_keyPressTime * 100 / _keyPressMaxTime)
      _pressedKeyR = true
      isProgressR = true
      if _keyPressMaxTime <= _keyPressTime then
        if Panel_SequenceSkipPopUp ~= nil and Sequence_R_SkipMessageBox_Show ~= nil then
          Sequence_R_SkipMessageBox_Show(_sequenceNo, _skipDataID)
          isShowRSkipUI = true
        end
        CircleProgressControlOnOff(false)
        _staticText_SkipAnno:SetShow(true)
        _circularProgress_Press:SetCurrentControlPos(0)
        _circularProgress_Press:SetProgressRate(0)
        _keyPressTime = 0
        _pressedKeyR = false
        isProgressR = false
      end
    end
  else
    isProgressR = false
    local isKeyDown_Y = false
    local isKeyUp_Y = false
    if _isConsole == true then
      isKeyDown_Y = isPadDown(__eJoyPadInputType_Y)
      isKeyUp_Y = isPadUp(__eJoyPadInputType_Y)
    elseif _ContentsGroup_UsePadSnapping == true then
      isKeyDown_Y = isPadDown(__eJoyPadInputType_Y) or keyCustom_IsDown_Action(CppEnums.ActionInputType.ActionInputType_Interaction)
      isKeyUp_Y = isPadUp(__eJoyPadInputType_Y) or keyCustom_IsUp_Action(CppEnums.ActionInputType.ActionInputType_Interaction)
    else
      isKeyDown_Y = keyCustom_IsDown_Action(CppEnums.ActionInputType.ActionInputType_Interaction)
      isKeyUp_Y = keyCustom_IsUp_Action(CppEnums.ActionInputType.ActionInputType_Interaction)
    end
    if isKeyDown_Y == true then
      _pressedKeyR = true
      _checkDownKeyR = true
    end
    if isKeyUp_Y == true then
      _pressedKeyR = false
      _checkDownKeyR = false
    end
    if _pressedKeyR == true then
      _showCantSkipTextTime = 0
      _staticText_CantSkip:SetShow(true)
    end
  end
  local useEscSkipUI = _pressedKeyR == false
  if useEscSkipUI == true and (_inventoryCloseFlag == true or _rSkipUICloseFlag == true) then
    useEscSkipUI = false
    _inventoryCloseFlag = false
    _rSkipUICloseFlag = false
  end
  if useEscSkipUI == true then
    local isKeyDown_ESC = false
    if _isConsole == true then
      isKeyDown_ESC = isPadDown(__eJoyPadInputType_Start)
    elseif _ContentsGroup_UsePadSnapping == true then
      isKeyDown_ESC = isPadDown(__eJoyPadInputType_Start)
    else
      isKeyDown_ESC = keyCustom_IsDown_Action(CppEnums.ActionInputType.ActionInputType_Esc)
    end
    if isKeyDown_ESC == true and isShowRSkipUI == false then
      if Panel_SequenceSkipEscPopUp ~= nil and openSequenceSkipEscPopUp ~= nil then
        openSequenceSkipEscPopUp(_isExitCharacterSelect)
        isShowEscSkipUI = true
      end
      _circularProgress_Press:SetCurrentControlPos(0)
      _circularProgress_Press:SetProgressRate(0)
      _keyPressTime = 0
      _pressedKeyR = false
    end
  end
  _useSpeedPlaybackMode = _useBlockSkip == true and isProgressR == false and isShowRSkipUI == false and isShowEscSkipUI == false and not ToClient_isPlayerControlable() and _isPartySequence == false
  if _useSpeedPlaybackMode == true then
    SequencePlaybackModeControlOnOff(true)
    local isKeyPress_G = false
    if _isConsole == true then
      isKeyPress_G = isPadPressed(__eJoyPadInputType_X)
    elseif _ContentsGroup_UsePadSnapping == true then
      isKeyPress_G = isPadPressed(__eJoyPadInputType_X) or isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_G)
    else
      isKeyPress_G = isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_G)
    end
    local isSpeedPlaybackMode = ToClient_IsSequencePlaybackSpeedMode()
    if isKeyPress_G == true then
      if isSpeedPlaybackMode == false then
        ToClient_SetSequencePlaybackSpeedMode(true, 5)
        _checkBtn_playbackMode:SetCheck(true)
      end
    elseif isSpeedPlaybackMode == true then
      ToClient_SetSequencePlaybackSpeedMode(false, 1)
      _checkBtn_playbackMode:SetCheck(false)
    end
  else
    SequencePlaybackModeControlOnOff(false)
    local isSpeedPlaybackMode = ToClient_IsSequencePlaybackSpeedMode()
    if isSpeedPlaybackMode == true then
      ToClient_SetSequencePlaybackSpeedMode(false, 1)
      _checkBtn_playbackMode:SetCheck(false)
    end
  end
end
function FromClient_OpenSequenceSkip()
  if Panel_SequenceSkip == nil then
    return
  end
  _keyPressTime = 0
  _useBlockSkip = false
  _pressedKeyR = false
  _staticText_SkipAnno:SetShow(false)
  _staticText_CantSkip:SetShow(false)
  FromClient_ResizeScreenSequenceSkip()
  Panel_SequenceSkip:SetShow(true)
  Panel_SequenceSkip:RegisterUpdateFunc("Panel_PerFrameUpdateSequenceSkip")
end
function FromClient_CloseSequenceSkip()
  if Panel_SequenceSkip == nil then
    return
  end
  CircleProgressControlOnOff(false)
  _circularProgress_Press:SetCurrentControlPos(0)
  _circularProgress_Press:SetProgressRate(0)
  _keyPressTime = 0
  _useBlockSkip = false
  Panel_SequenceSkip:SetShow(false)
  Panel_SequenceSkip:ClearUpdateLuaFunc()
end
function FromClient_ResizeScreenSequenceSkip()
  local screenX = getScreenSizeX()
  local screenY = getScreenSizeY()
  Panel_SequenceSkip:SetPosX(0)
  Panel_SequenceSkip:SetPosY(0)
  Panel_SequenceSkip:SetSize(screenX, screenY)
  Panel_SequenceSkip:ComputePosAllChild()
end
function FromClient_ShowSequenceSkip(onOff, sequenceNo, dataID, isExitCharacterSelect, isPartySequence)
  if Panel_SequenceSkip == nil then
    return
  end
  if onOff == true then
    _sequenceNo = sequenceNo
    _skipDataID = dataID
    _useBlockSkip = true
    _isExitCharacterSelect = isExitCharacterSelect
    _isPartySequence = isPartySequence
    _staticText_SkipAnno:SetShow(true)
    _staticText_CantSkip:SetShow(false)
  else
    _sequenceNo = toUint64(0, 0)
    _skipDataID = toUint64(0, 0)
    _useBlockSkip = false
    _pressedKeyR = false
    _isExitCharacterSelect = isExitCharacterSelect
    _isPartySequence = isPartySequence
    _staticText_SkipAnno:SetShow(false)
    _staticText_CantSkip:SetShow(true)
    CircleProgressControlOnOff(false)
  end
end
function FromClient_SelfPlayerDeadSequenceSkip()
  if Panel_SequenceSkip == nil then
    return
  end
  if Panel_SequenceSkip:GetShow() == false then
    return
  end
  CircleProgressControlOnOff(false)
end
function PaGlobalFunc_SequenceSkip_SetInventoryCloseFlag()
  if Panel_SequenceSkip == nil then
    return
  end
  if Panel_SequenceSkip:GetShow() == false then
    return
  end
  _inventoryCloseFlag = true
end
function PaGlobalFunc_SequenceSkip_SetRSkipCloseFlag()
  if Panel_SequenceSkip == nil then
    return
  end
  if Panel_SequenceSkip:GetShow() == false then
    return
  end
  _rSkipUICloseFlag = true
end
