function PaGlobal_ChattingColor_All:initialize()
  if true == PaGlobal_ChattingColor_All._initialize or nil == Panel_Window_Chatting_Color_All then
    return
  end
  self._ui.stc_title = UI.getChildControl(Panel_Window_Chatting_Color_All, "Static_Main_Title")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_title, "Button_Close")
  self._ui.stc_mainBg = UI.getChildControl(Panel_Window_Chatting_Color_All, "Static_Bg")
  self._ui.txt_chooseDesc = UI.getChildControl(self._ui.stc_mainBg, "MultilineText_Choose_Color")
  self._ui.stc_colorBg = UI.getChildControl(self._ui.stc_mainBg, "Static_Color_Bg")
  self._ui.stc_colorTemplate = UI.getChildControl(self._ui.stc_colorBg, "Static_Color")
  self._ui.rdo_colorSelectorTemplate = UI.getChildControl(self._ui.stc_colorBg, "RadioButton_ColorSelector")
  self._ui.stc_btnBg = UI.getChildControl(Panel_Window_Chatting_Color_All, "Static_BTN_Bg")
  self._ui.btn_confirm = UI.getChildControl(self._ui.stc_btnBg, "Button_Confirm")
  self._ui.btn_cancel = UI.getChildControl(self._ui.stc_btnBg, "Button_Cancel")
  for btnIdx = 0, #self._colorList do
    local colorBox = {}
    local row = math.floor(btnIdx / self._boxsCols)
    local col = btnIdx % self._boxsCols
    colorBox.plate = UI.createAndCopyBasePropertyControl(Panel_Chatting_Color, "Static_Color", self._ui.stc_colorBg, "ChattingColor_Box_" .. btnIdx)
    colorBox.plate:SetPosX(self._boxStartX + self._boxGapX * col)
    colorBox.plate:SetPosY(self._boxStartY + self._boxGapY * row)
    colorBox.plate:SetColor(self._colorList[btnIdx])
    colorBox.colorSelector = UI.createAndCopyBasePropertyControl(Panel_Chatting_Color, "RadioButton_ColorSelector", self._ui.stc_colorBg, "ChattingColor_Selector_" .. btnIdx)
    colorBox.colorSelector:SetPosX(self._boxStartX + self._boxGapX * col)
    colorBox.colorSelector:SetPosY(self._boxStartY + self._boxGapY * row)
    colorBox.colorSelector:addInputEvent("Mouse_LUp", "HandleEventLUp_ChattingColor_All_SelectColor(" .. btnIdx .. ")")
    self._colorSelected[btnIdx] = colorBox
  end
  self._ui.stc_colorTemplate:SetShow(false)
  self._ui.rdo_colorSelectorTemplate:SetShow(false)
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_ChattingColor_All:validate()
  PaGlobal_ChattingColor_All:registEventHandler()
  PaGlobal_ChattingColor_All:swichPlatform(self._isConsole)
  PaGlobal_ChattingColor_All._initialize = true
end
function PaGlobal_ChattingColor_All:swichPlatform(isConsole)
  if true == isConsole then
  else
  end
end
function PaGlobal_ChattingColor_All:prepareOpen()
  if nil == Panel_Window_Chatting_Color_All then
    return
  end
  if nil == Panel_Window_ChatOption_All then
    return
  end
  if false == Panel_Window_ChatOption_All:GetShow() then
    return
  end
  Panel_Window_ChatOption_All:SetSpanSize(-250, 0)
  self._ui.btn_confirm:addInputEvent("Mouse_LUp", "HandleEventLUp_ChattingColor_All_ConfirmColor()")
  PaGlobalFunc_ChatOption_All_filterBgShow(true, self._buttonType, self._isSystem)
  PaGlobal_ChattingColor_All:open()
  PaGlobal_ChattingColor_All:update()
  PaGlobal_ChattingColor_All:resize()
end
function PaGlobal_ChattingColor_All:dataclear()
  self._panelIndex = nil
  self._chatType = nil
  self._buttonType = nil
  self._isSystem = nil
  self._savedColorIndex = nil
end
function PaGlobal_ChattingColor_All:open()
  if nil == Panel_Window_Chatting_Color_All then
    return
  end
  Panel_Window_Chatting_Color_All:SetShow(true)
end
function PaGlobal_ChattingColor_All:prepareClose()
  if nil == Panel_Window_Chatting_Color_All then
    return
  end
  Panel_Window_ChatOption_All:SetSpanSize(0, 0)
  self:dataclear()
  PaGlobalFunc_ChatOption_All_filterBgShow(false)
  PaGlobal_ChattingColor_All:close()
end
function PaGlobal_ChattingColor_All:close()
  if nil == Panel_Window_Chatting_Color_All then
    return
  end
  Panel_Window_Chatting_Color_All:SetShow(false)
end
function PaGlobal_ChattingColor_All:update()
  if nil == self._panelIndex or nil == self._chatType then
    return
  end
  for btnIdx = 0, #self._colorList do
    self._colorSelected[btnIdx].colorSelector:SetCheck(false)
  end
  local chatPanel = ToClient_getChattingPanel(self._panelIndex)
  local chatColorIndex = chatPanel:getChatColorIndex(self._chatType)
  local chatColorSystemIndex = chatPanel:getChatSystemColorIndex(CppEnums.ChatType.System)
  if -1 ~= chatColorIndex and CppEnums.ChatType.System ~= chatType then
    self._colorSelected[chatColorIndex].colorSelector:SetCheck(true)
  end
  if -1 ~= chatColorSystemIndex and CppEnums.ChatType.System == chatType then
    self._colorSelected[chatColorSystemIndex].colorSelector:SetCheck(true)
  end
end
function PaGlobal_ChattingColor_All:registEventHandler()
  if nil == Panel_Window_Chatting_Color_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_ChattingColor_All_Resize()")
  self._ui.btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_ChattingColor_All_Close()")
  self._ui.btn_cancel:addInputEvent("Mouse_LUp", "HandleEventLUp_ChattingColor_All_Close()")
end
function PaGlobal_ChattingColor_All:validate()
  if nil == Panel_Window_Chatting_Color_All then
    return
  end
  self._ui.stc_title:isValidate()
  self._ui.btn_close:isValidate()
  self._ui.stc_mainBg:isValidate()
  self._ui.txt_chooseDesc:isValidate()
  self._ui.stc_colorBg:isValidate()
  self._ui.stc_colorTemplate:isValidate()
  self._ui.rdo_colorSelectorTemplate:isValidate()
  self._ui.stc_btnBg:isValidate()
  self._ui.btn_confirm:isValidate()
  self._ui.btn_cancel:isValidate()
end
function PaGlobal_ChattingColor_All:resize()
  if nil == Panel_Window_Chatting_Color_All then
    return
  end
  Panel_Window_Chatting_Color_All:ComputePos()
  Panel_Window_Chatting_Color_All:SetPosX(Panel_Window_ChatOption_All:GetPosX() + Panel_Window_ChatOption_All:GetSizeX() + 5)
  Panel_Window_Chatting_Color_All:SetPosY(Panel_Window_ChatOption_All:GetPosY())
end
