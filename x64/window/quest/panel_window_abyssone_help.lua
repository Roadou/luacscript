PaGlobal_AbyssOneJoinGuide = {
  _ui = {
    _stc_Bg = nil,
    _btn_close = nil,
    _txt_title = nil,
    _txt_desc = nil
  },
  _showFlag = false,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Quest/Panel_Window_AbyssOne_Help_1.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_AbyssOneJoinGuideInit")
function FromClient_PaGlobal_AbyssOneJoinGuideInit()
  PaGlobal_AbyssOneJoinGuide:initialize()
end
