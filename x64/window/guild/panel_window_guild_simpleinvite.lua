PaGlobal_Guild_SimpleInvite = {
  _ui = {
    stc_topArea = nil,
    stc_guildMarkBG = nil,
    stc_guildMark = nil,
    txt_Desc = nil,
    txt_guildName = nil,
    txt_guildMasterName = nil,
    btn_guildInfo = nil,
    btn_leftShow = nil,
    btn_rightShow = nil,
    radio_page = nil,
    btn_page_templete = nil,
    txt_SubDesc = nil,
    frame = nil,
    frame_contents = nil,
    frame_content_txt = nil,
    frame_horizontal = nil,
    frame_vertical = nil,
    frame_vertical_ctrl = nil,
    btn_join = nil,
    btn_reject = nil,
    btn_close = nil,
    stc_KeyGuideBG = nil,
    txt_KeyGuideB = nil
  },
  _selectIndex = 0,
  _control = {},
  _page = {},
  _isConsole = false,
  _originDescSize = 0,
  _isFirstOpen = true,
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/Panel_Window_Guild_SimpleInvite_1.lua")
runLua("UI_Data/Script/Window/Guild/Panel_Window_Guild_SimpleInvite_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Guild_SimpleInvite")
function FromClient_Guild_SimpleInvite()
  PaGlobal_Guild_SimpleInvite:initialize()
  Panel_GuildInvite_Alert:RegisterUpdateFunc("FromClient_PaGlobal_GuildInviteAlert_UpdatePerFrame")
end
