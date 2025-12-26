PaGlobal_Party_All = {
  _ui = {
    stc_memberTemplate = nil,
    stc_members = {},
    stc_progressBg = nil,
    progress_hp = nil,
    progress_mp = nil,
    stc_classIconBg = nil,
    stc_defaultClassIconBg = nil,
    stc_classIconLeaderBg = nil,
    stc_classIcon = nil,
    txt_level = nil,
    txt_name = nil,
    txt_serverName = nil,
    stc_deadState = nil,
    stc_distanceWifi = nil,
    stc_rootInfo = nil,
    stc_follow = nil,
    stc_memberBG = nil,
    stc_memberBG_mini = nil,
    btn_memberBG = nil,
    btn_memberBG_mini = nil,
    stc_memberTemplate_Mini = nil,
    stc_members_Mini = {},
    stc_morningBossAttributeBg = nil,
    stc_attributeList = {}
  },
  _ui_pc = {
    btn_option = nil,
    btn_leave = nil,
    btn_selfLeave = nil,
    stc_setMemberBg = nil,
    btn_setLeader = nil,
    btn_forceOut = nil,
    stc_OptionBg = nil,
    btn_specialItem = nil,
    btn_marketOption = nil,
    chk_dropItem = nil,
    btn_changeType = nil,
    btn_buttonBanner = nil,
    stc_buttonBG = nil,
    chk_dragToggle = nil,
    stc_dropSetBg = nil,
    radio_free = nil,
    radio_turn = nil,
    radio_rando = nil,
    radio_onlyLeader = nil,
    stc_marketOptionBg = nil,
    stc_mainBg = nil,
    btn_apply = nil,
    txt_marketOptionTitle = nil,
    btn_close = nil,
    txt_minCostTitle = nil,
    txt_minCostValue = nil,
    txt_minGradeTitle = nil,
    txt_minGradeValue = nil,
    btn_minCost = nil,
    btn_Grade = nil,
    stc_gradeOptionBg = nil,
    btn_grades = {},
    chk_minCost = nil,
    chk_grade = nil,
    stc_valuePack_enable = nil,
    stc_valuePack_disable = nil,
    stc_optionBG_Mini = nil,
    btn_specialItem_Mini = nil,
    btn_marketOption_Mini = nil,
    chk_dropItem_Mini = nil,
    btn_changeType_Mini = nil,
    stc_dropSetBg_Mini = nil,
    radio_free_Mini = nil,
    radio_turn_Mini = nil,
    radio_rando_Mini = nil,
    radio_onlyLeader_Mini = nil,
    stc_buttonBG_Mini = nil,
    chk_dragToggle_Mini = nil,
    stc_valuePack_mini_enable = nil,
    stc_valuePack_mini_disable = nil
  },
  _textureWifi = {
    ["path"] = "Renewal/ETC/Console_ETC_00.dds",
    [1] = {
      [1] = 51,
      [2] = 275,
      [3] = 74,
      [4] = 295
    },
    [2] = {
      [1] = 51,
      [2] = 296,
      [3] = 74,
      [4] = 316
    },
    [3] = {
      [1] = 51,
      [2] = 317,
      [3] = 74,
      [4] = 337
    },
    [4] = {
      [1] = 51,
      [2] = 338,
      [3] = 74,
      [4] = 358
    }
  },
  _textureRootInfo = {
    [1] = {
      [1] = 51,
      [2] = 359,
      [3] = 74,
      [4] = 379
    },
    [2] = {
      [1] = 51,
      [2] = 380,
      [3] = 74,
      [4] = 400
    }
  },
  _itemGradeString = {
    [0] = PAGetString(Defines.StringSheet_GAME, "LUA_PARTY_NOT_SETTING"),
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_PARTY_ITEMGRADE_GREEN"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_PARTY_ITEMGRADE_BLUE"),
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_PARTY_ITEMGRADE_YELLOW"),
    [4] = PAGetString(Defines.StringSheet_GAME, "LUA_PARTY_ITEMGRADE_ORANGE")
  },
  _config = {
    maxPartyCnt = 5,
    gapY = 0,
    miniGapY = 10,
    baseMoney = toInt64(0, 1000000),
    maxMoney = toInt64(0, 100000000)
  },
  _partyData = {},
  _currentMoney = 0,
  _currentGrade = 0,
  _inviteReqList = {},
  _refuseName = nil,
  _withdrawMember = nil,
  _preLootType = nil,
  _prevPrice = nil,
  _prevGrade = nil,
  _firstCheck = 0,
  _lastSelectUser = nil,
  _selectGrade = 0,
  _isMainChannel = false,
  _isDevServer = ToClient_IsDevelopment(),
  _isRootShowFlag = false,
  _currentPartyType = nil,
  _isMini = false,
  _isMemberDataLoad = false,
  _refCount = 0,
  _updateTime = 0,
  _isMouseOn = false,
  _isConsole = false,
  _initialize = false,
  _morningBossAttributeIcon = {
    [__eElementalStat_Sun] = "Combine_Etc_MorningLand_Boss_01_Icon_Quality_Sun",
    [__eElementalStat_Moon] = "Combine_Etc_MorningLand_Boss_01_Icon_Quality_Moon",
    [__eElementalStat_Land] = "Combine_Etc_MorningLand_Boss_01_Icon_Quality_Land"
  }
}
runLua("UI_Data/Script/Widget/Party/Panel_Widget_Party_All_New_1.lua")
runLua("UI_Data/Script/Widget/Party/Panel_Widget_Party_All_New_2.lua")
changePositionBySever(Panel_Widget_Party_All, CppEnums.PAGameUIType.PAGameUIPanel_Party, false, true, false)
registerEvent("FromClient_luaLoadCompleteLateUdpate", "FromClient_Widget_Party_All_Init")
function FromClient_Widget_Party_All_Init()
  PaGlobal_Party_All:initialize()
end
