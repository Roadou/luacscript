PaGlobal_MorningBossRank = {
  _ui = {
    _btn_Close = nil,
    _btn_Wiki = nil,
    _list2_BossList = nil,
    _btn_RewardView = nil,
    _btn_MyRank = nil,
    _combo2_MorningLandPart = nil,
    _combo2_Difficulty = nil,
    _combo2_Class = nil,
    _stc_Rank1Bg = nil,
    _txt_Rank1 = nil,
    _stc_Rank1AwakenIcon = nil,
    _txt_Rank1Level = nil,
    _txt_Rank1CharName = nil,
    _txt_Rank1Time = nil,
    _txt_Rank1OtherPlatform = nil,
    _stc_Rank2Bg = nil,
    _txt_Rank2 = nil,
    _stc_Rank2AwakenIcon = nil,
    _txt_Rank2Level = nil,
    _txt_Rank2CharName = nil,
    _txt_Rank2Time = nil,
    _txt_Rank2OtherPlatform = nil,
    _stc_Rank3Bg = nil,
    _txt_Rank3 = nil,
    _stc_Rank3AwakenIcon = nil,
    _txt_Rank3Level = nil,
    _txt_Rank3CharName = nil,
    _txt_Rank3Time = nil,
    _txt_Rank3OtherPlatform = nil,
    _stc_RankingBg = nil,
    _stc_RankingBgPart2 = nil,
    _txt_NoRecord = nil,
    _stc_GuildRank1Bg = nil,
    _txt_GuildRank1 = nil,
    _txt_GuildRank1Name = nil,
    _txt_GuildRank1Member1 = nil,
    _txt_GuildRank1Member2 = nil,
    _txt_GuildRank1Member3 = nil,
    _txt_GuildRank1Member4 = nil,
    _txt_GuildRank1Member5 = nil,
    _txt_GuildRank1Time = nil,
    _stc_GuildRank2Bg = nil,
    _txt_GuildRank2 = nil,
    _txt_GuildRank2Name = nil,
    _txt_GuildRank2Member1 = nil,
    _txt_GuildRank2Member2 = nil,
    _txt_GuildRank2Member3 = nil,
    _txt_GuildRank2Member4 = nil,
    _txt_GuildRank2Member5 = nil,
    _txt_GuildRank2Time = nil,
    _stc_GuildRank3Bg = nil,
    _txt_GuildRank3 = nil,
    _txt_GuildRank3Name = nil,
    _txt_GuildRank3Member1 = nil,
    _txt_GuildRank3Member2 = nil,
    _txt_GuildRank3Member3 = nil,
    _txt_GuildRank3Member4 = nil,
    _txt_GuildRank3Member5 = nil,
    _txt_GuildRank3Time = nil,
    _list2_OtherRankList = nil,
    _list2_OtherGuildRankList = nil,
    _stc_ConsoleKeyBG = nil,
    _stc_ConsoleKeyA = nil,
    _stc_ConsoleKeyB = nil,
    _stc_ConsoleKeyX = nil,
    _stc_ConsoleKeyY = nil
  },
  _bossTexture = {
    [0] = "Combine_Etc_MorningLand_Boss_01_List_Profile_06",
    [1] = "Combine_Etc_MorningLand_Boss_01_List_Profile_07",
    [2] = "Combine_Etc_MorningLand_Boss_01_List_Profile_09",
    [3] = "Combine_Etc_MorningLand_Boss_01_List_Profile_03",
    [4] = "Combine_Etc_MorningLand_Boss_01_List_Profile_04",
    [5] = "Combine_Etc_MorningLand_Boss_01_List_Profile_08",
    [6] = "Combine_Etc_MorningLand_Boss_01_List_Profile_01",
    [7] = "Combine_Etc_MorningLand_Boss_01_List_Profile_02",
    [8] = "Combine_Etc_MorningLand_Boss_01_List_Profile_05",
    [9] = "Combine_Etc_MorningLand_Boss_01_List_Profile_11",
    [10] = "Combine_Etc_MorningLandPt2_Boss_01_List_Profile_05",
    [11] = "Combine_Etc_MorningLandPt2_Boss_01_List_Profile_07",
    [12] = "Combine_Etc_MorningLandPt2_Boss_01_List_Profile_01",
    [13] = "Combine_Etc_MorningLandPt2_Boss_01_List_Profile_03",
    [14] = "Combine_Etc_MorningLandPt2_Boss_01_List_Profile_04",
    [15] = "Combine_Etc_MorningLandPt2_Boss_01_List_Profile_10",
    [16] = "Combine_Etc_MorningLandPt2_Boss_01_List_Profile_02",
    [17] = "Combine_Etc_MorningLandPt2_Boss_01_List_Profile_06",
    [18] = "Combine_Etc_MorningLandPt2_Boss_01_List_Profile_08",
    [19] = "Combine_Etc_MorningLandPt2_Boss_01_List_Profile_09",
    [20] = "Combine_Etc_MorningLandPt2_Boss_01_List_Profile_11",
    [21] = "Combine_Etc_MorningLandPt2_Boss_01_List_Profile_12"
  },
  _statTexture = {
    [0] = "Combine_Etc_MorningLand_Boss_01_Icon_Quality_Sun",
    [1] = "Combine_Etc_MorningLand_Boss_01_Icon_Quality_Moon",
    [2] = "Combine_Etc_MorningLand_Boss_01_Icon_Quality_Land"
  },
  _skillAwakenIcon = {
    [0] = "",
    [1] = "Combine_Etc_MorningLand_BossRanking_Icon_Awaken",
    [2] = "Combine_Etc_MorningLand_BossRanking_Icon_Succesion"
  },
  _comboBoxType = {
    ClassType = 0,
    Difficulty = 1,
    MorningLandPart = 2
  },
  _rankInfoTable = {},
  _guildRankInfoTable = {},
  _list2BossList = {},
  _totalBossKeyCount = 0,
  _selectedBossGroupIndex = 0,
  _selectedLevelIndex = 0,
  _selectedClassComboIndex = 0,
  _selectedMorningLandMonsterPart = __eMorningLandMosterPart1,
  _classTypeByComboIndexTbl = Array.new(),
  _isBossList2Pushed = false,
  _isConsole = false,
  _platformType = -1,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_MorningLand_BossRanking_Init")
function FromClient_MorningLand_BossRanking_Init()
  PaGlobal_MorningBossRank:initialize()
end
function PaGlobal_MorningBossRank:initialize()
  if true == PaGlobal_MorningBossRank._initialize or nil == Panel_MorningLand_BossRanking then
    return
  end
  local stc_Title = UI.getChildControl(Panel_MorningLand_BossRanking, "Static_TitleArea")
  self._ui._btn_Close = UI.getChildControl(stc_Title, "Button_Close_PCUI")
  self._ui._btn_Wiki = UI.getChildControl(stc_Title, "Button_Question_PCUI")
  self._ui._list2_BossList = UI.getChildControl(Panel_MorningLand_BossRanking, "List2_BossList")
  local stc_RankArea = UI.getChildControl(Panel_MorningLand_BossRanking, "Static_RakingArea")
  self._ui._btn_RewardView = UI.getChildControl(stc_RankArea, "Button_Reward_View")
  self._ui._btn_MyRank = UI.getChildControl(stc_RankArea, "Button_Reward_MyRank")
  local buttonArea = UI.getChildControl(stc_RankArea, "Static_ButtonArea")
  self._ui._combo2_MorningLandPart = UI.getChildControl(buttonArea, "Combobox2_Chapter")
  self._ui._combo2_Difficulty = UI.getChildControl(buttonArea, "Combobox_Difficulty")
  self._ui._combo2_Class = UI.getChildControl(buttonArea, "Combobox_Class")
  self._ui._stc_RankingBg = UI.getChildControl(stc_RankArea, "Static_RakingCanvas")
  self._ui._stc_RankingBgPart2 = UI.getChildControl(stc_RankArea, "Static_RankingCanvas2")
  self._ui._txt_NoRecord = UI.getChildControl(stc_RankArea, "StaticText_NoRanking")
  self._ui._stc_RankingAreaLock = UI.getChildControl(stc_RankArea, "Static_RakingArea_Lock")
  local stc_MainRank = UI.getChildControl(self._ui._stc_RankingBg, "Static_Main_Rank")
  self._ui._stc_Rank1Bg = UI.getChildControl(stc_MainRank, "Static_Rank_1st")
  local stc_Rank1Bg_C = UI.getChildControl(self._ui._stc_Rank1Bg, "Static_RankBG_1st")
  self._ui._txt_Rank1 = UI.getChildControl(stc_Rank1Bg_C, "StaticText_Rank_1st")
  local stc_Rank1InfoBG = UI.getChildControl(self._ui._stc_Rank1Bg, "Static_RankInfo_1st")
  self._ui._txt_Rank1Level = UI.getChildControl(stc_Rank1InfoBG, "StaticText_Level_1st")
  self._ui._stc_Rank1AwakenIcon = UI.getChildControl(self._ui._txt_Rank1Level, "Static_Symbol_Class_1st")
  self._ui._stc_Rank1PS = UI.getChildControl(self._ui._txt_Rank1Level, "Static_Icon_PS")
  self._ui._stc_Rank1XBOX = UI.getChildControl(self._ui._txt_Rank1Level, "Static_Icon_XBOX")
  self._ui._stc_Rank1OTHER = UI.getChildControl(self._ui._txt_Rank1Level, "Static_Icon_Other")
  self._ui._txt_Rank1CharName = UI.getChildControl(stc_Rank1InfoBG, "StaticText_CharName_1st")
  self._ui._txt_Rank1Time = UI.getChildControl(stc_Rank1InfoBG, "StaticText_Time_1st")
  self._ui._txt_Rank1OtherPlatform = UI.getChildControl(stc_Rank1InfoBG, "StaticText_OtherPlatform_1st")
  self._ui._stc_Rank2Bg = UI.getChildControl(stc_MainRank, "Static_Rank_2nd")
  local stc_Rank2Bg_C = UI.getChildControl(self._ui._stc_Rank2Bg, "Static_RankBG_2nd")
  self._ui._txt_Rank2 = UI.getChildControl(stc_Rank2Bg_C, "StaticText_Rank_2nd")
  local stc_Rank2InfoBG = UI.getChildControl(self._ui._stc_Rank2Bg, "Static_RankInfo_2nd")
  self._ui._txt_Rank2Level = UI.getChildControl(stc_Rank2InfoBG, "StaticText_Level_2nd")
  self._ui._stc_Rank2AwakenIcon = UI.getChildControl(self._ui._txt_Rank2Level, "Static_Symbol_Class_2nd")
  self._ui._stc_Rank2PS = UI.getChildControl(self._ui._txt_Rank2Level, "Static_Icon_PS")
  self._ui._stc_Rank2XBOX = UI.getChildControl(self._ui._txt_Rank2Level, "Static_Icon_XBOX")
  self._ui._stc_Rank2OTHER = UI.getChildControl(self._ui._txt_Rank2Level, "Static_Icon_Other")
  self._ui._txt_Rank2CharName = UI.getChildControl(stc_Rank2InfoBG, "StaticText_CharName_2nd")
  self._ui._txt_Rank2Time = UI.getChildControl(stc_Rank2InfoBG, "StaticText_Time_2nd")
  self._ui._txt_Rank2OtherPlatform = UI.getChildControl(stc_Rank2InfoBG, "StaticText_OtherPlatform_2nd")
  self._ui._stc_Rank3Bg = UI.getChildControl(stc_MainRank, "Static_Rank_3rd")
  local stc_Rank3Bg_C = UI.getChildControl(self._ui._stc_Rank3Bg, "Static_RankBG_3rd")
  self._ui._txt_Rank3 = UI.getChildControl(stc_Rank3Bg_C, "StaticText_Rank_3rd")
  local stc_Rank3InfoBG = UI.getChildControl(self._ui._stc_Rank3Bg, "Static_RankInfo_3rd")
  self._ui._txt_Rank3Level = UI.getChildControl(stc_Rank3InfoBG, "StaticText_Level_3rd")
  self._ui._stc_Rank3AwakenIcon = UI.getChildControl(self._ui._txt_Rank3Level, "Static_Symbol_Class_3rd")
  self._ui._stc_Rank3PS = UI.getChildControl(self._ui._txt_Rank3Level, "Static_Icon_PS")
  self._ui._stc_Rank3XBOX = UI.getChildControl(self._ui._txt_Rank3Level, "Static_Icon_XBOX")
  self._ui._stc_Rank3OTHER = UI.getChildControl(self._ui._txt_Rank3Level, "Static_Icon_Other")
  self._ui._txt_Rank3CharName = UI.getChildControl(stc_Rank3InfoBG, "StaticText_CharName_3rd")
  self._ui._txt_Rank3Time = UI.getChildControl(stc_Rank3InfoBG, "StaticText_Time_3rd")
  self._ui._txt_Rank3OtherPlatform = UI.getChildControl(stc_Rank3InfoBG, "StaticText_OtherPlatform_3rd")
  self._ui._list2_OtherRankList = UI.getChildControl(self._ui._stc_RankingBg, "List2_OtherRankList")
  local stc_MainGuildRank = UI.getChildControl(self._ui._stc_RankingBgPart2, "Static_Main_Rank")
  self._ui._stc_GuildRank1Bg = UI.getChildControl(stc_MainGuildRank, "Static_Rank_1st")
  local stc_GuildRank1Bg_C = UI.getChildControl(self._ui._stc_GuildRank1Bg, "Static_RankBG_1st")
  self._ui._txt_GuildRank1 = UI.getChildControl(stc_GuildRank1Bg_C, "StaticText_Rank_1st")
  local stc_GuildRank1InfoBg = UI.getChildControl(self._ui._stc_GuildRank1Bg, "Static_RankInfo_1st")
  self._ui._txt_GuildRank1Name = UI.getChildControl(stc_GuildRank1InfoBg, "StaticText_GuildName")
  self._ui._txt_GuildRank1Member1 = UI.getChildControl(stc_GuildRank1InfoBg, "StaticText_Member_1")
  self._ui._txt_GuildRank1Member2 = UI.getChildControl(stc_GuildRank1InfoBg, "StaticText_Member_2")
  self._ui._txt_GuildRank1Member3 = UI.getChildControl(stc_GuildRank1InfoBg, "StaticText_Member_3")
  self._ui._txt_GuildRank1Member4 = UI.getChildControl(stc_GuildRank1InfoBg, "StaticText_Member_4")
  self._ui._txt_GuildRank1Member5 = UI.getChildControl(stc_GuildRank1InfoBg, "StaticText_Member_5")
  self._ui._txt_GuildRank1Time = UI.getChildControl(stc_GuildRank1InfoBg, "StaticText_Time")
  self._ui._stc_GuildRank2Bg = UI.getChildControl(stc_MainGuildRank, "Static_Rank_2nd")
  local stc_GuildRank2Bg_C = UI.getChildControl(self._ui._stc_GuildRank2Bg, "Static_RankBG_2nd")
  self._ui._txt_GuildRank2 = UI.getChildControl(stc_GuildRank2Bg_C, "StaticText_Rank_2nd")
  local stc_GuildRank2InfoBg = UI.getChildControl(self._ui._stc_GuildRank2Bg, "Static_RankInfo_2nd")
  self._ui._txt_GuildRank2Name = UI.getChildControl(stc_GuildRank2InfoBg, "StaticText_GuildName")
  self._ui._txt_GuildRank2Member1 = UI.getChildControl(stc_GuildRank2InfoBg, "StaticText_Member_1")
  self._ui._txt_GuildRank2Member2 = UI.getChildControl(stc_GuildRank2InfoBg, "StaticText_Member_2")
  self._ui._txt_GuildRank2Member3 = UI.getChildControl(stc_GuildRank2InfoBg, "StaticText_Member_3")
  self._ui._txt_GuildRank2Member4 = UI.getChildControl(stc_GuildRank2InfoBg, "StaticText_Member_4")
  self._ui._txt_GuildRank2Member5 = UI.getChildControl(stc_GuildRank2InfoBg, "StaticText_Member_5")
  self._ui._txt_GuildRank2Time = UI.getChildControl(stc_GuildRank2InfoBg, "StaticText_Time")
  self._ui._stc_GuildRank3Bg = UI.getChildControl(stc_MainGuildRank, "Static_Rank_3rd")
  local stc_GuildRank3Bg_C = UI.getChildControl(self._ui._stc_GuildRank3Bg, "Static_RankBG_3rd")
  self._ui._txt_GuildRank3 = UI.getChildControl(stc_GuildRank3Bg_C, "StaticText_Rank_3rd")
  local stc_GuildRank3InfoBg = UI.getChildControl(self._ui._stc_GuildRank3Bg, "Static_RankInfo_3rd")
  self._ui._txt_GuildRank3Name = UI.getChildControl(stc_GuildRank3InfoBg, "StaticText_GuildName")
  self._ui._txt_GuildRank3Member1 = UI.getChildControl(stc_GuildRank3InfoBg, "StaticText_Member_1")
  self._ui._txt_GuildRank3Member2 = UI.getChildControl(stc_GuildRank3InfoBg, "StaticText_Member_2")
  self._ui._txt_GuildRank3Member3 = UI.getChildControl(stc_GuildRank3InfoBg, "StaticText_Member_3")
  self._ui._txt_GuildRank3Member4 = UI.getChildControl(stc_GuildRank3InfoBg, "StaticText_Member_4")
  self._ui._txt_GuildRank3Member5 = UI.getChildControl(stc_GuildRank3InfoBg, "StaticText_Member_5")
  self._ui._txt_GuildRank3Time = UI.getChildControl(stc_GuildRank3InfoBg, "StaticText_Time")
  self._ui._list2_OtherGuildRankList = UI.getChildControl(self._ui._stc_RankingBgPart2, "List2_OtherRankList")
  self._ui._stc_ConsoleKeyBG = UI.getChildControl(Panel_MorningLand_BossRanking, "Static_KeyGuide_ConsoleUI_Import")
  self._ui._stc_ConsoleKeyA = UI.getChildControl(self._ui._stc_ConsoleKeyBG, "StaticText_B_ConsoleUI")
  self._ui._stc_ConsoleKeyB = UI.getChildControl(self._ui._stc_ConsoleKeyBG, "StaticText_A_ConsoleUI")
  self._ui._stc_ConsoleKeyX = UI.getChildControl(self._ui._stc_ConsoleKeyBG, "StaticText_X_ConsoleUI")
  self._ui._stc_ConsoleKeyY = UI.getChildControl(self._ui._stc_ConsoleKeyBG, "StaticText_Y_ConsoleUI")
  self._platformType = ToClient_getGamePlatformType()
  for index = 0, PaGlobal_MorningLand_Boss_All._MORNINGLAND_PART2_BOSSCOUNT - 1 do
    local morningBossSSW = ToClient_getElementalMonsterInfo(index, 0)
    if morningBossSSW ~= nil and morningBossSSW:getIsBoss() == true then
      local characterKeyRaw = morningBossSSW:getCharacterKeyRaw()
      local statType = morningBossSSW:getElementalStatType()
      local mentalCardKey = morningBossSSW:getUnlockConditionMentalCardKeyRaw()
      local tempTable = {
        _groupIndex = index,
        _monsterKey = characterKeyRaw,
        _statType = statType,
        _mentalCardKey = mentalCardKey
      }
      local characterStaticStatusWarpper = getCharacterStaticStatusWarpper(characterKeyRaw)
      self._list2BossList[index] = tempTable
      self._totalBossKeyCount = self._totalBossKeyCount + 1
    end
  end
  local classCount = getCharacterClassCount()
  for index = 0, classCount - 1 do
    local classType = getCharacterClassTypeByIndex(index)
    local className = getCharacterClassName(classType)
    if nil ~= className and "" ~= className and " " ~= className then
      self._ui._combo2_Class:AddItem(className)
      self._classTypeByComboIndexTbl:push_back(classType)
    end
  end
  self._ui._combo2_MorningLandPart:AddItem(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BLACKTEMPLE_SINGLE"))
  self._ui._combo2_MorningLandPart:AddItem(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BLACKTEMPLE_PARTY"))
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_MorningBossRank:validate()
  PaGlobal_MorningBossRank:registEventHandler()
  PaGlobal_MorningBossRank:swichPlatform(self._isConsole)
  self._ui._btn_RewardView:SetTextMode(__eTextMode_AutoWrap)
  self._ui._btn_RewardView:SetText(self._ui._btn_RewardView:GetText())
  self._ui._btn_RewardView:ComputePos()
  self._ui._btn_MyRank:SetTextMode(__eTextMode_AutoWrap)
  self._ui._btn_MyRank:SetText(self._ui._btn_MyRank:GetText())
  self._ui._btn_MyRank:ComputePos()
  self._ui._combo2_MorningLandPart:SetShow(_ContentsGroup_MorningLandTierParty)
  self._ui._stc_RankingBgPart2:SetShow(_ContentsGroup_MorningLandTierParty)
  PaGlobal_MorningBossRank._initialize = true
end
function PaGlobal_MorningBossRank:registEventHandler()
  if nil == Panel_MorningLand_BossRanking then
    return
  end
  self._ui._list2_OtherRankList:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_MorningBossRank_OtherRankingList2Update")
  self._ui._list2_OtherRankList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._list2_OtherGuildRankList:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_MorningBossRank_OtherGuildRankingList2Update")
  self._ui._list2_OtherGuildRankList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._list2_BossList:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_MorningBossRank_BossListList2Update")
  self._ui._list2_BossList:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("FromClient_ElementalMonsterRankingLoad", "FromClient_ElementalMonsterRankingLoaded")
  registerEvent("FromClient_ElementalMonsterGuildRankingLoad", "FromClient_ElementalMonsterGuildRankingLoad")
  registerEvent("FromClient_MorningBossRank_FailLoadRanking", "FromClient_MorningBossRank_FailLoadRanking")
  self._ui._combo2_Difficulty:addInputEvent("Mouse_LUp", "HandleEventLUp_MorningBossRank_OpenComboBox(" .. self._comboBoxType.Difficulty .. ")")
  self._ui._combo2_Difficulty:GetListControl():AddSelectEvent("HandleEventLUp_MorningBossRank_SelectComboBox(" .. self._comboBoxType.Difficulty .. ")")
  self._ui._combo2_Class:GetListControl():AddSelectEvent("HandleEventLUp_MorningBossRank_SelectComboBox(" .. self._comboBoxType.ClassType .. ")")
  self._ui._combo2_Class:addInputEvent("Mouse_LUp", "HandleEventLUp_MorningBossRank_OpenComboBox(" .. self._comboBoxType.ClassType .. ")")
  self._ui._combo2_MorningLandPart:GetListControl():AddSelectEvent("HandleEventLUp_MorningBossRank_SelectComboBox(" .. self._comboBoxType.MorningLandPart .. ")")
  self._ui._combo2_MorningLandPart:addInputEvent("Mouse_LUp", "HandleEventLUp_MorningBossRank_OpenComboBox(" .. self._comboBoxType.MorningLandPart .. ")")
  if self._isConsole == true then
    Panel_MorningLand_BossRanking:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_MorningBossRank_ShowMyRank()")
    Panel_MorningLand_BossRanking:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_MorningBossRank_ShowReward()")
  else
    self._ui._btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_MorningBossRank_Close()")
    self._ui._btn_Wiki:addInputEvent("Mouse_LUp", "PaGlobalFunc_MorningBossRank_Wiki()")
    self._ui._btn_RewardView:addInputEvent("Mouse_LUp", "PaGlobalFunc_MorningBossRank_ShowReward()")
    self._ui._btn_MyRank:addInputEvent("Mouse_LUp", "PaGlobalFunc_MorningBossRank_ShowMyRank()")
  end
end
function PaGlobal_MorningBossRank:swichPlatform(isConsole)
  self._ui._btn_Close:SetShow(isConsole == false)
  if isConsole == true then
    PaGlobalFunc_ConsoleKeyGuide_SetAlign({
      self._ui._stc_ConsoleKeyY,
      self._ui._stc_ConsoleKeyX,
      self._ui._stc_ConsoleKeyA,
      self._ui._stc_ConsoleKeyB
    }, self._ui._stc_ConsoleKeyBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function PaGlobal_MorningBossRank:prepareOpen()
  if nil == Panel_MorningLand_BossRanking then
    return
  end
  local classType = self._classTypeByComboIndexTbl[self._selectedClassComboIndex + 1]
  local className = getCharacterClassName(classType)
  self._ui._combo2_Class:SetText(className)
  if self._selectedMorningLandMonsterPart == __eMorningLandMosterPart1 then
    self._ui._combo2_MorningLandPart:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BLACKTEMPLE_SINGLE"))
  else
    self._ui._combo2_MorningLandPart:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BLACKTEMPLE_PARTY"))
  end
  ToClient_ElementalBossMyRankInfoReq()
  PaGlobal_MorningBossRank:open()
  PaGlobal_MorningBossRank:update()
  PaGlobalFunc_MorningBossRank_OnScreenResize()
end
function PaGlobal_MorningBossRank:update()
  self._ui._list2_BossList:getElementManager():clearKey()
  self._ui._combo2_Difficulty:DeleteAllItem()
  if self._selectedMorningLandMonsterPart == __eMorningLandMosterPart1 then
    for index = 0, PaGlobal_MorningLand_Boss_All._MORNINGLAND_PART1_BOSSCOUNT - 1 do
      local level = self._selectedLevelIndex
      local morningBossSSW = ToClient_getElementalMonsterInfo(index, 0)
      if morningBossSSW ~= nil then
        self._ui._list2_BossList:getElementManager():pushKey(index)
      end
    end
    self._ui._stc_RankingBg:SetShow(true)
    self._ui._stc_RankingBgPart2:SetShow(false)
    self._ui._combo2_Class:SetIgnore(false)
    self._ui._combo2_Class:SetMonoTone(false)
    self._ui._combo2_Difficulty:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_DIFFICULTY_" .. tostring(self._selectedLevelIndex)))
    for levelIdx = 0, __eMaxMorningLandMonsterLevel - 1 do
      self._ui._combo2_Difficulty:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_DIFFICULTY_" .. tostring(levelIdx)))
    end
  else
    for index = PaGlobal_MorningLand_Boss_All._MORNINGLAND_PART1_BOSSCOUNT, PaGlobal_MorningLand_Boss_All._MORNINGLAND_PART2_BOSSCOUNT - 1 do
      local level = self._selectedLevelIndex
      local morningBossSSW = ToClient_getElementalMonsterInfo(index, 0)
      if morningBossSSW ~= nil then
        self._ui._list2_BossList:getElementManager():pushKey(index)
      end
    end
    self._ui._stc_RankingBg:SetShow(false)
    self._ui._stc_RankingBgPart2:SetShow(true)
    self._ui._combo2_Class:SetIgnore(true)
    self._ui._combo2_Class:SetMonoTone(true)
    if self._selectedLevelIndex == 0 then
      self._ui._combo2_Difficulty:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MORNING2_EASY"))
    else
      self._ui._combo2_Difficulty:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MORNING2_HARD"))
    end
    self._ui._combo2_Difficulty:AddItem(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MORNING2_EASY"))
    self._ui._combo2_Difficulty:AddItem(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MORNING2_HARD"))
  end
  ToClient_padSnapRefreshTarget(Panel_MorningLand_BossRanking)
end
function PaGlobal_MorningBossRank:requestRankInfo()
  local level = self._selectedLevelIndex
  local morningBossSSW = ToClient_getElementalMonsterInfo(self._selectedBossGroupIndex, level)
  if morningBossSSW == nil then
    self._ui._list2_OtherRankList:getElementManager():clearKey()
    self._rankInfoTable = {}
    self._ui._stc_Rank1Bg:SetShow(false)
    self._ui._stc_Rank2Bg:SetShow(false)
    self._ui._stc_Rank3Bg:SetShow(false)
    local hasRecord = false
    self._ui._stc_RankingBg:SetShow(hasRecord ~= false)
    self._ui._stc_RankingBgPart2:SetShow(false)
    self._ui._txt_NoRecord:SetShow(hasRecord == false)
    return
  end
  if morningBossSSW:getIsBoss() == true then
    local characterKeyRaw = morningBossSSW:getCharacterKeyRaw()
    local classType = self._classTypeByComboIndexTbl[self._selectedClassComboIndex + 1]
    ToClient_RequestElementalRank(characterKeyRaw, classType)
  end
end
function PaGlobal_MorningBossRank:requestGuildRankInfo()
  local level = self._selectedLevelIndex
  local morningBossSSW = ToClient_getElementalMonsterInfo(self._selectedBossGroupIndex, level)
  if morningBossSSW == nil then
    return
  end
  if morningBossSSW:getIsBoss() == true then
    local characterKeyRaw = morningBossSSW:getCharacterKeyRaw()
    ToClient_RequestElementalGuildRank(characterKeyRaw)
  end
end
function PaGlobal_MorningBossRank:open()
  if nil == Panel_MorningLand_BossRanking then
    return
  end
  Panel_MorningLand_BossRanking:SetShow(true)
  PaGlobal_MorningLand_Boss_All_ToggleGuilde()
end
function PaGlobal_MorningBossRank:prepareClose()
  if nil == Panel_MorningLand_BossRanking then
    return
  end
  PaGlobal_MorningBossRank:close()
end
function PaGlobal_MorningBossRank:close()
  if nil == Panel_MorningLand_BossRanking then
    return
  end
  Panel_MorningLand_BossRanking:SetShow(false)
  PaGlobal_MorningLand_Boss_All_ToggleGuilde()
end
function PaGlobal_MorningBossRank:setRankInfoBelow3rd(info, isOtherPlatform)
  if info == nil then
    return
  end
  local skillAwakenIconString = self._skillAwakenIcon[info._skillTypeParm]
  local time32 = convertThirdSecondsToClockTime(Int64toInt32(info._tickTime64) / 1000)
  if info._rank == 1 then
    self._ui._stc_Rank1Bg:SetShow(true)
    self._ui._txt_Rank1:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_RANK", "rank", info._rank))
    self._ui._txt_Rank1Level:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_CRAFTLEVEL") .. info._level)
    self._ui._stc_Rank1AwakenIcon:ChangeTextureInfoAndSizeByTextureIDKey(skillAwakenIconString)
    self._ui._stc_Rank1AwakenIcon:setRenderTexture(self._ui._stc_Rank1AwakenIcon:getBaseTexture())
    self._ui._txt_Rank1CharName:SetText(info._name)
    self._ui._txt_Rank1Time:SetText(time32)
    self._ui._stc_Rank1PS:SetShow(false)
    self._ui._stc_Rank1XBOX:SetShow(false)
    self._ui._stc_Rank1OTHER:SetShow(false)
    if _ContentsGroup_RenewUI == true then
      self._ui._txt_Rank1Level:SetShow(isOtherPlatform == false)
      self._ui._txt_Rank1CharName:SetShow(isOtherPlatform == false)
      self._ui._txt_Rank1Time:SetShow(isOtherPlatform == false)
      self._ui._stc_Rank1AwakenIcon:SetShow(isOtherPlatform == false)
      self._ui._txt_Rank1OtherPlatform:SetShow(isOtherPlatform == true)
      if self._platformType == info._platformType then
        if __eGAME_PLATFORM_TYPE_PS == self._platformType then
          self._ui._stc_Rank1PS:SetShow(true)
        elseif __eGAME_PLATFORM_TYPE_XB == self._platformType then
          self._ui._stc_Rank1XBOX:SetShow(true)
        end
      else
        self._ui._stc_Rank1OTHER:SetShow(true)
      end
    end
  elseif info._rank == 2 then
    self._ui._stc_Rank2Bg:SetShow(true)
    self._ui._txt_Rank2:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_RANK", "rank", info._rank))
    self._ui._txt_Rank2Level:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_CRAFTLEVEL") .. info._level)
    self._ui._stc_Rank2AwakenIcon:ChangeTextureInfoAndSizeByTextureIDKey(skillAwakenIconString)
    self._ui._stc_Rank2AwakenIcon:setRenderTexture(self._ui._stc_Rank2AwakenIcon:getBaseTexture())
    self._ui._txt_Rank2CharName:SetText(info._name)
    self._ui._txt_Rank2Time:SetText(time32)
    self._ui._stc_Rank2PS:SetShow(false)
    self._ui._stc_Rank2XBOX:SetShow(false)
    self._ui._stc_Rank2OTHER:SetShow(false)
    if _ContentsGroup_RenewUI == true then
      self._ui._txt_Rank2Level:SetShow(isOtherPlatform == false)
      self._ui._stc_Rank2AwakenIcon:SetShow(isOtherPlatform == false)
      self._ui._txt_Rank2CharName:SetShow(isOtherPlatform == false)
      self._ui._txt_Rank2Time:SetShow(isOtherPlatform == false)
      self._ui._txt_Rank2OtherPlatform:SetShow(isOtherPlatform == true)
      if self._platformType == info._platformType then
        if __eGAME_PLATFORM_TYPE_PS == self._platformType then
          self._ui._stc_Rank2PS:SetShow(true)
        elseif __eGAME_PLATFORM_TYPE_XB == self._platformType then
          self._ui._stc_Rank2XBOX:SetShow(true)
        end
      else
        self._ui._stc_Rank2OTHER:SetShow(true)
      end
    end
  elseif info._rank == 3 then
    self._ui._stc_Rank3Bg:SetShow(true)
    self._ui._txt_Rank3:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_RANK", "rank", info._rank))
    self._ui._txt_Rank3Level:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_CRAFTLEVEL") .. info._level)
    self._ui._stc_Rank3AwakenIcon:ChangeTextureInfoAndSizeByTextureIDKey(skillAwakenIconString)
    self._ui._stc_Rank3AwakenIcon:setRenderTexture(self._ui._stc_Rank3AwakenIcon:getBaseTexture())
    self._ui._txt_Rank3CharName:SetText(info._name)
    self._ui._txt_Rank3Time:SetText(time32)
    self._ui._stc_Rank3PS:SetShow(false)
    self._ui._stc_Rank3XBOX:SetShow(false)
    self._ui._stc_Rank3OTHER:SetShow(false)
    if _ContentsGroup_RenewUI == true then
      self._ui._txt_Rank3Level:SetShow(isOtherPlatform == false)
      self._ui._stc_Rank3AwakenIcon:SetShow(isOtherPlatform == false)
      self._ui._txt_Rank3CharName:SetShow(isOtherPlatform == false)
      self._ui._txt_Rank3Time:SetShow(isOtherPlatform == false)
      self._ui._txt_Rank3OtherPlatform:SetShow(isOtherPlatform == true)
      if self._platformType == info._platformType then
        if __eGAME_PLATFORM_TYPE_PS == self._platformType then
          self._ui._stc_Rank3PS:SetShow(true)
        elseif __eGAME_PLATFORM_TYPE_XB == self._platformType then
          self._ui._stc_Rank3XBOX:SetShow(true)
        end
      else
        self._ui._stc_Rank3OTHER:SetShow(true)
      end
    end
  end
end
function PaGlobal_MorningBossRank:setGuildRankInfoBelow3rd(info)
  if info == nil then
    return
  end
  local time32 = convertThirdSecondsToClockTime(Int64toInt32(info._tickTime64) / 1000)
  local userNameList = string.split(info._userNameList, ",")
  if info._rank == 1 then
    self._ui._stc_GuildRank1Bg:SetShow(true)
    self._ui._txt_GuildRank1:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_RANK", "rank", info._rank))
    self._ui._txt_GuildRank1Name:SetText(info._guildName)
    if userNameList[1] ~= nil then
      self._ui._txt_GuildRank1Member1:SetText(userNameList[1])
    else
      self._ui._txt_GuildRank1Member1:SetText("")
    end
    if userNameList[2] ~= nil then
      self._ui._txt_GuildRank1Member2:SetText(userNameList[2])
    else
      self._ui._txt_GuildRank1Member2:SetText("")
    end
    if userNameList[3] ~= nil then
      self._ui._txt_GuildRank1Member3:SetText(userNameList[3])
    else
      self._ui._txt_GuildRank1Member3:SetText("")
    end
    if userNameList[4] ~= nil then
      self._ui._txt_GuildRank1Member4:SetText(userNameList[4])
    else
      self._ui._txt_GuildRank1Member4:SetText("")
    end
    if userNameList[5] ~= nil then
      self._ui._txt_GuildRank1Member5:SetText(userNameList[5])
    else
      self._ui._txt_GuildRank1Member5:SetText("")
    end
    self._ui._txt_GuildRank1Time:SetText(time32)
  elseif info._rank == 2 then
    self._ui._stc_GuildRank2Bg:SetShow(true)
    self._ui._txt_GuildRank2:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_RANK", "rank", info._rank))
    self._ui._txt_GuildRank2Name:SetText(info._guildName)
    if userNameList[1] ~= nil then
      self._ui._txt_GuildRank2Member1:SetText(userNameList[1])
    else
      self._ui._txt_GuildRank2Member1:SetText("")
    end
    if userNameList[2] ~= nil then
      self._ui._txt_GuildRank2Member2:SetText(userNameList[2])
    else
      self._ui._txt_GuildRank2Member2:SetText("")
    end
    if userNameList[3] ~= nil then
      self._ui._txt_GuildRank2Member3:SetText(userNameList[3])
    else
      self._ui._txt_GuildRank2Member3:SetText("")
    end
    if userNameList[4] ~= nil then
      self._ui._txt_GuildRank2Member4:SetText(userNameList[4])
    else
      self._ui._txt_GuildRank2Member4:SetText("")
    end
    if userNameList[5] ~= nil then
      self._ui._txt_GuildRank2Member5:SetText(userNameList[5])
    else
      self._ui._txt_GuildRank2Member5:SetText("")
    end
    self._ui._txt_GuildRank2Time:SetText(time32)
  elseif info._rank == 3 then
    self._ui._stc_GuildRank3Bg:SetShow(true)
    self._ui._txt_GuildRank3:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_RANK", "rank", info._rank))
    self._ui._txt_GuildRank3Name:SetText(info._guildName)
    if userNameList[1] ~= nil then
      self._ui._txt_GuildRank3Member1:SetText(userNameList[1])
    else
      self._ui._txt_GuildRank3Member1:SetText("")
    end
    if userNameList[2] ~= nil then
      self._ui._txt_GuildRank3Member2:SetText(userNameList[2])
    else
      self._ui._txt_GuildRank3Member2:SetText("")
    end
    if userNameList[3] ~= nil then
      self._ui._txt_GuildRank3Member3:SetText(userNameList[3])
    else
      self._ui._txt_GuildRank3Member3:SetText("")
    end
    if userNameList[4] ~= nil then
      self._ui._txt_GuildRank3Member4:SetText(userNameList[4])
    else
      self._ui._txt_GuildRank3Member4:SetText("")
    end
    if userNameList[5] ~= nil then
      self._ui._txt_GuildRank3Member5:SetText(userNameList[5])
    else
      self._ui._txt_GuildRank3Member5:SetText("")
    end
    self._ui._txt_GuildRank3Time:SetText(time32)
  end
end
function PaGlobalFunc_MorningBossRank_Open()
  if Panel_MorningLand_BossRanking == nil then
    return
  end
  local self = PaGlobal_MorningBossRank
  if 0 < self._totalBossKeyCount then
    local classType = getSelfPlayer():getClassType()
    for idx = 1, #self._classTypeByComboIndexTbl do
      if self._classTypeByComboIndexTbl[idx] == classType then
        self._selectedClassComboIndex = idx - 1
      end
    end
    PaGlobal_MorningBossRank:requestRankInfo()
  end
end
function PaGlobalFunc_MorningBossGuildRank_Open()
  if Panel_MorningLand_BossRanking == nil then
    return
  end
  local self = PaGlobal_MorningBossRank
  if 0 < self._totalBossKeyCount then
    PaGlobal_MorningBossRank:requestGuildRankInfo()
  end
end
function PaGlobalFunc_MorningBossRank_OnScreenResize()
  Panel_MorningLand_BossRanking:ComputePos()
end
function PaGlobalFunc_MorningBossRank_Close()
  PaGlobal_MorningBossRank:prepareClose()
end
function PaGlobalFunc_MorningBossRank_Wiki()
end
function PaGlobalFunc_MorningBossRank_ShowReward()
  if Panel_MorningLand_DatailReward == nil then
    return
  end
  PaGlobalFunc_MorningLand_DetailReward_Open()
end
function PaGlobalFunc_MorningBossRank_ShowMyRank()
  PaGlobal_MorningLand_ConquestHistory_All_OpenByRankPanel()
end
function HandleEventLUp_MorningBossRank_SelectBoss(bossListIndex)
  local self = PaGlobal_MorningBossRank
  if self._selectedBossGroupIndex ~= bossListIndex then
    self._selectedBossGroupIndex = bossListIndex
    if self._selectedBossGroupIndex < PaGlobal_MorningLand_Boss_All._MORNINGLAND_PART1_BOSSCOUNT then
      PaGlobal_MorningBossRank:requestRankInfo()
    else
      PaGlobal_MorningBossRank:requestGuildRankInfo()
    end
  elseif ToClient_isElementalMonsterUnlockKnowledgeCondition(self._selectedBossGroupIndex) == true then
    self._ui._stc_RankingAreaLock:SetShow(false)
  end
end
function HandleEventLUp_MorningBossRank_OpenComboBox(comboBoxType)
  local self = PaGlobal_MorningBossRank
  if comboBoxType == self._comboBoxType.Difficulty then
    PaGlobal_MorningBossRank._ui._combo2_Difficulty:ToggleListbox()
  elseif comboBoxType == self._comboBoxType.ClassType then
    PaGlobal_MorningBossRank._ui._combo2_Class:ToggleListbox()
  elseif comboBoxType == self._comboBoxType.MorningLandPart then
    PaGlobal_MorningBossRank._ui._combo2_MorningLandPart:ToggleListbox()
  end
end
function HandleEventLUp_MorningBossRank_SelectComboBox(comboBoxType)
  local self = PaGlobal_MorningBossRank
  if comboBoxType == self._comboBoxType.Difficulty then
    self._selectedLevelIndex = self._ui._combo2_Difficulty:GetSelectIndex()
  elseif comboBoxType == self._comboBoxType.ClassType then
    self._selectedClassComboIndex = self._ui._combo2_Class:GetSelectIndex()
  elseif comboBoxType == self._comboBoxType.MorningLandPart then
    if self._ui._combo2_MorningLandPart:GetSelectIndex() == 0 then
      self._selectedMorningLandMonsterPart = __eMorningLandMosterPart1
      self._ui._combo2_Class:SetIgnore(false)
      self._ui._combo2_Class:SetMonoTone(false)
    elseif self._ui._combo2_MorningLandPart:GetSelectIndex() == 1 then
      self._selectedMorningLandMonsterPart = __eMorningLandMosterPart2
      self._ui._combo2_Difficulty:SetSelectItemIndex(0)
      self._selectedLevelIndex = 0
      self._ui._combo2_Class:SetIgnore(true)
      self._ui._combo2_Class:SetMonoTone(true)
    end
    self:update()
  end
  if self._selectedMorningLandMonsterPart == __eMorningLandMosterPart1 then
    PaGlobal_MorningBossRank:requestRankInfo()
  elseif self._selectedMorningLandMonsterPart == __eMorningLandMosterPart2 then
    PaGlobal_MorningBossRank:requestGuildRankInfo()
  end
end
function PaGlobalFunc_MorningBossRank_GetSelectedBossGroupIndex()
  return PaGlobal_MorningBossRank._selectedBossGroupIndex
end
function PaGlobalFunc_MorningBossRank_GetSelectedLevel()
  return PaGlobal_MorningBossRank._selectedLevelIndex
end
function PaGlobalFunc_MorningBossRank_SetSelectedBossGroupIndex(monsterGroupIndex)
  PaGlobal_MorningBossRank._selectedBossGroupIndex = monsterGroupIndex
  if monsterGroupIndex < PaGlobal_MorningLand_Boss_All._MORNINGLAND_PART1_BOSSCOUNT then
    PaGlobal_MorningBossRank._selectedMorningLandMonsterPart = __eMorningLandMosterPart1
  else
    PaGlobal_MorningBossRank._selectedMorningLandMonsterPart = __eMorningLandMosterPart2
  end
end
function PaGlobalFunc_MorningBossRank_SetSelectedLevel(level)
  PaGlobal_MorningBossRank._selectedLevelIndex = level
end
function FromClient_ElementalMonsterRankingLoaded(monsterKey, classType)
  if Panel_MorningLand_BossRanking == nil then
    return
  end
  local self = PaGlobal_MorningBossRank
  if Panel_MorningLand_BossRanking:GetShow() == false then
    self:prepareOpen()
  end
  if ToClient_isElementalMonsterUnlockKnowledgeCondition(self._selectedBossGroupIndex) == false then
    PaGlobal_MorningBossRank:lockMonsterSelect(self._selectedBossGroupIndex)
  else
    self._ui._stc_RankingAreaLock:SetShow(false)
  end
  self._ui._list2_OtherRankList:getElementManager():clearKey()
  self._rankInfoTable = {}
  self._ui._stc_Rank1Bg:SetShow(false)
  self._ui._stc_Rank2Bg:SetShow(false)
  self._ui._stc_Rank3Bg:SetShow(false)
  local infoSize = ToClient_ElementalBossRankInfoCount(monsterKey, classType)
  local hasRecord = infoSize > 0
  self._ui._stc_RankingBg:SetShow(hasRecord ~= false)
  self._ui._stc_RankingBgPart2:SetShow(false)
  self._ui._txt_NoRecord:SetShow(hasRecord == false)
  if hasRecord == false then
    return
  end
  local needShowSamePlatform = false
  if _ContentsGroup_RenewUI == true then
    local curChannelData = getCurrentChannelServerData()
    if curChannelData ~= nil then
      needShowSamePlatform = __ePlatformType_COUNT ~= curChannelData._servicePlatformType
    end
  end
  for idx = 0, infoSize - 1 do
    local info = ToClient_ElementalBossRankInfoIndex(monsterKey, classType, idx)
    if info ~= nil then
      local userNo64 = info:getUserNo64()
      local characterNo64 = info:getCharacterNo64()
      local rank = info:getRankIndex()
      local offence = info:getOffenceStat()
      local deffence = info:getDeffenceStat()
      local ttick64 = info:getRecordTick64()
      local rankPercent = info:getRankPercent()
      local name = info:getUserNickName()
      local skillType = info:getSkillTypeParam()
      local conquestLevel = info:getConquestLevel()
      local level = info:getLevel()
      local platformType = info:getPlatfromType()
      local tempTable = {
        _monsterKey = monsterKey,
        _classType = classType,
        _infoIndex = idx,
        _userNo32 = Int64toInt32(userNo64),
        _characterNo64 = characterNo64,
        _rank = rank,
        _offence = offence,
        _deffence = deffence,
        _tickTime64 = ttick64,
        _rankPercent = rankPercent,
        _skillTypeParm = skillType,
        _conquestLevel = conquestLevel,
        _name = name,
        _level = level,
        _platformType = platformType
      }
      PaGlobal_MorningBossRank._rankInfoTable[idx] = tempTable
      if needShowSamePlatform == true then
        if idx > 2 then
          if self._platformType == platformType then
            self._ui._list2_OtherRankList:getElementManager():pushKey(idx)
          end
        else
          PaGlobal_MorningBossRank:setRankInfoBelow3rd(tempTable, self._platformType ~= platformType)
        end
      elseif idx > 2 then
        self._ui._list2_OtherRankList:getElementManager():pushKey(idx)
      else
        PaGlobal_MorningBossRank:setRankInfoBelow3rd(tempTable, false)
      end
    end
  end
end
function FromClient_ElementalMonsterGuildRankingLoad(monsterKey)
  if Panel_MorningLand_BossRanking == nil then
    return
  end
  local self = PaGlobal_MorningBossRank
  if Panel_MorningLand_BossRanking:GetShow() == false then
    self:prepareOpen()
  end
  if ToClient_isElementalMonsterUnlockKnowledgeCondition(self._selectedBossGroupIndex) == false then
    PaGlobal_MorningBossRank:lockMonsterSelect(self._selectedBossGroupIndex)
  else
    self._ui._stc_RankingAreaLock:SetShow(false)
  end
  self._ui._list2_OtherGuildRankList:getElementManager():clearKey()
  self._guildRankInfoTable = {}
  self._ui._stc_GuildRank1Bg:SetShow(false)
  self._ui._stc_GuildRank2Bg:SetShow(false)
  self._ui._stc_GuildRank3Bg:SetShow(false)
  local infoSize = ToClient_ElementalBossGuildRankInfoCount(monsterKey)
  local hasRecord = infoSize > 0
  self._ui._stc_RankingBg:SetShow(false)
  self._ui._stc_RankingBgPart2:SetShow(hasRecord ~= false)
  self._ui._txt_NoRecord:SetShow(hasRecord == false)
  if hasRecord == false then
    return
  end
  local needShowSamePlatform = false
  for idx = 0, infoSize - 1 do
    local info = ToClient_ElementalBossGuildRankInfoIndex(monsterKey, idx)
    if info ~= nil then
      local guildName = info:getGuildName()
      local ttick64 = info:getRecordTick64()
      local rank = info:getRankIndex()
      local userNameList = info:getUserNameList()
      local tempTable = {
        _monsterKey = monsterKey,
        _guildName = guildName,
        _tickTime64 = ttick64,
        _rank = rank,
        _userNameList = userNameList
      }
      PaGlobal_MorningBossRank._guildRankInfoTable[idx] = tempTable
      if idx > 2 then
        self._ui._list2_OtherGuildRankList:getElementManager():pushKey(idx)
      else
        PaGlobal_MorningBossRank:setGuildRankInfoBelow3rd(tempTable, false)
      end
    end
  end
end
function FromClient_MorningBossRank_OtherRankingList2Update(control, key)
  if Panel_MorningLand_BossRanking == nil then
    return
  end
  local self = PaGlobal_MorningBossRank
  local index = Int64toInt32(key)
  local stc_bg = UI.getChildControl(control, "Static_OtherRankList_Template")
  local rankBg = UI.getChildControl(stc_bg, "Static_OtherRankBox")
  local stc_Rank = UI.getChildControl(rankBg, "StaticText_Rank_Other")
  local stc_Level = UI.getChildControl(rankBg, "StaticText_Level_Other")
  local stc_Charname = UI.getChildControl(rankBg, "StaticText_CharName_Other")
  local stc_SkillAwaken = UI.getChildControl(stc_Level, "Static_Symbol_Class_Other")
  local stc_Time = UI.getChildControl(rankBg, "StaticText_Time_Other")
  local stc_bgMine = UI.getChildControl(stc_bg, "Static_BGMine")
  local stc_platformCross = UI.getChildControl(stc_Level, "Static_Icon_Other")
  local stc_platformPS = UI.getChildControl(stc_Level, "Static_Icon_PS")
  local stc_platformXBOX = UI.getChildControl(stc_Level, "Static_Icon_XBOX")
  local info = self._rankInfoTable[index]
  local myUserNo = getSelfPlayer():getUserNo()
  if info == nil then
    return
  end
  local skillAwakenIconString = self._skillAwakenIcon[info._skillTypeParm]
  local time32 = convertThirdSecondsToClockTime(Int64toInt32(info._tickTime64) / 1000)
  local platformType = info._platformType
  stc_Rank:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_RANK", "rank", info._rank))
  stc_Level:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_CRAFTLEVEL") .. info._level)
  stc_Charname:SetText(info._name)
  stc_SkillAwaken:ChangeTextureInfoAndSizeByTextureIDKey(skillAwakenIconString)
  stc_SkillAwaken:setRenderTexture(stc_SkillAwaken:getBaseTexture())
  stc_Time:SetText(time32)
  stc_bgMine:SetShow(info._userNo32 == myUserNo)
  stc_platformCross:SetShow(false)
  stc_platformPS:SetShow(false)
  stc_platformXBOX:SetShow(false)
  if _ContentsGroup_RenewUI == true then
    if self._platformType == platformType then
      if __eGAME_PLATFORM_TYPE_PS == self._platformType then
        stc_platformPS:SetShow(true)
      elseif __eGAME_PLATFORM_TYPE_XB == self._platformType then
        stc_platformXBOX:SetShow(true)
      end
    else
      stc_platformCross:SetShow(true)
    end
  end
end
function FromClient_MorningBossRank_OtherGuildRankingList2Update(control, key)
  if Panel_MorningLand_BossRanking == nil then
    return
  end
  local self = PaGlobal_MorningBossRank
  local index = Int64toInt32(key)
  local stc_bg = UI.getChildControl(control, "Static_OtherRankList_Template")
  local rankBg = UI.getChildControl(stc_bg, "Static_OtherRankBox")
  local stc_guildName = UI.getChildControl(rankBg, "StaticText_GuildName")
  local stc_rank = UI.getChildControl(rankBg, "StaticText_Rank_Other")
  local txt_userNameList = UI.getChildControl(rankBg, "MultilineText_CharName")
  local stc_Time = UI.getChildControl(rankBg, "StaticText_Time_Other")
  local info = self._guildRankInfoTable[index]
  if info == nil then
    return
  end
  local time32 = convertThirdSecondsToClockTime(Int64toInt32(info._tickTime64) / 1000)
  stc_rank:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_RANK", "rank", info._rank))
  stc_guildName:SetText(info._guildName)
  txt_userNameList:SetText(info._userNameList)
  stc_Time:SetText(time32)
end
function FromClient_MorningBossRank_BossListList2Update(control, key)
  local index = Int64toInt32(key)
  local info = PaGlobal_MorningBossRank._list2BossList[index]
  local bossGroupIndex = info._groupIndex
  local characterKeyRaw = info._monsterKey
  local statType = info._statType
  local characterStaticStatusWarpper = getCharacterStaticStatusWarpper(characterKeyRaw)
  local rdo_Boss = UI.getChildControl(control, "RadioButton_BossList_Template")
  local stc_BossTexture = UI.getChildControl(rdo_Boss, "Static_BossList_Visual")
  local stc_Stat = UI.getChildControl(rdo_Boss, "Static_BossList_Weakness")
  local txt_BossName = UI.getChildControl(rdo_Boss, "StaticText_BossList_Name")
  local stc_New = UI.getChildControl(rdo_Boss, "Static_NEW")
  local isMorningLandMonsterPart1 = true
  local morningBossSSW = ToClient_getElementalMonsterInfoByCharacterKey(characterKeyRaw)
  if morningBossSSW ~= nil then
    isMorningLandMonsterPart1 = morningBossSSW:getMorningLandMonsterPartRaw() == __eMorningLandMosterPart1
  end
  local bossLockBg = UI.getChildControl(rdo_Boss, "Static_BossList_LockBG")
  local bossListOffBg = UI.getChildControl(bossLockBg, "Static_BossList_ListOffBG")
  local txtBossLock = UI.getChildControl(bossLockBg, "StaticText_BossList_Lock")
  if ToClient_isElementalMonsterUnlockKnowledgeCondition(bossGroupIndex) == true then
    bossLockBg:SetShow(false)
    stc_BossTexture:SetShow(true)
    stc_Stat:SetShow(true)
    txt_BossName:SetShow(true)
    stc_New:SetShow(false)
    stc_Stat:SetShow(isMorningLandMonsterPart1)
  else
    bossLockBg:ChangeTextureInfoAndSizeByTextureIDKey("Combine_Etc_MorningLand_Boss_01_List_Profile_10_Normal")
    bossLockBg:setRenderTexture(bossLockBg:getBaseTexture())
    bossLockBg:SetShow(true)
    if info._mentalCardKey ~= nil then
      local mentalCardSSW = ToClinet_getMentalCardStaticStatus(info._mentalCardKey)
      if mentalCardSSW ~= nil then
        local mentalCardName = mentalCardSSW:getName()
        local mentalCardDesc = mentalCardSSW:getDesc()
        txtBossLock:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_LOCK", "knowledge", mentalCardName))
        stc_BossTexture:SetShow(false)
        stc_Stat:SetShow(false)
        txt_BossName:SetShow(false)
        bossListOffBg:SetIgnore(false)
        bossListOffBg:addInputEvent("Mouse_LUp", "PaGlobal_MorningBossRank:lockMonsterSelect(" .. bossGroupIndex .. ")")
      end
    end
  end
  txt_BossName:SetTextMode(__eTextMode_AutoWrap)
  txt_BossName:SetText(characterStaticStatusWarpper:getName())
  txt_BossName:ComputePos()
  rdo_Boss:addInputEvent("Mouse_LUp", "HandleEventLUp_MorningBossRank_SelectBoss(" .. tostring(bossGroupIndex) .. ")")
  local isRdoCheck = PaGlobal_MorningBossRank._selectedBossGroupIndex == bossGroupIndex
  rdo_Boss:SetCheck(isRdoCheck)
  stc_BossTexture:ChangeTextureInfoAndSizeByTextureIDKey(PaGlobal_MorningBossRank._bossTexture[bossGroupIndex])
  stc_BossTexture:setRenderTexture(stc_BossTexture:getBaseTexture())
  stc_Stat:ChangeTextureInfoAndSizeByTextureIDKey(PaGlobal_MorningBossRank._statTexture[statType])
  stc_Stat:setRenderTexture(stc_Stat:getBaseTexture())
end
function PaGlobal_MorningBossRank:validate()
  if nil == Panel_MorningLand_BossRanking then
    return
  end
  self._ui._btn_Close:isValidate()
  self._ui._btn_Wiki:isValidate()
  self._ui._list2_BossList:isValidate()
  self._ui._btn_RewardView:isValidate()
  self._ui._btn_MyRank:isValidate()
  self._ui._combo2_MorningLandPart:isValidate()
  self._ui._combo2_Difficulty:isValidate()
  self._ui._combo2_Class:isValidate()
  self._ui._txt_Rank1:isValidate()
  self._ui._stc_Rank1AwakenIcon:isValidate()
  self._ui._txt_Rank1Level:isValidate()
  self._ui._txt_Rank1CharName:isValidate()
  self._ui._txt_Rank1Time:isValidate()
  self._ui._txt_Rank2:isValidate()
  self._ui._stc_Rank2AwakenIcon:isValidate()
  self._ui._txt_Rank2Level:isValidate()
  self._ui._txt_Rank2CharName:isValidate()
  self._ui._txt_Rank2Time:isValidate()
  self._ui._txt_Rank3:isValidate()
  self._ui._stc_Rank3AwakenIcon:isValidate()
  self._ui._txt_Rank3Level:isValidate()
  self._ui._txt_Rank3CharName:isValidate()
  self._ui._txt_Rank3Time:isValidate()
  self._ui._stc_GuildRank1Bg:isValidate()
  self._ui._txt_GuildRank1:isValidate()
  self._ui._txt_GuildRank1Name:isValidate()
  self._ui._txt_GuildRank1Member1:isValidate()
  self._ui._txt_GuildRank1Member2:isValidate()
  self._ui._txt_GuildRank1Member3:isValidate()
  self._ui._txt_GuildRank1Member4:isValidate()
  self._ui._txt_GuildRank1Member5:isValidate()
  self._ui._txt_GuildRank1Time:isValidate()
  self._ui._stc_GuildRank2Bg:isValidate()
  self._ui._txt_GuildRank2:isValidate()
  self._ui._txt_GuildRank2Name:isValidate()
  self._ui._txt_GuildRank2Member1:isValidate()
  self._ui._txt_GuildRank2Member2:isValidate()
  self._ui._txt_GuildRank2Member3:isValidate()
  self._ui._txt_GuildRank2Member4:isValidate()
  self._ui._txt_GuildRank2Member5:isValidate()
  self._ui._txt_GuildRank2Time:isValidate()
  self._ui._stc_GuildRank3Bg:isValidate()
  self._ui._txt_GuildRank3:isValidate()
  self._ui._txt_GuildRank3Name:isValidate()
  self._ui._txt_GuildRank3Member1:isValidate()
  self._ui._txt_GuildRank3Member2:isValidate()
  self._ui._txt_GuildRank3Member3:isValidate()
  self._ui._txt_GuildRank3Member4:isValidate()
  self._ui._txt_GuildRank3Member5:isValidate()
  self._ui._txt_GuildRank3Time:isValidate()
  self._ui._list2_OtherRankList:isValidate()
  self._ui._list2_OtherGuildRankList:isValidate()
  self._ui._stc_ConsoleKeyBG:isValidate()
  self._ui._stc_ConsoleKeyA:isValidate()
  self._ui._stc_ConsoleKeyB:isValidate()
end
function PaGlobal_MorningBossRank:lockMonsterSelect(group)
  if ToClient_isElementalMonsterUnlockKnowledgeCondition(group) == false then
    self._ui._stc_RankingAreaLock:SetShow(true)
    local morningBossSSW = ToClient_getElementalMonsterInfo(group, 0)
    local mentalCardKey = morningBossSSW:getUnlockConditionMentalCardKeyRaw()
    local mentalCardSSW = ToClinet_getMentalCardStaticStatus(mentalCardKey)
    if mentalCardSSW ~= nil then
      local mentalCardName = mentalCardSSW:getName()
      local txtConditionLock = UI.getChildControl(self._ui._stc_RankingAreaLock, "StaticText_Condition_Lock")
      txtConditionLock:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_LOCK", "knowledge", mentalCardName))
    end
  end
end
function FromClient_MorningBossRank_FailLoadRanking()
  local self = PaGlobal_MorningBossRank
  if self == nil then
    return
  end
  if Panel_MorningLand_BossRanking == nil or Panel_MorningLand_BossRanking:GetShow() == false then
    return
  end
  self._ui._stc_RankingBg:SetShow(false)
  self._ui._stc_RankingBgPart2:SetShow(false)
end
