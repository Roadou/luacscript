PaGlobal_CutScene_ESC_Skip = {
  _ui = {
    _stc_title = nil,
    _stc_desc = nil,
    _btn_characterSelect = nil,
    _btn_continue = nil,
    _btn_skip = nil,
    _btn_panelClose = nil,
    _stc_keyGuideBg = nil
  },
  _eButtonType = {
    CHARACTER_SELECT = 1,
    CONTINUE = 2,
    SKIP = 3
  },
  _buttonFunctionList = nil,
  _isConsole = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_CutSceneEscSkipInit")
function FromClient_CutSceneEscSkipInit()
  PaGlobal_CutScene_ESC_Skip:initialize()
end
function PaGlobal_CutScene_ESC_Skip:initialize()
  if Panel_Window_CutSceneEscSkip == nil then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:initializeControl()
  self:registEventHandler()
  self:validate()
  self:clear()
end
function PaGlobal_CutScene_ESC_Skip:initializeControl()
  if Panel_Window_CutSceneEscSkip == nil then
    return
  end
  self._ui._stc_title = UI.getChildControl(Panel_Window_CutSceneEscSkip, "StaticText_Title")
  self._ui._stc_desc = UI.getChildControl(Panel_Window_CutSceneEscSkip, "StaticText_Desc")
  self._ui._btn_characterSelect = UI.getChildControl(Panel_Window_CutSceneEscSkip, "Button_Yes")
  self._ui._btn_continue = UI.getChildControl(Panel_Window_CutSceneEscSkip, "Button_No")
  self._ui._btn_skip = UI.getChildControl(Panel_Window_CutSceneEscSkip, "Button_Skip")
  self._ui._btn_panelClose = UI.getChildControl(Panel_Window_CutSceneEscSkip, "Button_Close")
  self._ui._stc_keyGuideBg = UI.getChildControl(Panel_Window_CutSceneEscSkip, "Static_BottomBg_ConsoleUI")
  self._ui._btn_characterSelect:SetShow(not self._isConsole)
  self._ui._btn_continue:SetShow(not self._isConsole)
  self._ui._btn_skip:SetShow(not self._isConsole)
  self._ui._btn_panelClose:SetShow(not self._isConsole)
  self._ui._stc_keyGuideBg:SetShow(self._isConsole)
  if self._isConsole == true then
    self:updateKeyGuide(nil, nil, nil, true)
    local stc_descBg = UI.getChildControl(Panel_Window_CutSceneEscSkip, "Static_Text")
    stc_descBg:SetSize(stc_descBg:GetSizeX(), stc_descBg:GetSizeY() - 100)
    Panel_Window_CutSceneEscSkip:SetSize(Panel_Window_CutSceneEscSkip:GetSizeX(), Panel_Window_CutSceneEscSkip:GetSizeY() - 100)
    Panel_Window_CutSceneEscSkip:ComputePosAllChild()
  end
end
function PaGlobal_CutScene_ESC_Skip:updateKeyGuide(stringA, stringY, stringB, isShowSkipKeyGuide)
  if Panel_Window_CutSceneEscSkip == nil or self._isConsole == false then
    return
  end
  local stc_keyGuide_A = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_A_ConsoleUI")
  local stc_keyGuide_Y = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Y_ConsoleUI")
  local stc_keyGuide_B = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_B_ConsoleUI")
  if stringA ~= nil then
    stc_keyGuide_A:SetText(stringA)
  end
  if stringY ~= nil then
    stc_keyGuide_Y:SetText(stringY)
  end
  if stringB ~= nil then
    stc_keyGuide_B:SetText(stringB)
  end
  local keyGuideList = Array.new()
  Panel_Window_CutSceneEscSkip:ignorePadSnapMoveToOtherPanel()
  if isShowSkipKeyGuide ~= nil and isShowSkipKeyGuide == true then
    stc_keyGuide_Y:SetShow(true)
    keyGuideList:push_back(stc_keyGuide_B)
    keyGuideList:push_back(stc_keyGuide_A)
    keyGuideList:push_back(stc_keyGuide_Y)
    self._ui._stc_keyGuideBg:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_CutSceneEscSkip_ClickedButton(" .. tostring(self._eButtonType.CHARACTER_SELECT) .. ")")
    self._ui._stc_keyGuideBg:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_CutSceneEscSkip_ClickedButton(" .. tostring(self._eButtonType.SKIP) .. ")")
  else
    stc_keyGuide_Y:SetShow(false)
    keyGuideList:push_back(stc_keyGuide_A)
    keyGuideList:push_back(stc_keyGuide_B)
    self._ui._stc_keyGuideBg:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_CutSceneEscSkip_ClickedButton(" .. tostring(self._eButtonType.CHARACTER_SELECT) .. ")")
    self._ui._stc_keyGuideBg:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
  end
  for key, control in pairs(keyGuideList) do
    if control ~= nil then
      control:SetShow(true)
    end
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui._stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP, nil, nil)
end
function PaGlobal_CutScene_ESC_Skip:registEventHandler()
  if Panel_Window_CutSceneEscSkip == nil then
    return
  end
  if self._isConsole == false then
    self._ui._btn_characterSelect:addInputEvent("Mouse_LUp", "PaGlobalFunc_CutSceneEscSkip_ClickedButton(" .. tostring(self._eButtonType.CHARACTER_SELECT) .. ")")
    self._ui._btn_continue:addInputEvent("Mouse_LUp", "PaGlobalFunc_CutSceneEscSkip_ClickedButton(" .. tostring(self._eButtonType.CONTINUE) .. ")")
    self._ui._btn_skip:addInputEvent("Mouse_LUp", "PaGlobalFunc_CutSceneEscSkip_ClickedButton(" .. tostring(self._eButtonType.SKIP) .. ")")
    self._ui._btn_panelClose:addInputEvent("Mouse_LUp", "PaGlobalFunc_CutSceneEscSkip_Close()")
  end
end
function PaGlobal_CutScene_ESC_Skip:validate()
  if Panel_Window_CutSceneEscSkip == nil then
    return
  end
  self._ui._stc_title:isValidate()
  self._ui._stc_desc:isValidate()
  self._ui._btn_characterSelect:isValidate()
  self._ui._btn_continue:isValidate()
  self._ui._btn_skip:isValidate()
  self._ui._btn_panelClose:isValidate()
  self._ui._stc_keyGuideBg:isValidate()
end
function PaGlobal_CutScene_ESC_Skip:prepareOpen()
  if Panel_Window_CutSceneEscSkip == nil then
    return
  end
  self:clear()
  self:update()
  self:open()
end
function PaGlobal_CutScene_ESC_Skip:clear()
  if Panel_Window_CutSceneEscSkip == nil then
    return
  end
  if self._buttonFunctionList == nil then
    self._buttonFunctionList = Array.new()
  end
  self._buttonFunctionList[self._eButtonType.CHARACTER_SELECT] = nil
  self._buttonFunctionList[self._eButtonType.CONTINUE] = nil
  self._buttonFunctionList[self._eButtonType.SKIP] = nil
end
function PaGlobal_CutScene_ESC_Skip:open()
  if Panel_Window_CutSceneEscSkip == nil then
    return
  end
  if self._isConsole == true then
    Panel_Window_CutSceneEscSkip:RegisterUpdateFunc("PaGlobalFunc_CutSceneEscSkip_Update")
  end
  Panel_Window_CutSceneEscSkip:SetShow(true)
end
function PaGlobal_CutScene_ESC_Skip:prepareClose()
  if Panel_Window_CutSceneEscSkip == nil then
    return
  end
  ToClient_HideMouseCursor()
  PaGlobalFunc_CutSceneScript_KeyPressReset()
  self:close()
end
function PaGlobal_CutScene_ESC_Skip:close()
  if Panel_Window_CutSceneEscSkip == nil then
    return
  end
  if self._isConsole == true then
    Panel_Window_CutSceneEscSkip:ClearUpdateLuaFunc()
  end
  Panel_Window_CutSceneEscSkip:SetShow(false)
end
function PaGlobal_CutScene_ESC_Skip:update()
  if Panel_Window_CutSceneEscSkip == nil then
    return
  end
  local isAbyssOne = ToClient_isInAbyssOne()
  local currentAbyssOneMapKey = ToClient_GetCurrentInstanceFieldMapKey()
  local magnusAbyssOneMapKey = ToClient_GetAbyssOneBaseMapKey()
  local function function_backToCharacterSelect()
    if isAbyssOne == true then
      if currentAbyssOneMapKey == magnusAbyssOneMapKey then
        ToClient_UnJoinInstanceFieldForAll()
      else
        ToClient_MoveInstanceField(__eInstanceContentsType_AbyssOne, 0, magnusAbyssOneMapKey)
      end
    else
      PaGlobalFunc_CutSceneSkip_SetBackToCharacterSelect(true)
    end
    ToClient_SetForceStop(true)
    ToClient_CutsceneStop()
  end
  local function_continue = function()
    ToClient_HideMouseCursor()
    PaGlobalFunc_CutSceneScript_KeyPressReset()
  end
  local function_skip = function()
    PaGlobal_CutSceneSkip_Open()
  end
  local contentStr, yesStr
  if isAbyssOne == true then
    if currentAbyssOneMapKey == magnusAbyssOneMapKey then
      contentStr = PAGetString(Defines.StringSheet_GAME, "LUA_SEQUENCE_CUTSCENE_FORCE_SKIP_MAGNUS_DESC")
      yesStr = PAGetString(Defines.StringSheet_GAME, "LUA_POPUP_BTN_BACKTOWORLD")
    else
      contentStr = PAGetString(Defines.StringSheet_GAME, "LUA_SEQUENCE_CUTSCENE_FORCE_STOP_MAGNUS_DESC")
      yesStr = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SEADMESSAGE_A1_RECALL")
    end
  else
    contentStr = PAGetString(Defines.StringSheet_GAME, "LUA_SEQUENCE_CUTSCENE_FORCE_STOP_DESC")
    yesStr = PAGetString(Defines.StringSheet_GAME, "LUA_SEQUENCE_CUTSCENE_FORCE_STOP_BTN_YES")
  end
  local isForceSkip = ToClient_isForceSequenceSkip()
  local skipWrapper = ToClient_sequenceSkipWrapper()
  local partyLeaderSkip = PaGlobalFunc_CutSceneScript_IsOnlyPartyLeaderSkipAble()
  local isSkipable
  if skipWrapper == nil and isForceSkip == false or partyLeaderSkip == false then
    isSkipable = false
  else
    isSkipable = true
  end
  self._ui._stc_title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"))
  self._ui._stc_desc:SetText(contentStr)
  if self._isConsole == true then
    self:updateKeyGuide(yesStr, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_BARTER_SKIPBUTTON"), PAGetString(Defines.StringSheet_GAME, "LUA_SEQUENCE_CUTSCENE_FORCE_STOP_BTN_CANCEL"), isSkipable)
  else
    self._ui._btn_characterSelect:SetText(yesStr)
    self._ui._btn_continue:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SEQUENCE_CUTSCENE_FORCE_STOP_BTN_CANCEL"))
    self._ui._btn_skip:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_BARTER_SKIPBUTTON"))
    self._ui._btn_skip:SetMonoTone(not isSkipable, true)
    self._ui._btn_skip:SetIgnore(not isSkipable)
    ToClient_ShowMouseCursor()
  end
  self._buttonFunctionList[self._eButtonType.CHARACTER_SELECT] = function_backToCharacterSelect
  self._buttonFunctionList[self._eButtonType.CONTINUE] = function_continue
  self._buttonFunctionList[self._eButtonType.SKIP] = function_skip
end
function PaGlobalFunc_CutSceneEscSkip_Open()
  local self = PaGlobal_CutScene_ESC_Skip
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_CutSceneEscSkip_Close()
  local self = PaGlobal_CutScene_ESC_Skip
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_CutSceneEscSkip_ClickedButton(buttonType)
  local self = PaGlobal_CutScene_ESC_Skip
  if self == nil or self._buttonFunctionList[buttonType] == nil then
    return
  end
  if self._buttonFunctionList[buttonType] ~= nil then
    self._buttonFunctionList[buttonType]()
  end
  PaGlobalFunc_CutSceneEscSkip_Close()
end
function PaGlobalFunc_CutSceneEscSkip_Update(deltaTime)
  local self = PaGlobal_CutScene_ESC_Skip
  if self == nil or Panel_Window_CutSceneEscSkip == nil then
    return
  end
  if self._isConsole == false then
    return
  end
  if isPadDown(__eJoyPadInputType_B) == true then
    PaGlobalFunc_CutSceneEscSkip_ClickedButton(self._eButtonType.CONTINUE)
  end
end
