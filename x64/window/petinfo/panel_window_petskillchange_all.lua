PaGlobal_Window_PetSkillChange_All = {
  _ui = {
    _stc_TitleArea = nil,
    _btn_WinClose = nil,
    _btn_Question = nil,
    _stc_PetinfoArea = nil,
    _stc_PetIcon = nil,
    _txt_PetName = nil,
    _txt_Tier = nil,
    _txt_BaseSkill = nil,
    _txt_SpecialSkill = nil,
    _txt_SkillChangeFailedCount = nil,
    _stc_buyButton = nil,
    _stc_CurrentSkillSkillArea = nil,
    _stc_CurrentSkillBg = {},
    _stc_CurrentSkillIcon = {},
    _stc_CurrentSkillName = {},
    _stc_SkillChangeButton = {},
    _list2_SkillChangeSlot = nil,
    _stc_SkillListBg = nil,
    _stc_BottomArea = nil,
    _txt_SkillChangeItemCount = nil
  },
  _ui_console = {
    stc_KeyGuideBG = nil,
    stc_Detail = nil,
    stc_Change = nil,
    stc_Close = nil
  },
  _currentPetNo = nil,
  _changingSkillKey = nil,
  _currentSelectedKey = nil,
  _normalSkillCount = 3,
  _isConsole = false,
  _isConsoleToolTipShow = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/PetInfo/Panel_Window_PetSkillChange_All_1.lua")
runLua("UI_Data/Script/Window/PetInfo/Panel_Window_PetSkillChange_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PetSkillChange_All_Init")
function FromClient_PetSkillChange_All_Init()
  PaGlobal_Window_PetSkillChange_All:initialize()
end
