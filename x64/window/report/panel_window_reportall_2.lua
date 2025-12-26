function HandleEventLUp_ReportAll_SelectClassify(classify)
  if nil == Panel_Window_Report_All then
    return
  end
  PaGlobal_ReportAll:SetClassify(classify)
end
function HandleEventLUp_ReportAll_SetFocusEdit()
  if nil == Panel_Window_Report_All then
    return
  end
  PaGlobal_ReportAll:SetFocusEdit()
end
function HandleEventLUp_ReportAll_ReportingConfirm()
  if nil == Panel_Window_Report_All then
    return
  end
  PaGlobal_ReportAll:ReportingConfirm()
end
function FromClient_NagtiveUserReport(currentCount)
  if nil == Panel_Window_Report_All then
    return
  end
  PaGlobal_ReportAll:ReportingFeedBack(currentCount)
end
function FromClient_OpenReportAllWindow()
  if nil == Panel_Window_Report_All then
    return
  end
  PaGlobal_ReportAll:prepareOpen()
end
function PaGloabl_ReportAll_CheckUIEdit(targetUI)
  if nil == Panel_Window_Report_All then
    return
  end
  PaGlobal_ReportAll:CheckUIEdit()
end
function PaGloabl_ReportAll_EndFocusEdit()
  if nil == Panel_Window_Report_All then
    return
  end
  PaGlobal_ReportAll:EndFocusEdit()
end
function PaGloabl_ReportAll_Open()
  if nil == Panel_Window_Report_All then
    return
  end
  PaGlobal_ReportAll:prepareOpen()
end
function PaGloabl_ReportAll_Close()
  if nil == Panel_Window_Report_All then
    return
  end
  PaGlobal_ReportAll:prepareClose()
end
function PaGlobal_ReportAll_SelectReportType(index)
  if Panel_Window_Report_All == nil then
    return
  end
  local self = PaGlobal_ReportAll
  if self == nil then
    return
  end
  self._selectedReportType = self._reportType[index]
end
function PaGlobal_ReportAll_EditBoxChange()
  if Panel_Window_Report_All == nil then
    return
  end
  local self = PaGlobal_ReportAll
  if self == nil then
    return
  end
  local editTextLength = self._ui._edit_reportWrite_multilineEdit:GetEditTextSize()
  if editTextLength == 0 then
    self._ui._edit_reportWrite_multilineEdit:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_REPORTCHAT_REPORTMEMO", "stringLength", self._MAX_REPORTDESCRIPTION_COUNT))
  end
end
