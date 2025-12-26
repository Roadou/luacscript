PaGlobal_CharacterStatNew_All = {
  _ui = {
    stc_titleText_PVE = nil,
    btn_close = nil,
    btn_detail = nil,
    btn_bonusStat = nil,
    stc_padKeyGuide = nil
  },
  _uiValue = {},
  STAT_ENUM = {
    MAIN_OFFENCE = 1,
    AWAKEN_OFFENCE = 2,
    HIT = 3,
    DV_1 = 4,
    DV_2 = 5,
    DV_3 = 6,
    PV_1 = 7,
    PV_2 = 8,
    PV_3 = 9,
    PV_RATE = 10,
    CC_REG_1 = 11,
    CC_REG_2 = 12,
    CC_REG_3 = 13,
    PERCENT_CRI = 14,
    PERCENT_CRI_DAMAGE = 15,
    PERCENT_BACK_DAMAGE = 16,
    PERCENT_AIR_DAMAGE = 17,
    PERCENT_DOWN_DAMAGE = 18,
    COUNT = 19
  },
  _initialize = false
}
runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_Window_StatNew_All_1.lua")
runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_Window_StatNew_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Panel_Window_StatNew_All_Init")
function FromClient_Panel_Window_StatNew_All_Init()
  PaGlobal_CharacterStatNew_All:initialize()
end
