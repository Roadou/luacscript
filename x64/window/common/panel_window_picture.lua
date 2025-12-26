PaGlobal_Picture = {
  _eType = {
    termianMapHint1 = 0,
    termianMapHint2 = 1,
    termianMapHint3 = 2
  },
  _ui = {btn_Close = nil, stc_KeyguideB = nil},
  _contentsSpanY = 0,
  _initialize = false
}
runLua("UI_Data/Script/Window/Common/Panel_Window_Picture_1.lua")
runLua("UI_Data/Script/Window/Common/Panel_Window_Picture_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Picture_Init")
function FromClient_Picture_Init()
  PaGlobal_Picture:initialize()
end
