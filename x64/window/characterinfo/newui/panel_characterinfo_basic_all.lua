PaGlobal_CharInfoBasic_All = {
  _ui = {
    photoBg = nil,
    stc_CharPhoto = nil,
    btn_FacePhoto = nil,
    stc_EnchantStackIcon = nil,
    txt_EnchantStackIcon_Value = nil,
    txt_FamilyName = nil,
    txt_PlayerName = nil,
    txt_PlayerLv = nil,
    stc_IntroduceBg = nil,
    stc_EditBoxIcon = nil,
    edit_multiEdit = nil,
    c_prog_Hp = nil,
    txt_HpTitle = nil,
    txt_HpVal = nil,
    c_prog_Mp = nil,
    txt_MpTitle = nil,
    txt_Mp_Val = nil,
    c_prog_LT = nil,
    txt_LTTitle = nil,
    txt_LtVal = nil,
    fameBg = nil,
    txt_BattlePoint = nil,
    txt_LifePoint = nil,
    txt_SpecialPoint = nil,
    txt_FamilyPoint = nil,
    txt_BattlePointTitle = nil,
    txt_LifePointTitle = nil,
    txt_SpecialPointTitle = nil,
    txt_FamilyPointTitle = nil,
    statBg = nil,
    stc_Tendency = nil,
    stc_Wp = nil,
    stc_Contribute = nil,
    stc_SkillPoint = nil,
    stc_Star = nil,
    stc_EnchantCount = nil,
    txt_Tendency = nil,
    txt_OceanTendency = nil,
    stc_OceanTendencyPirateIcon = nil,
    stc_OceanTendencyNavyIcon = nil,
    txt_Wp = nil,
    txt_Contribute = nil,
    txt_SkillPoint = nil,
    txt_Star = nil,
    txt_EnchantCount = nil,
    txt_SelfTimer = nil,
    stc_SelfTimer = nil,
    txt_MusicGradeValue = nil,
    txt_MusicGradeTitle = nil,
    stc_RightBg = nil,
    stc_RightTapBg = nil,
    stc_KeyGuide_LT = nil,
    stc_KeyGuide_RT = nil,
    rdo_BattleInfo = nil,
    rdo_LifeInfo = nil,
    stc_TabSelectBar = nil,
    stc_RightInfoBg = nil,
    stc_BattleInfoBg = nil,
    stc_FitnessBg = nil,
    txt_Breath = nil,
    txt_BreathLv = nil,
    prog_Breath = nil,
    txt_Power = nil,
    txt_PowerLv = nil,
    prog_Power = nil,
    txt_Health = nil,
    txt_HealthLv = nil,
    prog_Health = nil,
    stc_PotenBg = nil,
    txt_AtkSpd = nil,
    txt_AtkLv = nil,
    txt_MoveSpd = nil,
    txt_MoveLv = nil,
    txt_Critical = nil,
    txt_CriticalLv = nil,
    txt_Fish = nil,
    txt_FishLv = nil,
    txt_Gather = nil,
    txt_GatherLv = nil,
    txt_Luck = nil,
    txt_LuckLv = nil,
    stc_CombatBg = nil,
    txt_AtkTitle = nil,
    txt_Atk = nil,
    txt_AwakenTitle = nil,
    txt_AwakenAtk = nil,
    txt_DefTitle = nil,
    txt_Def = nil,
    txt_StaminaTitle = nil,
    txt_Stamina = nil,
    txt_StunRegistTitle = nil,
    txt_StunRegist = nil,
    txt_DownRegistTitle = nil,
    txt_DownRegist = nil,
    txt_AirRegistTitle = nil,
    txt_AirRegist = nil,
    txt_AtkTypeTitle = nil,
    txt_AtkTypeRegist = nil,
    txt_ItemDropRateTitle = nil,
    txt_ItemDropRate = nil,
    btn_MyStatInfoBtn = nil,
    stc_LifeBg = nil,
    stc_LifeTable = {},
    btn_ShowDetail = nil,
    btn_LifeRanking = nil,
    stc_KeyGuide_Bg = nil,
    stc_KeyGuide_A = nil,
    stc_KeyGuide_B = nil,
    stc_KeyGuide_X = nil,
    stc_KeyGuide_Y = nil,
    stc_KeyGuide_RS = nil,
    stc_KeyGuide_LS = nil
  },
  _LIFEINFOCOUNT = 11,
  _ENUM_FITNESS = {
    BREATH = 0,
    POWER = 1,
    HEALTH = 2
  },
  _ENUM_FAMILY_PIONT_TYPE = {
    ALL = 0,
    BATTLE = 1,
    LIFE = 2,
    ETC = 3
  },
  _familyBattlePoint = 0,
  _familyLifePoint = 0,
  _familyEtcPoint = 0,
  _familySumPoint = 0,
  _battlePointSection = {
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_BASIC_FAMILYBATTLEPOINT_DESC"),
    sectionStart = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_BASIC_FAMILY_SECTIONSTART"),
    count = 21,
    conditionDesc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_BASIC_FAMILYBATTLEPOINT_CONDITION"),
    reciveDesc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_BASIC_FAMILY_RECIVE_DESC")
  },
  _lifePointSection = {
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_BASIC_FAMILYLIFEPOINT_DESC"),
    sectionStart = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_BASIC_FAMILY_SECTIONSTART"),
    count = 7,
    conditionDesc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_BASIC_FAMILYLIFEPOINT_CONDITION"),
    reciveDesc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_BASIC_FAMILY_RECIVE_DESC")
  },
  _etcPointSection = {
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_BASIC_FAMILYETCPOINT_DESC"),
    sectionStart = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_BASIC_FAMILY_SECTIONSTART"),
    count = 7,
    conditionDesc = "",
    reciveDesc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_BASIC_FAMILY_RECIVE_DESC")
  },
  _allPointSection = {
    ["desc"] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_BASIC_FAMILYALLPOINT_DESC"),
    ["sectionStart"] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_BASIC_FAMILY_SECTIONSTART"),
    [0] = {
      start = 1000,
      next = 4000,
      bonus = 0.5,
      itemBonus = 0
    },
    [1] = {
      start = 4000,
      next = 7000,
      bonus = 1,
      itemBonus = 0
    },
    [2] = {
      start = 7000,
      next = nil,
      bonus = 1.5,
      itemBonus = 10
    },
    ["count"] = 3,
    ["conditionDesc"] = "",
    ["reciveDesc"] = ""
  },
  _fitnessData = {},
  _potentialData = {},
  _statusTable = {},
  _MAX_POTENCIALSLOT = 4,
  _ENUM_POTEN = {
    ATKSPD = 0,
    MOVESPD = 1,
    CRITICAL = 2,
    FISH = 3,
    COLLECT = 4,
    LUCK = 5
  },
  _iconInfo = {
    skill = {
      name = "combine/icon/combine_basic_icon_00.dds",
      uv = {
        x1 = 379,
        y1 = 434,
        x2 = 407,
        y2 = 462
      }
    },
    music = {
      name = "combine/icon/combine_basic_icon_01.dds",
      uv = {
        x1 = 1,
        y1 = 27,
        x2 = 28,
        y2 = 54
      }
    },
    enchant = {
      name = "combine/etc/combine_etc_blackspirit_01.dds",
      uv = {
        x1 = 218,
        y1 = 304,
        x2 = 248,
        y2 = 334
      }
    }
  },
  _consoleTooltip = {},
  _statOriginSpanX = 30,
  _asianFlag = false,
  _checkAwaken = nil,
  _currentTab = 0,
  _isAwakenWeaponContentsOpen = false,
  _contributeUsePoint = {
    [0] = PAGetString(Defines.StringSheet_GAME, "LUA_EXPGUAGE_CONTRIBUTE_VALUE_1"),
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_EXPGUAGE_CONTRIBUTE_VALUE_2"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_EXPGUAGE_CONTRIBUTE_VALUE_3")
  },
  _selfPlayer = nil,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_Basic_All_1.lua")
runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_Basic_All_2.lua")
runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_Basic_All_3.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_CharInfoBasic_AllInit")
function FromClient_CharInfoBasic_AllInit()
  PaGlobal_CharInfoBasic_All:initialize()
end
