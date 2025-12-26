PaGlobal_AbyssOneMenu = {
  _ui = {
    _btn_openEquip = nil,
    _btn_returnMagnus = nil,
    _btn_exit = nil,
    _btn_retry = nil,
    _btn_ringMenu = nil,
    _btn_gameOption = nil,
    _btn_trayMode = nil,
    _btn_gameExit = nil,
    _stc_keyGuide_A = nil
  },
  _BTN_TYPE = {
    _OPEN_EQUIP = 0,
    _RETURN_MAGNUS = 1,
    _EXIT_ABYSSONE = 2,
    _RINGMENU_SETTING = 3,
    _OPEN_GAMEOPTION = 4,
    _TRAY_MODE = 5,
    _EXIT_GAME = 6,
    _RETRY = 7,
    _COUNT = 8
  },
  _retryDelay = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/AbyssOne/Menu/Panel_AbyssOne_Menu_1.lua")
runLua("UI_Data/Script/AbyssOne/Menu/Panel_AbyssOne_Menu_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_AbyssOneMenuInit")
function FromClient_AbyssOneMenuInit()
  PaGlobal_AbyssOneMenu:initialize()
end
