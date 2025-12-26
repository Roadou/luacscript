PaGlobal_GuildPresent_All = {
  _ui = {
    _pc = {_btn_close = nil, _btn_question = nil},
    _console = {
      _keyGuideBg = nil,
      _txt_keyGuideApply = nil,
      _txt_keyGuideClose = nil,
      _txt_keyGuideInput = nil
    },
    _btn_confirm = nil,
    _stc_itemSlotGuideText = nil,
    _stc_itemSlot = nil,
    _stc_defaultSearchText = nil,
    _stc_searchBg = nil,
    _btn_searchReset = nil,
    _edit_memberNameText = nil
  },
  _selectedItemKey = nil,
  _selectedItemSlotNo = nil,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/Panel_Window_GuildPresent_All_1.lua")
runLua("UI_Data/Script/Window/Guild/Panel_Window_GuildPresent_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildPresentInit")
function FromClient_GuildPresentInit()
  PaGlobal_GuildPresent_All:initialize()
end
