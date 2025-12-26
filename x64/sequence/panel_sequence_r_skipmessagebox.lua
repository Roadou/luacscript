registerEvent("FromClient_luaLoadComplete", "FromClient_InitSequence_R_SkipMessageBox")
local _stc_message, _btn_skip, _btn_cancel, _btn_close, _btn_skipForDev, _btn_forceSkip, _static_consoleUI, _static_consoleUI_A, _static_consoleUI_B, _static_consoleUI_Y
local _sequenceNo = toUint64(0, 0)
local _skipDataID = toUint64(0, 0)
local _oriBtnSizeX = 0
local _oriBtnPosX = 0
function FromClient_InitSequence_R_SkipMessageBox()
  if Panel_Sequence_R_SkipMessageBox == nil then
    return
  end
  _stc_message = UI.getChildControl(Panel_Sequence_R_SkipMessageBox, "StaticText_Content")
  _btn_skip = UI.getChildControl(Panel_Sequence_R_SkipMessageBox, "Button_Skip")
  _btn_cancel = UI.getChildControl(Panel_Sequence_R_SkipMessageBox, "Button_Cancel")
  _btn_close = UI.getChildControl(Panel_Sequence_R_SkipMessageBox, "Button_Close")
  _btn_skipForDev = UI.getChildControl(Panel_Sequence_R_SkipMessageBox, "Button_SkipForDev")
  _btn_forceSkip = UI.getChildControl(Panel_Sequence_R_SkipMessageBox, "Button_ForceSkip")
  _forceSkip_consoleUI_X = UI.getChildControl(_btn_forceSkip, "StaticText_1")
  _static_consoleUI = UI.getChildControl(Panel_Sequence_R_SkipMessageBox, "Static_BottomBg_ConsoleUI")
  _static_consoleUI_A = UI.getChildControl(_static_consoleUI, "StaticText_A_ConsoleUI")
  _static_consoleUI_B = UI.getChildControl(_static_consoleUI, "StaticText_B_ConsoleUI")
  _static_consoleUI_Y = UI.getChildControl(_static_consoleUI, "StaticText_Y_ConsoleUI")
  _oriBtnSizeX = _btn_forceSkip:GetSizeX()
  _oriBtnPosX = _btn_forceSkip:GetPosX()
  _btn_close:SetShow(not _ContentsGroup_UsePadSnapping)
  _btn_skip:SetShow(not _ContentsGroup_UsePadSnapping)
  _btn_cancel:SetShow(not _ContentsGroup_UsePadSnapping)
  _btn_skipForDev:SetShow(ToClient_isForceSequenceSkip() == true)
  _static_consoleUI:SetShow(_ContentsGroup_UsePadSnapping)
  _static_consoleUI_A:SetShow(_ContentsGroup_UsePadSnapping)
  _static_consoleUI_B:SetShow(_ContentsGroup_UsePadSnapping)
  _forceSkip_consoleUI_X:SetShow(_ContentsGroup_UsePadSnapping)
  _btn_skip:addInputEvent("Mouse_LUp", "PaGlobalFunc_Sequence_R_SkipMessageBox_DoSkip()")
  _btn_cancel:addInputEvent("Mouse_LUp", "PaGlobalFunc_Sequence_R_SkipMessageBox_Close()")
  _btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_Sequence_R_SkipMessageBox_Close()")
  _btn_skipForDev:addInputEvent("Mouse_LUp", "PaGlobalFunc_Sequence_R_SkipMessageBox_DoSkipForDev()")
  _btn_forceSkip:addInputEvent("Mouse_LUp", "PaGlobalFunc_Sequence_R_SkipMessageBox_DoForceSkip()")
  registerEvent("FromClient_StopSequence", "PaGlobalFunc_Sequence_R_SkipMessageBox_Close()")
  if _ContentsGroup_UsePadSnapping == true then
    local keyGuideTable = {
      _static_consoleUI_A,
      _static_consoleUI_B,
      _static_consoleUI_Y
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideTable, _static_consoleUI, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_CENTER)
  end
  Panel_Sequence_R_SkipMessageBox:SetFadeOverRender()
end
function Sequence_R_SkipMessageBox_Show(sequenceNo, dataID)
  if Panel_Sequence_R_SkipMessageBox == nil then
    return
  end
  _sequenceNo = sequenceNo
  _skipDataID = dataID
  Panel_Sequence_R_SkipMessageBox:ComputePos()
  _btn_skipForDev:ComputePos()
  _btn_forceSkip:ComputePos()
  _btn_forceSkip:SetShow(ToClient_isForceSkipSequence() == true)
  if _ContentsGroup_UsePadSnapping == true then
    _btn_forceSkip:SetIgnore(true)
    Panel_Sequence_R_SkipMessageBox:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_Sequence_R_SkipMessageBox_DoForceSkip()")
  else
    _btn_forceSkip:SetIgnore(false)
  end
  if _btn_skipForDev:GetShow() == true and _btn_forceSkip:GetShow() == true then
    _btn_skipForDev:SetSize(_btn_skipForDev:GetSizeX() / 2, _btn_skipForDev:GetSizeY())
    _btn_forceSkip:SetSize(_btn_forceSkip:GetSizeX() / 2, _btn_forceSkip:GetSizeY())
    _btn_forceSkip:SetPosX(_btn_forceSkip:GetPosX() + _btn_forceSkip:GetSizeX() + 5)
  else
    _btn_skipForDev:SetSize(_oriBtnSizeX, _btn_forceSkip:GetSizeY())
    _btn_forceSkip:SetSize(_oriBtnSizeX, _btn_forceSkip:GetSizeY())
    _btn_skipForDev:SetPosX(_oriBtnPosX)
    _btn_forceSkip:SetPosX(_oriBtnPosX)
  end
  Panel_Sequence_R_SkipMessageBox:SetShow(true)
end
function Sequence_R_SkipMessageBox_Hide()
  if Panel_Sequence_R_SkipMessageBox == nil then
    return
  end
  _sequenceNo = toUint64(0, 0)
  _skipDataID = toUint64(0, 0)
  if PaGlobalFunc_SequenceSkip_SetRSkipCloseFlag ~= nil then
    PaGlobalFunc_SequenceSkip_SetRSkipCloseFlag()
  end
  Panel_Sequence_R_SkipMessageBox:SetShow(false)
end
function PaGlobalFunc_Sequence_R_SkipMessageBox_DoSkip()
  ToClient_SequenceSkip(_sequenceNo, _skipDataID)
  Sequence_R_SkipMessageBox_Hide()
end
function PaGlobalFunc_Sequence_R_SkipMessageBox_Close()
  Sequence_R_SkipMessageBox_Hide()
end
function PaGlobalFunc_Sequence_R_SkipMessageBox_DoSkipForDev()
  ToClient_SequenceSkipForDev(_sequenceNo)
  Sequence_R_SkipMessageBox_Hide()
end
function PaGlobalFunc_Sequence_R_SkipMessageBox_DoForceSkip()
  ToClient_EscapeSequence(__eESequenceEscapeType_ForceSkip)
  Sequence_R_SkipMessageBox_Hide()
end
