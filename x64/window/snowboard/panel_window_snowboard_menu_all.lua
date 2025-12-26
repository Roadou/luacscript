PaGlobal_SnowBoardMenu = {
  _ui = {
    btn_close = nil,
    stc_tabBg = nil,
    rdo_tabTemplate = nil,
    stc_tabSelectLine = nil,
    stc_mainBg = nil,
    stc_tabImageGroup = nil,
    stc_tabImage = nil,
    stc_itemModeBg = nil,
    stc_userNickName = nil,
    txt_itemCount = nil,
    stc_speedModeBg = nil,
    stc_challengeTitle = nil,
    lst_rank = nil,
    stc_emptyList = nil,
    stc_myRankBg = nil,
    stc_buttonBg = nil,
    btn_gameStart = nil,
    btn_eventOver = nil,
    btn_showInfo = nil,
    stc_Info = nil,
    stc_frameDesc = nil,
    stc_frameContents = nil,
    btn_dev_updateRank = nil
  },
  _uiConsole = {
    stc_tabLB = nil,
    stc_tabRB = nil,
    stc_keyGuideBG = nil
  },
  _frame = {
    [0] = {},
    [1] = {},
    [2] = {},
    [3] = {}
  },
  _frameContentsCount = 4,
  _openDesc = -1,
  _aniSpeedTime = 5,
  _maxDescSize = 30,
  _tabs = nil,
  _currentTabIndex = nil,
  _isConsole = false,
  _initialize = false,
  _titleTexture = {
    [1] = "Combine_ETC_MiniGame_SnowBoard_Img_01",
    [2] = "Combine_ETC_MiniGame_SnowBoard_Img_02",
    [3] = "Combine_ETC_MiniGame_SnowBoard_Img_03"
  },
  _rankTextureBG = {
    [1] = "Combine_Etc_horseracing_RackingBadge_1st",
    [2] = "Combine_Etc_horseracing_RackingBadge_2nd",
    [3] = "Combine_Etc_horseracing_RackingBadge_3rd"
  },
  _rankTexture = {
    [1] = "Combine_Etc_horseracing_RackingBadgeTXT_1st",
    [2] = "Combine_Etc_horseracing_RackingBadgeTXT_2nd",
    [3] = "Combine_Etc_horseracing_RackingBadgeTXT_3rd"
  }
}
runLua("UI_Data/Script/Window/SnowBoard/Panel_Window_SnowBoard_Menu_All_1.lua")
runLua("UI_Data/Script/Window/SnowBoard/Panel_Window_SnowBoard_Menu_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SnowBoardMenuInit")
function FromClient_SnowBoardMenuInit()
  PaGlobal_SnowBoardMenu:initialize()
end
