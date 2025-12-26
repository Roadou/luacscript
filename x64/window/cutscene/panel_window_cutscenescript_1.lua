function PaGlobal_CutSceneScript:initialize()
  self._renderMode = RenderModeWrapper.new(100, {
    Defines.RenderMode.eRenderMode_GroupCamera
  }, false)
  self._renderMode:setClosefunctor(self._renderMode, PaGlobalFunc_CutSceneScript_Awake)
  self._ui._txt_desc = UI.getChildControl(self._ui._stc_textArea, "MultilineText_1")
  self._ui._pg_keyPressTime = UI.getChildControl(self._ui._stc_keyPress, "CircularProgress_Press")
  self._ui._pg_keyPressTime:SetSmoothMode(true)
  self._ui._stc_Rkey_pc = UI.getChildControl(self._ui._stc_keyPress, "Static_InteractionKey_R")
  self._ui._stc_Rkey_console = UI.getChildControl(self._ui._stc_keyPress, "Static_InteractionKey")
  self._ui._stc_ESCkey_pc = UI.getChildControl(self._ui._stc_keyPress, "Static_InteractionKey_ESC")
  self._ui._stc_ESCkey_console = UI.getChildControl(self._ui._stc_keyPress, "Static_ConsoleMenuKey")
  if true == _ContentsGroup_UsePadSnapping then
    self._ui._stc_Rkey_pc:SetShow(false)
    self._ui._stc_Rkey_console:SetShow(true)
    self._ui._stc_ESCkey_pc:SetShow(false)
    self._ui._stc_ESCkey_console:SetShow(false)
  else
    self._ui._stc_Rkey_pc:SetShow(true)
    self._ui._stc_Rkey_console:SetShow(false)
    self._ui._stc_ESCkey_pc:SetShow(false)
    self._ui._stc_ESCkey_console:SetShow(false)
  end
  self:validate()
  self:registerEvent()
  self:resizePanel()
  Panel_Window_CutSceneScript:SetFadeOverRender()
  Panel_Window_CutSceneSkip:ignorePadSnapMoveToOtherPanel()
  self._initialize = true
end
function PaGlobal_CutSceneScript:clear()
  self._tickCount = getTickCount32()
  self._scriptCurrentIdx = 0
  self._scriptMaxCount = 0
  self._ui._txt_desc:SetText("")
  self._ui._stc_skipAnno:SetShow(false)
  self._ui._stc_cancleAnno:SetShow(false)
  self._ui._stc_keyPress:SetShow(false)
  self._currentSkipState = self._skipState.Press_Any_Key
  self._ui._pg_keyPressTime:SetCurrentControlPos(0)
  self._keyPressTime = 0
end
function PaGlobal_CutSceneScript:prepareOpen()
  if nil == Panel_Window_CutSceneScript then
    return
  end
  if false == self._initialize then
    return
  end
  local strInteractionKey = keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_Interaction)
  self._ui._stc_skipAnno:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CUTSCENE_SKIP_DESC"))
  self._ui._stc_Rkey_pc:SetText(strInteractionKey)
  local strEscKey = keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_Esc)
  if ToClient_isInAbyssOne() == true then
    local currentAbyssOneMapKey = ToClient_GetCurrentInstanceFieldMapKey()
    local magnusAbyssOneMapKey = ToClient_GetAbyssOneBaseMapKey()
    if currentAbyssOneMapKey == magnusAbyssOneMapKey then
      if ToClient_isPS5() == true then
        self._ui._stc_cancleAnno:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CUTSCENE_BACKTOWORLD_PS5"))
      else
        self._ui._stc_cancleAnno:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CUTSCENE_BACKTOWORLD"))
      end
    elseif ToClient_isPS5() == true then
      self._ui._stc_cancleAnno:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CUTSCENE_BACKTOMAGNUS_PS5"))
    else
      self._ui._stc_cancleAnno:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CUTSCENE_BACKTOMAGNUS"))
    end
  elseif ToClient_isPS5() == true then
    self._ui._stc_cancleAnno:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CUTSCENE_BACKTOCHARACTERSELECT_PS5"))
  else
    self._ui._stc_cancleAnno:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CUTSCENE_BACKTOCHARACTERSELECT"))
  end
  self._ui._stc_ESCkey_pc:SetText(strEscKey)
  self:clear()
  if Panel_Movie_KeyViewer ~= nil and _ContentsGroup_UsePadSnapping == false then
    Panel_KeyViewer_Hide()
  end
  if false == ToClient_IsEnterSequence() then
    self._currentSkipState = self._skipState.End
    self._renderMode:set()
    if Defines.UIMode.eUIMode_Default == self._prevUIMode or Defines.UIMode.eUIMode_GroupCamera == self._prevUIMode then
      self._prevUIMode = GetUIMode()
    end
    SetUIMode(Defines.UIMode.eUIMode_GroupCamera)
  else
  end
  if ToClient_IsOnlyPartyLeaderSkip() == true then
    local isPartyLeader = RequestParty_isLeader()
    if isPartyLeader == false then
      self._ui._stc_skipAnno:SetText("")
      self._ui._stc_Rkey_pc:SetText("")
    end
  end
  self:open()
end
function PaGlobal_CutSceneScript:open()
  if nil == Panel_Window_CutSceneScript then
    return
  end
  Panel_Window_CutSceneScript:SetShow(true)
end
function PaGlobal_CutSceneScript:prepareClose()
  if nil == Panel_Window_CutSceneScript then
    return
  end
  if Panel_Window_CutSceneEscSkip ~= nil and Panel_Window_CutSceneEscSkip:GetShow() == true then
    PaGlobalFunc_CutSceneEscSkip_Close()
  end
  if false == ToClient_IsEnterSequence() then
    self._renderMode:reset()
    local uiMode = Defines.UIMode.eUIMode_Default
    if Defines.UIMode.eUIMode_Default ~= self._prevUIMode and Defines.UIMode.eUIMode_GroupCamera ~= self._prevUIMode then
      uiMode = self._prevUIMode
      self._prevUIMode = Defines.UIMode.eUIMode_Default
    end
    SetUIMode(uiMode)
  else
  end
  self:close()
end
function PaGlobal_CutSceneScript:close()
  if false == Panel_Window_CutSceneScript:GetShow() then
    return
  end
  Panel_Window_CutSceneScript:SetShow(false)
end
function PaGlobal_CutSceneScript:validate()
  self._ui._stc_textArea:isValidate()
  self._ui._txt_desc:isValidate()
  self._ui._stc_skipAnno:isValidate()
  self._ui._stc_cancleAnno:isValidate()
  self._ui._stc_keyPress:isValidate()
  self._ui._pg_keyPressTime:isValidate()
end
function PaGlobal_CutSceneScript:registerEvent()
  registerEvent("FromClient_startCutSceneGroupCamera", "FromClient_startCutSceneGroupCamera")
end
function PaGlobal_CutSceneScript:resizePanel()
  Panel_Window_CutSceneScript:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_Window_CutSceneScript:ComputePosAllChild()
end
function PaGlobal_CutSceneScript:isKeyDown_OnceESC()
  local isKeyDownOnceESC = false
  if true == _ContentsGroup_UsePadSnapping then
    if true == isPadDown(__eJoyPadInputType_Start) then
      isKeyDownOnceESC = true
    end
  else
    if true == isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_ESCAPE) then
      isKeyDownOnceESC = true
    end
    if true == isPadDown(__eJoyPadInputType_Start) then
      isKeyDownOnceESC = true
    end
  end
  if isKeyDownOnceESC == true and ToClient_IsOnlyPartyLeaderSkip() == true then
    isKeyDownOnceESC = false
  end
  return isKeyDownOnceESC
end
function PaGlobal_CutSceneScript:isKeyDown_Once()
  if true == _ContentsGroup_UsePadSnapping then
    for key, value in pairs(self._joyPadKey) do
      if true == isPadDown(value) then
        return true
      end
    end
  else
    for key, value in pairs(CppEnums.VirtualKeyCode) do
      if true == isKeyDown_Once(value) then
        return true
      end
    end
    for key, value in pairs(self._joyPadKey) do
      if true == isPadDown(value) then
        return true
      end
    end
  end
  return false
end
function PaGlobal_CutSceneScript:keyPressReset()
  self._currentSkipState = self._skipState.Press_Any_Key
  self._ui._pg_keyPressTime:SetCurrentControlPos(0)
  self._keyPressTime = 0
end
function PaGlobal_CutSceneScript:cancleSequence()
  if nil == Panel_Window_CutSceneScript then
    return
  end
  if false == self._initialize then
    return
  end
  self:clear()
  PaGlobalFunc_CutSceneEscSkip_Open()
end
function PaGlobal_CutSceneScript:isOnlyPartyLeaderSkipAble()
  if ToClient_IsOnlyPartyLeaderSkip() == false then
    return true
  end
  local isPartyLeader = RequestParty_isLeader()
  return isPartyLeader
end
