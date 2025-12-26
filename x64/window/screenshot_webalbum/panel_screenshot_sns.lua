PaGlobal_ScreenShot_SNS = {
  _ui = {btn_close = nil},
  _initialize = false
}
runLua("UI_Data/Script/Window/ScreenShot_WebAlbum/Panel_ScreenShot_SNS_1.lua")
runLua("UI_Data/Script/Window/ScreenShot_WebAlbum/Panel_ScreenShot_SNS_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ScreenShotSNSInit")
function FromClient_ScreenShotSNSInit()
  PaGlobal_ScreenShot_SNS:initialize()
end
