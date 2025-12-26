PaGlobal_ChattingColor_All = {
  _ui = {
    stc_title = nil,
    btn_close = nil,
    stc_mainBg = nil,
    txt_chooseDesc = nil,
    stc_colorBg = nil,
    stc_colorTemplate = nil,
    rdo_colorSelectorTemplate = nil,
    stc_btnBg = nil,
    btn_confirm = nil,
    btn_cancel = nil
  },
  _colorList = colorSettingList,
  _boxStartX = 10,
  _boxStartY = 5,
  _boxGapX = 45,
  _boxGapY = 45,
  _boxsCols = 11,
  _colorSelected = Array.new(),
  _savedColorIndex = nil,
  _panelIndex = nil,
  _chatType = nil,
  _buttonType = nil,
  _isSystem = false,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/Chatting/Panel_Window_Chatting_Color_All_1.lua")
runLua("UI_Data/Script/Widget/Chatting/Panel_Window_Chatting_Color_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ChattingColor_All_Init")
function FromClient_ChattingColor_All_Init()
  PaGlobal_ChattingColor_All:initialize()
end
