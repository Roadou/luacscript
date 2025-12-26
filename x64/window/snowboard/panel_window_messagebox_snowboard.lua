PaGlobal_MessageBox_SnowBoard = {
  _ui = {
    _btn_big = UI.getChildControl(Panel_Window_MessageBox_SnowBoard, "Button_Big"),
    _btn_left = UI.getChildControl(Panel_Window_MessageBox_SnowBoard, "Button_Left"),
    _btn_right = UI.getChildControl(Panel_Window_MessageBox_SnowBoard, "Button_Right"),
    _btn_close = UI.getChildControl(Panel_Window_MessageBox_SnowBoard, "Button_Close"),
    _btn_consoleGroup = UI.getChildControl(Panel_Window_MessageBox_SnowBoard, "Static_BottomBg_ConsoleUI"),
    _txt_desc = UI.getChildControl(Panel_Window_MessageBox_SnowBoard, "StaticText_Content"),
    _txt_title = UI.getChildControl(Panel_Window_MessageBox_SnowBoard, "Static_Text")
  },
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/SnowBoard/Panel_Window_MessageBox_SnowBoard_1.lua")
runLua("UI_Data/Script/Window/SnowBoard/Panel_Window_MessageBox_SnowBoard_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_MessageBox_SnowBoard_Init")
function FromClient_PaGlobal_MessageBox_SnowBoard_Init()
  PaGlobal_MessageBox_SnowBoard:initialize()
end
