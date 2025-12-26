function PaGlobal_Ping_All:initialize()
  if true == PaGlobal_Ping_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._stc_pingBG = UI.getChildControl(Panel_Widget_Ping_All, "Static_PingBG")
  self._ui._btn_ping[__eNotifyPingTypeBDO_Attack] = UI.getChildControl(self._ui._stc_pingBG, "Button_Top")
  self._ui._btn_ping[__eNotifyPingTypeBDO_Help] = UI.getChildControl(self._ui._stc_pingBG, "Button_Bottom")
  self._ui._btn_ping[__eNotifyPingTypeBDO_Dangerous] = UI.getChildControl(self._ui._stc_pingBG, "Button_Left")
  self._ui._btn_ping[__eNotifyPingTypeBDO_Move] = UI.getChildControl(self._ui._stc_pingBG, "Button_Right")
  self._ui._stc_pingIcon[__eNotifyPingTypeBDO_Attack] = UI.getChildControl(self._ui._stc_pingBG, "Static_Top_Icon")
  self._ui._stc_pingIcon[__eNotifyPingTypeBDO_Help] = UI.getChildControl(self._ui._stc_pingBG, "Static_Bottom_Icon")
  self._ui._stc_pingIcon[__eNotifyPingTypeBDO_Dangerous] = UI.getChildControl(self._ui._stc_pingBG, "Static_Left_Icon")
  self._ui._stc_pingIcon[__eNotifyPingTypeBDO_Move] = UI.getChildControl(self._ui._stc_pingBG, "Static_Right_Icon")
  self._ui._stc_pingName = UI.getChildControl(self._ui._stc_pingBG, "StaticText_Name")
  self._ui._stc_mouseMove = UI.getChildControl(self._ui._stc_pingBG, "Static_MouseMove")
  self._ui._stc_padMove = UI.getChildControl(self._ui._stc_pingBG, "Static_PadMove")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Ping_All:validate()
  if nil == Panel_Widget_Ping_All then
    return
  end
  self._ui._stc_pingBG:isValidate()
  self._ui._btn_ping[__eNotifyPingTypeBDO_Attack]:isValidate()
  self._ui._btn_ping[__eNotifyPingTypeBDO_Help]:isValidate()
  self._ui._btn_ping[__eNotifyPingTypeBDO_Dangerous]:isValidate()
  self._ui._btn_ping[__eNotifyPingTypeBDO_Move]:isValidate()
  self._ui._stc_pingIcon[__eNotifyPingTypeBDO_Attack]:isValidate()
  self._ui._stc_pingIcon[__eNotifyPingTypeBDO_Help]:isValidate()
  self._ui._stc_pingIcon[__eNotifyPingTypeBDO_Dangerous]:isValidate()
  self._ui._stc_pingIcon[__eNotifyPingTypeBDO_Move]:isValidate()
  self._ui._stc_pingName:isValidate()
  self._ui._stc_mouseMove:isValidate()
end
function PaGlobal_Ping_All:registEventHandler()
  if nil == Panel_Widget_Ping_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_Ping_All_ResizePanel")
end
function PaGlobal_Ping_All:prepareOpen(isDelayOpen)
  if nil == Panel_Widget_Ping_All and true == Panel_Widget_Ping_All:GetShow() then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    return
  end
  if getInputMode() ~= CppEnums.EProcessorInputMode.eProcessorInputMode_GameMode and false == ToClient_WorldMapIsShow() then
    return
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_OthilitaDungeon) then
    return
  end
  if true == selfPlayerWrapper:isDead() then
    return
  end
  local guildWrapper = ToClient_GetMyGuildInfoWrapper()
  if nil == guildWrapper then
    return
  end
  FromClient_Ping_All_ResizePanel()
  if true == self._isConsole then
    if true == ToClient_WorldMapIsShow() then
      Panel_Widget_Ping_All:setUiConvertableType(CppEnums.UIConvertableType.eUIConvertableType_showTime)
      Panel_Widget_Ping_All:setConvetableInputMode(CppEnums.EProcessorInputMode.eProcessorInputMode_UiModeNotInput)
    else
      Panel_Widget_Ping_All:setUiConvertableType(CppEnums.UIConvertableType.eUIConvertableType_none)
      Panel_Widget_Ping_All:setConvetableInputMode(CppEnums.EProcessorInputMode.eProcessorInputMode_UiMode)
    end
  end
  if true == isDelayOpen then
    self._elapsedTime = 0
    self._notifyKeyPressTime = 0
    self._prevInitMousePosInBoader = ToClient_GetInitMousePosInBoader()
    self._ui._stc_pingBG:SetShow(false)
    Panel_Widget_Ping_All:RegisterUpdateFunc("PaGlobal_Ping_All_UpdatePressKey")
    PaGlobal_Ping_All:open()
    return
  end
  self:setPingType(__eNotifyPingTypeBDO_None)
  self._mouseMove.x = 0
  self._mouseMove.y = 0
  self._elapsedTime = 0
  if true == self._isConsole then
    self._updateRate = 0.01
    self._isPadSetting = false
    self._ui._stc_mouseMove:SetShow(false)
    self._ui._stc_padMove:SetShow(true)
    self._prevLockRStickMoveState = ToClient_IsLockRStickMove()
    ToClient_SetLockRstickMove(true)
    if nil ~= Panel_Worldmap_RingMenu and true == Panel_Worldmap_RingMenu:GetShow() and nil ~= PaGlobalFunc_WorldMap_RingMenu_SetShow then
      PaGlobalFunc_WorldMap_RingMenu_SetShow(false, false)
      self._prevWorldmapRingMenuShow = true
    end
  else
    self._updateRate = 0.2
    self._ui._stc_mouseMove:SetShow(true)
    self._ui._stc_padMove:SetShow(false)
  end
  ToClient_blockCameraRotate(true)
  ToClient_setMousePosition(self._centerPos.x, self._centerPos.y)
  self._prevInitMousePosInBoader = ToClient_GetInitMousePosInBoader()
  ToClient_SetInitMousePosInBoader(false)
  self._prevUIMode = GetUIMode()
  SetUIMode(Defines.UIMode.eUIMode_NpcDialog_Dummy)
  self._ui._stc_pingBG:SetShow(true)
  Panel_Widget_Ping_All:RegisterUpdateFunc("PaGlobal_Ping_All_Update")
  PaGlobal_Ping_All:open()
end
function PaGlobal_Ping_All:open()
  if nil == Panel_Widget_Ping_All then
    return
  end
  Panel_Widget_Ping_All:SetShow(true)
end
function PaGlobal_Ping_All:prepareClose()
  if nil == Panel_Widget_Ping_All then
    return
  end
  ToClient_blockCameraRotate(false)
  if nil ~= self._prevInitMousePosInBoader then
    ToClient_SetInitMousePosInBoader(self._prevInitMousePosInBoader)
    self._prevInitMousePosInBoader = nil
  end
  if nil ~= self._prevLockRStickMoveState then
    ToClient_SetLockRstickMove(self._prevLockRStickMoveState)
    self._prevLockRStickMoveState = nil
  end
  if nil ~= self._prevUIMode then
    SetUIMode(self._prevUIMode)
    self._prevUIMode = nil
  end
  if true == self._prevWorldmapRingMenuShow then
    if nil ~= PaGlobalFunc_WorldMap_RingMenu_SetShow then
      PaGlobalFunc_WorldMap_RingMenu_SetShow(true, false)
    end
    PaGlobal_Ping_All:sendPing()
    self._prevWorldmapRingMenuShow = false
  end
  self._notifyKeyPressTime = 0
  self._elapsedTime = 0
  self._currentType = self._defaultPingType
  Panel_Widget_Ping_All:ClearUpdateLuaFunc()
  PaGlobal_Ping_All:close()
end
function PaGlobal_Ping_All:close()
  if nil == Panel_Widget_Ping_All then
    return
  end
  Panel_Widget_Ping_All:SetShow(false)
end
function PaGlobal_Ping_All:updatePressKey(deltaTime)
  self._notifyKeyPressTime = self._notifyKeyPressTime + deltaTime
  if self._notifyKeySelectOpenTime <= self._notifyKeyPressTime then
    Panel_Widget_Ping_All:ClearUpdateLuaFunc()
    PaGlobal_Ping_All:prepareOpen(false)
    return
  end
  local isClose = false
  if true == self._isConsole then
    if false == isPadPressed(__eJoyPadInputType_LeftThumb) then
      isClose = true
    end
  else
    local pingNotifyKeyCode = keyCustom_getDefineUIVirtualKeyCode(__eUiInputType_PositionNotify)
    if false == isKeyPressed(pingNotifyKeyCode) then
      isClose = true
    end
  end
  if isClose == true then
    PaGlobal_Ping_All:sendPing()
    self._notifyKeyPressTime = 0
    self._elapsedTime = 0
    self._currentType = self._defaultPingType
    Panel_Widget_Ping_All:ClearUpdateLuaFunc()
    ToClient_blockCameraRotate(false)
    PaGlobal_Ping_All:close()
  end
end
function PaGlobal_Ping_All:updatePingType(deltaTime)
  ToClient_SetInitMousePosInBoader(false)
  self._elapsedTime = self._elapsedTime + deltaTime
  if self._elapsedTime < self._updateRate then
    return
  end
  self._elapsedTime = 0
  if true == self._isConsole then
    if false == self._isPadSetting then
      if false == isPadPressed(__eJoyPadInputType_RightStick_Up) and false == isPadPressed(__eJoyPadInputType_RightStick_Right) and false == isPadPressed(__eJoyPadInputType_RightStick_Down) and false == isPadPressed(__eJoyPadInputType_RightStick_Left) then
        self._isPadSetting = true
      end
    elseif true == isPadPressed(__eJoyPadInputType_RightStick_Up) then
      self:setPingType(__eNotifyPingTypeBDO_Attack)
      self._ui._stc_padMove:SetShow(false)
    elseif true == isPadPressed(__eJoyPadInputType_RightStick_Right) then
      self:setPingType(__eNotifyPingTypeBDO_Move)
      self._ui._stc_padMove:SetShow(false)
    elseif true == isPadPressed(__eJoyPadInputType_RightStick_Down) then
      self:setPingType(__eNotifyPingTypeBDO_Help)
      self._ui._stc_padMove:SetShow(false)
    elseif true == isPadPressed(__eJoyPadInputType_RightStick_Left) then
      self:setPingType(__eNotifyPingTypeBDO_Dangerous)
      self._ui._stc_padMove:SetShow(false)
    elseif __eNotifyPingTypeBDO_Attack == self._currentType and true == isPadUp(__eJoyPadInputType_RightStick_Up) or __eNotifyPingTypeBDO_Move == self._currentType and true == isPadUp(__eJoyPadInputType_RightStick_Right) or __eNotifyPingTypeBDO_Help == self._currentType and true == isPadUp(__eJoyPadInputType_RightStick_Down) or __eNotifyPingTypeBDO_Dangerous == self._currentType and true == isPadUp(__eJoyPadInputType_RightStick_Left) then
      PaGlobal_Ping_All_SavePingType()
      return
    end
  else
    if true == PaGlobal_Ping_All._isDelayOpen then
      local pingNotifyKeyCode = keyCustom_getDefineUIVirtualKeyCode(__eUiInputType_PositionNotify)
      if false == isKeyPressed(pingNotifyKeyCode) then
        PaGlobal_Ping_All_SavePingType()
        return
      end
    elseif false == isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_MENU) or false == isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_OEM_3) then
      PaGlobal_Ping_All_SavePingType()
      return
    end
    local mouseMovePos = {
      x = self._centerPos.x - getMousePosX() * self._uiScale,
      y = self._centerPos.y - getMousePosY() * self._uiScale
    }
    local moveLength = math.sqrt(math.abs(math.pow(mouseMovePos.x, 2)) + math.abs(math.pow(mouseMovePos.y, 2)))
    if moveLength < self._maxMoveSelect then
      self:setPingType(__eNotifyPingTypeBDO_None)
      self._ui._stc_mouseMove:SetShow(true)
      return
    end
    self._ui._stc_mouseMove:SetShow(false)
    local angle = math.floor(-1 * math.atan2(mouseMovePos.x, mouseMovePos.y) / math.pi * 180)
    if math.abs(angle) < 45 then
      self:setPingType(__eNotifyPingTypeBDO_Attack)
    elseif math.abs(angle) < 135 then
      if angle < 0 then
        self:setPingType(__eNotifyPingTypeBDO_Dangerous)
      else
        self:setPingType(__eNotifyPingTypeBDO_Move)
      end
    else
      self:setPingType(__eNotifyPingTypeBDO_Help)
    end
  end
end
function PaGlobal_Ping_All:setPingType(pingType)
  for index = 1, __eNotifyPingTypeBDO_Count do
    if nil ~= self._ui._btn_ping[index] then
      self._ui._btn_ping[index]:SetShow(false)
    end
  end
  self._ui._stc_pingName:SetText("")
  if nil == pingType or __eNotifyPingTypeBDO_None == pingType then
    self._currentType = __eNotifyPingTypeBDO_None
    return
  end
  self._currentType = pingType
  if nil ~= self._ui._btn_ping[self._currentType] then
    self._ui._btn_ping[self._currentType]:SetShow(true)
  end
  local pingTypeText = ""
  if pingType == __eNotifyPingTypeBDO_Attack then
    pingTypeText = PAGetString(Defines.StringSheet_GAME, "LUA_PING_ATTACK")
  elseif pingType == __eNotifyPingTypeBDO_Dangerous then
    pingTypeText = PAGetString(Defines.StringSheet_GAME, "LUA_PING_CAUTION")
  elseif pingType == __eNotifyPingTypeBDO_Move then
    pingTypeText = PAGetString(Defines.StringSheet_GAME, "LUA_PING_MOVE")
  elseif pingType == __eNotifyPingTypeBDO_Help then
    pingTypeText = PAGetString(Defines.StringSheet_GAME, "LUA_PING_LEAD")
  end
  if nil == pingTypeText then
    pingTypeText = ""
  end
  self._ui._stc_pingName:SetText(pingTypeText)
end
function PaGlobal_Ping_All:savePingType()
  if nil == Panel_Widget_Ping_All then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local pingType = self._currentType
  if nil == pingType or pingType >= __eNotifyPingTypeBDO_Count then
    pingType = __eNotifyPingTypeBDO_None
  end
  ToClient_SetPingType(pingType)
  local pingTypeText = ""
  if pingType == __eNotifyPingTypeBDO_Attack then
    pingTypeText = PAGetString(Defines.StringSheet_GAME, "LUA_PING_ATTACK")
  elseif pingType == __eNotifyPingTypeBDO_Dangerous then
    pingTypeText = PAGetString(Defines.StringSheet_GAME, "LUA_PING_CAUTION")
  elseif pingType == __eNotifyPingTypeBDO_Move then
    pingTypeText = PAGetString(Defines.StringSheet_GAME, "LUA_PING_MOVE")
  elseif pingType == __eNotifyPingTypeBDO_Help then
    pingTypeText = PAGetString(Defines.StringSheet_GAME, "LUA_PING_LEAD")
  else
    return
  end
  Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PING_SELECT_SHAPE", "position", pingTypeText))
end
function PaGlobal_Ping_All:sendPing()
  local pingType = ToClient_GetPingType()
  local isGuild = true
  local isPermanent = false
  local guildWrapper = ToClient_GetMyGuildInfoWrapper()
  if nil == guildWrapper then
    return
  end
  if true == self._isConsole then
    if nil ~= SendPingInfo_WorldMap_ToConsole then
      SendPingInfo_WorldMap_ToConsole(true)
    end
  else
    local targetPosition = crossHair_GetTargetPosition()
    if true == ToClient_IsViewSelfPlayer(targetPosition) then
      ToClient_RequestSendPositionGuide(isGuild, isPermanent, false, targetPosition, pingType)
    end
    audioPostEvent_SystemUi(24, 20)
    _AudioPostEvent_SystemUiForXBOX(24, 20)
  end
end
