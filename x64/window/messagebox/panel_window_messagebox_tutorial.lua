PaGlobal_MessageBox_Tutorial = {
  _ui = {
    _btn_big = UI.getChildControl(Panel_Window_MessageBox_Tutorial, "Button_Big"),
    _btn_left = UI.getChildControl(Panel_Window_MessageBox_Tutorial, "Button_Left"),
    _btn_right = UI.getChildControl(Panel_Window_MessageBox_Tutorial, "Button_Right"),
    _btn_close = UI.getChildControl(Panel_Window_MessageBox_Tutorial, "Button_Close"),
    _txt_desc = UI.getChildControl(Panel_Window_MessageBox_Tutorial, "StaticText_Content")
  },
  _initialize = false
}
runLua("UI_Data/Script/Window/MessageBox/Panel_Window_MessageBox_Tutorial_1.lua")
runLua("UI_Data/Script/Window/MessageBox/Panel_Window_MessageBox_Tutorial_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_MessageBox_Tutorial_Init")
function FromClient_PaGlobal_MessageBox_Tutorial_Init()
  PaGlobal_MessageBox_Tutorial:initialize()
end
