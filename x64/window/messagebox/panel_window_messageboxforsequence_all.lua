PaGlobal_Window_MessageBoxForSequence_All = {
  _ui = {
    _stc_blockBG = nil,
    _stc_text = nil,
    _txt_static_text_title = nil,
    _btn_yes = nil,
    _btn_no = nil,
    _btn_close = nil,
    _multilineText_content = nil,
    _multilineText_selectType = nil,
    _stc_acceptTime = nil,
    _stc_progessBG = nil,
    _stc_progressBar = nil,
    _stc_attributeList = nil,
    _rdo_Attribute_Sun = nil,
    _rdo_Attribute_Moon = nil,
    _rdo_Attribute_Land = nil,
    _stc_bottomBg_consoleUI = nil,
    _stc_bottomBg_consoleUI_txt_a_consoleUI = nil,
    _stc_bottomBg_consoleUI_txt_b_consoleUI = nil,
    _stc_bottomBg_consoleUI_txt_y_consoleUI = nil,
    _stc_consoleUI = nil,
    _stc_progressBar = nil
  },
  _isConsole = false,
  _attributeList = {},
  _currentSelectAttribute = 0,
  _difficultList = {},
  _MESSAGEBOX_CLOSETIME = 20,
  _messageDeltaTime = 0,
  _isAcceptInvite = nil,
  _MESSAGEBOX_CONTENT_TEXTSIZE_Y = 26,
  _MESSAGEBOX_ORIGINAL_SIZE_Y = 300,
  _MESSAGEBOX_UI_GAP = 15,
  _initialize = false
}
runLua("UI_Data/Script/Window/MessageBox/Panel_Window_MessageBoxForSequence_All_1.lua")
runLua("UI_Data/Script/Window/MessageBox/Panel_Window_MessageBoxForSequence_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Window_MessageBoxForSequence_All_Init")
function FromClient_Window_MessageBoxForSequence_All_Init()
  PaGlobal_Window_MessageBoxForSequence_All:initialize()
end
