PaGlobal_MessageBox_SeasonItem_All = {
  _ui = {
    btn_close = nil,
    stc_mainImg = nil,
    stc_mainText = nil,
    stc_consoleGuide = nil
  },
  _mousePosX = 0,
  _mosuePosY = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/MessageBox/Panel_Window_MessageBox_SeasonItem_All_1.lua")
runLua("UI_Data/Script/Window/MessageBox/Panel_Window_MessageBox_SeasonItem_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_MessageBox_SeasonItem_All_Init")
function FromClient_MessageBox_SeasonItem_All_Init()
  PaGlobal_MessageBox_SeasonItem_All:initialize()
end
