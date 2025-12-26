PaGlobal_MiniGame_SniperShotResult_All = {
  _ui = {
    stc_resultView_View = nil,
    stc_resultCritical = nil,
    stc_resultMiss = nil,
    stc_resultHit = nil,
    stc_resultPerfect = nil
  },
  _config = {_shotResultCloseTime = 3},
  _shotResultShowTime = 0
}
runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_SniperShotResult_All_1.lua")
runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_SniperShotResult_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_MiniGame_SniperShotResult_All_Init")
function FromClient_MiniGame_SniperShotResult_All_Init()
  PaGlobal_MiniGame_SniperShotResult_All:initialize()
end
