PaGlobal_UseCharacterWp_All = {
  _ui = {
    _stc_title = nil,
    _stc_title_icon = nil,
    _btn_close = nil,
    _list2_button = nil,
    _list2_content = nil,
    _stc_keyGuideBg = nil,
    _btn_confirm_consoleUI = nil,
    _btn_cancel_consoleUI = nil,
    _btn_otherItem_consoleUI = nil,
    _stc_blockBg = nil
  },
  _panelOriginSizeY = 0,
  _listOriginPosX = 0,
  _listOriginPosY = 0,
  _listOriginSizeY = 0,
  _startPosX = 0,
  _selectedIndex = -1,
  _selfCharacterNo_64 = 0,
  _currentOpenType = 0,
  _param0 = nil,
  _openType = {
    _investNode = 1,
    _workerRandomSelect = 2,
    _secretRandomShop = 3
  },
  _isUsePadSnapping = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Keypad/Panel_Window_UseCharacterWp_All_1.lua")
runLua("UI_Data/Script/Window/Keypad/Panel_Window_UseCharacterWp_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_UseCharacterWp_All_luaLoadComplete")
function FromClient_UseCharacterWp_All_luaLoadComplete()
  PaGlobal_UseCharacterWp_All:initialize()
end
