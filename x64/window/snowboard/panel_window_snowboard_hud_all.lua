PaGlobal_SnowBoardHud = {
  _ui = {
    txt_coinCount = nil,
    stc_timerBg = nil,
    txt_timer = nil,
    stc_checkPointProgressBase = nil,
    stc_checkPointActive = nil,
    stc_checkDetail = nil,
    stc_checkPointValue = nil,
    stc_penaltyBg = nil,
    stc_failCheckPointValue = nil,
    stc_penaltyGroup = nil,
    stc_penaltyTime = nil,
    btn_rideSnowBoard = nil,
    btn_rideKeyGuide = nil
  },
  _progBar = {
    [0] = {},
    [1] = {},
    [2] = {},
    [3] = {},
    [4] = {},
    [5] = {},
    [6] = {}
  },
  _lastUpdateCheckPointIndex = -1,
  _checkPointCount = 0,
  _checkPointUpdateCount = 3,
  _checkPointUIMax = 7,
  _checkPointBase = "Combine_Etc_MiniGame_SnowBoard_CheckpointIcon_Normal",
  _checkPointFail = "Combine_Etc_MiniGame_SnowBoard_CheckpointIcon_Complete",
  _checkPointPass = "Combine_Etc_MiniGame_SnowBoard_CheckpointIcon_Complete",
  _checkPointGoal = "Combine_Etc_MiniGame_SnowBoard_CheckpointIcon_Goal",
  _checkPointActive = "Combine_Etc_MiniGame_SnowBoard_CheckpointIcon_Active",
  _progressBase = "Combine_Etc_MiniGame_SnowBoard_CheckpointGauge_Normal",
  _progressFail = "Combine_Etc_MiniGame_SnowBoard_CheckpointGauge_Normal",
  _progressSucess = "Combine_Etc_MiniGame_SnowBoard_CheckpointGauge_Complete",
  _progressActive = "Combine_Etc_MiniGame_SnowBoard_CheckpointGauge_Active",
  _progressSizeX = 280,
  _snowBoardCourseMode = 0,
  _startTickCount = 0,
  _raceTickCount = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/SnowBoard/Panel_Window_SnowBoard_Hud_All_1.lua")
runLua("UI_Data/Script/Window/SnowBoard/Panel_Window_SnowBoard_Hud_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SnowBoardHudInit")
function FromClient_SnowBoardHudInit()
  PaGlobal_SnowBoardHud:initialize()
end
