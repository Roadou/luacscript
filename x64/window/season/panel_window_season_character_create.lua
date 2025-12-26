PaGlobal_Season_Character_Create = {
  _ui = {
    _stc_titleBG = UI.getChildControl(Panel_Window_Season_Character_Create, "Static_Title_Bg"),
    _btn_season = UI.getChildControl(Panel_Window_Season_Character_Create, "Button_Season"),
    _btn_normal = UI.getChildControl(Panel_Window_Season_Character_Create, "Button_Normal"),
    _stc_keyGuideBG = UI.getChildControl(Panel_Window_Season_Character_Create, "Static_BottomBg_ConsoleUI")
  },
  _playerCreateType = nil,
  _isSeasonCharacter = nil,
  _initialize = false
}
runLua("UI_Data/Script/Window/Season/Panel_Window_Season_Character_Create_1.lua")
runLua("UI_Data/Script/Window/Season/Panel_Window_Season_Character_Create_2.lua")
function FromClient_PaGlobal_Season_Character_Create_Init()
  PaGlobal_Season_Character_Create:initialize()
end
FromClient_PaGlobal_Season_Character_Create_Init()
