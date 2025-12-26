PaGlobal_BoxReward_All = {
  _ui = {
    frame = nil,
    frame_Content = nil,
    frame_SlideBg = nil,
    frame_SlideBtn = nil,
    txt_GetRewardMain = nil
  },
  _ui_pc = {},
  _ui_console = {
    stc_KeyGuideBG = nil,
    txt_KeyGuideX = nil,
    txt_KeyGuideB = nil
  },
  _maxSlotCount = 40,
  _showItemTerm = 0,
  _isShowEnd = false,
  _isAnimationEnd = false,
  _rewardRootingItemCount = 0,
  _rewardRootingItemIndex = 0,
  _bgSlots = nil,
  _slots = nil,
  _itemKeyList = nil,
  _frameSizeX = 0,
  _frameContentSizeX = 0,
  _frameContentSizeY = 0,
  _maxFrameContentSizeX = 0,
  _frameMoveSpeed = 3,
  _nextItemShowTime = 0.25,
  _viewCount = 20,
  _scrollIndex = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/BossReward/Panel_Widget_BoxReward_All_1.lua")
runLua("UI_Data/Script/Widget/BossReward/Panel_Widget_BoxReward_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_BoxReward_All_Init")
function FromClient_BoxReward_All_Init()
  PaGlobal_BoxReward_All:initialize()
end
