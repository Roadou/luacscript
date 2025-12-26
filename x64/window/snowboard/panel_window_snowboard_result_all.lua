PaGlobal_SnowBoardFieldResult = {
  _ui = {
    stc_mainBg = nil,
    stc_resultImage = nil,
    stc_itemGroupBg = nil,
    txt_itemCount = nil,
    stc_itemCountDeco = nil,
    stc_speedGroupBg = nil,
    stc_bestLapTimeTitle = nil,
    txt_bestLapTime = nil,
    stc_lapTimeTitle = nil,
    txt_lapTime = nil,
    stc_penaltyTimeTitle = nil,
    txt_penaltyTime = nil,
    txt_ghostDesc = nil,
    btn_exit = nil,
    btn_retry = nil
  },
  _textureItemCountDecoBase = "Combine_ETC_MiniGame_SnowBoard_Result_Aura",
  _textureItemCountDecoFail = "Combine_ETC_MiniGame_SnowBoard_Result_Aura_2",
  _textureBgBase = "Combine_ETC_MiniGame_SnowBoard_Result_BG",
  _textureBgFail = "Combine_ETC_MiniGame_SnowBoard_Result_BG_2",
  _textureFinishBase = "Combine_ETC_MiniGame_SnowBoard_Result_Finish",
  _textureFinishFail = "Combine_ETC_MiniGame_SnowBoard_Result_Retire",
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/SnowBoard/Panel_Window_SnowBoard_Result_All_1.lua")
runLua("UI_Data/Script/Window/SnowBoard/Panel_Window_SnowBoard_Result_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SnowBoardFieldResultInit")
function FromClient_SnowBoardFieldResultInit()
  PaGlobal_SnowBoardFieldResult:initialize()
end
