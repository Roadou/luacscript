PaGlobal_Daily_Reward_Notice_All = {
  _ui = {
    stc_today_reward = nil,
    stc_tomorrow_reward = nil,
    txt_tomorrow_title = nil
  },
  _todayContent = {},
  _tomorrowContent = {},
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createClassEquipBG = true,
    createCash = true
  },
  _rewardTypeCount = 0,
  _todayRewardCount = 0,
  _tomorrowRewardCount = 0,
  _closeAnimationStart = false,
  _animationTime = 0,
  _originalTodayPosX = 0,
  _originalTodayPosY = 0,
  _firstOpen = true,
  _initialize = false
}
runLua("UI_Data/Script/Window/DailyStamp/Panel_Window_Daily_Reward_Notice_All_1.lua")
runLua("UI_Data/Script/Window/DailyStamp/Panel_Window_Daily_Reward_Notice_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_Daily_Reward_Notice_AllInit")
function FromClient_PaGlobal_Daily_Reward_Notice_AllInit()
  PaGlobal_Daily_Reward_Notice_All:initialize()
end
