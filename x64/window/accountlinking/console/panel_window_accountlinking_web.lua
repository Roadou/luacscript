PaGlobal_AccountLinking_Web = {
  _ui = {
    stc_Title = nil,
    txt_Title = nil,
    btn_Close = nil,
    btn_Refresh = nil,
    stc_webControl = nil
  },
  _webSizeX = 1000,
  _webSizeY = 640,
  _initialize = false
}
runLua("UI_Data/Script/Window/AccountLinking/Console/Panel_Window_AccountLinking_Web_1.lua")
runLua("UI_Data/Script/Window/AccountLinking/Console/Panel_Window_AccountLinking_Web_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_AccountLinking_Init")
function FromClient_AccountLinking_Init()
  PaGlobal_AccountLinking_Web:initialize()
end
