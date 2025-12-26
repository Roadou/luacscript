PaGlobal_Dialog_HorseLevelDecrease_All = {
  _ui = {
    _txt_title = nil,
    _stc_mainBg = nil,
    _stc_imageBG = nil,
    _stc_horseImage = nil,
    _stc_horseGenderIcon = nil,
    _btn_horseSimulator = nil,
    _stc_currentLevelBg = nil,
    _txt_currentLevel_level = nil,
    _txt_currentLevel_hpValue = nil,
    _txt_currentLevel_staminaValue = nil,
    _txt_currentLevel_weightValue = nil,
    _txt_currentLevel_speedValue = nil,
    _txt_currentLevel_accelerationValue = nil,
    _txt_currentLevel_corneringSpeedValue = nil,
    _txt_currentLevel_breakValue = nil,
    _stc_downLevelBg = nil,
    _txt_downLevel_level = nil,
    _txt_downLevel_hpValue = nil,
    _txt_downLevel_staminaValue = nil,
    _txt_downLevel_weightValue = nil,
    _txt_downLevel_speedValue = nil,
    _txt_downLevel_accelerationValue = nil,
    _txt_downLevel_corneringSpeedValue = nil,
    _txt_downLevel_breakValue = nil,
    _btn_close = nil,
    _btn_confirm = nil,
    _btn_cancel = nil,
    _stc_skillReset = nil,
    _stc_skillIcon = nil,
    _txt_skillName = nil,
    _txt_priceBg = nil,
    _txt_priceValue = nil,
    _stc_bottomBg_consoleUI = nil,
    _stc_bottomBg_consoleUI_A = nil,
    _stc_bottomBg_consoleUI_B = nil
  },
  _servantNo = nil,
  _initialize = false
}
runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_HorseLevelDecrease_All_1.lua")
runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_HorseLevelDecrease_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Dialog_HorseLevelDecrease_All_Init")
function FromClient_Dialog_HorseLevelDecrease_All_Init()
  PaGlobal_Dialog_HorseLevelDecrease_All:initialize()
end
