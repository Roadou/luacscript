PaGlobal_BeginnerEnchantGuide_All = {
  _ui = {
    _stc_TitleBar = nil,
    _txt_TitleIcon = nil,
    _stc_CloseIcon = nil,
    _stc_ImageBox = nil,
    _stc_Image_1 = nil,
    _stc_Image_2 = nil,
    _stc_Image_3 = nil,
    _stc_Image_4 = nil,
    _stc_Image_5 = nil,
    _stc_Image_6 = nil,
    _txt_1 = nil,
    _txt_2 = nil,
    _txt_3 = nil,
    _btn_Left = nil,
    _btn_Right = nil,
    _txt_KeyGuide_LB_ConsoleUI = nil,
    _txt_KeyGuide_LB_ConsoleUI = nil,
    _stc_DescBox = nil,
    _txt_Title = nil,
    _multxt_Desc = nil,
    _stc_TitleDeco = nil,
    _stc_PageBar = nil,
    _stc_Dot_1 = nil,
    _stc_Dot_2 = nil,
    _stc_Dot_3 = nil,
    _stc_Dot_4 = nil,
    _stc_Dot_5 = nil,
    _stc_Dot_6 = nil
  },
  _DIR = {_LEFT = 0, _RIGHT = 1},
  _PAGE_BOUND = {_MIN = 1, _MAX = 6},
  _curPageNum = nil,
  _initialize = false
}
runLua("UI_Data/Script/Window/Enchant/Panel_Window_BeginnerEnchantGuide_All_1.lua")
runLua("UI_Data/Script/Window/Enchant/Panel_Window_BeginnerEnchantGuide_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_BeginnerEnchantGuide_All_Init")
function FromClient_BeginnerEnchantGuide_All_Init()
  PaGlobal_BeginnerEnchantGuide_All:initialize()
end
