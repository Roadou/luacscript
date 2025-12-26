PaGlobal_PartyRecruite_All = {
  _ui = {
    stc_centerBg = nil,
    edit_adDesc = nil,
    edit_adDescCover = nil,
    stc_level = nil,
    stc_offence = nil,
    stc_defence = nil,
    rdo_PartyNormal = nil,
    rdo_PartyLarge = nil
  },
  _ui_pc = {
    btn_close = nil,
    stc_icon_Text = nil,
    btn_admin = nil
  },
  _ui_console = {
    stc_icon_X = nil,
    stc_bottomBg = nil,
    stc_icon_A = nil,
    stc_icon_B = nil,
    stc_icon_Y = nil
  },
  _panelOriginY = 0,
  _centerOriginY = 0,
  _selectLevel = 0,
  _selectOffence = 0,
  _selectDeffence = 0,
  _maxLevel = toInt64(0, 60),
  _maxOffence = toInt64(0, 370),
  _maxDefence = toInt64(0, 440),
  _MAXINPUTSIZE = 30,
  _isGuildParty = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Party/Panel_Window_PartyRecruite_All_1.lua")
runLua("UI_Data/Script/Window/Party/Panel_Window_PartyRecruite_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PartyRecruite_All_Init")
function FromClient_PartyRecruite_All_Init()
  PaGlobal_PartyRecruite_All:initialize()
end
