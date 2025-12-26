PaGlobal_InstanceContentsReplayDownloadWeb = {
  _ui = {
    _stc_title = nil,
    _btn_refresh = nil,
    _btn_close = nil
  },
  _serviceTypeStrArr = nil,
  _panelSizeX = 1500,
  _panelSizeY = 900,
  _webUI = nil,
  _initialize = false
}
runLua("UI_Data/Script/Window/Replay/Panel_Window_InstanceContentsReplayDownloadWeb_1.lua")
runLua("UI_Data/Script/Window/Replay/Panel_Window_InstanceContentsReplayDownloadWeb_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_InstanceContentsReplayDownloadWeb_Init")
function FromClient_InstanceContentsReplayDownloadWeb_Init()
  PaGlobal_InstanceContentsReplayDownloadWeb:initialize()
end
