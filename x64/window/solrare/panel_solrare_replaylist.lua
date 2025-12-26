PaGlobal_Solrare_ReplayList = {
  _ui = {
    _btn_close = nil,
    _btn_openUploadList = nil,
    _btn_openDownloadWeb = nil,
    _stc_uploadBg = nil,
    _lst_uploadList = nil,
    _stc_uploadListEmpty = nil,
    _btn_reloadDownloadCompleteList = nil,
    _lst_downloadComplete = nil,
    _stc_downloadCompleteListEmpty = nil
  },
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Solrare/Panel_Solrare_ReplayList_1.lua")
runLua("UI_Data/Script/Window/Solrare/Panel_Solrare_ReplayList_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Solrare_ReplayList_Init")
function FromClient_Solrare_ReplayList_Init()
  PaGlobal_Solrare_ReplayList:initialize()
end
