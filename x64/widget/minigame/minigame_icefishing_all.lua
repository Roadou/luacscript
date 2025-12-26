PaGlobal_MiniGame_IceFishing_All = {
  _ui = {
    stc_game_borad = nil,
    stc_waterBG = nil,
    stc_fising_area = nil,
    stc_hook = {},
    stc_fish_up = nil,
    stc_fish_down = nil,
    txt_leftTime = nil,
    progress_time = nil,
    stc_space = nil,
    txt_space_pc = nil,
    txt_space_console = nil,
    stc_fish_msg_BG = nil,
    stc_fish_title = nil,
    stc_fish_stateBG = {},
    txt_fish_state = nil,
    stc_key_Guide_BG = nil,
    stc_aim = nil,
    stc_mouse_PC = nil,
    stc_rs_Console = nil,
    stc_direct_Left = nil,
    stc_direct_Right = nil,
    txt_keyGuide = nil,
    stc_fishHp_BG = nil,
    progress_fishHp = nil,
    stc_fishHpHead = nil,
    stc_result_board = nil,
    stc_success = nil,
    stc_fail = nil
  },
  HOOK_LEVEL = {
    NORMAL = 0,
    HARD = 1,
    VERYHARD = 2
  },
  FISH_STATE = {
    NORMAL = 0,
    WARNING = 1,
    SUCCESS = 2
  },
  FISH_DIRECTION = {UP = 0, DOWN = 1},
  _originalPlayerPosY = 0,
  _originalUpFishPosY = 0,
  _originalDownFishPosY = 0,
  _currentEndurance = 2,
  _currentPlayerPosY = 0,
  _currentFishDirection = 0,
  _leftTime = 0,
  _totalPlayTime = 0,
  _fishHp = 0,
  _fishTotalHp = 0,
  _preUIMode = 0,
  _initialize = false
}
runLua("UI_Data/Script/Widget/MiniGame/MiniGame_IceFishing_All_1.lua")
runLua("UI_Data/Script/Widget/MiniGame/MiniGame_IceFishing_All_2.lua")
ActionChartEventBindFunction(307, PaGlobal_MiniGame_IceFishing_All_Wait)
ActionChartEventBindFunction(308, PaGlobal_MiniGame_IceFishing_All_Catch)
ActionChartEventBindFunction(309, PaGlobal_MiniGame_IceFishing_All_Start)
ActionChartEventBindFunction(310, PaGlobal_MiniGame_IceFishing_All_Success)
ActionChartEventBindFunction(311, PaGlobal_MiniGame_IceFishing_All_Fail)
ActionChartEventBindFunction(312, PaGlobal_MiniGame_IceFishing_All_Close)
ActionChartEventBindFunction(313, PaGlobal_MiniGame_IceFishing_All_SettingIceFishingMiniGame)
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_MiniGame_IceFishing_All")
function FromClient_PaGlobal_MiniGame_IceFishing_All()
  PaGlobal_MiniGame_IceFishing_All:initialize()
end
