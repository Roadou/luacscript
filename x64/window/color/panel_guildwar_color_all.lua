PaGlobal_GuildWarColor_All = {
  _ui = {
    _stc_titleBG = nil,
    _btn_close = nil,
    _stc_guildListBG = nil,
    _stc_guildList = nil,
    _stc_previewColorBG = nil,
    _stc_illustBG = nil,
    _stc_leftIllustBG = nil,
    _txt_leftGuildName = nil,
    _txt_leftAccountName = nil,
    _txt_leftCharacterName = nil,
    _stc_rightIllustBG = nil,
    _txt_rightGuildName = nil,
    _txt_rightAccountName = nil,
    _txt_rightCharacterName = nil,
    _stc_descBG = nil,
    _txt_desc = nil,
    _btn_confirm = nil,
    _btn_resetColor = nil,
    _stc_keyGuideBG = nil,
    _txt_keyGuide_A = nil,
    _txt_keyGuide_B = nil,
    _txt_keyGuide_Y = nil,
    _txt_keyGuide_LT_X = nil
  },
  _panelBaseSizeY = 0,
  _listBGBaseSizeY = 0,
  _listBaseSizeY = 0,
  _previewBGBaseSizeY = 0,
  _descBgBaseSpanSizeY = 0,
  _descBgBaseSizeY = 0,
  _descBaseSizeY = 0,
  _baseColor = 4294967295,
  _selectedColor = 4294967295,
  _selectedGuildIndex = nil,
  _myGuildOrAllianceNo = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Color/Panel_GuildWar_Color_All_1.lua")
runLua("UI_Data/Script/Window/Color/Panel_GuildWar_Color_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildWarColor_All_Init")
function FromClient_GuildWarColor_All_Init()
  PaGlobal_GuildWarColor_All:initialize()
end
