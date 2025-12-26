PaGlobal_EventGuide_Total = {
  _ui = {
    txt_mainBg = nil,
    stc_contentBg = nil,
    txt_titleBg = nil,
    btn_Close = nil,
    txt_mainTitle = nil,
    txt_periodDesc = nil,
    txt_mainDesc = nil,
    txt_subDesc = nil,
    stc_eventBg = nil,
    stc_deco = nil,
    btn_forum = nil,
    stc_icon = nil,
    txt_contentDesc = nil,
    txt_contentDesc2 = nil,
    stc_rewardBg = nil,
    btn_rewardConfirm = nil,
    txt_rewardConfirm = nil,
    stc_rewardGroup = nil,
    stc_deco_left = nil,
    stc_deco_right = nil,
    stc_bottomDesc = nil,
    txt_bottomDesc = nil,
    stc_rewardSlot = nil,
    txt_rewardName = nil,
    rewardSlotList = {},
    list2_totalEvent = nil,
    list2_Content = nil,
    stc_KeyGuide_Bg = nil,
    btn_KeyGuide_A = nil,
    btn_KeyGuide_B = nil,
    btn_KeyGuide_X = nil,
    btn_KeyGuide_Y = nil
  },
  _config = {maxRewardSlotCount = 10},
  _rewardSlotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createClassEquipBG = true,
    createCash = true
  },
  _currentPage = 0,
  _selectedIndex = 0,
  _oldSelectedIndex = 0,
  _initialize = false,
  _isConsole = false
}
runLua("UI_Data/Script/Window/EventNotify/Panel_EventGuide_Total_1.lua")
runLua("UI_Data/Script/Window/EventNotify/Panel_EventGuide_Total_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_EventGuide_Total_Init")
function FromClient_EventGuide_Total_Init()
  PaGlobal_EventGuide_Total:initialize()
end
