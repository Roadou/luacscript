PaGlobal_CharacterInfo_HardCore_All = {
  _ui = {
    _btn_Close = nil,
    _btn_Question = nil,
    _btn_StickerUI = nil,
    _stc_selectLine = nli,
    _btn_GameExit = nil
  },
  _initialize = false,
  _HARDCORE_CHARACTERINFO_TABINDEX = {_basic = 0, _totalCount = 1},
  _TABSTRING = {
    [0] = "UI_WINDOW_CHARACTERINFO_TAB_INFO"
  },
  _tabData = {},
  _currentTabIdx = nil,
  _consoleIdx = nil
}
runLua("UI_Data/Script/Window/HardCore/Panel_CharacterInfo_HardCore_All_1.lua")
runLua("UI_Data/Script/Window/HardCore/Panel_CharacterInfo_HardCore_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_CharacterInfo_HardCore_All_Init")
function FromClient_CharacterInfo_HardCore_All_Init()
  PaGlobal_CharacterInfo_HardCore_All:initialize()
end
