local _btn_KeepGoing, _btn_Return, _stc_message, _btn_close
local _isConsole = _ContentsGroup_UsePadSnapping
local _static_consoleUI, _static_consoleUI_A, _static_consoleUI_B, _static_consoleUI_Y
local _closeFlagFromKeyBinder = false
local _isExitCharacterSelectSequence = false
registerEvent("FromClient_luaLoadComplete", "FromClient_InitSequenceSkipEscPopUp")
function FromClient_InitSequenceSkipEscPopUp()
  _btn_KeepGoing = UI.getChildControl(Panel_SequenceSkipEscPopUp, "Button_KeepGoing")
  _btn_Return = UI.getChildControl(Panel_SequenceSkipEscPopUp, "Button_Return")
  _stc_message = UI.getChildControl(Panel_SequenceSkipEscPopUp, "StaticText_Content")
  _btn_close = UI.getChildControl(Panel_SequenceSkipEscPopUp, "Button_Close")
  _static_consoleUI = UI.getChildControl(Panel_SequenceSkipEscPopUp, "Static_BottomBg_ConsoleUI")
  _static_consoleUI_A = UI.getChildControl(_static_consoleUI, "StaticText_A_ConsoleUI")
  _static_consoleUI_B = UI.getChildControl(_static_consoleUI, "StaticText_B_ConsoleUI")
  _static_consoleUI_Y = UI.getChildControl(_static_consoleUI, "StaticText_Y_ConsoleUI")
  _btn_close:SetShow(not _isConsole)
  _btn_Return:SetShow(not _isConsole)
  _btn_KeepGoing:SetShow(not _isConsole)
  _static_consoleUI:SetShow(_isConsole)
  _static_consoleUI_A:SetShow(_isConsole)
  _static_consoleUI_B:SetShow(_isConsole)
  if _isConsole == false then
    _btn_close:addInputEvent("Mouse_LUp", "keepGogingSequence()")
  else
    Panel_SequenceSkipEscPopUp:ignorePadSnapMoveToOtherPanel()
    local keyGuideTable = {
      _static_consoleUI_Y,
      _static_consoleUI_A,
      _static_consoleUI_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideTable, _static_consoleUI, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_CENTER)
  end
  _btn_KeepGoing:addInputEvent("Mouse_LUp", "keepGogingSequence()")
  _btn_Return:addInputEvent("Mouse_LUp", "returnSequenceSkip()")
  _stc_message:SetText(PAGetString(Defines.StringSheet_GAME, "MORNINGLAND_ESC_BOX"))
  registerEvent("FromClient_StopSequence", "closeSequenceSkipEscPopUp")
  Panel_SequenceSkipEscPopUp:SetFadeOverRender()
end
function keepGogingSequence()
  closeSequenceSkipEscPopUp()
end
function keepGogingSequenceByKeyBinder()
  if _ContentsGroup_UsePadSnapping == false then
    _closeFlagFromKeyBinder = true
  end
  closeSequenceSkipEscPopUp()
end
function returnSequenceSkip()
  closeSequenceSkipEscPopUp()
  if _isExitCharacterSelectSequence == true then
    ToClient_EscapeSequence(__eESequenceEscapeType_ExitCharacterSelect)
  else
    ToClient_EscapeSequence(__eESequenceEscapeType_ResurrectPos)
  end
end
function openSequenceSkipEscPopUp(isExistCharacterSelect)
  if Panel_SequenceSkipEscPopUp == nil then
    return
  end
  if _closeFlagFromKeyBinder == true then
    _closeFlagFromKeyBinder = false
    return
  end
  local isEnterBlackTempleParty = ToClient_IsEnterMirrorField(__eMirrorFieldContentsKey_BlackTemple)
  local selfIsPartyLeader = RequestParty_isLeader()
  _isExitCharacterSelectSequence = isExistCharacterSelect
  if isExistCharacterSelect == true then
    _stc_message:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_ESC_DESC"))
  elseif isEnterBlackTempleParty == true then
    if selfIsPartyLeader == true then
      _stc_message:SetText(PAGetString(Defines.StringSheet_GAME, "MORNINGLAND_ESC_BOX_LEADER"))
    else
      _stc_message:SetText(PAGetString(Defines.StringSheet_GAME, "MORNINGLAND_ESC_BOX_MEMBER"))
    end
    _btn_Return:SetText(PAGetString(Defines.StringSheet_RESOURCE, "MESSAGEBOX_BTN_YES_WITHOUT_KEY"))
    _btn_KeepGoing:SetText(PAGetString(Defines.StringSheet_RESOURCE, "MESSAGEBOX_BTN_NO_WITHOUT_KEY"))
  else
    _stc_message:SetText(PAGetString(Defines.StringSheet_GAME, "MORNINGLAND_ESC_BOX"))
  end
  Panel_SequenceSkipEscPopUp:SetShow(true)
end
function closeSequenceSkipEscPopUp()
  if Panel_SequenceSkipEscPopUp == nil then
    return
  end
  Panel_SequenceSkipEscPopUp:SetShow(false)
end
