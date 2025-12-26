PaGlobal_BossReward = {
  _ui = {
    stc_LootingMainBG = nil,
    stc_Progress = nil,
    progress_Gauge = nil,
    btn_Reward = nil,
    txt_GetReward = nil,
    frame = nil,
    frame_Content = nil,
    frame_SlideBg = nil,
    frame_SlideBtn = nil,
    txt_GetRewardMain = nil,
    stc_keyGuideConsole = nil,
    stc_ConsoleUI = nil,
    stc_Console_B_Button = nil,
    stc_Console_X_Button = nil
  },
  _maxSlotCount = 40,
  _autoBossRewardGetTime = 0,
  _showItemTerm = 0,
  _isShowEnd = false,
  _isAnimationEnd = false,
  _rewardRootingItemCount = 0,
  _rewardRootingItemIndex = 0,
  _showItemTerm = 0,
  _isShowEnd = false,
  _rewardRootingItemCount = 0,
  _rewardRootingItemIndex = 0,
  _bgSlots = nil,
  _slots = nil,
  _randomTime = 0,
  _itemKeyList = nil,
  _txtGetRewardMainPosY = 0,
  _isPadsnapping = _ContentsGroup_UsePadSnapping,
  _isConsole = ToClient_isConsole(),
  _initialize = false,
  _frameSizeX = 0,
  _frameContentSizeX = 0,
  _frameContentSizeY = 0,
  _maxFrameContentSizeX = 0,
  _frameMoveSpeed = 3
}
runLua("UI_Data/Script/Widget/BossReward/Panel_Widget_BossReward_All_1.lua")
runLua("UI_Data/Script/Widget/BossReward/Panel_Widget_BossReward_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_BossRewardInit")
function FromClient_BossRewardInit()
  PaGlobal_BossReward:initialize()
end
