PaGlobal_CharacterStatDetail_All = {
  _ui = {
    list2_Contents = nil,
    btn_close = nil,
    stc_padKeyGuid = nil
  },
  STAT_ENUM = {
    MAIN_OFFENCE = 1,
    AWAKEN_OFFENCE = 2,
    MON_DD = 3,
    PLAYER_DD = 4,
    TRIBE_HUMAN_DD = 5,
    TRIBE_AIN_DD = 6,
    TRIBE_ANIMAL_DD = 7,
    TRIBE_KAMASILVIA_DD = 8,
    TRIBE_EDANIA_DD = nil,
    CRITIAL_PERENCT = 10,
    CRITIAL_DAMAGE = 11,
    BACK_ATTAK_PERENCT = 12,
    AIR_ATTAK_PERENCT = 13,
    DOWN_ATTACK_PERENCT = 14,
    HIT = 15,
    DV_1 = 16,
    DV_2 = 17,
    DV_3 = 18,
    PV_1 = 19,
    PV_2 = 20,
    PV_3 = 21,
    MON_PV = 22,
    PV_RATE = 23,
    PV_RATE_MON = 24,
    CC_REG_1 = 25,
    CC_REG_2 = 26,
    CC_REG_3 = 27
  },
  STAT_ENUM_SORT = {},
  _initialize = false
}
runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_Window_StatDetail_All_1.lua")
runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_Window_StatDetail_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Panel_Window_StatDetail_All_Init")
function FromClient_Panel_Window_StatDetail_All_Init()
  PaGlobal_CharacterStatDetail_All:initialize()
end
