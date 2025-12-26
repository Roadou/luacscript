PaGlobal_MessageBox_Edit_All = {
  _ui = {
    stc_blockBg = nil,
    stc_bg = nil,
    btn_Apply = nil,
    btn_Cancel = nil,
    btn_Close = nil,
    txt_Desc = nil,
    confirm_name = nil,
    edit_Input = nil,
    stc_KeyGuide_X = nil,
    stc_Bottom_KeyGuide = nil,
    stc_KeyGuide_A = nil,
    stc_KeyGuide_B = nil,
    multilRetry = nil,
    multilAlert = nil
  },
  _changeSpanSizeY = 0,
  _varyDescTextControlSizeX = 0,
  _varyBottomDescTextControlSizeX = 0,
  _oriPanelSizeX = 0,
  _oriPanelSizeY = 0,
  _functionYes = nil,
  _functionNo = nil,
  _addPanelSizeX = 0,
  _isInputEndUseKey = false,
  _isBlockBgShow = false,
  _isUseBottomTextMultiline = false,
  _initilize = false,
  _isConsole = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_MessageBox_Edit_All")
function FromClient_MessageBox_Edit_All()
  PaGlobal_MessageBox_Edit_All:initialize()
end
function PaGlobal_MessageBox_Edit_All:initialize()
  if true == PaGlobal_MessageBox_Edit_All._initilize then
    return
  end
  self._ui.stc_blockBg = UI.getChildControl(Panel_Window_MessageBox_Edit_All, "Static_BlockBG")
  self._ui.txt_Title = UI.getChildControl(Panel_Window_MessageBox_Edit_All, "Static_Text_Title")
  self._ui.stc_bg = UI.getChildControl(Panel_Window_MessageBox_Edit_All, "Static_Text_BG")
  self._ui.confirm_name = UI.getChildControl(self._ui.stc_bg, "StaticText_GuideName")
  self._ui.edit_Input = UI.getChildControl(self._ui.stc_bg, "Edit_ItemName")
  self._ui.stc_KeyGuide_X = UI.getChildControl(self._ui.edit_Input, "Static_X_ConsoleUI")
  self._ui.txt_Desc = UI.getChildControl(self._ui.stc_bg, "StaticText_Content")
  self._ui.multilRetry = UI.getChildControl(self._ui.stc_bg, "MultilineText_Retry")
  self._ui.multilAlert = UI.getChildControl(self._ui.stc_bg, "MultilineText_Alert")
  self._ui.txtAlert = UI.getChildControl(self._ui.stc_bg, "StaticText_Alert")
  self._ui.btn_Apply = UI.getChildControl(Panel_Window_MessageBox_Edit_All, "Button_Apply")
  self._ui.btn_Cancel = UI.getChildControl(Panel_Window_MessageBox_Edit_All, "Button_Cancel")
  self._ui.btn_Close = UI.getChildControl(Panel_Window_MessageBox_Edit_All, "Button_Close")
  self._ui.stc_Bottom_KeyGuide = UI.getChildControl(Panel_Window_MessageBox_Edit_All, "Static_BottomBg_ConsoleUI")
  self._ui.stc_KeyGuide_A = UI.getChildControl(self._ui.stc_Bottom_KeyGuide, "StaticText_A_ConsoleUI")
  self._ui.stc_KeyGuide_B = UI.getChildControl(self._ui.stc_Bottom_KeyGuide, "StaticText_B_ConsoleUI")
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._oriPanelSizeY = Panel_Window_MessageBox_Edit_All:GetSizeY()
  self._oriPanelSizeX = Panel_Window_MessageBox_Edit_All:GetSizeX()
  self._ui.multilRetry:SetText(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoIsNotMatchString"))
  self._ui.multilAlert:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txtAlert:SetTextMode(__eTextMode_AutoWrap)
  PaGlobal_MessageBox_Edit_All:validate()
  PaGlobal_MessageBox_Edit_All:SwitchUI(self._isConsole)
  PaGlobal_MessageBox_Edit_All:registerEvent(self._isConsole)
end
function PaGlobal_MessageBox_Edit_All:SwitchUI(isConsole)
  self._ui.btn_Apply:SetShow(not isConsole)
  self._ui.btn_Cancel:SetShow(not isConsole)
  self._ui.btn_Close:SetShow(not isConsole)
  self._ui.stc_KeyGuide_A:SetShow(isConsole)
  self._ui.stc_KeyGuide_B:SetShow(isConsole)
  self._ui.stc_KeyGuide_X:SetShow(isConsole)
  self._ui.stc_Bottom_KeyGuide:SetShow(isConsole)
  self._ui.multilRetry:SetShow(false)
  if true == isConsole then
    PaGlobal_MessageBox_Edit_All:padKeyAlign()
  end
end
function PaGlobal_MessageBox_Edit_All:reset()
  self._ui.confirm_name:SetText("")
  self._ui.edit_Input:SetText("")
  self._ui.txt_Desc:SetText("")
  self._ui.multilAlert:SetText("")
  self._ui.txtAlert:SetText("")
  self._ui.txt_Desc:SetSize(self._oriPanelSizeX - self._varyDescTextControlSizeX, self._oriPanelSizeY)
  self._ui.multilAlert:SetSize(self._oriPanelSizeX - self._varyBottomDescTextControlSizeX, self._oriPanelSizeY)
  self._ui.txtAlert:SetSize(self._oriPanelSizeX - self._varyBottomDescTextControlSizeX, self._oriPanelSizeY)
  self._ui.stc_bg:SetSize(self._oriPanelSizeX + self._addPanelSizeX, self._oriPanelSizeY)
  Panel_Window_MessageBox_Edit_All:SetSize(self._oriPanelSizeX + self._addPanelSizeX, self._oriPanelSizeY)
end
function PaGlobal_MessageBox_Edit_All:padKeyAlign()
  self._ui.stc_Bottom_KeyGuide:SetSize(Panel_Window_MessageBox_Edit_All:GetSizeX(), self._ui.stc_Bottom_KeyGuide:GetSizeY())
  self._ui.stc_Bottom_KeyGuide:ComputePos()
  local tempBtnGroup = {
    self._ui.stc_KeyGuide_A,
    self._ui.stc_KeyGuide_B
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(tempBtnGroup, self._ui.stc_Bottom_KeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_MessageBox_Edit_All:registerEvent(isConsole)
  Panel_Window_MessageBox_Edit_All:ignorePadSnapMoveToOtherPanel()
  registerEvent("onScreenResize", "PaGlobalFunc_MessageBox_Edit_All_BlockBGResize()")
  if true == isConsole then
    Panel_Window_MessageBox_Edit_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_MessageBox_Edit_All_ClearEdit()")
    Panel_Window_MessageBox_Edit_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_MessageBox_Edit_All_isValidateText()")
    self._ui.edit_Input:setXboxVirtualKeyBoardEndEvent("HandleEventKeyBoard_MessageBox_Edit_All")
  else
    self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_MessageBox_Edit_All_Close()")
    self._ui.btn_Cancel:addInputEvent("Mouse_LUp", "PaGlobalFunc_MessageBox_Edit_All_Close()")
    self._ui.edit_Input:addInputEvent("Mouse_LUp", "HandleEventLUp_MessageBox_Edit_All_ClearEdit()")
    self._ui.edit_Input:RegistReturnKeyEvent("HandleEventLUp_MessageBox_Edit_All_isValidateTextReturnKey()")
    self._ui.btn_Apply:addInputEvent("Mouse_LUp", "HandleEventLUp_MessageBox_Edit_All_isValidateText()")
  end
end
function PaGlobalFunc_MessageBox_Edit_All_Open(msgData)
  if nil == Panel_Window_MessageBox_Edit_All or true == Panel_Window_MessageBox_Edit_All:GetShow() then
    return
  end
  local self = PaGlobal_MessageBox_Edit_All
  if msgData.addPanelSizeX == nil then
    msgData.addPanelSizeX = 0
  end
  self._addPanelSizeX = msgData.addPanelSizeX
  if msgData.isUseBottomTextMultiline == nil then
    msgData.isUseBottomTextMultiline = false
  end
  self._isUseBottomTextMultiline = msgData.isUseBottomTextMultiline
  self._ui.multilAlert:SetShow(self._isUseBottomTextMultiline == true)
  self._ui.txtAlert:SetShow(self._isUseBottomTextMultiline == false)
  if msgData.varyDescTextControlSizeX == nil then
    msgData.varyDescTextControlSizeX = 0
  end
  self._varyDescTextControlSizeX = math.max(0, msgData.varyDescTextControlSizeX)
  if msgData.varyBottomDescTextControlSizeX == nil then
    msgData.varyBottomDescTextControlSizeX = 0
  end
  self._varyBottomDescTextControlSizeX = math.max(0, msgData.varyBottomDescTextControlSizeX)
  self._ui.confirm_name:SetSize(300, 40)
  self._ui.edit_Input:SetSize(300, 40)
  if msgData.isLongEditCheck == 177 or msgData.isLongEditCheck == 238 then
    self._ui.edit_Input:SetSize(420, 40)
    self._ui.confirm_name:SetSize(420, 40)
    self._ui.edit_Input:ComputePos()
    self._ui.confirm_name:ComputePos()
  end
  PaGlobal_MessageBox_Edit_All:reset()
  self._ui.confirm_name:SetText(msgData.confirmText)
  self._ui.edit_Input:SetText("")
  self._ui.txt_Desc:SetText(msgData.desc)
  self._ui.multilAlert:SetText(msgData.bottomRedDesc)
  self._ui.txtAlert:SetText(msgData.bottomRedDesc)
  if msgData.isInputEndUseKey == nil then
    msgData.isInputEndUseKey = false
  end
  self._isInputEndUseKey = msgData.isInputEndUseKey
  if msgData.isBlockBgShow == nil then
    msgData.isBlockBgShow = false
  end
  if msgData.functionYes ~= nil then
    self._functionYes = msgData.functionYes
  end
  if msgData.functionNo ~= nil then
    self._functionNo = msgData.functionNo
  end
  self._ui.stc_blockBg:SetShow(msgData.isBlockBgShow)
  PaGlobalFunc_MessageBox_Edit_All_RetryResize(false)
  PaGlobal_MessageBox_Edit_All_ReAlign()
  ClearFocusEdit()
  Panel_Window_MessageBox_Edit_All:SetShow(true)
  ToClient_padSnapSetTargetPanel(Panel_Window_MessageBox_Edit_All)
end
function PaGlobalFunc_MessageBox_Edit_All_Close()
  if nil == Panel_Window_MessageBox_Edit_All or false == Panel_Window_MessageBox_Edit_All:GetShow() then
    return
  end
  if PaGlobal_MessageBox_Edit_All._functionNo ~= nil then
    PaGlobal_MessageBox_Edit_All._functionNo()
  end
  Panel_Window_MessageBox_Edit_All:SetShow(false)
end
function PaGlobalFunc_MessageBox_Edit_All_BlockBGResize()
  if nil ~= Panel_Window_MessageBox_Edit_All or false == Panel_Window_MessageBox_Edit_All:GetShow() then
    return
  end
  PaGlobal_MessageBox_Edit_All._ui.stc_blockBg:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_Window_MessageBox_Edit_All:ComputePosAllChild()
end
function PaGlobal_MessageBox_Edit_All_ReAlign()
  local self = PaGlobal_MessageBox_Edit_All
  local copyOriPanelSizeX = self._oriPanelSizeX + self._addPanelSizeX
  local copyVaryDescTextControlSizeX = self._oriPanelSizeX - self._varyDescTextControlSizeX
  local copyVaryBottomTextControlSizeX = self._oriPanelSizeX - self._varyBottomDescTextControlSizeX
  local prevSizeY = 0
  local gap = 15
  local totalGap = 0
  local padding = 20
  local retrySize = 0
  local titleBarSize = self._ui.txt_Title:GetSizeY()
  self._ui.txt_Desc:SetText(self._ui.txt_Desc:GetText())
  self._ui.multilAlert:SetText(self._ui.multilAlert:GetText())
  self._ui.txtAlert:SetText(self._ui.txtAlert:GetText())
  self._ui.txt_Desc:SetSize(copyVaryDescTextControlSizeX, self._ui.txt_Desc:GetTextSizeY())
  self._ui.multilAlert:SetSize(copyVaryBottomTextControlSizeX, self._ui.multilAlert:GetTextSizeY())
  self._ui.txtAlert:SetSize(copyVaryBottomTextControlSizeX, self._ui.txtAlert:GetTextSizeY())
  prevSizeY = self._ui.txt_Desc:GetPosY() + self._ui.txt_Desc:GetTextSizeY() + gap
  totalGap = totalGap + gap + gap
  self._ui.confirm_name:SetSpanSize(self._ui.confirm_name:GetSpanSize().x, prevSizeY)
  self._ui.edit_Input:SetSpanSize(self._ui.edit_Input:GetSpanSize().x, prevSizeY)
  if self._ui.multilRetry:GetShow() == true then
    self._ui.multilRetry:SetSpanSize(self._ui.multilRetry:GetSpanSize().x, self._ui.edit_Input:GetPosY() + self._ui.edit_Input:GetSizeY() + gap)
    prevSizeY = self._ui.multilRetry:GetPosY() + self._ui.multilRetry:GetSizeY() + gap
    retrySize = self._ui.multilRetry:GetSizeY() + gap
    totalGap = totalGap + gap + gap
  else
    prevSizeY = self._ui.edit_Input:GetPosY() + self._ui.edit_Input:GetSizeY() + gap
    totalGap = totalGap + gap
  end
  self._ui.multilAlert:SetSpanSize(self._ui.multilAlert:GetSpanSize().x, prevSizeY)
  self._ui.txtAlert:SetSpanSize(self._ui.txtAlert:GetSpanSize().x, prevSizeY)
  local bgTotalSizeY = self._ui.txt_Desc:GetTextSizeY() + self._ui.edit_Input:GetTextSizeY() + self._ui.txtAlert:GetTextSizeY() + totalGap + gap
  if self._ui.multilAlert:GetShow() == true then
    bgTotalSizeY = self._ui.txt_Desc:GetTextSizeY() + self._ui.edit_Input:GetTextSizeY() + self._ui.multilAlert:GetTextSizeY() + totalGap + gap
  end
  if self._isConsole == true then
    bgTotalSizeY = bgTotalSizeY + self._ui.btn_Apply:GetSizeY() + retrySize + padding
  else
    bgTotalSizeY = bgTotalSizeY + self._ui.btn_Apply:GetSizeY() + padding
  end
  self._ui.stc_bg:SetSize(copyOriPanelSizeX, bgTotalSizeY)
  local panelTotalSizeY = bgTotalSizeY + titleBarSize
  if self._isConsole == true then
    panelTotalSizeY = panelTotalSizeY + padding
  else
    panelTotalSizeY = panelTotalSizeY + self._ui.btn_Apply:GetSizeY() + padding + 5
  end
  Panel_Window_MessageBox_Edit_All:SetSize(copyOriPanelSizeX, panelTotalSizeY)
  Panel_Window_MessageBox_Edit_All:ComputePosAllChild()
  if self._isConsole == true then
    PaGlobal_MessageBox_Edit_All:padKeyAlign()
  else
    self._ui.btn_Apply:ComputePos()
    self._ui.btn_Cancel:ComputePos()
  end
end
function PaGlobalFunc_MessageBox_Edit_All_RetryResize(isShow)
  local self = PaGlobal_MessageBox_Edit_All
  if self._isConsole == false then
    return false
  end
  self._ui.multilRetry:SetShow(isShow)
end
function HandleEventLUp_MessageBox_Edit_All_ClearEdit()
  PaGlobal_MessageBox_Edit_All._ui.edit_Input:SetEditText("", true)
  SetFocusEdit(PaGlobal_MessageBox_Edit_All._ui.edit_Input)
  PaGlobalFunc_MessageBox_Edit_All_RetryResize(false)
  PaGlobal_MessageBox_Edit_All_ReAlign()
end
function HandleEventLUp_MessageBox_Edit_All_isValidateTextReturnKey()
  if PaGlobal_MessageBox_Edit_All._isInputEndUseKey == false then
    return
  end
  HandleEventLUp_MessageBox_Edit_All_isValidateText()
end
function HandleEventLUp_MessageBox_Edit_All_isValidateText()
  local userInput = PaGlobal_MessageBox_Edit_All._ui.edit_Input:GetEditText()
  ClearFocusEdit()
  if userInput == "" then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoIsNotMatchString"))
    if PaGlobal_MessageBox_Edit_All._isConsole == true then
      PaGlobal_MessageBox_Edit_All._ui.multilRetry:SetText(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoIsNotMatchString"))
      PaGlobalFunc_MessageBox_Edit_All_RetryResize(true)
      PaGlobal_MessageBox_Edit_All_ReAlign()
    end
    return
  end
  if userInput ~= PaGlobal_MessageBox_Edit_All._ui.confirm_name:GetText() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoIsNotMatchString"))
    if PaGlobal_MessageBox_Edit_All._isConsole == true then
      PaGlobal_MessageBox_Edit_All._ui.multilRetry:SetText(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoIsNotMatchString"))
      PaGlobalFunc_MessageBox_Edit_All_RetryResize(true)
      PaGlobal_MessageBox_Edit_All_ReAlign()
    end
    return
  else
    PaGlobal_MessageBox_Edit_All._functionYes()
  end
  PaGlobal_MessageBox_Edit_All._ui.edit_Input:SetEditText("")
  PaGlobalFunc_MessageBox_Edit_All_Close()
end
function PaGlobalFunc_MessageBox_Edit_All_PressKey()
  return
end
function HandleEventKeyBoard_MessageBox_Edit_All(str)
  PaGlobal_MessageBox_Edit_All._ui.edit_Input:SetEditText(str)
  ClearFocusEdit()
end
function PaGlobalFunc_MessageBox_Edit_All_Input_SetFocus()
  if PaGlobal_MessageBox_Edit_All._isConsole == false then
    PaGlobal_MessageBox_Edit_All._ui.edit_Input:SetEditText("")
  else
    PaGlobal_MessageBox_Edit_All._ui.edit_Input:SetText("")
  end
  PaGlobalFunc_MessageBox_Edit_All_RetryResize(false)
  PaGlobal_MessageBox_Edit_All_ReAlign()
  SetFocusEdit(PaGlobal_MessageBox_Edit_All._ui.edit_Input)
end
function PaGlobalFunc_MessageBox_Edit_All_CheckUiEdit(uiEdit)
  if PaGlobal_MessageBox_Edit_All._isConsole == false then
    return false
  end
  if false == Panel_Window_MessageBox_Edit_All:GetShow() then
    return false
  end
  if uiEdit:GetKey() == PaGlobal_MessageBox_Edit_All._ui.edit_Input:GetKey() then
    return true
  end
  return false
end
function PaGlobal_MessageBox_Edit_All:validate()
  if true == PaGlobal_MessageBox_Edit_All._initilize then
    return
  end
  self._ui.stc_blockBg:isValidate()
  self._ui.stc_bg:isValidate()
  self._ui.btn_Apply:isValidate()
  self._ui.btn_Cancel:isValidate()
  self._ui.btn_Close:isValidate()
  self._ui.txt_Desc:isValidate()
  self._ui.edit_Input:isValidate()
  self._ui.stc_KeyGuide_X:isValidate()
  self._ui.stc_Bottom_KeyGuide:isValidate()
  self._ui.stc_KeyGuide_A:isValidate()
  self._ui.stc_KeyGuide_B:isValidate()
  self._ui.multilRetry:isValidate()
  self._initilize = true
end
