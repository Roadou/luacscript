PaGlobal_PetSkill_Percent_All = {
  _ui = {
    _list2 = nil,
    _btn_winClose = nil,
    _stc_descBg = nil,
    _stc_bottonDesc = nil,
    _btn_close_pc = nil,
    _txt_keyGuide_console = nil,
    _stc_keyGuide_console = nil,
    _btn_petTier_1 = nil,
    _btn_petTier_2 = nil,
    _stc_SelectBar = nil,
    _stc_LB = nil,
    _stc_RB = nil
  },
  _tier1 = -1,
  _tier2 = -1,
  _isConsole = false,
  _originPosX1 = 0,
  _originPosX2 = 0,
  _initialize = false
}
runLua("UI_Data/Script/Window/PetInfo/Panel_Window_PetSkill_Percent_All_1.lua")
runLua("UI_Data/Script/Window/PetInfo/Panel_Window_PetSkill_Percent_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PetSkill_Percent_All_Init")
function FromClient_PetSkill_Percent_All_Init()
  PaGlobal_PetSkill_Percent_All:initialize()
end
