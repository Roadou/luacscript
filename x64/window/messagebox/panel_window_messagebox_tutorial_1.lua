function PaGlobal_MessageBox_Tutorial:initialize()
  self:validate()
  self:registerEvent()
  self._initialize = true
end
function PaGlobal_MessageBox_Tutorial:clear()
end
function PaGlobal_MessageBox_Tutorial:prepareOpen()
  self:open()
end
function PaGlobal_MessageBox_Tutorial:open()
  if false == self._initialize then
    return
  end
  if false == _ContentsGroup_NewTutorial then
    return
  end
  local progressingWrapper = ToClient_getProgressingTutorialWrapper()
  if nil == progressingWrapper then
    return
  end
  if false == progressingWrapper:isUsePopupMsg() then
    return
  end
  local tutorialSSW = ToClient_getTutorialStaticStatusWrapper(progressingWrapper:getKey())
  if nil == tutorialSSW then
    return
  end
  self:clear()
  local txt_desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MSGBOX_TUTORIAL_DESC", "title", tutorialSSW:getTitle())
  self._ui._txt_desc:SetText(txt_desc)
  if true == progressingWrapper:isUseSkip() then
    self._ui._btn_big:SetText(PAGetString(Defines.StringSheet_RESOURCE, "MESSAGEBOX_BTN_YES"))
    self._ui._btn_big:addInputEvent("Mouse_LUp", "PaGlobal_MessageBox_Tutorial:funcYes()")
    self._ui._btn_big:SetShow(true)
    self._ui._btn_left:SetText(PAGetString(Defines.StringSheet_RESOURCE, "MESSAGEBOX_BTN_NO"))
    self._ui._btn_left:addInputEvent("Mouse_LUp", "PaGlobal_MessageBox_Tutorial:funcNo()")
    self._ui._btn_right:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_MSGBOX_TUTORIAL_SKIP"))
    self._ui._btn_right:addInputEvent("Mouse_LUp", "PaGlobal_MessageBox_Tutorial:funcSkip()")
  else
    self._ui._btn_big:SetShow(false)
    self._ui._btn_left:SetText(PAGetString(Defines.StringSheet_RESOURCE, "MESSAGEBOX_BTN_YES"))
    self._ui._btn_left:addInputEvent("Mouse_LUp", "PaGlobal_MessageBox_Tutorial:funcYes()")
    self._ui._btn_right:SetText(PAGetString(Defines.StringSheet_RESOURCE, "MESSAGEBOX_BTN_NO"))
    self._ui._btn_right:addInputEvent("Mouse_LUp", "PaGlobal_MessageBox_Tutorial:funcNo()")
  end
  Panel_Window_MessageBox_Tutorial:SetShow(true)
end
function PaGlobal_MessageBox_Tutorial:prepareClose()
  self:close()
end
function PaGlobal_MessageBox_Tutorial:close()
  Panel_Window_MessageBox_Tutorial:SetShow(false)
end
function PaGlobal_MessageBox_Tutorial:validate()
  self._ui._btn_big:isValidate()
  self._ui._btn_left:isValidate()
  self._ui._btn_right:isValidate()
  self._ui._btn_close:isValidate()
  self._ui._txt_desc:isValidate()
end
function PaGlobal_MessageBox_Tutorial:registerEvent()
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_MessageBox_Tutorial:funcNo()")
end
function PaGlobal_MessageBox_Tutorial:funcYes()
  if false == ToClient_setProgressingTutorialStopMode(false) then
    return
  end
  PaGlobal_Widget_Tutorial_GuideUI:prepareOpen()
  self:prepareClose()
end
function PaGlobal_MessageBox_Tutorial:funcNo()
  if false == ToClient_cancelProgressingTutorial() then
    return
  end
  self:prepareClose()
end
function PaGlobal_MessageBox_Tutorial:funcSkip()
  ToClient_requestCompleteTutorial()
  self:prepareClose()
end
