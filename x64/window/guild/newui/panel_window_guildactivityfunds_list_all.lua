PaGlobal_GuildActivityFunds_List_All = {
  _ui = {
    stc_listAreaBg = nil,
    frame_list = nil,
    frame_content = nil,
    stc_listMember = nil,
    scroll_vs = nil,
    scroll_vsCtrl = nil,
    txt_Fund = nil,
    _memberlist = {}
  },
  _ui_pc = {
    btn_Close = nil,
    btn_Fund = nil,
    btn_Option = nil
  },
  _ui_console = {
    stc_KeyGuideBG = nil,
    txt_KeyGuideX = nil,
    txt_KeyGuideA = nil,
    txt_KeyGuideB = nil
  },
  _config = {
    listMaxCount = 150,
    collectionY = 90,
    collectionX = 45,
    voiceBgY = 110,
    gradeSpanX = 0
  },
  _memberlistData = {},
  _memberIndex = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildActivityFunds_List_All_1.lua")
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildActivityFunds_List_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildActivityFunds_List_AllInit")
function FromClient_GuildActivityFunds_List_AllInit()
  PaGlobal_GuildActivityFunds_List_All:initialize()
end
