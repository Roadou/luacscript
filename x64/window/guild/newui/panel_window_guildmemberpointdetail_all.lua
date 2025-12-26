PaGlobal_GuildMemberPointDetail_All = {
  _ui = {
    stc_Grade = nil,
    txt_FamilyName = nil,
    txt_Point = nil,
    frame_list = nil,
    frame_content = nil,
    scroll_vs = nil,
    scroll_vsCtrl = nil,
    stc_siegeTitle = nil,
    stc_requestTitle = nil,
    stc_sendAllTitle = nil,
    _requestList = {},
    _allSendList = {}
  },
  _ui_pc = {btn_Close = nil, btn_Close2 = nil},
  _ui_console = {btn_Close = nil},
  _config = {
    listMaxCount = 30,
    colCount = 10,
    collectionY = 90,
    collectionX = 45,
    voiceBgY = 110,
    gradeSpanX = 0
  },
  _memberIndex = -1,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildMemberPointDetail_All_1.lua")
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildMemberPointDetail_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildMemberPointDetail_AllInit")
function FromClient_GuildMemberPointDetail_AllInit()
  PaGlobal_GuildMemberPointDetail_All:initialize()
end
