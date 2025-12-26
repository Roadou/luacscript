PaGlobal_Chat_Process = {
  _ui = {
    _edit = nil,
    _editCover = nil,
    _arr_stc_Recent = {},
    _arr_stc_Macro = {},
    _chk_close = nil,
    _chk_popUp = nil
  },
  _currentRecentIndex = nil,
  _MAXCOUNT = 9,
  _initialize = false
}
if true == isRealServiceMode() then
  registerEvent("FromClient_luaLoadComplete", "FromClient_Panel_Chat_Process_All")
end
function FromClient_Panel_Chat_Process_All()
  if true == isRealServiceMode() then
    PaGlobal_Chat_Process:initialize()
  end
end
function PaGlobal_Chat_Process:initialize()
  self._ui._edit = UI.getChildControl(Panel_Chat_Process_All, "Edit_Process")
  self._ui._edit:SetMaxInput(1000)
  self._ui._edit:SetMaxEditLine(20)
  if _ContentsGroup_RenewUI == true then
    self._ui._edit:setXboxVirtualKeyBoardEndEvent("PaGlobalFunc_Chat_Process_EnterFunc_Console")
  end
  local recentBG = UI.getChildControl(Panel_Chat_Process_All, "Recent")
  for ii = 0, self._MAXCOUNT do
    self._ui._arr_stc_Recent[ii] = UI.getChildControl(recentBG, "Recent_" .. tostring(ii))
    self._ui._arr_stc_Recent[ii]:addInputEvent("Mouse_LUp", "PaGlobalFunc_Chat_Process_ClickRecent(" .. ii .. ")")
  end
  local macroBG = UI.getChildControl(Panel_Chat_Process_All, "Macro")
  for ii = 0, self._MAXCOUNT do
    self._ui._arr_stc_Macro[ii] = UI.getChildControl(macroBG, "Edit_" .. tostring(ii))
    self._ui._arr_stc_Macro[ii]:RegistReturnKeyEvent("PaGlobalFunc_Chat_Process_EnterFuncMacro(" .. tostring(ii) .. ")")
    self._ui._arr_stc_Macro[ii]:registerPadEvent(__eConsoleUIPadEvent_Y, "PaGlobalFunc_Chat_Process_ClickMacro(" .. ii .. ")")
  end
  local titleArea = UI.getChildControl(Panel_Chat_Process_All, "Static_TitleArea_Import")
  self._ui._chk_popUp = UI.getChildControl(titleArea, "CheckButton_PopUp")
  self._ui._chk_close = UI.getChildControl(titleArea, "Button_Close")
  self._ui._chk_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_Chat_Process_Close()")
  self._ui._chk_popUp:addInputEvent("Mouse_LUp", "PaGlobal_Chat_Process_PopUp()")
  self._ui._editCover = UI.getChildControl(Panel_Chat_Process_All, "MultilineEdit_CoverBox")
  self._ui._editCover:addInputEvent("Mouse_LUp", "PaGlobal_Chat_Process_SetFocusEdit()")
  self:validate()
  Panel_Chat_Process_All:registerPadEvent(__eConsoleUIPadEvent_X, "PaGlobal_Chat_Process_SetFocusEdit()")
  Panel_Chat_Process_All:registerPadEvent(__eConsoleUIPadEvent_RT, "PaGlobalFunc_Chat_Process_EnterFunc()")
  registerEvent("FromClient_OpenChatProcess", "FromClient_OpenChatProcess")
  registerEvent("FromClient_UpdateRecentChatProcessMsg", "FromClient_UpdateRecentChatProcessMsg")
  registerEvent("FromClient_MacroExecutedByHomeKey", "FromClient_MacroExecutedByHomeKey")
  self._initialize = true
end
function PaGlobal_Chat_Process:open()
  Panel_Chat_Process_All:SetShow(true)
end
function PaGlobal_Chat_Process:prepareOpen()
  if ToClient_SelfPlayerIsGM() == false then
    return
  end
  self._ui._edit:SetEditText("")
  for ii = 0, self._MAXCOUNT do
    local recentStr = ToClient_GetRecentInputChatProcess(ii)
    if recentStr == nil then
      self._ui._arr_stc_Recent[ii]:SetText("")
    else
      self._ui._arr_stc_Recent[ii]:SetText(recentStr)
      UI.setLimitTextAndAddTooltip(self._ui._arr_stc_Recent[ii], recentStr)
    end
    local macroStr = ToClient_GetChatProcessMacro(ii)
    if macroStr == nil then
      self._ui._arr_stc_Macro[ii]:SetText("")
    else
      self._ui._arr_stc_Macro[ii]:SetEditText(macroStr)
      UI.setLimitTextAndAddTooltip(self._ui._arr_stc_Macro[ii], macroStr)
    end
  end
  self._currentRecentIndex = -1
  for ii = 0, self._MAXCOUNT do
    self._ui._arr_stc_Recent[ii]:SetFontColor(Defines.Color.C_FFFFFFFF)
  end
  self:open()
  SetFocusEdit(self._ui._edit)
end
function PaGlobal_Chat_Process:close()
  Panel_Chat_Process_All:SetShow(false)
end
function PaGlobal_Chat_Process:prepareClose()
  for ii = 0, self._MAXCOUNT do
    ToClient_SetChatProcessMacro(ii, self._ui._arr_stc_Macro[ii]:GetEditText())
  end
  if Panel_Chat_Process_All:IsUISubApp() == true then
    Panel_Chat_Process_All:CloseUISubApp()
  end
  self:close()
end
function PaGlobal_Chat_Process:validate()
end
function PaGlobal_Chat_Process:setRecentString(index)
  if index < -1 then
    return
  end
  local length = 0
  for ii = 0, self._MAXCOUNT do
    if self._ui._arr_stc_Recent[ii]:GetText() ~= "" then
      length = length + 1
    end
  end
  if length == 0 then
    return
  end
  self._currentRecentIndex = index % length
  local recentString = self:removeTimeline(self._ui._arr_stc_Recent[self._currentRecentIndex]:GetText())
  self._ui._edit:SetEditText(recentString)
  for ii = 0, self._MAXCOUNT do
    self._ui._arr_stc_Recent[ii]:SetFontColor(Defines.Color.C_FFFFFFFF)
  end
  self._ui._arr_stc_Recent[self._currentRecentIndex]:SetFontColor(Defines.Color.C_FFF5BA3A)
end
function PaGlobal_Chat_Process:removeTimeline(string)
  return string.match(string, ".*%("):sub(1, -3)
end
function PaGlobalFunc_Chat_Process_Open()
  if PaGlobal_Chat_Process == nil then
    return
  end
  PaGlobal_Chat_Process:prepareOpen()
end
function PaGlobalFunc_Chat_Process_Close()
  if PaGlobal_Chat_Process == nil then
    return
  end
  PaGlobal_Chat_Process:prepareClose()
end
function PaGlobalFunc_Chat_Process_EnterFunc_Console(str)
  if PaGlobal_Chat_Process == nil then
    return
  end
  local self = PaGlobal_Chat_Process
  self._ui._edit:SetEditText(str)
  ClearFocusEdit()
end
function PaGlobalFunc_Chat_Process_EnterFunc()
  if PaGlobal_Chat_Process == nil then
    return
  end
  local self = PaGlobal_Chat_Process
  local inputText = self._ui._edit:GetEditText()
  inputText = string.gsub(inputText, [[

([^/])]], "%1")
  if inputText:sub(-1) == "\n" then
    inputText = inputText:sub(1, -2)
  end
  ToClient_ChatProcess(inputText)
  self._ui._edit:SetEditText("")
end
function PaGlobalFunc_Chat_Process_EnterFuncMacro(ii)
  local self = PaGlobal_Chat_Process
  if self._ui._arr_stc_Macro == nil or self._ui._arr_stc_Macro[ii] == nil then
    return
  end
  local inputText = self._ui._arr_stc_Macro[ii]:GetEditText()
  ToClient_SetChatProcessMacro(ii, self._ui._arr_stc_Macro[ii]:GetEditText())
  ClearFocusEdit()
end
function FromClient_OpenChatProcess()
  local self = PaGlobal_Chat_Process
  if Panel_Chat_Process_All == nil or Panel_Chatting_Input == nil then
    return
  end
  if Panel_Chatting_Input:GetShow() == true then
    return
  end
  if Panel_Chat_Process_All:GetShow() == true then
    if GetFocusEdit() == nil then
      SetFocusEdit(self._ui._edit)
    elseif false == isRealServiceMode() then
      QASupport_AutomationPanel_Open()
    end
    return
  end
  PaGlobalFunc_Chat_Process_Open()
end
function PaGlobalFunc_Chat_Process_ClickRecent(ii)
  if PaGlobal_Chat_Process == nil then
    return
  end
  local self = PaGlobal_Chat_Process
  local str = self._ui._arr_stc_Recent[ii]:GetText()
  if str == nil or str == "" then
    return
  end
  str = self:removeTimeline(str)
  self._ui._edit:SetEditText(str)
  SetFocusEdit(self._ui._edit)
  self:setRecentString(ii)
end
function PaGlobalFunc_Chat_Process_ClickMacro(ii)
  if PaGlobal_Chat_Process == nil then
    return
  end
  local self = PaGlobal_Chat_Process
  local str = self._ui._arr_stc_Macro[ii]:GetText()
  if str == nil or str == "" then
    return
  end
  self._ui._edit:SetEditText(str)
  SetFocusEdit(self._ui._edit)
end
function FromClient_UpdateRecentChatProcessMsg()
  if Panel_Chat_Process_All == nil then
    return
  end
  if Panel_Chat_Process_All:GetShow() == false then
    return
  end
  local self = PaGlobal_Chat_Process
  for ii = 0, self._MAXCOUNT do
    local recentStr = ToClient_GetRecentInputChatProcess(ii)
    if recentStr == nil then
      self._ui._arr_stc_Recent[ii]:SetText("")
    else
      self._ui._arr_stc_Recent[ii]:SetText(recentStr)
      UI.setLimitTextAndAddTooltip(self._ui._arr_stc_Recent[ii], recentStr)
    end
  end
  self._currentRecentIndex = -1
  for ii = 0, self._MAXCOUNT do
    self._ui._arr_stc_Recent[ii]:SetFontColor(Defines.Color.C_FFFFFFFF)
  end
end
function PaGlobal_Chat_Process_UseMacro(index)
  if Panel_Chat_Process_All == nil then
    return
  end
  local str = ToClient_GetChatProcessMacro(index)
  if str == nil then
    return
  end
  ToClient_ChatProcess(str)
end
function PaGlobal_Chat_Process_PopUp()
  if Panel_Chat_Process_All == nil then
    return
  end
  if Panel_Chat_Process_All:GetShow() == false then
    return
  end
  if Panel_Chat_Process_All:IsUISubApp() == false then
    Panel_Chat_Process_All:OpenUISubApp()
  else
    Panel_Chat_Process_All:CloseUISubApp()
  end
end
function PaGlobal_Chat_Process_SetFocusEdit()
  if Panel_Chat_Process_All == nil then
    return
  end
  if Panel_Chat_Process_All:GetShow() == false then
    return
  end
  SetFocusEdit(PaGlobal_Chat_Process._ui._edit)
end
function PaGlobal_Chat_Process_PressArrowUp()
  if Panel_Chat_Process_All == nil then
    return
  end
  PaGlobal_Chat_Process:setRecentString(PaGlobal_Chat_Process._currentRecentIndex + 1)
end
function PaGlobal_Chat_Process_PressArrowDown()
  if Panel_Chat_Process_All == nil then
    return
  end
  PaGlobal_Chat_Process:setRecentString(PaGlobal_Chat_Process._currentRecentIndex - 1)
end
function PaGlobal_Chat_Process_CheckCurrentUiEdit(targetUI)
  return nil ~= targetUI and PaGlobal_Chat_Process._ui._edit ~= nil and targetUI:GetKey() == PaGlobal_Chat_Process._ui._edit:GetKey()
end
