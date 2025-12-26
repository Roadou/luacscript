PaGlobal_AwakeningSuccession = {
  _ui = {
    _btn_left_awakening = UI.getChildControl(Panel_Widget_Awakening_Succession_Select_All, "RadioButton_Awakening_Tab"),
    _btn_right_succession = UI.getChildControl(Panel_Widget_Awakening_Succession_Select_All, "RadioButton_Succession_Tab"),
    _btn_confirm = UI.getChildControl(Panel_Widget_Awakening_Succession_Select_All, "Button_Select"),
    _stc_console_keyguides = UI.getChildControl(Panel_Widget_Awakening_Succession_Select_All, "Static_ConsoleUI_KeyGuide")
  },
  _leftInfo = {
    _stc_characterTexture = nil,
    _stc_WeaponTypeValue = nil,
    _stc_CombatTypeValue = nil,
    _stc_Desc = nil
  },
  _rightInfo = {
    _stc_characterTexture = nil,
    _stc_WeaponTypeValue = nil,
    _stc_CombatTypeValue = nil,
    _stc_Desc = nil
  },
  _processInfo = {_isWatingClearSkillResult = false, _requestSkillType = nil},
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/Awakening_Succession/Panel_Awakening_Succession_1.lua")
runLua("UI_Data/Script/Widget/Awakening_Succession/Panel_Awakening_Succession_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_AwakeningSuccessionInit")
function FromClient_AwakeningSuccessionInit()
  PaGlobal_AwakeningSuccession:initialize()
end
