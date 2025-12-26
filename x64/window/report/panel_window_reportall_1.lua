function PaGlobal_ReportAll:initialize()
  if true == PaGlobal_ReportAll._initialize then
    return
  end
  PaGlobal_ReportAll._ui._stc_Title = UI.getChildControl(Panel_Window_Report_All, "Static_TitleBg")
  PaGlobal_ReportAll._ui._btn_Close = UI.getChildControl(PaGlobal_ReportAll._ui._stc_Title, "Button_Close")
  PaGlobal_ReportAll._ui._stc_Main = UI.getChildControl(Panel_Window_Report_All, "Static_Main")
  PaGlobal_ReportAll._ui._stc_ContentTitle = UI.getChildControl(PaGlobal_ReportAll._ui._stc_Main, "StaticText_ContentTitle")
  PaGlobal_ReportAll._ui._stc_ContentTitle:SetTextMode(__eTextMode_AutoWrap)
  PaGlobal_ReportAll._ui._stc_ContentTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPORT_CONTENTTITLE"))
  PaGlobal_ReportAll._ui._rdo_Classifys[1] = UI.getChildControl(PaGlobal_ReportAll._ui._stc_Main, "RadioButton_1")
  local posY = PaGlobal_ReportAll._ui._rdo_Classifys[1]:GetPosY()
  local posX1 = PaGlobal_ReportAll._ui._rdo_Classifys[1]:GetPosX()
  local posX2 = PaGlobal_ReportAll._ui._rdo_Classifys[1]:GetPosX() + PaGlobal_ReportAll._ui._rdo_Classifys[1]:GetSizeX() + 3
  PaGlobal_ReportAll._ui._rdo_Classifys[1]:SetShow(false)
  for recordIndex = 2, self._value.classifyCount do
    PaGlobal_ReportAll._ui._rdo_Classifys[recordIndex] = UI.cloneControl(PaGlobal_ReportAll._ui._rdo_Classifys[1], PaGlobal_ReportAll._ui._stc_Main, "RadioButton_" .. recordIndex)
    if 1 == recordIndex % 2 then
      posY = posY + PaGlobal_ReportAll._ui._rdo_Classifys[1]:GetSizeY() + 2
      PaGlobal_ReportAll._ui._rdo_Classifys[recordIndex]:SetPosX(posX1)
    else
      PaGlobal_ReportAll._ui._rdo_Classifys[recordIndex]:SetPosX(posX2)
    end
    PaGlobal_ReportAll._ui._rdo_Classifys[recordIndex]:SetPosY(posY)
    PaGlobal_ReportAll._ui._rdo_Classifys[recordIndex]:SetShow(false)
    ToClient_padSnapRefreshTarget(PaGlobal_ReportAll._ui._rdo_Classifys[recordIndex])
  end
  PaGlobal_ReportAll._ui._btn_Confirm = UI.getChildControl(PaGlobal_ReportAll._ui._stc_Main, "Button_Report")
  PaGlobal_ReportAll._ui._btn_Cancle = UI.getChildControl(PaGlobal_ReportAll._ui._stc_Main, "Button_Cancel")
  PaGlobal_ReportAll._ui._stc_Line = UI.getChildControl(PaGlobal_ReportAll._ui._stc_Main, "Static_Line")
  PaGlobal_ReportAll._ui._stc_NoTarget = UI.getChildControl(PaGlobal_ReportAll._ui._stc_Main, "StaticText_NoTarget")
  PaGlobal_ReportAll._ui._btn_Close:SetShow(not _ContentsGroup_UsePadSnapping)
  self._ui._stc_ReportType = UI.getChildControl(Panel_Window_Report_All, "Static_SelectReportType")
  self._ui._rdo_ReportType[1] = UI.getChildControl(self._ui._stc_ReportType, "RadioButton_Bug")
  self._ui._rdo_ReportType[2] = UI.getChildControl(self._ui._stc_ReportType, "RadioButton_Macro")
  self._ui._rdo_ReportType[3] = UI.getChildControl(self._ui._stc_ReportType, "RadioButton_Program")
  self._ui._rdo_ReportType[4] = UI.getChildControl(self._ui._stc_ReportType, "RadioButton_Name")
  self._ui._rdo_ReportType[5] = UI.getChildControl(self._ui._stc_ReportType, "RadioButton_Etc")
  self._reportType[1] = __eReasonGameBug
  self._reportType[2] = __eReasonMacroScript
  self._reportType[3] = __eReasonHackProgram
  self._reportType[4] = __eReasonCharacterName
  self._reportType[5] = __eReasonUserEtc
  self._selectedReportType = 0
  self._ui._stc_ReportWrite = UI.getChildControl(Panel_Window_Report_All, "Static_ReportWrite")
  self._ui._edit_reportWrite_multilineEditCover = UI.getChildControl(self._ui._stc_ReportWrite, "MultilineEdit_CoverBox")
  self._ui._edit_reportWrite_multilineEdit = UI.getChildControl(self._ui._stc_ReportWrite, "MultilineEdit_ReportWrite")
  self._ui._edit_reportWrite_multilineEdit:SetMaxInput(self._MAX_REPORTDESCRIPTION_COUNT)
  self._ui._edit_reportWrite_multilineEdit:SetMaxEditLine(8)
  local consoleKeyGuideX = UI.getChildControl(self._ui._stc_ReportWrite, "Static_Console_KeyGuide_X")
  consoleKeyGuideX:SetShow(false)
  if _ContentsGroup_UsePadSnapping == true then
    consoleKeyGuideX:SetShow(true)
  end
  PaGlobal_ReportAll:registEventHandler()
  PaGlobal_ReportAll._initialize = true
end
function PaGlobal_ReportAll:registEventHandler()
  if nil == Panel_Window_Report_All then
    return
  end
  for i = 1, PaGlobal_ReportAll._value.classifyCount do
    PaGlobal_ReportAll._ui._rdo_Classifys[i]:addInputEvent("Mouse_LUp", "HandleEventLUp_ReportAll_SelectClassify(" .. i .. ")")
  end
  PaGlobal_ReportAll._ui._btn_Confirm:addInputEvent("Mouse_LUp", "HandleEventLUp_ReportAll_ReportingConfirm()")
  PaGlobal_ReportAll._ui._btn_Cancle:addInputEvent("Mouse_LUp", "PaGloabl_ReportAll_Close()")
  PaGlobal_ReportAll._ui._btn_Close:addInputEvent("Mouse_LUp", "PaGloabl_ReportAll_Close()")
  for i = 1, #self._ui._rdo_ReportType do
    local radioButtonText = UI.getChildControl(self._ui._rdo_ReportType[i], "StaticText_1")
    UI.setLimitTextAndAddTooltip(radioButtonText, radioButtonText:GetText(), "")
    self._ui._rdo_ReportType[i]:addInputEvent("Mouse_LUp", "PaGlobal_ReportAll_SelectReportType(" .. i .. ")")
    radioButtonText:addInputEvent("Mouse_LUp", "PaGlobal_ReportAll_SelectReportType(" .. i .. ")")
  end
  if _ContentsGroup_UsePadSnapping == true then
    self._ui._edit_reportWrite_multilineEdit:setXboxVirtualKeyBoardEndEvent("HandleEventKey_Chat_Report_OnVirtualKeyboardEnd")
    Panel_Window_Report_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_ReportAll_SetFocusEdit()")
  end
  self._ui._edit_reportWrite_multilineEditCover:addInputEvent("Mouse_LUp", "HandleEventLUp_ReportAll_SetFocusEdit()")
  self._ui._edit_reportWrite_multilineEdit:RegistAllKeyEvent("PaGlobal_ReportAll_EditBoxChange()")
  registerEvent("FromClient_NagtiveUserReport", "FromClient_NagtiveUserReport")
  registerEvent("FromClient_OpenReportWindow", "FromClient_OpenReportAllWindow")
end
function PaGlobal_ReportAll:prepareOpen()
  if false == ToClient_IsContentsGroupOpen("1392") then
    return
  end
  if nil == Panel_Window_Report_All then
    return
  end
  PaGlobal_ReportAll._value.classify = nil
  PaGlobal_ReportAll._value.selcetedHideCharater = ""
  PaGlobal_ReportAll._ui._stc_NoTarget:SetShow(false)
  self._ui._edit_reportWrite_multilineEdit:SetEditText("")
  self._ui._edit_reportWrite_multilineEdit:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_REPORTCHAT_REPORTMEMO", "stringLength", PaGlobal_Window_Chat_Report_All._MAX_REPORTDESCRIPTION_COUNT))
  for i = 1, #self._ui._rdo_ReportType do
    self._ui._rdo_ReportType[i]:SetCheck(false)
  end
  self._selectedReportType = 0
  PaGlobal_ReportAll:open()
end
function PaGlobal_ReportAll:open()
  if false == ToClient_IsContentsGroupOpen("1392") then
    return
  end
  if nil == Panel_Window_Report_All then
    return
  end
  Panel_Window_Report_All:SetShow(true)
  PaGlobal_ReportAll:update()
end
function PaGlobal_ReportAll:update()
  if nil == Panel_Window_Report_All then
    return
  end
  local count = ToClient_GetNearestHackUserForReport()
  local linePosY = 0
  local nameLess = ToClient_namelessPVPServer() == true
  for index = 1, count do
    local userInfo = ToClient_GetNearUserInfoByIndex(index - 1)
    if nil ~= userInfo then
      local name = userInfo:getName()
      if nameLess == true then
        name = PaGlobalFunc_getAnonymousNameString(0)
      end
      local className = NewClassData.newClass_String[userInfo:getClassType()]._classType2String
      if "" == name and NewClassData.newClass_String[userInfo:getClassType()]._classType2String ~= nil then
        name = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WINDOW_REPORT_HIDEONE", "className", className)
      else
        name = name .. "(" .. className .. ")"
      end
      PaGlobal_ReportAll._ui._rdo_Classifys[index]:SetText(name)
      PaGlobal_ReportAll._ui._rdo_Classifys[index]:SetShow(true)
      linePosY = PaGlobal_ReportAll._ui._rdo_Classifys[index]:GetPosY()
    end
  end
  local buttonAreaSize = (count + 1) / 2 * PaGlobal_ReportAll._ui._rdo_Classifys[1]:GetSizeY() + 90
  if count <= 0 then
    PaGlobal_ReportAll._ui._stc_NoTarget:SetShow(true)
  end
  PaGlobal_ReportAll._ui._stc_Main:SetSize(650, buttonAreaSize)
  PaGlobal_ReportAll._ui._stc_Line:SetPosY(linePosY + PaGlobal_ReportAll._ui._rdo_Classifys[1]:GetSizeY() + 10)
  self._ui._stc_ReportType:SetShow(true)
  self._ui._stc_ReportType:SetPosY(buttonAreaSize + 80)
  self._ui._stc_ReportWrite:SetShow(true)
  self._ui._stc_ReportWrite:SetPosY(self._ui._stc_ReportType:GetPosY() + self._ui._stc_ReportType:GetSizeY() + 10)
  local reportTypeSizeY = self._ui._stc_ReportType:GetSizeY() + self._ui._stc_ReportWrite:GetSizeY() + 50
  self._ui._stc_ContentTitle:SetPosY(buttonAreaSize + reportTypeSizeY)
  local sizeY = buttonAreaSize + PaGlobal_ReportAll._ui._stc_Title:GetSizeY() + PaGlobal_ReportAll._ui._stc_ContentTitle:GetSizeY() + reportTypeSizeY + 90
  local buttonPosY = PaGlobal_ReportAll._ui._stc_ContentTitle:GetPosY() + PaGlobal_ReportAll._ui._stc_ContentTitle:GetSizeY() + 15
  PaGlobal_ReportAll._ui._btn_Confirm:SetPosY(buttonPosY)
  PaGlobal_ReportAll._ui._btn_Cancle:SetPosY(buttonPosY)
  Panel_Window_Report_All:SetSize(Panel_Window_Report_All:GetSizeX(), sizeY)
  Panel_Window_Report_All:SetPosY((getScreenSizeY() - Panel_Window_Report_All:GetSizeY()) * 0.5)
end
function PaGlobal_ReportAll:prepareClose()
  if nil == Panel_Window_Report_All then
    return
  end
  for index = 1, self._value.classifyCount do
    PaGlobal_ReportAll._ui._rdo_Classifys[index]:SetShow(false)
  end
  if nil ~= PaGlobal_ReportAll._value.classify then
    PaGlobal_ReportAll._ui._rdo_Classifys[PaGlobal_ReportAll._value.classify]:SetUnchecked()
  end
  self._ui._edit_reportWrite_multilineEdit:SetEditText("")
  self._selectedReportType = 0
  PaGlobal_ReportAll:close()
end
function PaGlobal_ReportAll:close()
  if nil == Panel_Window_Report_All then
    return
  end
  Panel_Window_Report_All:SetShow(false)
end
function PaGlobal_ReportAll:ReportingConfirm()
  if nil == Panel_Window_Report_All then
    return
  end
  if nil == PaGlobal_ReportAll._value.classify then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CASH_CUSTOMIZATION_NOSELECT"))
    return
  end
  if self._selectedReportType == 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CASH_CUSTOMIZATION_NOSELECT"))
    return
  end
  local function reportConfirmYes()
    ToClient_HackUserReport(PaGlobal_ReportAll._value.classify - 1, self._value.selcetedHideCharater, self._selectedReportType, self._ui._edit_reportWrite_multilineEdit:GetEditText())
    PaGlobal_ReportAll:prepareClose()
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPORT_TITLE"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_REPORT_MESSAGECONFIRM"),
    functionYes = reportConfirmYes,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_ReportAll:SetClassify(classify)
  if nil == Panel_Window_Report_All then
    return
  end
  PaGlobal_ReportAll._value.classify = classify
  PaGlobal_ReportAll._value.selcetedHideCharater = PaGlobal_ReportAll._ui._rdo_Classifys[classify]:GetText()
end
function PaGlobal_ReportAll:ReportingFeedBack(currentCount)
  if _ContentsOption_CH_Report == false then
    if 0 < 3 - currentCount then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_REPORT_RECEIVEREPORT") .. " " .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TRADEGAME_REMAINCOUNT", "tryCount", 2 - currentCount))
    else
      Proc_ShowMessage_Ack(PAGetStringSymNo(3038419446))
    end
  end
  local reportedName = ToClient_GetReportCharacterName()
  if ToClient_namelessPVPServer() == true then
    reportedName = PaGlobalFunc_getAnonymousNameString(0)
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_REPORT_REPORTCOMPLETE_TITLE"),
    content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_REPORT_COMPLETE_WITHNAME", "name", reportedName) .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_REPORT_COMPLETE_INFO"),
    functionApply = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_ReportAll:SetFocusEdit()
  if Panel_Window_Report_All == nil then
    return
  end
  SetFocusEdit(self._ui._edit_reportWrite_multilineEdit)
end
