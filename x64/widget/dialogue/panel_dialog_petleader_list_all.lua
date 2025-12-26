PaGlobal_DialogPetLeader_List_All = {
  _ui = {
    stc_ButtonBg = nil,
    list2_Pet = nil,
    txt_Empty = nil
  },
  _ui_pc = {},
  _ui_console = {
    txt_KeyGuideY = nil,
    txt_KeyGuideA = nil,
    txt_KeyGuideB = nil
  },
  _gradeColorConfig = {
    [0] = Defines.Color.C_FFEFEFEF,
    [1] = Defines.Color.C_FFB5FF6D,
    [2] = Defines.Color.C_FF008AFF,
    [3] = Defines.Color.C_FFFFCE22,
    [4] = Defines.Color.C_FFD05D48
  },
  _contentsSkillIconCount = 4,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_PetLeader_List_All_1.lua")
runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_PetLeader_List_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_DialogPetLeader_List_All_Init")
function FromClient_DialogPetLeader_List_All_Init()
  PaGlobal_DialogPetLeader_List_All:initialize()
end
