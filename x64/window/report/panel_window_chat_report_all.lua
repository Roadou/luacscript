PaGlobal_Window_Chat_Report_All = {
  _ui = {
    _stc_titleArea_import_import = nil,
    _stc_titleArea_import_import_txt_title = nil,
    _stc_titleArea_import_import_btn_close = nil,
    _stc_chatReportDetail = nil,
    _stc_chatDetail_reportTarget = nil,
    _stc_chatDetail_chatDesc = nil,
    _stc_reportWrite = nil,
    _edit_reportWrite_multilineEdit = nil,
    _edit_reportWrite_multilineEditCover = nil,
    _btn_report = nil,
    _btn_exit = nil,
    _txt_reportReasonSubTitle = nil,
    _txt_characterCount = nil,
    _txt_reportDesc = nil,
    _stc_chatReportBottomDesc = nil,
    _txt_chatReportBottomDesc = nil,
    _stc_keyGuide_console = nil,
    _stc_keyGuide_Y = nil,
    _stc_ReportType = nil,
    _rdo_ReportType = {},
    _stc_ReportWrite = nil
  },
  _eOpenType = {BlockVote = 0, Report = 1},
  _currentOpenType = nil,
  _clickedName = nil,
  _clickedUserNickName = nil,
  _senderUserNo = nil,
  _clickedMsg = nil,
  _chattingTime = nil,
  _chatType = nil,
  _MAX_REPORTDESCRIPTION_COUNT = 200,
  _reportType = {},
  _selectedReportTypeIndex = 0,
  _originPanelSizeY = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Report/Panel_Window_Chat_Report_All_1.lua")
runLua("UI_Data/Script/Window/Report/Panel_Window_Chat_Report_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Window_Chat_Report_All_Init")
function FromClient_Window_Chat_Report_All_Init()
  PaGlobal_Window_Chat_Report_All:initialize()
end
