function PaGlobal_MessageBox_SnowBoard:initialize()
  self:validate()
  self:registerEvent()
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._initialize = true
end
function PaGlobal_MessageBox_SnowBoard:clear()
end
function PaGlobal_MessageBox_SnowBoard:prepareOpen()
  self:open()
end
function PaGlobal_MessageBox_SnowBoard:open()
  if false == self._initialize then
    return
  end
  if false == _ContentsGroup_SnowBoardMirrorField then
    return
  end
  self:clear()
  local txt_desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_RETRYMESSAGE")
  self._ui._txt_desc:SetText(txt_desc)
  if self._isConsole == false then
    self._ui._btn_big:SetText(PAGetString(Defines.StringSheet_RESOURCE, "MESSAGEBOX_BTN_YES"))
    self._ui._btn_big:addInputEvent("Mouse_LUp", "PaGlobal_MessageBox_SnowBoard:funcYes()")
    self._ui._btn_big:SetShow(true)
    self._ui._btn_left:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PERSONALFIELD_EXIT"))
    self._ui._btn_left:addInputEvent("Mouse_LUp", "PaGlobal_MessageBox_SnowBoard:funcOut()")
    self._ui._btn_left:SetShow(true)
    self._ui._btn_right:SetText(PAGetString(Defines.StringSheet_RESOURCE, "MESSAGEBOX_BTN_CANCEL"))
    self._ui._btn_right:addInputEvent("Mouse_LUp", "PaGlobal_MessageBox_SnowBoard:funcNo()")
    self._ui._btn_right:SetShow(true)
    self._ui._btn_consoleGroup:SetShow(false)
  else
    self._ui._btn_big:SetShow(false)
    self._ui._btn_left:SetShow(false)
    self._ui._btn_right:SetShow(false)
    self._ui._btn_close:SetShow(false)
    Panel_Window_MessageBox_SnowBoard:registerPadEvent(__eConsoleUIPadEvent_A, "PaGlobal_MessageBox_SnowBoard:funcYes()")
    Panel_Window_MessageBox_SnowBoard:registerPadEvent(__eConsoleUIPadEvent_Y, "PaGlobal_MessageBox_SnowBoard:funcOut()")
    Panel_Window_MessageBox_SnowBoard:registerPadEvent(__eConsoleUIPadEvent_B, "PaGlobal_MessageBox_SnowBoard:funcNo()")
    self._ui._btn_consoleGroup:SetShow(true)
    self._ui._btn_consoleGroup:ComputePos()
  end
  local buttonSize = 90
  local baseSize = 150
  if self._isConsole == true then
    buttonSize = 40
  end
  local textSizeY = self._ui._txt_desc:GetTextSizeY()
  self._ui._txt_desc:SetSize(self._ui._txt_desc:GetSizeX(), textSizeY)
  self._ui._txt_title:SetSize(self._ui._txt_title:GetSizeX(), textSizeY + buttonSize + 50)
  Panel_Window_MessageBox_All:ComputePos()
  Panel_Window_MessageBox_SnowBoard:SetSize(Panel_Window_MessageBox_SnowBoard:GetSizeX(), textSizeY + baseSize + buttonSize)
  Panel_Window_MessageBox_SnowBoard:SetShow(true)
  self._ui._btn_consoleGroup:ComputePos()
end
function PaGlobal_MessageBox_SnowBoard:prepareClose()
  self:close()
end
function PaGlobal_MessageBox_SnowBoard:close()
  Panel_Window_MessageBox_SnowBoard:SetShow(false)
end
function PaGlobal_MessageBox_SnowBoard:validate()
  self._ui._btn_big:isValidate()
  self._ui._btn_left:isValidate()
  self._ui._btn_right:isValidate()
  self._ui._btn_close:isValidate()
  self._ui._txt_desc:isValidate()
  self._ui._btn_consoleGroup:isValidate()
end
function PaGlobal_MessageBox_SnowBoard:registerEvent()
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_MessageBox_SnowBoard:funcNo()")
  if self._isConsole == true then
    Panel_Window_MessageBox_SnowBoard:registerPadEvent(__eConsoleUIPadEvent_A, "PaGlobal_MessageBox_SnowBoard:funcYes()")
    Panel_Window_MessageBox_SnowBoard:registerPadEvent(__eConsoleUIPadEvent_Y, "PaGlobal_MessageBox_SnowBoard:funcOut()")
    Panel_Window_MessageBox_SnowBoard:registerPadEvent(__eConsoleUIPadEvent_B, "PaGlobal_MessageBox_SnowBoard:funcNo()")
  end
end
function PaGlobal_MessageBox_SnowBoard:funcYes()
  if ToClient_IsSnowBoardGhostReplayUploading() == true then
    return
  end
  self:prepareClose()
  ToClient_RequestRetrySnowBoardField()
end
function PaGlobal_MessageBox_SnowBoard:funcNo()
  self:prepareClose()
end
function PaGlobal_MessageBox_SnowBoard:funcOut()
  if ToClient_IsSnowBoardGhostReplayUploading() == true then
    return
  end
  self:prepareClose()
  ToClient_RequestLeaveSnowBoardField()
end
