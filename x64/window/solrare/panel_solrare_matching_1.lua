function PaGlobal_Solrare_Matching:initialize()
  if Panel_Window_Solrare_Matching == nil then
    return
  end
  if self._initialize == true then
    return
  end
  local titleBg = UI.getChildControl(Panel_Window_Solrare_Matching, "Static_Title_Bg")
  self._ui._btn_Close = UI.getChildControl(titleBg, "Button_Close")
  self._ui._btn_Wiki = UI.getChildControl(titleBg, "Button_Guide")
  local topBg = UI.getChildControl(Panel_Window_Solrare_Matching, "Static_Top")
  local rankBg = UI.getChildControl(topBg, "Static_Rank_Wrap")
  self._ui._stc_RankIcon = UI.getChildControl(rankBg, "Static_Rank_Icon")
  self._ui._txt_Tier = UI.getChildControl(rankBg, "StaticText_Tier")
  self._ui._txt_RankRating = UI.getChildControl(rankBg, "StaticText_Score")
  local profileBg = UI.getChildControl(topBg, "Static_Profile")
  self._ui._stc_ClassIcon = UI.getChildControl(profileBg, "Static_Profile_Icon")
  self._ui._txt_Level = UI.getChildControl(profileBg, "StaticText_LV")
  self._ui._txt_Name = UI.getChildControl(profileBg, "StaticText_Name")
  self._ui._txt_Ranking = UI.getChildControl(profileBg, "StaticText_My_Ranking")
  self._ui._txt_RecentRecord = UI.getChildControl(profileBg, "StaticText_My_Fight_Record")
  self._ui._btn_CopyUserInformation = UI.getChildControl(profileBg, "Button_Copy_Character")
  self._ui._stc_copyProgress = UI.getChildControl(Panel_Window_Solrare_Matching, "Static_Progress")
  self._ui._stc_changeModeBg = UI.getChildControl(topBg, "Static_ChangeModeBg")
  self._ui._btn_changeMode = UI.getChildControl(self._ui._stc_changeModeBg, "Button_Toggle")
  self._ui._btn_RankGameReq = UI.getChildControl(topBg, "Button_Find_Match")
  self._ui._btn_NormalGameReq = UI.getChildControl(topBg, "Button_NormalGame_Match")
  self._ui._btn_CustomGameReq = UI.getChildControl(topBg, "Button_CustomGame_Match")
  self._ui._btn_Equip = UI.getChildControl(topBg, "Button_Equip")
  self._ui._btn_CeremonyOption = UI.getChildControl(topBg, "Button_VictoryAction")
  self._ui._btn_TierList = UI.getChildControl(topBg, "Static_Tierlist_Btn")
  self._ui._btn_Rules = UI.getChildControl(topBg, "Button_Guide")
  self._ui._btn_Ranking = UI.getChildControl(topBg, "Button_Ranking")
  self._ui._btn_ReplayList = UI.getChildControl(topBg, "Button_Replay")
  self._ui._btn_SolarePass = UI.getChildControl(topBg, "Button_SolarePass")
  self._ui._txt_NoRecord = UI.getChildControl(Panel_Window_Solrare_Matching, "StaticText_NoRecord")
  self._ui._frameRecentInfoList = UI.getChildControl(Panel_Window_Solrare_Matching, "Frame_1")
  self._ui._stc_TierListBg = UI.getChildControl(Panel_Window_Solrare_Matching, "Static_TierList_BG")
  self._ui._btn_CoinShop = UI.getChildControl(topBg, "Button_CoinShop")
  self._ui._btn_CoinShop:SetShow(false)
  self._ui._keypadBg = UI.getChildControl(Panel_Window_Solrare_Matching, "Static_Key_GuideGroup_ConsoleUI")
  self._ui._keypadX = UI.getChildControl(self._ui._keypadBg, "StaticText_X_ConsoleUI")
  self._ui._keypadA = UI.getChildControl(self._ui._keypadBg, "StaticText_A_ConsoleUI")
  self._ui._keypadB = UI.getChildControl(self._ui._keypadBg, "StaticText_B_ConsoleUI")
  self._ui._keypadY = UI.getChildControl(self._ui._keypadBg, "StaticText_Y_ConsoleUI")
  self._ui._keypadTable = {
    self._ui._keypadY,
    self._ui._keypadX,
    self._ui._keypadA,
    self._ui._keypadB
  }
  self._middleButtonList = {
    self._ui._btn_Rules,
    self._ui._btn_Ranking,
    self._ui._btn_ReplayList,
    self._ui._btn_SolarePass
  }
  self._ui._btn_CeremonyOption:SetShow(_ContentsGroup_SolareCeremony == true)
  self._ui._btn_ReplayList:SetShow(_ContentsGroup_SolareReplay == true)
  self._ui._keypadBg:SetShow(_ContentsGroup_UsePadSnapping)
  for idx = 0, self._maxTierCount do
    self._ui._txt_TierListTable[idx] = UI.getChildControl(self._ui._stc_TierListBg, "StaticText_Tier_" .. tostring(idx))
  end
  self._ui._frameContent = UI.getChildControl(self._ui._frameRecentInfoList, "Frame_1_Content")
  self._ui._frameVertiScroll = UI.getChildControl(self._ui._frameRecentInfoList, "Frame_1_VerticalScroll")
  self._ui._placementBg = UI.getChildControl(Panel_Window_Solare_Finding_Match, "Static_RankingDecision")
  local resultBg = UI.getChildControl(self._ui._placementBg, "Static_ResultArea")
  local bgTemp = UI.getChildControl(resultBg, "Static_Game1")
  bgTemp:SetShow(false)
  local spanY = 0
  local count = 0
  local gap = 29
  local raw = 5
  local placementCountMax = math.max(self._placementMatchMaxCount_1vs1, self._placementMatchMaxCount_3vs3)
  for idx = 0, placementCountMax - 1 do
    local table = {}
    local bg = UI.cloneControl(bgTemp, resultBg, "stc_resultBgSolare" .. tostring(idx))
    table._stc_Win = UI.getChildControl(bg, "Static_Win")
    table._stc_Lose = UI.getChildControl(bg, "Static_Lose")
    table._stc_Draw = UI.getChildControl(bg, "Static_Draw")
    table._stc_None = UI.getChildControl(bg, "Static_None")
    if idx ~= 0 and idx % raw == 0 then
      spanY = spanY + gap
      count = 0
    end
    local spanX = count * gap
    bg:SetSpanSize(spanX, spanY)
    bg:ComputePos()
    bg:SetShow(true)
    self._ui._placementRecordIcon:push_back(table)
    count = count + 1
  end
  self._ui._placementBg:SetSize(self._ui._placementBg:GetSizeX(), self._ui._placementBg:GetSizeY() + spanY)
  self._ui._placementBg:ComputePosAllChild()
  resultBg:SetSize(resultBg:GetSizeX(), resultBg:GetSizeY() + spanY)
  resultBg:ComputePosAllChild()
  self._ui._stc_matchingBg = UI.getChildControl(Panel_Window_Solare_Finding_Match, "Static_MatchingWaiting")
  self._ui._txt_MatchingState = UI.getChildControl(self._ui._stc_matchingBg, "StaticText_Loading")
  self._ui._btn_MatchingCancel = UI.getChildControl(self._ui._stc_matchingBg, "Button_Cancel")
  self._ui._txt_MatchingElapsedTime = UI.getChildControl(self._ui._stc_matchingBg, "StaticText_Time")
  self._ui._stc_changeModeBg:SetShow(ToClient_IsDevelopment() == true)
  self._ui._btn_RankGameReq:SetTextMode(__eTextMode_AutoWrap)
  self._ui._btn_RankGameReq:SetText(self._ui._btn_RankGameReq:GetText())
  self._ui._btn_NormalGameReq:SetTextMode(__eTextMode_AutoWrap)
  self._ui._btn_NormalGameReq:SetText(self._ui._btn_NormalGameReq:GetText())
  self._ui._btn_CustomGameReq:SetTextMode(__eTextMode_AutoWrap)
  self._ui._btn_CustomGameReq:SetText(self._ui._btn_CustomGameReq:GetText())
  local presetDropBox = UI.getChildControl(topBg, "Combobox2_Preset")
  presetDropBox:GetListControl():AddSelectEvent("PaGlobal_Solrare_Matching_DropBox_Click()")
  local dropBoxList = UI.getChildControl(presetDropBox, "Combobox2_1_List")
  if isGameServiceTypeDev() then
    if _ContentsGroup_SolareCeremony == false then
      presetDropBox:SetShow(true)
    end
    presetDropBox:AddItem("\236\130\172\235\131\165")
    presetDropBox:AddItem("PVP")
    presetDropBox:AddItem("\234\177\176\236\160\144\236\160\132")
    presetDropBox:addInputEvent("Mouse_LUp", "PaGlobal_Solrare_Matching_DropBox()")
  end
  if _ContentsGroup_SolareCeremony == true then
  end
  function PaGlobal_Solrare_Matching_DropBox()
    presetDropBox:ToggleListbox()
  end
  function PaGlobal_Solrare_Matching_DropBox_Click()
    local selectIndex = presetDropBox:GetSelectIndex()
    local title = "\237\148\132\235\166\172\236\133\139 \235\179\128\234\178\189"
    local desc = ""
    if 0 == selectIndex then
      desc = "\237\148\132\235\166\172\236\133\139 \236\132\164\236\160\149\236\157\132 <PAColor0xfff5ba3a>[\236\130\172\235\131\165]<PAOldColor>\236\156\188\235\161\156 \235\179\128\234\178\189\237\149\152\236\139\156\234\178\160\236\138\181\235\139\136\234\185\140?"
    elseif 1 == selectIndex then
      desc = "\237\148\132\235\166\172\236\133\139 \236\132\164\236\160\149\236\157\132 <PAColor0xfff5ba3a>[PVP]<PAOldColor>\235\161\156 \235\179\128\234\178\189\237\149\152\236\139\156\234\178\160\236\138\181\235\139\136\234\185\140?"
    elseif 2 == selectIndex then
      desc = "\237\148\132\235\166\172\236\133\139 \236\132\164\236\160\149\236\157\132 <PAColor0xfff5ba3a>[\234\177\176\236\160\144\236\160\132]<PAOldColor>\236\156\188\235\161\156 \235\179\128\234\178\189\237\149\152\236\139\156\234\178\160\236\138\181\235\139\136\234\185\140?"
    end
    local messageBoxData = {
      title = title,
      content = desc,
      functionYes = MessageBox_Empty_function,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
  local curChannelData = getCurrentChannelServerData()
  local isMultiNationChampionshipServer = false
  if curChannelData ~= nil then
    isMultiNationChampionshipServer = curChannelData:isMultiNationChampionshipServer()
  end
  if _ContentsGroup_ChampionshipServer == true and isMultiNationChampionshipServer == false and ToClient_isMultiNationChampionshipUser() == true then
    self._ui._btn_CopyUserInformation:SetShow(true)
  else
    self._ui._btn_CopyUserInformation:SetShow(false)
  end
  self:registEventHandler()
  self:createFrameControl()
  self._initialize = true
end
function PaGlobal_Solrare_Matching:registEventHandler()
  if Panel_Window_Solrare_Matching == nil then
    return
  end
  self._ui._btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_Solrare_Matching_Close()")
  self._ui._btn_RankGameReq:addInputEvent("Mouse_LUp", "HandleEventLUp_Solrare_JoinRankMatching()")
  self._ui._btn_NormalGameReq:addInputEvent("Mouse_LUp", "HandleEventLUp_Solrare_NormalMatching()")
  self._ui._btn_CustomGameReq:addInputEvent("Mouse_LUp", "HandleEventLUp_Solrare_OpenCustomMatching()")
  if ToClient_IsDevelopment() == true then
    self._ui._btn_RankGameReq:addInputEvent("Mouse_On", "HandleEventOnOut_Solrare_AccumulateTime(true)")
    self._ui._btn_RankGameReq:addInputEvent("Mouse_Out", "HandleEventOnOut_Solrare_AccumulateTime(false)")
  end
  self._ui._btn_MatchingCancel:addInputEvent("Mouse_LUp", "PaGlobalFunc_Solrare_MatchingState_PrepareClose()")
  self._ui._btn_Equip:addInputEvent("Mouse_LUp", "PaGlobalFunc_PaGlobal_Solare_EquipPreset_Open()")
  self._ui._btn_CeremonyOption:addInputEvent("Mouse_LUp", "PaGlobal_Solare_CeremonyAction_Open()")
  self._ui._btn_Ranking:addInputEvent("Mouse_LUp", "HandleEventLUp_MenuRemake_SolrareRankingOpen()")
  self._ui._btn_ReplayList:addInputEvent("Mouse_LUp", "PaGlobalFunc_SolareReplayList_Open()")
  self._ui._btn_Wiki:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"Solare\" )")
  if _ContentsGroup_UsePadSnapping == false then
    self._ui._btn_Rules:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"Solare\" )")
  else
    self._ui._btn_Rules:addInputEvent("Mouse_LUp", "PaGlobalFunc_Solrare_Matching_OpenRule()")
  end
  self._ui._stc_changeModeBg:addInputEvent("Mouse_LUp", "HandleEventLUp_Solare_ChangeGameMode()")
  self._ui._btn_changeMode:addInputEvent("Mouse_LUp", "HandleEventLUp_Solare_ChangeGameMode()")
  self._ui._btn_SolarePass:addInputEvent("Mouse_LUp", "PaGlobal_Event_SpecialPass_Open(" .. __eSpecialPassContentType_Solare .. ")")
  if _ContentsGroup_UsePadSnapping == true then
    Panel_Window_Solrare_Matching:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_PaGlobal_Solare_EquipPreset_Open()")
    Panel_Window_Solrare_Matching:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_PaGlobal_Solare_EquipPreset_TierListShow()")
  else
    self._ui._btn_TierList:addInputEvent("Mouse_On", "PaGlobalFunc_PaGlobal_Solare_EquipPreset_TierListShow(true)")
    self._ui._btn_TierList:addInputEvent("Mouse_Out", "PaGlobalFunc_PaGlobal_Solare_EquipPreset_TierListShow(false)")
  end
  registerEvent("FromClient_SolareRecentRecordLoad", "FromClient_SolareRecentRecordLoad")
  registerEvent("FromClient_SolareNeedSettingEquipPresetAck", "FromClient_SolareNeedSettingEquipPresetAck")
  if _ContentsGroup_ChampionshipServer == true then
    self._ui._btn_CopyUserInformation:addInputEvent("Mouse_LUp", "PaGlobalFunc_Solare_CopyUserInformation()")
    registerEvent("FromClient_CopyUserInformation", "FromClient_CopyUserInformation")
  end
end
function PaGlobal_Solrare_Matching:createFrameControl()
  if Panel_Window_Solrare_Matching == nil then
    return
  end
  local frameContentOriginal = UI.getChildControl(self._ui._frameContent, "Static_1")
  self._normalBgSize = frameContentOriginal:GetSizeY()
  self._detailBgSize = UI.getChildControl(frameContentOriginal, "Static_Detail_BG"):GetSizeY()
  for idx = 1, self._maxShowRecentInfoCount do
    local tempTable = {
      _mainBg = nil,
      _checkButtonBg = nil,
      _line_Win = nil,
      _line_Lose = nil,
      _line_Draw = nil,
      _txt_Escape = nil,
      _txt_ResultWithRate = nil,
      _stc_RoundResult = nil,
      _txt_PlayTime = nil,
      _chk_ShowDetail = nil,
      _ATeamClassWithTier = Array.new(),
      _BTeamClassWithTier = Array.new(),
      _detailBg = nil,
      _ATeamDetail = Array.new(),
      _BTeamDetail = Array.new(),
      _isDetailControlShow = false,
      _stc_MVP = nil,
      _stc_Ace = nil,
      _stc_recordTime = nil,
      _txt_isWinStreak = nil
    }
    tempTable._mainBg = UI.cloneControl(frameContentOriginal, self._ui._frameContent, "Copied_FrameContent_RecentInfo" .. tostring(idx))
    tempTable._mainBg:SetPosXY(tempTable._mainBg:GetPosX(), (tempTable._mainBg:GetPosY() + tempTable._mainBg:GetSizeY() + 3) * (idx - 1))
    tempTable._mainBg:SetShow(false)
    tempTable._checkButtonBg = UI.getChildControl(tempTable._mainBg, "CheckButton_Bg")
    tempTable._line_Win = UI.getChildControl(tempTable._checkButtonBg, "Static_Win")
    tempTable._line_Lose = UI.getChildControl(tempTable._checkButtonBg, "Static_Lose")
    tempTable._line_Draw = UI.getChildControl(tempTable._checkButtonBg, "Static_Tie")
    tempTable._txt_Escape = UI.getChildControl(tempTable._checkButtonBg, "StaticText_Escape")
    tempTable._txt_ResultWithRate = UI.getChildControl(tempTable._checkButtonBg, "StaticText_Win")
    tempTable._stc_RoundResult = UI.getChildControl(tempTable._checkButtonBg, "Static_RecordArea")
    tempTable._txt_PlayTime = UI.getChildControl(tempTable._checkButtonBg, "StaticText_PlayTime")
    tempTable._stc_recordTime = UI.getChildControl(tempTable._checkButtonBg, "StaticText_Date")
    tempTable._txt_isWinStreak = UI.getChildControl(tempTable._checkButtonBg, "StaticText_SuccWin")
    tempTable._chk_ShowDetail = UI.getChildControl(tempTable._checkButtonBg, "CheckButton_Show_Detail")
    tempTable._chk_ShowDetail:SetShow(true)
    if _ContentsGroup_UsePadSnapping == true then
      tempTable._checkButtonBg:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_Solrare_ShowDetailToggle(" .. tostring(idx) .. ")")
    else
      tempTable._chk_ShowDetail:addInputEvent("Mouse_LUp", "HandleEventLUp_Solrare_ShowDetailToggle(" .. tostring(idx) .. ")")
    end
    tempTable._chk_ShowDetail:setNotImpactScrollEvent(true)
    local stc_MyTeam = UI.getChildControl(tempTable._checkButtonBg, "Static_MyTeam")
    local stc_EnemyTeam = UI.getChildControl(tempTable._checkButtonBg, "Static_EnemyTeam")
    tempTable._detailBg = UI.getChildControl(tempTable._mainBg, "Static_Detail_BG")
    tempTable._detailBg:SetShow(false)
    local stc_MyTeamDetail = UI.getChildControl(tempTable._detailBg, "Static_MyTeam")
    local stc_EnemyTeamDetail = UI.getChildControl(tempTable._detailBg, "Static_EnemyTeam")
    local txt_MyTitleTeam = UI.getChildControl(stc_MyTeamDetail, "StaticText_Title_Team")
    local txt_MyTitleKDA = UI.getChildControl(stc_MyTeamDetail, "StaticText_Title_KDA")
    local txt_MyTitleHeal = UI.getChildControl(stc_MyTeamDetail, "StaticText_Title_Heal")
    local txt_MyTitleHarm = UI.getChildControl(stc_MyTeamDetail, "StaticText_Title_Harm")
    local txt_MyTitleDamage = UI.getChildControl(stc_MyTeamDetail, "StaticText_Title_Damage")
    local txt_MyTitleCCCount = UI.getChildControl(stc_MyTeamDetail, "StaticText_Title_CCCount")
    local txt_Title_Team = UI.getChildControl(stc_EnemyTeamDetail, "StaticText_Title_Team")
    local txt_Title_KDA = UI.getChildControl(stc_EnemyTeamDetail, "StaticText_Title_KDA")
    local txt_Title_Heal = UI.getChildControl(stc_EnemyTeamDetail, "StaticText_Title_Heal")
    local txt_Title_Harm = UI.getChildControl(stc_EnemyTeamDetail, "StaticText_Title_Harm")
    local txt_Title_Damage = UI.getChildControl(stc_EnemyTeamDetail, "StaticText_Title_Damage")
    local txt_Title_CCCount = UI.getChildControl(stc_EnemyTeamDetail, "StaticText_Title_CCCount")
    UI.setLimitTextAndAddTooltip(txt_MyTitleTeam, txt_MyTitleTeam:GetText(), "")
    UI.setLimitTextAndAddTooltip(txt_MyTitleKDA, txt_MyTitleKDA:GetText(), "")
    UI.setLimitTextAndAddTooltip(txt_MyTitleHeal, txt_MyTitleHeal:GetText(), "")
    UI.setLimitTextAndAddTooltip(txt_MyTitleHarm, txt_MyTitleHarm:GetText(), "")
    UI.setLimitTextAndAddTooltip(txt_MyTitleDamage, txt_MyTitleDamage:GetText(), "")
    UI.setLimitTextAndAddTooltip(txt_Title_Team, txt_Title_Team:GetText(), "")
    UI.setLimitTextAndAddTooltip(txt_Title_KDA, txt_Title_KDA:GetText(), "")
    UI.setLimitTextAndAddTooltip(txt_Title_Heal, txt_Title_Heal:GetText(), "")
    UI.setLimitTextAndAddTooltip(txt_Title_Harm, txt_Title_Harm:GetText(), "")
    UI.setLimitTextAndAddTooltip(txt_Title_Damage, txt_Title_Damage:GetText(), "")
    UI.setLimitTextAndAddTooltip(txt_MyTitleCCCount, txt_MyTitleCCCount:GetText(), "")
    UI.setLimitTextAndAddTooltip(txt_Title_CCCount, txt_Title_CCCount:GetText(), "")
    for idx = 1, 3 do
      local tempA = {_classBg = nil, _tierBg = nil}
      local tempB = {_classBg = nil, _tierBg = nil}
      local stc_ATeamClass = UI.getChildControl(stc_MyTeam, "Static_Profile_Icon_" .. tostring(idx))
      local stc_ATeamTier = UI.getChildControl(stc_MyTeam, "Static_TierIcon_" .. tostring(idx))
      local stc_BTeamClass = UI.getChildControl(stc_EnemyTeam, "Static_Profile_Icon_" .. tostring(idx))
      local stc_BTeamTier = UI.getChildControl(stc_EnemyTeam, "Static_TierIcon_" .. tostring(idx))
      tempA._classBg = stc_ATeamClass
      tempA._tierBg = stc_ATeamTier
      tempB._classBg = stc_BTeamClass
      tempB._tierBg = stc_BTeamTier
      tempA._classBg:SetShow(false)
      tempA._tierBg:SetShow(false)
      tempB._classBg:SetShow(false)
      tempB._tierBg:SetShow(false)
      tempTable._ATeamClassWithTier:push_back(tempA)
      tempTable._BTeamClassWithTier:push_back(tempB)
      local teamADetailBg = UI.getChildControl(stc_MyTeamDetail, "Static_Member_BG_" .. tostring(idx))
      local teamBDetailBg = UI.getChildControl(stc_EnemyTeamDetail, "Static_Member_BG_" .. tostring(idx))
      local tempDetailA = {
        _bg = teamADetailBg,
        _classBg = UI.getChildControl(teamADetailBg, "Static_Profile"),
        _stc_tier = UI.getChildControl(teamADetailBg, "Static_Tier"),
        _txt_name = UI.getChildControl(teamADetailBg, "StaticText_Name"),
        _txt_KDA = UI.getChildControl(teamADetailBg, "StaticText_KDA"),
        _txt_heal = UI.getChildControl(teamADetailBg, "StaticText_Heal"),
        _txt_harm = UI.getChildControl(teamADetailBg, "StaticText_Harm"),
        _txt_dmg = UI.getChildControl(teamADetailBg, "StaticText_Damage"),
        _stc_MVP = UI.getChildControl(teamADetailBg, "Static_MVP"),
        _stc_Ace = UI.getChildControl(teamADetailBg, "Static_Ace"),
        _btn_detail = UI.getChildControl(teamADetailBg, "Button_Detail"),
        _stc_awaken = UI.getChildControl(teamADetailBg, "Static_Type_Awaken"),
        _stc_succession = UI.getChildControl(teamADetailBg, "Static_Type_Succession"),
        _stc_shy = UI.getChildControl(teamADetailBg, "Static_Type_Shy"),
        _stc_archer = UI.getChildControl(teamADetailBg, "Static_Type_Archer"),
        _stc_scholar = UI.getChildControl(teamADetailBg, "Static_Type_Scholar"),
        _stc_deadeye = UI.getChildControl(teamADetailBg, "Static_Type_DeadEye"),
        _stc_ogong = UI.getChildControl(teamADetailBg, "Static_Type_Ogong"),
        _stc_seraphim = UI.getChildControl(teamADetailBg, "Static_Type_Seraphim"),
        _stc_CCCount = UI.getChildControl(teamADetailBg, "StaticText_CCCount")
      }
      local tempDetailB = {
        _bg = teamBDetailBg,
        _classBg = UI.getChildControl(teamBDetailBg, "Static_Profile"),
        _stc_tier = UI.getChildControl(teamBDetailBg, "Static_Tier"),
        _txt_name = UI.getChildControl(teamBDetailBg, "StaticText_Name"),
        _txt_KDA = UI.getChildControl(teamBDetailBg, "StaticText_KDA"),
        _txt_heal = UI.getChildControl(teamBDetailBg, "StaticText_Heal"),
        _txt_harm = UI.getChildControl(teamBDetailBg, "StaticText_Harm"),
        _txt_dmg = UI.getChildControl(teamBDetailBg, "StaticText_Damage"),
        _stc_MVP = UI.getChildControl(teamBDetailBg, "Static_MVP"),
        _stc_Ace = UI.getChildControl(teamBDetailBg, "Static_Ace"),
        _btn_detail = UI.getChildControl(teamBDetailBg, "Button_Detail"),
        _stc_awaken = UI.getChildControl(teamBDetailBg, "Static_Type_Awaken"),
        _stc_succession = UI.getChildControl(teamBDetailBg, "Static_Type_Succession"),
        _stc_shy = UI.getChildControl(teamBDetailBg, "Static_Type_Shy"),
        _stc_archer = UI.getChildControl(teamBDetailBg, "Static_Type_Archer"),
        _stc_scholar = UI.getChildControl(teamBDetailBg, "Static_Type_Scholar"),
        _stc_deadeye = UI.getChildControl(teamBDetailBg, "Static_Type_DeadEye"),
        _stc_ogong = UI.getChildControl(teamBDetailBg, "Static_Type_Ogong"),
        _stc_seraphim = UI.getChildControl(teamBDetailBg, "Static_Type_Seraphim"),
        _stc_CCCount = UI.getChildControl(teamBDetailBg, "StaticText_CCCount")
      }
      tempTable._ATeamDetail:push_back(tempDetailA)
      tempTable._BTeamDetail:push_back(tempDetailB)
    end
    self._frameControlList:push_back(tempTable)
  end
  frameContentOriginal:SetShow(false)
end
function PaGlobal_Solrare_Matching:reAlignFrameControl()
  if Panel_Window_Solrare_Matching == nil then
    return
  end
  local prevPosY = 0
  local gap = 3
  local isDetailClicked = false
  for idx = 1, self._maxShowRecentInfoCount do
    if self._frameControlList[idx] ~= nil then
      local controlList = self._frameControlList[idx]
      local isDetailOpen = controlList._isDetailControlShow
      controlList._mainBg:SetPosXY(controlList._mainBg:GetPosX(), prevPosY)
      if isDetailOpen == true then
        isDetailClicked = true
        prevPosY = prevPosY + (controlList._mainBg:GetSizeY() + controlList._detailBg:GetSizeY() + gap)
      else
        prevPosY = prevPosY + (controlList._mainBg:GetSizeY() + gap)
      end
    end
  end
  local totalControlSize = #self._recordNumberList * (self._normalBgSize + 10)
  if isDetailClicked == true then
    totalControlSize = totalControlSize + self._detailBgSize
  end
  self._ui._frameContent:SetSize(self._ui._frameContent:GetSizeX(), totalControlSize)
  self._ui._frameVertiScroll:SetInterval(#self._recordNumberList)
  self._ui._frameRecentInfoList:UpdateContentScroll()
  self._ui._frameRecentInfoList:UpdateContentPos()
  self:setFrameControlByRecentInfo()
end
function PaGlobal_Solrare_Matching:update()
  if Panel_Window_Solrare_Matching == nil then
    return
  end
  self:updateSelfPlayerInfo()
  self:updateRecentMatchList()
  self:setFrameControlByRecentInfo()
  self:updateChampionShipButton()
  local totalControlSize = #self._recordNumberList * (self._normalBgSize + 10)
  if isDetailClicked == true then
    totalControlSize = totalControlSize + self._detailBgSize
  end
  self._ui._stc_copyProgress:SetShow(false)
  self._ui._frameContent:SetSize(self._ui._frameContent:GetSizeX(), totalControlSize)
  self._ui._frameVertiScroll:SetInterval(#self._recordNumberList)
  self._ui._frameRecentInfoList:UpdateContentScroll()
  self._ui._frameRecentInfoList:UpdateContentPos()
  self._ui._frameVertiScroll:SetControlTop()
end
function PaGlobal_Solrare_Matching:updateSelfPlayerInfo()
  if Panel_Window_Solrare_Matching == nil then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local info = ToClient_GetSolareSelfPlayerInfo(self:getCurrentGameMode())
  if info == nil then
    return
  end
  local myRankRating = info:getRankRating()
  local myRank = info:getRanking()
  if myRank <= 0 then
    myRank = "-"
  end
  local winCount = info:getWinCount()
  local loseCount = info:getLoseCount()
  local drawCount = info:getDrawCount()
  local playCount = info:getPlayCount()
  local classTypeRaw = selfPlayer:getClassType()
  local isTop = myRank == 1
  local playTotalCount = info:getPlayTotalCount()
  local winTotalCount = info:getWinTotalCount()
  self._ui._txt_RankRating:SetText(myRankRating)
  self._ui._txt_Level:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EXPEDITION_UNIT_LEVEL", "level", selfPlayer:get():getLevel()))
  self._ui._txt_Name:SetText(selfPlayer:getUserNickname())
  self._ui._txt_Ranking:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SOLARE_RANK_VALUE", "rank", myRank))
  local recordText = PAGetStringParam4(Defines.StringSheet_GAME, "LUA_SOLARA_RECENT_VALUE", "total", playCount, "win", winCount, "tie", drawCount, "lose", loseCount)
  local recordTotalText = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SOLARE_TOTALCOUNT_VALUE", "total", playTotalCount, "win", winTotalCount)
  self._ui._txt_RecentRecord:SetText(recordText .. " " .. recordTotalText)
  self._ui._txt_NoRecord:SetShow(false)
  if PaGlobalFunc_Util_SetSolrareRankingClassBigBG ~= nil then
    PaGlobalFunc_Util_SetSolrareRankingClassBigBG(self._ui._stc_ClassIcon, classTypeRaw)
  end
  if PaGlobalFunc_Solrare_Ranking_SetTierIconByScore ~= nil then
    PaGlobalFunc_Solrare_Ranking_SetTierIconByScore(self._ui._stc_RankIcon, myRankRating, isTop)
  end
  local myTier = CovertSolrareRankScoreToTierGrade(myRankRating)
  local rankOrder = Defines.SolrareRankOrder[myTier]
  for idx = 0, self._maxTierCount do
    if rankOrder == idx then
      self._ui._txt_TierListTable[idx]:SetFontColor(Defines.Color.C_FFF5BA3A)
    else
      self._ui._txt_TierListTable[idx]:SetFontColor(Defines.Color.C_FFDDC39E)
    end
  end
  if rankOrder < 10 then
    rankOrder = "0" .. tostring(rankOrder)
  end
  self._ui._txt_Tier:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_RANK_TIER_" .. tostring(rankOrder)))
  UI.setLimitTextAndAddTooltip(self._ui._txt_Tier, self._ui._txt_Tier:GetText(), "")
end
function PaGlobal_Solrare_Matching:updateRecentMatchList()
  if Panel_Window_Solrare_Matching == nil then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  self._recentInfoList = {}
  self._recordNumberList = Array.new()
  self._recentInfoCount = 0
  local recentInfoCount = ToClient_GetSolareMyRecentRecordCount()
  if recentInfoCount <= 0 then
    self._ui._txt_NoRecord:SetShow(true)
    return
  end
  local languageType = ToClient_getResourceType()
  local selfUserNo = selfPlayer:get():getUserNo()
  local startIndex = recentInfoCount - 1
  for index = 0, recentInfoCount - 1 do
    local recentInfo = ToClient_GetSolareMyRecentRecordIndex(index)
    if recentInfo ~= nil then
      local recordNumber32 = Int64toInt32(recentInfo:getRecordNumber64())
      local teamNo = recentInfo:getTeamNo()
      local recordResult = recentInfo:getResult()
      local isWin = recordResult == __eSolareRoundResult_Win
      local recordUserNo64 = recentInfo:getUserNo64()
      local isMVPAce = recentInfo:getWinMVPUserNo64() == recordUserNo64 or recentInfo:getLoseAceUserNo64() == recordUserNo64
      local userInfoTable = {
        _recordIndex = index,
        _userNo = tostring(recordUserNo64),
        _name = recentInfo:getName(),
        _classType = recentInfo:getClassTypeRaw(),
        _attackDamage = recentInfo:getAttackedDamage(),
        _harmDamage = recentInfo:getHittedDamage(),
        _healAmount = recentInfo:getHealedAmount(),
        _killCount = recentInfo:getKillCount(),
        _deathCount = recentInfo:getDeathCount(),
        _teamNo = recentInfo:getTeamNo(),
        _rankRating = Int64toInt32(recentInfo:getUserRankRating64()),
        _isMVP = isMVPAce == true and isWin == true,
        _isAce = isMVPAce == true and isWin == false,
        _winStreakCount = 0,
        _skillBranchType = recentInfo:getSkillBranch(),
        _CCCount = recentInfo:getCCAppliedCount()
      }
      if recentInfo:getUserNo64() == selfUserNo then
        userInfoTable._name = "<PAColor0xfff5ba3a>" .. userInfoTable._name .. "<PAOldColor>"
        userInfoTable._winStreakCount = recentInfo:getWinStreak()
      else
        userInfoTable._name = "<PAColor0xffddc39e>" .. userInfoTable._name .. "<PAOldColor>"
      end
      if self._recentInfoList[recordNumber32] ~= nil then
        if userInfoTable._teamNo == __eSolareTeamNo_Red then
          self._recentInfoList[recordNumber32]._ATeam:push_back(userInfoTable)
        elseif userInfoTable._teamNo == __eSolareTeamNo_Blue then
          self._recentInfoList[recordNumber32]._BTeam:push_back(userInfoTable)
        end
      else
        local tempTable = {
          _ATeam = Array.new(),
          _BTeam = Array.new(),
          _playTime = recentInfo:getPlayTime64(),
          _recordNumber32 = recordNumber32,
          _result = __eSolareRoundResult_Win,
          _varyRating = 0,
          _resultTypeList = Array.new(),
          _selfPlayerTeamNumber = -1,
          _isLogin = false,
          _recordTime = "",
          _mode = recentInfo:getMode()
        }
        if userInfoTable._teamNo == __eSolareTeamNo_Red then
          tempTable._ATeam:push_back(userInfoTable)
        elseif userInfoTable._teamNo == __eSolareTeamNo_Blue then
          tempTable._BTeam:push_back(userInfoTable)
        end
        local recordTime64 = recentInfo:getRecordDateUTCTime64()
        local recordTimStamp = PATime(recentInfo:getRecordDateUTCTime64())
        tempTable._recordTime = string.sub(tostring(recordTimStamp:GetYear()), 3, 4) .. " / " .. tostring(recordTimStamp:GetMonth()) .. " / " .. tostring(recordTimStamp:GetDay())
        if languageType == CppEnums.ServiceResourceType.eServiceResourceType_EN or languageType == CppEnums.ServiceResourceType.eServiceResourceType_ID then
          tempTable._recordTime = tostring(recordTimStamp:GetMonth()) .. " / " .. tostring(recordTimStamp:GetDay()) .. " / " .. string.sub(tostring(recordTimStamp:GetYear()), 3, 4)
        elseif languageType == CppEnums.ServiceResourceType.eServiceResourceType_TR or languageType == CppEnums.ServiceResourceType.eServiceResourceType_RU or languageType == CppEnums.ServiceResourceType.eServiceResourceType_TH or languageType == CppEnums.ServiceResourceType.eServiceResourceType_FR or languageType == CppEnums.ServiceResourceType.eServiceResourceType_DE or languageType == CppEnums.ServiceResourceType.eServiceResourceType_ES or languageType == CppEnums.ServiceResourceType.eServiceResourceType_PT or languageType == CppEnums.ServiceResourceType.eServiceResourceType_SP then
          tempTable._recordTime = tostring(recordTimStamp:GetDay()) .. " / " .. tostring(recordTimStamp:GetMonth()) .. " / " .. string.sub(tostring(recordTimStamp:GetYear()), 3, 4)
        end
        self._recentInfoList[recordNumber32] = tempTable
        self._recentInfoCount = self._recentInfoCount + 1
        self._recordNumberList:push_back(recordNumber32)
      end
      if selfUserNo == recordUserNo64 then
        self._recentInfoList[recordNumber32]._selfPlayerTeamNumber = userInfoTable._teamNo
        self._recentInfoList[recordNumber32]._result = recordResult
        self._recentInfoList[recordNumber32]._varyRating = recentInfo:getResultGameRating()
        self._recentInfoList[recordNumber32]._isLogin = recentInfo:getIsLogin()
        self._recentInfoList[recordNumber32]._winStreakCount = recentInfo:getWinStreak()
        for idx = 0, recentInfo:getWinRecordCount() - 1 do
          local result = recentInfo:getWinRecordByIndex(idx)
          self._recentInfoList[recordNumber32]._resultTypeList:push_back(result)
        end
      end
    end
  end
end
function PaGlobal_Solrare_Matching:setFrameControlByRecentInfo()
  if Panel_Window_Solrare_Matching == nil then
    return
  end
  for idx = 1, #self._recordNumberList do
    local recentNumber = self._recordNumberList[idx]
    local recentRecordList = self._recentInfoList[recentNumber]
    local frameControlTable = self._frameControlList[idx]
    if recentRecordList ~= nil and frameControlTable ~= nil then
      frameControlTable._mainBg:SetShow(true)
      frameControlTable._txt_PlayTime:SetText(convertSecondsToClockTime(Int64toInt32(recentRecordList._playTime)))
      frameControlTable._stc_recordTime:SetText(recentRecordList._recordTime)
      local mode = recentRecordList._mode
      local isLogin = recentRecordList._isLogin
      local result = recentRecordList._result
      local winString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SOLARE_WIN")
      local loseString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SOLARE_LOSE")
      local drawString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SOLARE_TIE")
      local varyRatingString = tostring(recentRecordList._varyRating)
      if recentRecordList._varyRating > 0 then
        varyRatingString = "(+" .. varyRatingString .. ")"
      elseif recentRecordList._varyRating < 0 then
        varyRatingString = "(" .. varyRatingString .. ")"
      else
        varyRatingString = "(" .. varyRatingString .. ")"
      end
      if recentRecordList._mode == __eSolareMode_Normal_1vs1 or recentRecordList._mode == __eSolareMode_Normal_3vs3 or recentRecordList._mode == __eSolareMode_Custom then
        winString = PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_NORMALGAME_TITLE_WIN")
        loseString = PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_NORMALGAME_TITLE_LOSE")
        drawString = PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_NORMALGAME_TITLE_TIE")
        varyRatingString = ""
      end
      frameControlTable._line_Win:SetShow(false)
      frameControlTable._line_Lose:SetShow(false)
      frameControlTable._line_Draw:SetShow(false)
      frameControlTable._txt_Escape:SetShow(false)
      frameControlTable._txt_ResultWithRate:SetShow(false)
      frameControlTable._txt_isWinStreak:SetShow(false)
      local isRankRecord = recentRecordList._mode == __eSolareMode_Ranking_1vs1 or recentRecordList._mode == __eSolareMode_Ranking_3vs3
      if self._startWinStreakCount <= recentRecordList._winStreakCount and isRankRecord == true then
        frameControlTable._txt_isWinStreak:SetShow(true)
      end
      if result == __eSolareRoundResult_Win then
        frameControlTable._txt_ResultWithRate:SetText("<PAColor0xff77c2ff>" .. winString .. tostring(varyRatingString) .. "<PAOldColor>")
        frameControlTable._line_Win:SetShow(true)
        frameControlTable._txt_ResultWithRate:SetShow(true)
      elseif result == __eSolareRoundResult_Lose then
        frameControlTable._txt_ResultWithRate:SetText("<PAColor0xffff826b>" .. loseString .. tostring(varyRatingString) .. "<PAOldColor>")
        frameControlTable._line_Lose:SetShow(true)
        frameControlTable._txt_ResultWithRate:SetShow(true)
      elseif result == __eSolareRoundResult_Draw then
        frameControlTable._txt_ResultWithRate:SetText("<PAColor0xfff5ba3a>" .. drawString .. tostring(varyRatingString) .. "<PAOldColor>")
        frameControlTable._line_Draw:SetShow(true)
        frameControlTable._txt_ResultWithRate:SetShow(true)
      end
      if isLogin == false then
        frameControlTable._txt_Escape:SetShow(true)
      end
      local winTextureID = "Combine_Etc_Solare_War_Ingame_Icon_Result_Win"
      local loseTextureID = "Combine_Etc_Solare_War_Ingame_Icon_Result_Lose"
      local drawTextureID = "Combine_Etc_Solare_War_Ingame_Icon_Result_Draw"
      local roundResultControlList = Array.new()
      roundResultControlList:push_back(UI.getChildControl(frameControlTable._stc_RoundResult, "StaticText_Record_0"))
      roundResultControlList:push_back(UI.getChildControl(frameControlTable._stc_RoundResult, "StaticText_Record_1"))
      roundResultControlList:push_back(UI.getChildControl(frameControlTable._stc_RoundResult, "StaticText_Record_2"))
      roundResultControlList:push_back(UI.getChildControl(frameControlTable._stc_RoundResult, "StaticText_Record_3"))
      roundResultControlList:push_back(UI.getChildControl(frameControlTable._stc_RoundResult, "StaticText_Record_4"))
      local slashControlList = Array.new()
      slashControlList:push_back(UI.getChildControl(frameControlTable._stc_RoundResult, "StaticText_Record_Slash_0"))
      slashControlList:push_back(UI.getChildControl(frameControlTable._stc_RoundResult, "StaticText_Record_Slash_1"))
      slashControlList:push_back(UI.getChildControl(frameControlTable._stc_RoundResult, "StaticText_Record_Slash_2"))
      slashControlList:push_back(UI.getChildControl(frameControlTable._stc_RoundResult, "StaticText_Record_Slash_3"))
      local slashCount = 0
      local recordCount = 0
      for key, value in pairs(roundResultControlList) do
        if value ~= nil then
          if recentRecordList._resultTypeList[key] ~= nil then
            local roundResultValue = recentRecordList._resultTypeList[key]
            local roundResultTextureID
            if roundResultValue == __eSolareRoundResult_Win then
              roundResultTextureID = winTextureID
            elseif roundResultValue == __eSolareRoundResult_Lose then
              roundResultTextureID = loseTextureID
            elseif roundResultValue == __eSolareRoundResult_Draw then
              roundResultTextureID = drawTextureID
            end
            if roundResultTextureID ~= nil then
              value:ChangeTextureInfoTextureIDAsync(roundResultTextureID)
              value:setRenderTexture(value:getBaseTexture())
              value:SetShow(true)
              recordCount = recordCount + 1
            end
          else
            value:SetShow(false)
          end
        end
      end
      slashCount = recordCount - 1
      local allCount = slashCount + recordCount
      local middlePos = 103
      local sizeIcon = 20
      local startPos = middlePos - allCount / 2 * 20
      local iconIdx = 0
      for key, value in pairs(roundResultControlList) do
        if value ~= nil and key <= recordCount then
          value:SetPosX(startPos + sizeIcon * iconIdx)
          iconIdx = iconIdx + 2
        end
      end
      iconIdx = 1
      for key, value in pairs(slashControlList) do
        if value ~= nil and key <= slashCount then
          value:SetPosX(startPos + sizeIcon * iconIdx)
          iconIdx = iconIdx + 2
        else
          value:SetShow(false)
        end
      end
      if recentRecordList._selfPlayerTeamNumber == 0 then
        for aTeamIndex = 1, #recentRecordList._ATeam do
          if nil ~= frameControlTable._ATeamClassWithTier[aTeamIndex] and nil ~= recentRecordList._ATeam[aTeamIndex] then
            local classTypeRaw = recentRecordList._ATeam[aTeamIndex]._classType
            local rankRating = recentRecordList._ATeam[aTeamIndex]._rankRating
            if nil ~= PaGlobalFunc_Util_SetSolrareMiniClassIcon then
              PaGlobalFunc_Util_SetSolrareMiniClassIcon(frameControlTable._ATeamClassWithTier[aTeamIndex]._classBg, classTypeRaw)
              frameControlTable._ATeamClassWithTier[aTeamIndex]._classBg:SetShow(true)
            end
            if nil ~= PaGlobalFunc_Solrare_Ranking_SetTierIconByScore and mode ~= __eSolareMode_Normal_1vs1 and mode ~= __eSolareMode_Normal_3vs3 and mode ~= __eSolareMode_Custom then
              PaGlobalFunc_Solrare_Ranking_SetTierIconByScore(frameControlTable._ATeamClassWithTier[aTeamIndex]._tierBg, rankRating)
              frameControlTable._ATeamClassWithTier[aTeamIndex]._tierBg:SetShow(true)
            end
          end
        end
        for bTeamIndex = 1, #recentRecordList._BTeam do
          if nil ~= frameControlTable._BTeamClassWithTier[bTeamIndex] and nil ~= recentRecordList._BTeam[bTeamIndex] then
            local classTypeRaw = recentRecordList._BTeam[bTeamIndex]._classType
            local rankRating = recentRecordList._BTeam[bTeamIndex]._rankRating
            if nil ~= PaGlobalFunc_Util_SetSolrareMiniClassIcon then
              PaGlobalFunc_Util_SetSolrareMiniClassIcon(frameControlTable._BTeamClassWithTier[bTeamIndex]._classBg, classTypeRaw)
              frameControlTable._BTeamClassWithTier[bTeamIndex]._classBg:SetShow(true)
            end
            if nil ~= PaGlobalFunc_Solrare_Ranking_SetTierIconByScore and mode ~= __eSolareMode_Normal_1vs1 and mode ~= __eSolareMode_Normal_3vs3 and mode ~= __eSolareMode_Custom then
              PaGlobalFunc_Solrare_Ranking_SetTierIconByScore(frameControlTable._BTeamClassWithTier[bTeamIndex]._tierBg, rankRating)
              frameControlTable._BTeamClassWithTier[bTeamIndex]._tierBg:SetShow(true)
            end
          end
        end
      elseif recentRecordList._selfPlayerTeamNumber == 1 then
        for aTeamIndex = 1, #recentRecordList._ATeam do
          if nil ~= frameControlTable._BTeamClassWithTier[aTeamIndex] and nil ~= recentRecordList._ATeam[aTeamIndex] then
            local classTypeRaw = recentRecordList._ATeam[aTeamIndex]._classType
            local rankRating = recentRecordList._ATeam[aTeamIndex]._rankRating
            if nil ~= PaGlobalFunc_Util_SetSolrareMiniClassIcon then
              PaGlobalFunc_Util_SetSolrareMiniClassIcon(frameControlTable._BTeamClassWithTier[aTeamIndex]._classBg, classTypeRaw)
              frameControlTable._BTeamClassWithTier[aTeamIndex]._classBg:SetShow(true)
            end
            if nil ~= PaGlobalFunc_Solrare_Ranking_SetTierIconByScore and mode ~= __eSolareMode_Normal_1vs1 and mode ~= __eSolareMode_Normal_3vs3 and mode ~= __eSolareMode_Custom then
              PaGlobalFunc_Solrare_Ranking_SetTierIconByScore(frameControlTable._BTeamClassWithTier[aTeamIndex]._tierBg, rankRating)
              frameControlTable._BTeamClassWithTier[aTeamIndex]._tierBg:SetShow(true)
            end
          end
        end
        for bTeamIndex = 1, #recentRecordList._BTeam do
          if nil ~= frameControlTable._ATeamClassWithTier[bTeamIndex] and nil ~= recentRecordList._BTeam[bTeamIndex] then
            local classTypeRaw = recentRecordList._BTeam[bTeamIndex]._classType
            local rankRating = recentRecordList._BTeam[bTeamIndex]._rankRating
            if nil ~= PaGlobalFunc_Util_SetSolrareMiniClassIcon then
              PaGlobalFunc_Util_SetSolrareMiniClassIcon(frameControlTable._ATeamClassWithTier[bTeamIndex]._classBg, classTypeRaw)
              frameControlTable._ATeamClassWithTier[bTeamIndex]._classBg:SetShow(true)
            end
            if nil ~= PaGlobalFunc_Solrare_Ranking_SetTierIconByScore and mode ~= __eSolareMode_Normal_1vs1 and mode ~= __eSolareMode_Normal_3vs3 and mode ~= __eSolareMode_Custom then
              PaGlobalFunc_Solrare_Ranking_SetTierIconByScore(frameControlTable._ATeamClassWithTier[bTeamIndex]._tierBg, rankRating)
              frameControlTable._ATeamClassWithTier[bTeamIndex]._tierBg:SetShow(true)
            end
          end
        end
      end
      frameControlTable._detailBg:SetShow(frameControlTable._isDetailControlShow)
      if frameControlTable._isDetailControlShow == true then
        local ATeamDetailTable = frameControlTable._ATeamDetail
        local BTeamDetailTable = frameControlTable._BTeamDetail
        local recentRecordATeam = recentRecordList._ATeam
        local recentRecordBTeam = recentRecordList._BTeam
        if nil ~= ATeamDetailTable and nil ~= BTeamDetailTable then
          for idx = 1, 3 do
            ATeamDetailTable[idx]._bg:SetShow(false)
            BTeamDetailTable[idx]._bg:SetShow(false)
          end
          for idx = 1, #recentRecordATeam do
            if nil ~= recentRecordATeam[idx] then
              local classTypeRaw = recentRecordATeam[idx]._classType
              local rankRating = recentRecordATeam[idx]._rankRating
              local name = recentRecordATeam[idx]._name
              local attack = recentRecordATeam[idx]._attackDamage
              local harm = recentRecordATeam[idx]._harmDamage
              local recovery = recentRecordATeam[idx]._healAmount
              local kill = recentRecordATeam[idx]._killCount
              local death = recentRecordATeam[idx]._deathCount
              local isMVP = recentRecordATeam[idx]._isMVP
              local isAce = recentRecordATeam[idx]._isAce
              local recordIndex = recentRecordATeam[idx]._recordIndex
              local skillBranchType = recentRecordATeam[idx]._skillBranchType
              local ccCount = recentRecordATeam[idx]._CCCount
              if 0 == recentRecordList._selfPlayerTeamNumber and nil ~= ATeamDetailTable[idx] then
                ATeamDetailTable[idx]._bg:SetShow(true)
                ATeamDetailTable[idx]._txt_name:SetText(name)
                ATeamDetailTable[idx]._txt_KDA:SetText(kill .. " / " .. death)
                ATeamDetailTable[idx]._txt_heal:SetText(recovery)
                ATeamDetailTable[idx]._txt_harm:SetText(harm)
                ATeamDetailTable[idx]._txt_dmg:SetText(attack)
                ATeamDetailTable[idx]._stc_MVP:SetShow(isMVP)
                ATeamDetailTable[idx]._stc_Ace:SetShow(isAce)
                ATeamDetailTable[idx]._stc_CCCount:SetText(ccCount)
                if _ContentsGroup_UsePadSnapping == true then
                  ATeamDetailTable[idx]._bg:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_Solrare_OtherInfo_OpenByRecord(" .. tostring(recordIndex) .. ")")
                else
                  ATeamDetailTable[idx]._btn_detail:addInputEvent("Mouse_LUp", "PaGlobalFunc_Solrare_OtherInfo_OpenByRecord(" .. tostring(recordIndex) .. ")")
                end
                PaGlobalFunc_Util_SetSolrareIngameClassBg(ATeamDetailTable[idx]._classBg, classTypeRaw)
                ATeamDetailTable[idx]._classBg:SetShow(true)
                if nil ~= PaGlobalFunc_Solrare_Ranking_SetTierIconByScore and mode ~= __eSolareMode_Normal_1vs1 and mode ~= __eSolareMode_Normal_3vs3 and mode ~= __eSolareMode_Custom then
                  PaGlobalFunc_Solrare_Ranking_SetTierIconByScore(ATeamDetailTable[idx]._stc_tier, rankRating)
                  ATeamDetailTable[idx]._stc_tier:SetShow(true)
                else
                  ATeamDetailTable[idx]._stc_tier:SetShow(false)
                end
                PaGlobalFunc_Solrare_Ranking_SetSkillBranchType(ATeamDetailTable[idx], skillBranchType, classTypeRaw)
              elseif 1 == recentRecordList._selfPlayerTeamNumber and nil ~= BTeamDetailTable[idx] then
                BTeamDetailTable[idx]._bg:SetShow(true)
                BTeamDetailTable[idx]._txt_name:SetText(name)
                BTeamDetailTable[idx]._txt_KDA:SetText(kill .. " / " .. death)
                BTeamDetailTable[idx]._txt_heal:SetText(recovery)
                BTeamDetailTable[idx]._txt_harm:SetText(harm)
                BTeamDetailTable[idx]._txt_dmg:SetText(attack)
                BTeamDetailTable[idx]._stc_MVP:SetShow(isMVP)
                BTeamDetailTable[idx]._stc_Ace:SetShow(isAce)
                BTeamDetailTable[idx]._stc_CCCount:SetText(ccCount)
                if _ContentsGroup_UsePadSnapping == true then
                  BTeamDetailTable[idx]._bg:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_Solrare_OtherInfo_OpenByRecord(" .. tostring(recordIndex) .. ")")
                else
                  BTeamDetailTable[idx]._btn_detail:addInputEvent("Mouse_LUp", "PaGlobalFunc_Solrare_OtherInfo_OpenByRecord(" .. tostring(recordIndex) .. ")")
                end
                PaGlobalFunc_Util_SetSolrareIngameClassBg(BTeamDetailTable[idx]._classBg, classTypeRaw)
                BTeamDetailTable[idx]._classBg:SetShow(true)
                if nil ~= PaGlobalFunc_Solrare_Ranking_SetTierIconByScore and mode ~= __eSolareMode_Normal_1vs1 and mode ~= __eSolareMode_Normal_3vs3 and mode ~= __eSolareMode_Custom then
                  PaGlobalFunc_Solrare_Ranking_SetTierIconByScore(BTeamDetailTable[idx]._stc_tier, rankRating)
                  BTeamDetailTable[idx]._stc_tier:SetShow(true)
                else
                  BTeamDetailTable[idx]._stc_tier:SetShow(false)
                end
                PaGlobalFunc_Solrare_Ranking_SetSkillBranchType(BTeamDetailTable[idx], skillBranchType, classTypeRaw)
              end
            end
          end
          for idx = 1, #recentRecordBTeam do
            if nil ~= recentRecordBTeam[idx] then
              local classTypeRaw = recentRecordBTeam[idx]._classType
              local rankRating = recentRecordBTeam[idx]._rankRating
              local name = recentRecordBTeam[idx]._name
              local attack = recentRecordBTeam[idx]._attackDamage
              local harm = recentRecordBTeam[idx]._harmDamage
              local recovery = recentRecordBTeam[idx]._healAmount
              local kill = recentRecordBTeam[idx]._killCount
              local death = recentRecordBTeam[idx]._deathCount
              local isMVP = recentRecordBTeam[idx]._isMVP
              local isAce = recentRecordBTeam[idx]._isAce
              local recordIndex = recentRecordBTeam[idx]._recordIndex
              local skillBranchType = recentRecordBTeam[idx]._skillBranchType
              local ccCount = recentRecordBTeam[idx]._CCCount
              if 0 == recentRecordList._selfPlayerTeamNumber and nil ~= BTeamDetailTable[idx] then
                BTeamDetailTable[idx]._bg:SetShow(true)
                BTeamDetailTable[idx]._txt_name:SetText(name)
                BTeamDetailTable[idx]._txt_KDA:SetText(kill .. " / " .. death)
                BTeamDetailTable[idx]._txt_heal:SetText(recovery)
                BTeamDetailTable[idx]._txt_harm:SetText(harm)
                BTeamDetailTable[idx]._txt_dmg:SetText(attack)
                BTeamDetailTable[idx]._stc_MVP:SetShow(isMVP)
                BTeamDetailTable[idx]._stc_Ace:SetShow(isAce)
                BTeamDetailTable[idx]._stc_CCCount:SetText(ccCount)
                if _ContentsGroup_UsePadSnapping == true then
                  BTeamDetailTable[idx]._bg:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_Solrare_OtherInfo_OpenByRecord(" .. tostring(recordIndex) .. ")")
                else
                  BTeamDetailTable[idx]._btn_detail:addInputEvent("Mouse_LUp", "PaGlobalFunc_Solrare_OtherInfo_OpenByRecord(" .. tostring(recordIndex) .. ")")
                end
                PaGlobalFunc_Util_SetSolrareIngameClassBg(BTeamDetailTable[idx]._classBg, classTypeRaw)
                BTeamDetailTable[idx]._classBg:SetShow(true)
                if nil ~= PaGlobalFunc_Solrare_Ranking_SetTierIconByScore and mode ~= __eSolareMode_Normal_1vs1 and mode ~= __eSolareMode_Normal_3vs3 and mode ~= __eSolareMode_Custom then
                  PaGlobalFunc_Solrare_Ranking_SetTierIconByScore(BTeamDetailTable[idx]._stc_tier, rankRating)
                  BTeamDetailTable[idx]._stc_tier:SetShow(true)
                else
                  BTeamDetailTable[idx]._stc_tier:SetShow(false)
                end
                PaGlobalFunc_Solrare_Ranking_SetSkillBranchType(BTeamDetailTable[idx], skillBranchType, classTypeRaw)
              elseif 1 == recentRecordList._selfPlayerTeamNumber and nil ~= ATeamDetailTable[idx] then
                ATeamDetailTable[idx]._bg:SetShow(true)
                ATeamDetailTable[idx]._txt_name:SetText(name)
                ATeamDetailTable[idx]._txt_KDA:SetText(kill .. " / " .. death)
                ATeamDetailTable[idx]._txt_heal:SetText(recovery)
                ATeamDetailTable[idx]._txt_harm:SetText(harm)
                ATeamDetailTable[idx]._txt_dmg:SetText(attack)
                ATeamDetailTable[idx]._stc_MVP:SetShow(isMVP)
                ATeamDetailTable[idx]._stc_Ace:SetShow(isAce)
                ATeamDetailTable[idx]._stc_CCCount:SetText(ccCount)
                if _ContentsGroup_UsePadSnapping == true then
                  ATeamDetailTable[idx]._bg:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_Solrare_OtherInfo_OpenByRecord(" .. tostring(recordIndex) .. ")")
                else
                  ATeamDetailTable[idx]._btn_detail:addInputEvent("Mouse_LUp", "PaGlobalFunc_Solrare_OtherInfo_OpenByRecord(" .. tostring(recordIndex) .. ")")
                end
                PaGlobalFunc_Util_SetSolrareIngameClassBg(ATeamDetailTable[idx]._classBg, classTypeRaw)
                ATeamDetailTable[idx]._classBg:SetShow(true)
                if nil ~= PaGlobalFunc_Solrare_Ranking_SetTierIconByScore and mode ~= __eSolareMode_Normal_1vs1 and mode ~= __eSolareMode_Normal_3vs3 and mode ~= __eSolareMode_Custom then
                  PaGlobalFunc_Solrare_Ranking_SetTierIconByScore(ATeamDetailTable[idx]._stc_tier, rankRating)
                  ATeamDetailTable[idx]._stc_tier:SetShow(true)
                else
                  ATeamDetailTable[idx]._stc_tier:SetShow(false)
                end
                PaGlobalFunc_Solrare_Ranking_SetSkillBranchType(ATeamDetailTable[idx], skillBranchType, classTypeRaw)
              end
            end
          end
        end
      end
    end
  end
end
function PaGlobal_Solrare_Matching:prepareOpen()
  if Panel_Window_Solrare_Matching == nil then
    return
  end
  if _ContentsGroup_Solare == false then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local isInstancePlayer = selfPlayer:isInstancePlayer()
  self._ui._btn_RankGameReq:SetIgnore(isInstancePlayer)
  self._ui._btn_RankGameReq:SetMonoTone(isInstancePlayer, isInstancePlayer)
  self._ui._btn_NormalGameReq:SetIgnore(isInstancePlayer)
  self._ui._btn_NormalGameReq:SetMonoTone(isInstancePlayer, isInstancePlayer)
  self._selectedRecentRecordIndex = -1
  self._matchingTime = 100
  if _ContentsGroup_UsePadSnapping == true then
    self._ui._btn_Close:SetShow(false)
    self._ui._btn_Wiki:SetShow(false)
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._ui._keypadTable, self._ui._keypadBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  else
    self._ui._btn_Close:SetShow(true)
    self._ui._btn_Wiki:SetShow(true)
  end
  if PaGlobal_GetSpecialPassKey ~= nil and PaGlobal_GetSpecialPassKey(__eSpecialPassContentType_Solare) ~= 0 then
    self._ui._btn_SolarePass:SetShow(true)
  else
    self._ui._btn_SolarePass:SetShow(false)
  end
  local panSize = self._ui._btn_Rules:GetSizeX() + 5
  local currentPanSize = 130
  for index = 1, #self._middleButtonList do
    if self._middleButtonList[index] ~= nil and self._middleButtonList[index]:GetShow() == true then
      self._middleButtonList[index]:SetSpanSize(currentPanSize, self._middleButtonList[index]:GetSpanSize().y)
      currentPanSize = currentPanSize + panSize
    end
  end
  self:refreshSelectModeButton()
  self:update()
  self:reAlignFrameControl()
  Panel_Window_Solrare_Matching:ComputePos()
  self:open()
end
function PaGlobal_Solrare_Matching:open()
  if Panel_Window_Solrare_Matching == nil then
    return
  end
  Panel_Window_Solrare_Matching:RegisterUpdateFunc("FromClient_Solrare_Matching_UpdatePerFrame")
  Panel_Window_Solrare_Matching:SetShow(true)
end
function PaGlobal_Solrare_Matching:prepareClose()
  if Panel_Window_Solrare_Matching == nil then
    return
  end
  if _ContentsGroup_UsePadSnapping == true then
    if Panel_Popup_Solare_BuyEquipment_All:GetShow() == true then
      return
    end
    if Panel_Solrare_EquipPresetList:GetShow() == true then
      return
    end
  end
  self._ui._stc_TierListBg:SetShow(false)
  allClearMessageData()
  self:close()
end
function PaGlobal_Solrare_Matching:close()
  if Panel_Window_Solrare_Matching == nil then
    return
  end
  Panel_Window_Solrare_Matching:ClearUpdateLuaFunc()
  Panel_Window_Solrare_Matching:SetShow(false)
end
function PaGlobal_Solrare_Matching:switchMatchingBtn(isMatching)
  if Panel_Window_Solrare_Matching == nil then
    return
  end
  if isMatching == true then
    local curMatchMode = ToClient_GetMatchMode()
    if curMatchMode == __eMatchMode_Normal then
      self._ui._btn_RankGameReq:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SOLARE_FIND_MATCH_BTN_RANK_CANCEL"))
      self._ui._btn_RankGameReq:addInputEvent("Mouse_LUp", "PaGlobalFunc_Solrare_MatchingState_PrepareClose()")
      self._ui._btn_NormalGameReq:addInputEvent("Mouse_LUp", "")
    elseif curMatchMode == __eMatchMode_Party then
      self._ui._btn_NormalGameReq:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SOLARE_FIND_MATCH_BTN_RANK_CANCEL"))
      self._ui._btn_NormalGameReq:addInputEvent("Mouse_LUp", "PaGlobalFunc_Solrare_MatchingState_PrepareClose()")
      self._ui._btn_RankGameReq:addInputEvent("Mouse_LUp", "")
    end
  else
    self._ui._btn_RankGameReq:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SOLARE_FIND_MATCH_BTN_RANK"))
    self._ui._btn_RankGameReq:addInputEvent("Mouse_LUp", "HandleEventLUp_Solrare_JoinRankMatching()")
    self._ui._btn_NormalGameReq:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SOLARE_FIND_MATCH_BTN_NORMAL"))
    self._ui._btn_NormalGameReq:addInputEvent("Mouse_LUp", "HandleEventLUp_Solrare_NormalMatching()")
  end
end
function PaGlobal_Solrare_Matching:checkPlacementBgOpen()
  if Panel_Window_Solrare_Matching == nil then
    return
  end
  self._ui._placementBg:SetShow(false)
  local gameMode = self:getCurrentGameMode()
  local info = ToClient_GetSolareSelfPlayerInfo(gameMode)
  if info == nil then
    return
  end
  local playCount = info:getPlayCount()
  if gameMode == __ePVPArenaMode_SOLARE1vs1 then
    if playCount >= self._placementMatchMaxCount_1vs1 then
      return
    end
  elseif gameMode == __ePVPArenaMode_SOLARE3vs3 then
    if playCount >= self._placementMatchMaxCount_3vs3 then
      return
    end
  else
    return
  end
  if ToClient_GetMatchMode() ~= __eMatchMode_Normal then
    return
  end
  self._ui._placementBg:SetShow(true)
  local rankMatchCount = ToClient_GetSolarePlacementMatchRecordCount(gameMode)
  local rankInfoDataTable = Array.new()
  local selfPlayer = getSelfPlayer()
  local selfUserNo = selfPlayer:get():getUserNo()
  for idx = 0, rankMatchCount do
    local rankMatchData = ToClient_GetSolarePlacementMatchInfoIndex(gameMode, idx)
    if rankMatchData ~= nil then
      local recordUserNo64 = rankMatchData:getUserNo64()
      if recordUserNo64 == selfUserNo then
        rankInfoDataTable:push_back(rankMatchData:getResult())
      end
    end
  end
  for idx = 1, #self._ui._placementRecordIcon do
    self._ui._placementRecordIcon[idx]._stc_Win:SetShow(false)
    self._ui._placementRecordIcon[idx]._stc_Lose:SetShow(false)
    self._ui._placementRecordIcon[idx]._stc_Draw:SetShow(false)
    self._ui._placementRecordIcon[idx]._stc_None:SetShow(true)
  end
  for idx = 1, #rankInfoDataTable do
    if self._ui._placementRecordIcon[idx] ~= nil then
      self._ui._placementRecordIcon[idx]._stc_None:SetShow(false)
      if rankInfoDataTable[idx] == __eSolareRoundResult_Win then
        self._ui._placementRecordIcon[idx]._stc_Win:SetShow(true)
      elseif rankInfoDataTable[idx] == __eSolareRoundResult_Lose then
        self._ui._placementRecordIcon[idx]._stc_Lose:SetShow(true)
      elseif rankInfoDataTable[idx] == __eSolareRoundResult_Draw then
        self._ui._placementRecordIcon[idx]._stc_Draw:SetShow(true)
      end
    end
  end
end
function PaGlobal_Solrare_Matching:toggleSelectModeButton()
  if Panel_Window_Solrare_Matching == nil then
    return __ePVPArenaMode_Count
  end
  if self._currentSelectMode == __ePVPArenaMode_SOLARE3vs3 then
    self._currentSelectMode = __ePVPArenaMode_SOLARE1vs1
  else
    self._currentSelectMode = __ePVPArenaMode_SOLARE3vs3
  end
  self:refreshSelectModeButton()
end
function PaGlobal_Solrare_Matching:refreshSelectModeButton()
  if Panel_Window_Solrare_Matching == nil then
    return __ePVPArenaMode_Count
  end
  if self._currentSelectMode == __ePVPArenaMode_SOLARE3vs3 then
    self._ui._btn_changeMode:SetHorizonRight()
  else
    self._ui._btn_changeMode:SetHorizonLeft()
  end
  self._ui._btn_changeMode:ComputePos()
end
function PaGlobal_Solrare_Matching:getCurrentGameMode()
  if Panel_Window_Solrare_Matching == nil then
    return __ePVPArenaMode_Count
  end
  if ToClient_IsDevelopment() == true then
    return self._currentSelectMode
  else
    return __ePVPArenaMode_SOLARE3vs3
  end
end
function PaGlobal_Solrare_Matching:updateChampionShipButton()
  local copyTime_s64 = ToClient_GetUserCopyTime()
  local copyTime = Int64toInt32(copyTime_s64)
  if copyTime == 0 then
    self._ui._btn_CopyUserInformation:SetText("<PAColor0xFFD05D48>" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SOLARE_CHARACTER_COPY_BTN") .. "<PAOldColor>")
    self._ui._btn_CopyUserInformation:addInputEvent("Mouse_On", "")
    self._ui._btn_CopyUserInformation:addInputEvent("Mouse_Out", "")
  else
    self._ui._btn_CopyUserInformation:SetText("<PAColor0xFFF5BA3A>" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SOLARE_CHARACTER_COPY_BTN") .. "<PAOldColor>")
    self._ui._btn_CopyUserInformation:addInputEvent("Mouse_On", "HandleEventOnOut_Solare_CopyUserTime(true)")
    self._ui._btn_CopyUserInformation:addInputEvent("Mouse_Out", "HandleEventOnOut_Solare_CopyUserTime(false)")
  end
end
