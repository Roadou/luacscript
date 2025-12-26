PaGlobal_Bromide_All = {
  _ui = {
    _stc_blackBG = nil,
    _stc_smallPicture = nil,
    _btn_close = nil,
    _btn_confirm = nil,
    _stc_bigPicture = nil,
    _btn_bigPictureOff = nil,
    _stc_keyGuideBG = nil,
    _stc_keyGuideY = nil,
    _stc_keyGuideB = nil
  },
  _prevPos = {x = 0, y = 0},
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Common/Panel_Window_Bromide_All_1.lua")
runLua("UI_Data/Script/Window/Common/Panel_Window_Bromide_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Bromide_All_Init")
function FromClient_Bromide_All_Init()
  PaGlobal_Bromide_All:initialize()
end
