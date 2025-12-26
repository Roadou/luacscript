PaGlobal_ReplayController = {
  _ui = {
    stc_titleBG = nil,
    btn_sticker = nil,
    btn_close = nil,
    stc_recordBG = nil,
    stc_recordTypeGroup = nil,
    btn_recordTypeTemplate = nil,
    btn_recordTypeList = {},
    btn_streaming = nil,
    btn_replayStop = nil,
    btn_streamStop = nil,
    txt_currentRecord = nil,
    txt_recordNameBox = nil,
    btn_recordStart = nil,
    btn_recordSaveAndStop = nil,
    btn_recordOnlyStop = nil,
    btn_recordListRefresh = nil,
    btn_recording = nil,
    chk_isShowNak = nil,
    stc_playBG = nil,
    btn_deleteServer = nil,
    btn_playListRefresh = nil,
    list2_playList = nil
  },
  _loadRecordList = {},
  _loadPlayList = {},
  _isServerList = {},
  _replayListTemplate = {
    btn_Template = nil,
    txt_ReplayName = nil,
    txt_replayLength = nil
  },
  _baseRecordRefreshBtnPosX = 0,
  _isDownload = false,
  _recordType = -1,
  _serverFlag = 1000000000,
  _isCheckPopUp = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Replay/Panel_Window_ReplayController_All_1.lua")
runLua("UI_Data/Script/Window/Replay/Panel_Window_ReplayController_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ReplayController")
function FromClient_ReplayController()
  PaGlobal_ReplayController:initialize()
end
