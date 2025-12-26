PaGlobal_GuildQuestList_All = {
  _ui = {
    stc_CurrentQuestBG = nil,
    txt_ProgressQuestTime = nil,
    txt_ProgressQuestName = nil,
    txt_ProgressQuestCondition = nil,
    btn_GiveUp = nil,
    btn_Complete = nil,
    btn_ProgressingQuestInfo = nil,
    txt_AcceptMember = nil,
    txt_ReAcceptTime = nil,
    stc_QuestListBG = nil,
    stc_CheckBtnBG = nil,
    list2_Quest = nil,
    list2_Content = nil,
    txt_GuildFunds = nil,
    btn_GetGuildMoney = nil,
    btn_ShowQuestLog = nil
  },
  _ui_Console = {},
  _parentBG = nil,
  _BtnCount = 5,
  _rdo_Button = {},
  _guildQuestType = 0,
  _BtnIdx = 1,
  _ChkCount = 4,
  _chk_Button = {},
  _qeustListMaxShowCount = 8,
  _questList = {},
  _defaultRewardSlotCount = 12,
  _rewardSlotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createClassEquipBG = true,
    createCash = true
  },
  _progressQuestConditionMaxCount = 5,
  _progressQuestCondition = {},
  _enableQuestCount = 0,
  _isReqeustMemberBonus = false,
  _latestRefreshGuildQuestTime_s64 = toInt64(0, 0),
  _startRefreshQuestTick32 = 0,
  _remainRestrictTime_s64 = toInt64(0, 0),
  _startRestrictCheckTick32 = 0,
  UNDEFINED_WARRINGLISTINDEX = -1,
  _targetArbitrationGuildWarringListIndex = UNDEFINED_WARRINGLISTINDEX,
  _initialize = false,
  _isConsole = false
}
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildQuestList_All_1.lua")
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildQuestList_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildQuestList_All_Init")
function FromClient_GuildQuestList_All_Init()
  PaGlobal_GuildQuestList_All:initialize()
end
