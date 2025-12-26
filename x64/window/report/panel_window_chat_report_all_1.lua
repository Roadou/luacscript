function PaGlobal_Window_Chat_Report_All:initialize()
  if self._initialize == true then
    return
  end
  self._ui._stc_titleArea_import_import = UI.getChildControl(Panel_Window_Chat_Report_All, "Static_TitleArea_Import_Import")
  self._ui._stc_titleArea_import_import_txt_title = UI.getChildControl(self._ui._stc_titleArea_import_import, "StaticText_Title")
  self._ui._stc_titleArea_import_import_btn_close = UI.getChildControl(self._ui._stc_titleArea_import_import, "Button_Close")
  self._ui._stc_reportTarget = UI.getChildControl(Panel_Window_Chat_Report_All, "StaticText_ReportTarget")
  self._ui._stc_chatReportDetail = UI.getChildControl(Panel_Window_Chat_Report_All, "Static_ChatReportDetail")
  self._ui._stc_chatDetail_chatDesc = UI.getChildControl(self._ui._stc_chatReportDetail, "StaticText_Desc")
  self._ui._stc_reportWrite = UI.getChildControl(Panel_Window_Chat_Report_All, "Static_ReportWrite")
  self._ui._edit_reportWrite_multilineEdit = UI.getChildControl(self._ui._stc_reportWrite, "MultilineEdit_ReportWrite")
  self._ui._edit_reportWrite_multilineEditCover = UI.getChildControl(self._ui._stc_reportWrite, "MultilineEdit_CoverBox")
  local keyGuide_X = UI.getChildControl(self._ui._stc_reportWrite, "Static_X_ConsoleUI")
  self._ui._btn_report = UI.getChildControl(Panel_Window_Chat_Report_All, "Button_Report")
  self._ui._btn_exit = UI.getChildControl(Panel_Window_Chat_Report_All, "Button_Exit")
  self._ui._txt_reportReasonSubTitle = UI.getChildControl(Panel_Window_Chat_Report_All, "StaticText_ReportReason_SubTitle")
  self._ui._txt_characterCount = UI.getChildControl(Panel_Window_Chat_Report_All, "StaticText_CharacterCount")
  self._ui._txt_reportDesc = UI.getChildControl(Panel_Window_Chat_Report_All, "StaticText_ReportDesc")
  self._ui._stc_chatReportBottomDesc = UI.getChildControl(Panel_Window_Chat_Report_All, "Static_ChatReportBottomDesc")
  self._ui._txt_chatReportBottomDesc = UI.getChildControl(self._ui._stc_chatReportBottomDesc, "StaticText_Desc")
  self._ui._stc_keyGuide_console = UI.getChildControl(Panel_Window_Chat_Report_All, "Static_KeyGuide_ConsoleUI_Import")
  self._ui._stc_keyGuide_Y = UI.getChildControl(self._ui._stc_keyGuide_console, "StaticText_Y_ConsoleUI")
  self._ui._stc_keyGuide_console:SetShow(false)
  keyGuide_X:SetShow(false)
  if _ContentsGroup_UsePadSnapping == true then
    Panel_Window_Chat_Report_All:ignorePadSnapMoveToOtherPanel()
    self._ui._stc_keyGuide_console:ComputePos()
    self._ui._stc_keyGuide_console:SetShow(true)
    keyGuide_X:SetShow(true)
  end
  self._isConsole = ToClient_isConsole()
  if self._isConsole == true then
    self._ui._stc_titleArea_import_import_btn_close:SetShow(false)
    self._MAX_REPORTDESCRIPTION_COUNT = 100
  end
  self._ui._stc_chatDetail_chatDesc:SetTextMode(__eTextMode_Limit_AutoWrap)
  self._ui._stc_chatDetail_chatDesc:setLineCountByLimitAutoWrap(6)
  self._ui._edit_reportWrite_multilineEdit:SetMaxInput(self._MAX_REPORTDESCRIPTION_COUNT)
  self._ui._edit_reportWrite_multilineEdit:SetMaxEditLine(8)
  self._ui._stc_ReportType = UI.getChildControl(Panel_Window_Chat_Report_All, "Static_SelectReportType")
  self._ui._stc_ReportType:SetShow(true)
  self._ui._rdo_ReportType[1] = UI.getChildControl(self._ui._stc_ReportType, "RadioButton_Abuse")
  self._ui._rdo_ReportType[2] = UI.getChildControl(self._ui._stc_ReportType, "RadioButton_Advertisment")
  self._ui._rdo_ReportType[3] = UI.getChildControl(self._ui._stc_ReportType, "RadioButton_Adult")
  self._ui._rdo_ReportType[4] = UI.getChildControl(self._ui._stc_ReportType, "RadioButton_Politics")
  self._ui._rdo_ReportType[5] = UI.getChildControl(self._ui._stc_ReportType, "RadioButton_Dispute")
  self._ui._rdo_ReportType[6] = UI.getChildControl(self._ui._stc_ReportType, "RadioButton_Violent")
  self._ui._rdo_ReportType[7] = UI.getChildControl(self._ui._stc_ReportType, "RadioButton_LieInfo")
  self._ui._rdo_ReportType[8] = UI.getChildControl(self._ui._stc_ReportType, "RadioButton_UndifinedName")
  self._ui._rdo_ReportType[9] = UI.getChildControl(self._ui._stc_ReportType, "RadioButton_Etc")
  self._reportType[1] = __eReasonInsult
  self._reportType[2] = __eReasonAdvertisingOtherGame
  self._reportType[3] = __eReasonSexualHarassment
  self._reportType[4] = __eReasonPoliticalSensitive
  self._reportType[5] = __eReasonStalking
  self._reportType[6] = __eReasonViolent
  self._reportType[7] = __eReasonCheat
  self._reportType[8] = __eReasonCharacterName
  self._reportType[9] = __eReasonChattingEtc
  self._selectedReportType = 0
  Panel_Window_Chat_Report_All:SetPosY((getScreenSizeY() - Panel_Window_Chat_Report_All:GetSizeY()) * 0.5)
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Window_Chat_Report_All:registEventHandler()
  if Panel_Window_Chat_Report_All == nil then
    return
  end
  if _ContentsGroup_UsePadSnapping == true then
    self._ui._edit_reportWrite_multilineEdit:setXboxVirtualKeyBoardEndEvent("HandleEventKey_Chat_Report_OnVirtualKeyboardEnd")
    Panel_Window_Chat_Report_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_Chat_Report_SetFocusEdit()")
  end
  self._ui._btn_exit:addInputEvent("Mouse_LUp", "PaGlobal_Window_Chat_Report_All_Close()")
  self._ui._stc_titleArea_import_import_btn_close:addInputEvent("Mouse_LUp", "PaGlobal_Window_Chat_Report_All_Close()")
  self._ui._edit_reportWrite_multilineEdit:RegistAllKeyEvent("FromClient_Chat_Report_EditBoxChange()")
  self._ui._edit_reportWrite_multilineEditCover:addInputEvent("Mouse_LUp", "HandleEventLUp_Chat_Report_SetFocusEdit()")
  registerEvent("FromClient_Chat_Report_Success", "FromClient_Chat_Report_Success")
  registerEvent("FromClient_Chat_Report_Failed", "FromClient_Chat_Report_Failed")
  registerEvent("onScreenResize", "FromClient_PaGlobal_Window_Chat_Report_Resize")
  for i = 1, #self._ui._rdo_ReportType do
    local radioButtonText = UI.getChildControl(self._ui._rdo_ReportType[i], "StaticText_1")
    UI.setLimitTextAndAddTooltip(radioButtonText, radioButtonText:GetText(), "")
    self._ui._rdo_ReportType[i]:addInputEvent("Mouse_LUp", "PaGlobal_Window_Chat_Report_SelectReportType(" .. i .. ")")
    radioButtonText:addInputEvent("Mouse_LUp", "PaGlobal_Window_Chat_Report_SelectReportType(" .. i .. ")")
  end
end
function PaGlobal_Window_Chat_Report_All:prepareOpen(openType, clickedName, clickedUserNickName, senderUserNo, clickedMsg, chatType, chatSendTime, chatSendServerTime, clickedUserId)
  if Panel_Window_Chat_Report_All == nil then
    return
  end
  if openType ~= self._eOpenType.BlockVote and openType ~= self._eOpenType.Report then
    UI.ASSERT_NAME(false, "openType\236\157\180 \235\185\132\236\160\149\236\131\129\236\157\180\235\139\164! \236\177\132\237\140\133 \234\184\136\236\167\128 \236\154\148\236\178\173\235\143\132 \236\149\132\235\139\136\234\179\160, \235\140\128\237\153\148 \235\130\180\236\151\173 \236\139\160\234\179\160\235\143\132 \236\149\132\235\139\136\235\139\164?!", "\236\157\180\236\163\188")
    return
  end
  self._currentOpenType = openType
  self._clickedName = clickedName
  self._clickedUserNickName = clickedUserNickName
  self._clickedUserId = clickedUserId
  self._senderUserNo = senderUserNo
  self._clickedMsg = clickedMsg
  self._chattingTime = chatSendServerTime
  self._chatType = chatType
  self:registEventByOpenMode()
  self:changeTextByOpenMode()
  self:realignPanelSizeByOpenMode()
  Panel_Window_Chat_Report_All:SetPosX((getScreenSizeX() - Panel_Window_Chat_Report_All:GetSizeX()) / 2)
  Panel_Window_Chat_Report_All:SetPosY((getScreenSizeY() - Panel_Window_Chat_Report_All:GetSizeY()) / 2)
  local timeString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_REPORTCHAT_TARGET_CHAT", "chat", clickedMsg .. " [" .. getTimeYearMonthDayHourMinSecByTTime64(chatSendTime) .. "]")
  if self._isConsole == true then
    timeString = timeString .. " (UTC)"
  end
  self._ui._stc_chatDetail_chatDesc:SetText(timeString)
  self._ui._txt_characterCount:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_REPORTCHAT_CHARACTERCOUNT", "current", 0, "max", self._MAX_REPORTDESCRIPTION_COUNT))
  self._selectedReportType = 0
  for i = 1, #self._ui._rdo_ReportType do
    self._ui._rdo_ReportType[i]:SetCheck(false)
  end
  self:open()
end
function PaGlobal_Window_Chat_Report_All:open()
  if Panel_Window_Chat_Report_All == nil then
    return
  end
  Panel_Window_Chat_Report_All:SetShow(true)
end
function PaGlobal_Window_Chat_Report_All:prepareClose()
  if Panel_Window_Chat_Report_All == nil then
    return
  end
  self._currentOpenType = nil
  self._clickedName = nil
  self._clickedUserNickName = nil
  self._clickedUserId = nil
  self._senderUserNo = nil
  self._clickedMsg = nil
  self._chatType = nil
  self._chattingTime = nil
  self._ui._stc_chatDetail_chatDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_REPORTCHAT_TARGET_CHAT"))
  self._ui._edit_reportWrite_multilineEdit:SetEditText("")
  self._selectedReportType = 0
  self:close()
end
function PaGlobal_Window_Chat_Report_All:close()
  if Panel_Window_Chat_Report_All == nil then
    return
  end
  Panel_Window_Chat_Report_All:SetShow(false)
end
function PaGlobal_Window_Chat_Report_All:validate()
  if Panel_Window_Chat_Report_All == nil then
    return
  end
  self._ui._stc_titleArea_import_import:isValidate()
  self._ui._stc_titleArea_import_import_txt_title:isValidate()
  self._ui._stc_titleArea_import_import_btn_close:isValidate()
  self._ui._stc_chatReportDetail:isValidate()
  self._ui._stc_reportTarget:isValidate()
  self._ui._stc_chatDetail_chatDesc:isValidate()
  self._ui._stc_reportWrite:isValidate()
  self._ui._edit_reportWrite_multilineEdit:isValidate()
  self._ui._edit_reportWrite_multilineEditCover:isValidate()
  self._ui._btn_report:isValidate()
  self._ui._btn_exit:isValidate()
  self._ui._txt_reportReasonSubTitle:isValidate()
  self._ui._txt_characterCount:isValidate()
  self._ui._txt_reportDesc:isValidate()
  self._ui._stc_chatReportBottomDesc:isValidate()
  self._ui._txt_chatReportBottomDesc:isValidate()
end
function PaGlobal_Window_Chat_Report_All:registEventByOpenMode()
  if Panel_Window_Chat_Report_All == nil then
    return
  end
  if self._currentOpenType == self._eOpenType.BlockVote then
    if _ContentsGroup_UsePadSnapping == true then
      Panel_Window_Chat_Report_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_RequestBlockVoteChat()")
    end
    self._ui._btn_report:addInputEvent("Mouse_LUp", "HandleEventLUp_RequestBlockVoteChat()")
  elseif self._currentOpenType == self._eOpenType.Report then
    if _ContentsGroup_UsePadSnapping == true then
      Panel_Window_Chat_Report_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_RequestReportChat()")
    end
    self._ui._btn_report:addInputEvent("Mouse_LUp", "HandleEventLUp_RequestReportChat()")
  else
    UI.ASSERT_NAME(false, "Invalidate OpenType.", "\236\157\180\236\163\188")
    return
  end
end
function PaGlobal_Window_Chat_Report_All:changeTextByOpenMode()
  if Panel_Window_Chat_Report_All == nil then
    return
  end
  if self._currentOpenType == self._eOpenType.BlockVote then
    self._ui._stc_titleArea_import_import_txt_title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHAT_BLOCKVOTE_TITLE"))
    self._ui._stc_reportTarget:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHAT_BLOCKVOTE_TARGETNAME", "name", self._clickedUserNickName))
    self._ui._txt_reportReasonSubTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHAT_BLOCKVOTE_DESC"))
    self._ui._txt_reportDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHAT_BLOCKVOTE_ALERT"))
    self._ui._edit_reportWrite_multilineEdit:SetEditText("")
    self._ui._edit_reportWrite_multilineEdit:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHAR_BLOCKVOTE_DESC_EMPTY", "stringLength", self._MAX_REPORTDESCRIPTION_COUNT))
    self._ui._txt_chatReportBottomDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHAT_BLOCKVOTE_ALERT_DESC"))
    self._ui._btn_report:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHAT_BLOCKVOTE_REQUEST"))
    self._ui._stc_keyGuide_Y:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHAT_BLOCKVOTE_REQUEST"))
  elseif self._currentOpenType == self._eOpenType.Report then
    self._ui._stc_titleArea_import_import_txt_title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHATSUBMENU_REPORTCHAT"))
    self._ui._stc_reportTarget:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_REPORTCHAT_TARGET_NAME", "name", self._clickedUserNickName))
    self._ui._txt_reportReasonSubTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_REPORTCHAT_REPORT_REASON_SUBTITLE"))
    self._ui._txt_reportDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_REPORTCHAT_BOTTOM_DESC_SUBTITLE"))
    self._ui._edit_reportWrite_multilineEdit:SetEditText("")
    self._ui._edit_reportWrite_multilineEdit:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_REPORTCHAT_REPORTMEMO", "stringLength", self._MAX_REPORTDESCRIPTION_COUNT))
    self._ui._txt_chatReportBottomDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_REPORTCHAT_BOTTOM_DESC"))
    self._ui._btn_report:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SAVAGEDEFENCE_RESULT_REPORT"))
    self._ui._stc_keyGuide_Y:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SAVAGEDEFENCE_RESULT_REPORT"))
  else
    UI.ASSERT_NAME(false, "Invalidate OpenType.", "\236\157\180\236\163\188")
    return
  end
end
function PaGlobal_Window_Chat_Report_All:realignPanelSizeByOpenMode()
  if Panel_Window_Chat_Report_All == nil then
    return
  end
  local isShow = self._currentOpenType == self._eOpenType.Report
  self._ui._stc_ReportType:SetShow(isShow)
  local spanY = 0
  if self._ui._stc_ReportType:GetShow() == true then
    spanY = self._ui._stc_chatReportDetail:GetSpanSize().y + self._ui._stc_chatReportDetail:GetSizeY() + 40
    self._ui._stc_ReportType:SetSpanSize(self._ui._stc_ReportType:GetSpanSize().x, spanY)
    spanY = self._ui._stc_ReportType:GetSpanSize().y + self._ui._stc_ReportType:GetSizeY() + 15
    self._ui._txt_reportReasonSubTitle:SetSpanSize(self._ui._txt_reportReasonSubTitle:GetSpanSize().x, spanY)
    self._ui._txt_characterCount:SetSpanSize(self._ui._txt_characterCount:GetSpanSize().x, spanY + 5)
    spanY = self._ui._txt_characterCount:GetSpanSize().y + self._ui._txt_characterCount:GetSizeY()
    self._ui._stc_reportWrite:SetSpanSize(self._ui._stc_reportWrite:GetSpanSize().x, spanY)
    spanY = self._ui._stc_reportWrite:GetSpanSize().y + self._ui._stc_reportWrite:GetSizeY() + 15
    self._ui._txt_reportDesc:SetSpanSize(self._ui._txt_reportDesc:GetSpanSize().x, spanY)
    spanY = self._ui._txt_reportDesc:GetSpanSize().y + self._ui._txt_reportDesc:GetSizeY() + 15
    self._ui._stc_chatReportBottomDesc:SetSpanSize(self._ui._stc_chatReportBottomDesc:GetSpanSize().x, spanY)
  else
    spanY = self._ui._stc_chatReportDetail:GetSpanSize().y + self._ui._stc_chatReportDetail:GetSizeY() + 15
    self._ui._txt_reportReasonSubTitle:SetSpanSize(self._ui._txt_reportReasonSubTitle:GetSpanSize().x, spanY)
    self._ui._txt_characterCount:SetSpanSize(self._ui._txt_characterCount:GetSpanSize().x, spanY + 5)
    spanY = self._ui._txt_characterCount:GetSpanSize().y + self._ui._txt_characterCount:GetSizeY()
    self._ui._stc_reportWrite:SetSpanSize(self._ui._stc_reportWrite:GetSpanSize().x, spanY)
    spanY = self._ui._stc_reportWrite:GetSpanSize().y + self._ui._stc_reportWrite:GetSizeY() + 15
    self._ui._txt_reportDesc:SetSpanSize(self._ui._txt_reportDesc:GetSpanSize().x, spanY)
    spanY = self._ui._txt_reportDesc:GetSpanSize().y + self._ui._txt_reportDesc:GetSizeY() + 15
    self._ui._stc_chatReportBottomDesc:SetSpanSize(self._ui._stc_chatReportBottomDesc:GetSpanSize().x, spanY)
  end
  local bottomDescTextSizeY = self._ui._txt_chatReportBottomDesc:GetTextSizeY()
  self._ui._txt_chatReportBottomDesc:SetSize(self._ui._txt_chatReportBottomDesc:GetSizeX(), bottomDescTextSizeY)
  self._ui._stc_chatReportBottomDesc:SetSize(self._ui._stc_chatReportBottomDesc:GetSizeX(), bottomDescTextSizeY + 20)
  local panelSizeY = self._ui._stc_chatReportBottomDesc:GetSpanSize().y + self._ui._stc_chatReportBottomDesc:GetSizeY() + self._ui._btn_report:GetSizeY() + 20
  Panel_Window_Chat_Report_All:SetSize(Panel_Window_Chat_Report_All:GetSizeX(), panelSizeY)
  Panel_Window_Chat_Report_All:ComputePosAllChild()
end
