PaGlobal_Solrare_MatchNotice = {
  _ui = {
    _blackBg = nil,
    _txt_Round = nil,
    _stc_Versus = nil,
    _stc_ScoreBg = nil,
    _stc_TeamControl = Array.new(),
    _stc_MyTeamResultControl = nil,
    _stc_RoundResult_Win = nil,
    _stc_RoundResult_Tie = nil,
    _stc_RoundResult_Lose = nil,
    _stc_FinalResult_Win = nil,
    _stc_FinalResult_Tie = nil,
    _stc_FinalResult_Lose = nil,
    _stc_RewardBg = nil,
    _stc_rewardFrameBg = nil,
    _stc_rewardItemSlotBg = nil,
    _stc_rewardItemSlot = nil,
    _txt_rewardItemName = nil,
    _txt_TierDesc = nil,
    _stc_TierIcon = nil,
    _stc_Effect = nil,
    _btn_Confirm = nil,
    _placementBg = nil,
    _placementRecordIcon = Array.new()
  },
  _rewardItemSlotConfing = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCash = true,
    createClassEquipBG = true
  },
  _placementMatchMaxCount_1vs1 = ToClient_GetSolarePlaceMentMatchCount(__ePVPArenaMode_SOLARE1vs1),
  _placementMatchMaxCount_3vs3 = ToClient_GetSolarePlaceMentMatchCount(__ePVPArenaMode_SOLARE3vs3),
  _currentTime = 0,
  _showTime = 5,
  _maxPlayerCountByTeam = 3,
  _maxWinScore = 3,
  _maxTeamCount = 2,
  _renderMode = nil,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClie_Solrare_MatchNotice_Init")
function FromClie_Solrare_MatchNotice_Init()
  PaGlobal_Solrare_MatchNotice:initialize()
end
function PaGlobal_Solrare_MatchNotice:initialize()
  if true == PaGlobal_Solrare_MatchNotice._initialize or nil == Panel_Window_Solrare_RoundNotice then
    return
  end
  self._ui._blackBg = UI.getChildControl(Panel_Window_Solrare_RoundNotice, "Static_BlackBG")
  self._ui._txt_Round = UI.getChildControl(Panel_Window_Solrare_RoundNotice, "MultilineText_Round")
  self._ui._stc_Versus = UI.getChildControl(Panel_Window_Solrare_RoundNotice, "Static_Vs")
  local stc_RoundResultBg = UI.getChildControl(Panel_Window_Solrare_RoundNotice, "Static_Result_Middle")
  self._ui._stc_RoundResult_Win = UI.getChildControl(stc_RoundResultBg, "Static_Win")
  self._ui._stc_RoundResult_Tie = UI.getChildControl(stc_RoundResultBg, "Static_Tie")
  self._ui._stc_RoundResult_Lose = UI.getChildControl(stc_RoundResultBg, "Static_Lose")
  self._ui._stc_FinalResult_Win = UI.getChildControl(Panel_Window_Solrare_RoundNotice, "Static_Win_Final")
  self._ui._stc_FinalResult_Tie = UI.getChildControl(Panel_Window_Solrare_RoundNotice, "Static_Tie_Final")
  self._ui._stc_FinalResult_Lose = UI.getChildControl(Panel_Window_Solrare_RoundNotice, "Static_Lose_Final")
  self._ui._stc_ScoreBg = UI.getChildControl(Panel_Window_Solrare_RoundNotice, "Static_Score_BG")
  self._ui._stc_ScoreBg:SetShow(false)
  self._ui._stc_RewardBg = UI.getChildControl(Panel_Window_Solrare_RoundNotice, "Static_Reward_BG")
  self._ui._stc_RewardBg:SetShow(false)
  self._ui._stc_rewardFrameBg = UI.getChildControl(self._ui._stc_RewardBg, "Static_Reward_FrameBG")
  self._ui._stc_rewardItemSlotBg = UI.getChildControl(self._ui._stc_RewardBg, "Static_RewardItemSlotBG")
  self._ui._stc_rewardItemSlot = UI.getChildControl(self._ui._stc_RewardBg, "Static_RewardItemSlot")
  self._ui._txt_rewardItemName = UI.getChildControl(self._ui._stc_RewardBg, "StaticText_RewardItemName")
  local panelY = Panel_Window_Solrare_RoundNotice:GetPosY()
  if _ContentsGroup_SolareCeremony == false then
    self._ui._stc_FinalResult_Win:SetSize(605, 480)
    self._ui._stc_FinalResult_Tie:SetSize(605, 480)
    self._ui._stc_FinalResult_Lose:SetSize(605, 480)
    self._ui._stc_FinalResult_Win:SetSpanSize(260, -50)
    self._ui._stc_FinalResult_Tie:SetSpanSize(260, -50)
    self._ui._stc_FinalResult_Lose:SetSpanSize(260, -50)
    self._ui._stc_RewardBg:SetSize(650, 150)
    self._ui._stc_RewardBg:SetSpanSize(0, 495)
    self._ui._stc_rewardItemSlotBg:SetSpanSize(315, -19)
    self._ui._stc_rewardItemSlot:SetSpanSize(320, -20)
    self._ui._txt_rewardItemName:SetSpanSize(320 - self._ui._txt_rewardItemName:GetTextSizeX() / 2, 30)
  else
    self._ui._stc_FinalResult_Win:SetSpanSize(self._ui._stc_FinalResult_Win:GetSpanSize().x, self._ui._stc_FinalResult_Win:GetSpanSize().y - panelY)
    self._ui._stc_FinalResult_Tie:SetSpanSize(self._ui._stc_FinalResult_Tie:GetSpanSize().x, self._ui._stc_FinalResult_Tie:GetSpanSize().y - panelY)
    self._ui._stc_FinalResult_Lose:SetSpanSize(self._ui._stc_FinalResult_Lose:GetSpanSize().x, self._ui._stc_FinalResult_Lose:GetSpanSize().y - panelY)
    self._ui._stc_RewardBg:SetSpanSize(self._ui._stc_RewardBg:GetSpanSize().x, self._ui._stc_RewardBg:GetSpanSize().y - panelY)
  end
  local mainSlot = {}
  SlotItem.new(mainSlot, "SolareRewardItemSlot", 0, self._ui._stc_rewardItemSlot, self._rewardItemSlotConfing)
  mainSlot:createChild()
  for idx = 1, self._maxTeamCount do
    local tempTable = {
      _bg = nil,
      _memberControl = Array.new(),
      _stc_Win = nil,
      _stc_Lose = nil,
      _stc_WinCount = Array.new(),
      _memberUserNoList = Array.new()
    }
    local parentBg, resultBg
    local scoreBg = UI.getChildControl(Panel_Window_Solrare_RoundNotice, "Static_Score_BG")
    if idx == 1 then
      parentBg = UI.getChildControl(Panel_Window_Solrare_RoundNotice, "Static_Left_MyTeam")
      tempTable._stc_Win = UI.getChildControl(scoreBg, "Static_My_Win")
      tempTable._stc_Lose = UI.getChildControl(scoreBg, "Static_My_Lose")
      if _ContentsGroup_SolareCeremony == true then
        resultBg = UI.getChildControl(Panel_Window_Solrare_RoundNotice, "Static_Result_MyTeam")
        resultBg:SetShow(false)
      end
    elseif idx == 2 then
      parentBg = UI.getChildControl(Panel_Window_Solrare_RoundNotice, "Static_Right_EnemyTeam")
      tempTable._stc_Win = UI.getChildControl(scoreBg, "Static_Enemy_Win")
      tempTable._stc_Lose = UI.getChildControl(scoreBg, "Static_Enemy_Lose")
    end
    tempTable._bg = parentBg
    for ii = 1, self._maxPlayerCountByTeam do
      local subTable = {
        _sub_Bg = nil,
        _txt_NameTier = nil,
        _stc_Tier = nil,
        _stc_PreSeasonTier = nil,
        _txt_ClassName = nil,
        _stc_Class = nil,
        _userNo = nil,
        _stc_MVP = nil,
        _stc_Ace = nil
      }
      subTable._sub_Bg = UI.getChildControl(parentBg, "Static_Member_" .. tostring(ii))
      subTable._sub_Bg:SetShow(false)
      subTable._txt_NameTier = UI.getChildControl(subTable._sub_Bg, "StaticText_Tier_Name")
      subTable._stc_Tier = UI.getChildControl(subTable._sub_Bg, "StaticText_TierIcon")
      subTable._stc_PreSeasonTier = UI.getChildControl(subTable._sub_Bg, "Static_Border")
      subTable._txt_ClassName = UI.getChildControl(subTable._sub_Bg, "StaticText_Class")
      subTable._stc_Class = UI.getChildControl(subTable._sub_Bg, "Static_Image")
      subTable._stc_Ace = UI.getChildControl(subTable._sub_Bg, "Static_Ace")
      subTable._stc_MVP = UI.getChildControl(subTable._sub_Bg, "Static_MVP")
      tempTable._memberControl:push_back(subTable)
    end
    for jj = 1, self._maxWinScore do
      local winCountBg
      if idx == 1 then
        winCountBg = UI.getChildControl(scoreBg, "Static_My_Present_Score")
      elseif idx == 2 then
        winCountBg = UI.getChildControl(scoreBg, "Static_Enemy_Present_Score")
      end
      local scoreBg = UI.getChildControl(winCountBg, "Static_Bg_" .. tostring(jj))
      local score = UI.getChildControl(scoreBg, "Static_On")
      tempTable._stc_WinCount:push_back(score)
    end
    self._ui._stc_TeamControl:push_back(tempTable)
    if _ContentsGroup_SolareCeremony == true and idx == 1 then
      local resultTable = {
        _bg = nil,
        _memberControl = Array.new(),
        _memberUserNoList = Array.new()
      }
      resultTable._bg = resultBg
      resultBg:SetSpanSize(resultBg:GetSpanSize().x, resultBg:GetSpanSize().y - panelY)
      for ii = 1, self._maxPlayerCountByTeam do
        local resultSubTable = {
          _sub_Bg = nil,
          _txt_NameTier = nil,
          _stc_Tier = nil,
          _stc_PreSeasonTier = nil,
          _txt_ClassName = nil,
          _stc_Class = nil,
          _userNo = nil,
          _stc_MVP = nil,
          _stc_Ace = nil
        }
        resultSubTable._sub_Bg = UI.getChildControl(resultBg, "Static_Member_" .. tostring(ii))
        resultSubTable._sub_Bg:SetShow(false)
        resultSubTable._txt_NameTier = UI.getChildControl(resultSubTable._sub_Bg, "StaticText_Tier_Name")
        resultSubTable._stc_Tier = UI.getChildControl(resultSubTable._sub_Bg, "StaticText_TierIcon")
        resultSubTable._stc_PreSeasonTier = UI.getChildControl(resultSubTable._sub_Bg, "Static_Border")
        resultSubTable._txt_ClassName = UI.getChildControl(resultSubTable._sub_Bg, "StaticText_Class")
        resultSubTable._stc_Class = UI.getChildControl(resultSubTable._sub_Bg, "Static_Image")
        resultSubTable._stc_Ace = UI.getChildControl(resultSubTable._sub_Bg, "Static_Ace")
        resultSubTable._stc_MVP = UI.getChildControl(resultSubTable._sub_Bg, "Static_MVP")
        resultTable._memberControl:push_back(resultSubTable)
      end
      self._ui._stc_MyTeamResultControl = resultTable
    end
  end
  Panel_Widget_Solare_TierUpgrade:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_Widget_Solare_TierUpgrade:ComputePosAllChild()
  local bg = UI.getChildControl(Panel_Widget_Solare_TierUpgrade, "Static_Desc_BG")
  self._ui._txt_TierDesc = UI.getChildControl(bg, "StaticText_Desc")
  self._ui._stc_TierIcon = UI.getChildControl(bg, "Static_TierIcon")
  self._ui._stc_Effect = UI.getChildControl(bg, "Static_Effect")
  self._ui._btn_Confirm = UI.getChildControl(Panel_Widget_Solare_TierUpgrade, "Button_Confirm")
  self._ui._console_KeyGuide = UI.getChildControl(self._ui._btn_Confirm, "StaticText_Confirm_A")
  self._ui._console_KeyGuide:SetShow(false)
  local desc = UI.getChildControl(bg, "MultilineText_Desc")
  desc:SetTextMode(__eTextMode_AutoWrap)
  desc:SetText(desc:GetText())
  if ToClient_isConsole() == true then
    self._ui._console_KeyGuide:SetShow(true)
  end
  local currentGameMode = ToClient_GetSolareGameMode()
  local info = ToClient_GetSolareSelfPlayerInfo(currentGameMode)
  if nil ~= info then
    local myRankRating = info:getRankRating()
    PaGlobalFunc_Solrare_Ranking_SetTierIconByScore(self._ui._stc_TierIcon, myRankRating)
  end
  self._ui._placementBg = UI.getChildControl(bg, "Static_ResultArea")
  local bgTemp = UI.getChildControl(self._ui._placementBg, "Static_Game1")
  local count = 0
  local gap = 29
  local lastPosX = 0
  local maxPlacementCount = math.max(self._placementMatchMaxCount_1vs1, self._placementMatchMaxCount_3vs3)
  for idx = 1, maxPlacementCount do
    local table = {}
    local bg = UI.cloneControl(bgTemp, self._ui._placementBg, "stc_resultBgSolare" .. tostring(idx))
    table._stc_Win = UI.getChildControl(bg, "Static_Win")
    table._stc_Lose = UI.getChildControl(bg, "Static_Lose")
    table._stc_Draw = UI.getChildControl(bg, "Static_Draw")
    local spanX = count * gap
    bg:SetSpanSize(spanX, bg:GetSpanSize().y)
    bg:ComputePos()
    self._ui._placementRecordIcon:push_back(table)
    count = count + 1
    lastPosX = bg:GetPosX()
  end
  self._ui._placementBg:SetSize(lastPosX + bgTemp:GetSizeX(), self._ui._placementBg:GetSizeY())
  self._ui._placementBg:ComputePos()
  self._renderMode = RenderModeWrapper.new(100, {
    Defines.RenderMode.eRenderMode_InstanceContentsCeremony
  }, false)
  self._renderMode:setClosefunctor(nil, PaGloabalFunc_SolareCeremony_CloseRenderMode)
  PaGlobal_Solrare_MatchNotice:registEventHandler()
  PaGlobal_Solrare_MatchNotice._initialize = true
end
function PaGlobal_Solrare_MatchNotice:registEventHandler()
  if nil == Panel_Window_Solrare_RoundNotice then
    return
  end
  self._ui._btn_Confirm:addInputEvent("Mouse_LUp", "PaGlobal_Solrare_MatchNotice:closeTierUp()")
  registerEvent("FromClient_SolareRoundResultAck", "FromClient_SolareMatchNotice_UpdateNoticeByResult")
  registerEvent("FromClient_SolareInGameInfoAck", "FromClient_SolareMatchNotice_IntialControlSetting")
  registerEvent("FromClient_SolareVaryRankRating", "FromClient_SolareVaryRankRating")
end
function PaGlobal_Solrare_MatchNotice:prepareOpen()
  if nil == Panel_Window_Solrare_RoundNotice then
    return
  end
  Panel_Widget_Solare_TierUpgrade:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_Widget_Solare_TierUpgrade:ComputePosAllChild()
  PaGlobal_Solrare_MatchNotice._currentTime = 0
  self._ui._blackBg:SetSize(getScreenSizeX(), getScreenSizeY())
  self._ui._blackBg:ComputePos()
  Panel_Window_Solrare_RoundNotice:ComputePos()
  PaGlobal_Solrare_MatchNotice:open()
  PaGlobal_Solrare_MatchNotice:update()
  Panel_Window_Solrare_RoundNotice:RegisterUpdateFunc("FromClient_SolrareMatchNotice_UpdatePerFrame")
end
function PaGlobal_Solrare_MatchNotice:update()
end
function PaGlobal_Solrare_MatchNotice:open()
  if nil == Panel_Window_Solrare_RoundNotice then
    return
  end
  Panel_Window_Solrare_RoundNotice:SetShow(true)
end
function PaGlobal_Solrare_MatchNotice:prepareClose()
  if nil == Panel_Window_Solrare_RoundNotice then
    return
  end
  Panel_Window_Solrare_RoundNotice:setConvetableInputMode(CppEnums.EProcessorInputMode.eProcessorInputMode_GameMode)
  PaGlobal_Solrare_MatchNotice._currentTime = 0
  Panel_Window_Solrare_RoundNotice:ClearUpdateLuaFunc()
  Panel_Widget_Solare_TierUpgrade:EraseAllEffect()
  PaGlobal_Solrare_MatchNotice:close()
end
function PaGlobal_Solrare_MatchNotice:close()
  if nil == Panel_Window_Solrare_RoundNotice then
    return
  end
  Panel_Window_Solrare_RoundNotice:SetShow(false)
end
function PaGlobal_Solrare_MatchNotice:playerSetting(solareMatchMode)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local totalInfoCount = ToClient_GetSolareInGameInfoCount()
  local totalPlayerCount = self._maxPlayerCountByTeam * self._maxTeamCount
  if totalInfoCount > totalPlayerCount then
    return
  end
  for idx = 1, self._maxTeamCount do
    if nil ~= self._ui._stc_TeamControl[idx] then
      local teamControlTable = self._ui._stc_TeamControl[idx]
      local memberControlList = teamControlTable._memberControl
      teamControlTable._memberUserNoList = Array.new()
      for ii = 1, self._maxPlayerCountByTeam do
        memberControlList[ii]._sub_Bg:SetShow(false)
      end
    end
  end
  local selfUserNo = selfPlayer:get():getUserNo()
  for idx = 0, totalInfoCount - 1 do
    local userInfo = ToClient_GetSolareInGameInfoByIndex(idx)
    if nil ~= userInfo then
      local teamNo = userInfo:getTeamNo()
      local userNo = userInfo:getUserNo()
      local name = userInfo:getName()
      local rankRating = userInfo:getRankRating()
      local preRankRating = userInfo:getPreSeasonRankRating()
      local classTypeRaw = userInfo:getClassTypeRaw()
      local className = getCharacterClassName(classTypeRaw)
      local isLogin = userInfo:isLogin()
      local controlIndex = teamNo + 1
      if nil ~= self._ui._stc_TeamControl[controlIndex] then
        local teamControlTable = self._ui._stc_TeamControl[controlIndex]
        local memberControlList = teamControlTable._memberControl
        teamControlTable._memberUserNoList:push_back(userNo)
        local memberUserInfoCount = #teamControlTable._memberUserNoList
        local teamControlIndex = memberUserInfoCount
        if nil ~= memberControlList[teamControlIndex] then
          memberControlList[teamControlIndex]._userNo = userNo
          memberControlList[teamControlIndex]._txt_NameTier:SetText(name)
          memberControlList[teamControlIndex]._txt_ClassName:SetText(className)
          memberControlList[teamControlIndex]._sub_Bg:SetShow(true)
          memberControlList[teamControlIndex]._sub_Bg:SetMonoTone(not isLogin, not isLogin)
          memberControlList[teamControlIndex]._txt_NameTier:SetFontColor(Defines.Color.C_FFDDC39E)
          memberControlList[teamControlIndex]._sub_Bg:ChangeTextureInfoNameAsync("combine/etc/combine_etc_solare_war_02.dds")
          local x1, y1, x2, y2 = setTextureUV_Func(memberControlList[teamControlIndex]._sub_Bg, 671, 564, 1179, 651)
          memberControlList[teamControlIndex]._sub_Bg:getBaseTexture():setUV(x1, y1, x2, y2)
          memberControlList[teamControlIndex]._sub_Bg:setRenderTexture(memberControlList[teamControlIndex]._sub_Bg:getBaseTexture())
          if Int64toInt32(selfUserNo) == userNo then
            memberControlList[teamControlIndex]._txt_NameTier:SetFontColor(Defines.Color.C_FFF5BA3A)
            memberControlList[teamControlIndex]._sub_Bg:ChangeTextureInfoNameAsync("combine/etc/combine_etc_solare_war_02.dds")
            local x1, y1, x2, y2 = setTextureUV_Func(memberControlList[teamControlIndex]._sub_Bg, 671, 476, 1179, 563)
            memberControlList[teamControlIndex]._sub_Bg:getBaseTexture():setUV(x1, y1, x2, y2)
            memberControlList[teamControlIndex]._sub_Bg:setRenderTexture(memberControlList[teamControlIndex]._sub_Bg:getBaseTexture())
          end
          if solareMatchMode ~= __eSolareMode_Normal_1vs1 and solareMatchMode ~= __eSolareMode_Normal_3vs3 and solareMatchMode ~= __eSolareMode_Custom then
            PaGlobalFunc_Solrare_Ranking_SetTierIconByScore(memberControlList[teamControlIndex]._stc_Tier, rankRating)
          else
            memberControlList[teamControlIndex]._stc_Tier:SetShow(false)
          end
          if preRankRating > 0 then
            PaGlobalFunc_Solrare_Ranking_SetTierFrameByPreSeasonScore(memberControlList[teamControlIndex]._stc_PreSeasonTier, preRankRating, teamNo, false)
            memberControlList[teamControlIndex]._stc_PreSeasonTier:SetShow(true)
          else
            memberControlList[teamControlIndex]._stc_PreSeasonTier:SetShow(false)
          end
          if PaGlobalFunc_Util_SetSolrareIngameClassBg ~= nil then
            PaGlobalFunc_Util_SetSolrareIngameClassBg(memberControlList[teamControlIndex]._stc_Class, classTypeRaw)
            if teamNo == __eSolareTeamNo_Blue then
              memberControlList[teamControlIndex]._stc_Class:setFlipHorizontalTexture(true)
              memberControlList[teamControlIndex]._sub_Bg:setFlipHorizontalTexture(true)
            end
          end
        end
      end
    end
  end
end
function PaGlobal_Solrare_MatchNotice:setRenderMode(isSet)
  if Panel_Window_Solrare_RoundNotice == nil then
    return
  end
  if isSet == true then
    self._renderMode:set()
  else
    self._renderMode:reset()
  end
end
function PaGlobal_Solrare_MatchNotice:updateTeamUI_Round(solareMatchMode, redMVPUserNo, blueMVPUserNo)
  local playState = ToClient_GetSolarePlayState()
  local roomState = ToClient_GetSolareRoomState()
  local currentRound = ToClient_GetSolareCurrentRound()
  local redTeamScore = ToClient_GetSolareWinScore(0)
  local blueTeamScore = ToClient_GetSolareWinScore(1)
  local myTeamNo = ToClient_GetSolareMyTeamType()
  self._ui._txt_Round:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_COMPETITION_ROUND", "round", currentRound))
  if __eInstanceSolareManagerState_Wait == roomState then
    self._ui._blackBg:SetShow(true)
  elseif __eInstanceSolareManagerState_Ready == roomState then
  elseif __eInstanceSolareManagerState_Play == roomState then
    if __eSolareRoundState_Ready == playState then
      PaGlobal_Solrare_MatchNotice:playerSetting(solareMatchMode)
      PaGlobal_Solrare_MatchNotice:prepareOpen()
      audioPostEvent_SystemUi(30, 11)
      _AudioPostEvent_SystemUiForXBOX(30, 11)
    end
  elseif __eInstanceSolareManagerState_Result == roomState then
    Panel_Window_Solrare_RoundNotice:EraseAllEffect()
    for idx = 1, self._maxTeamCount do
      if nil ~= self._ui._stc_TeamControl[idx] then
        self._ui._stc_TeamControl[idx]._bg:SetShow(false)
      end
    end
    if _ContentsGroup_SolareCeremony == true then
      self._ui._stc_MyTeamResultControl._bg:SetShow(false)
    end
    self._ui._stc_Versus:SetShow(false)
    self._ui._stc_RoundResult_Win:SetShow(false)
    self._ui._stc_RoundResult_Lose:SetShow(false)
    self._ui._stc_RoundResult_Tie:SetShow(false)
    self._showTime = 30
    local winnerTeamNo = -1
    local isRedTeamWin = false
    local isBlueTeamWin = false
    if redTeamScore == blueTeamScore then
    elseif redTeamScore < blueTeamScore then
      isBlueTeamWin = true
      winnerTeamNo = __eSolareTeamNo_Blue
    elseif redTeamScore > blueTeamScore then
      isRedTeamWin = true
      winnerTeamNo = __eSolareTeamNo_Red
    end
    ToClient_UpdateOpenUICondition(__eCheckOpenUIType_SolareResult)
    local totalInfoCount = ToClient_GetSolareInGameInfoCount()
    local totalPlayerCount = self._maxPlayerCountByTeam * self._maxTeamCount
    if totalInfoCount > totalPlayerCount then
      return
    end
    for idx = 1, self._maxTeamCount do
      if self._ui._stc_TeamControl[idx] ~= nil then
        local teamControlTable = self._ui._stc_TeamControl[idx]
        local memberControlList = teamControlTable._memberControl
        teamControlTable._memberUserNoList = Array.new()
        for ii = 1, self._maxPlayerCountByTeam do
          memberControlList[ii]._sub_Bg:SetShow(false)
        end
      end
    end
    local MVPUserNo = -1
    if myTeamNo == __eSolareTeamNo_Red then
      MVPUserNo = redMVPUserNo
    else
      MVPUserNo = blueMVPUserNo
    end
    local selfUserNo32 = Int64toInt32(getSelfPlayer():get():getUserNo())
    local isSelfMVP = false
    local resultControl
    if _ContentsGroup_SolareCeremony == true then
      if self._ui._stc_MyTeamResultControl ~= nil then
        local teamControlTable = self._ui._stc_MyTeamResultControl
        local memberControlList = teamControlTable._memberControl
        teamControlTable._memberUserNoList = Array.new()
        for ii = 1, self._maxPlayerCountByTeam do
          memberControlList[ii]._sub_Bg:SetShow(false)
        end
        resultControl = self._ui._stc_MyTeamResultControl
      end
    else
      resultControl = self._ui._stc_TeamControl[1]
    end
    if resultControl ~= nil then
      resultControl._memberUserNoList = Array.new()
      for idx = 0, totalInfoCount - 1 do
        local userInfo = ToClient_GetSolareInGameInfoByIndex(idx)
        if nil ~= userInfo then
          local teamNo = userInfo:getTeamNo()
          if myTeamNo == teamNo then
            local userNo = userInfo:getUserNo()
            local name = userInfo:getName()
            local rankRating = userInfo:getRankRating()
            local preRankRating = userInfo:getPreSeasonRankRating()
            local classTypeRaw = userInfo:getClassTypeRaw()
            local className = getCharacterClassName(classTypeRaw)
            local isLogin = userInfo:isLogin()
            local isMVP = userNo == MVPUserNo and winnerTeamNo == myTeamNo
            local isAce = userNo == MVPUserNo and winnerTeamNo ~= myTeamNo
            local memberControlList = resultControl._memberControl
            resultControl._memberUserNoList:push_back(userNo)
            local memberUserInfoCount = #resultControl._memberUserNoList
            local controlIndex = memberUserInfoCount
            if nil ~= memberControlList[controlIndex] then
              memberControlList[controlIndex]._userNo = userNo
              memberControlList[controlIndex]._txt_NameTier:SetText(name)
              memberControlList[controlIndex]._txt_ClassName:SetText(className)
              memberControlList[controlIndex]._sub_Bg:SetShow(true)
              memberControlList[controlIndex]._sub_Bg:SetMonoTone(not isLogin, not isLogin)
              memberControlList[controlIndex]._stc_Ace:SetShow(isAce)
              memberControlList[controlIndex]._stc_MVP:SetShow(isMVP)
              memberControlList[controlIndex]._txt_NameTier:SetFontColor(Defines.Color.C_FFDDC39E)
              memberControlList[controlIndex]._sub_Bg:ChangeTextureInfoNameAsync("combine/etc/combine_etc_solare_war_02.dds")
              local x1, y1, x2, y2 = setTextureUV_Func(memberControlList[controlIndex]._sub_Bg, 671, 564, 1179, 651)
              memberControlList[controlIndex]._sub_Bg:getBaseTexture():setUV(x1, y1, x2, y2)
              memberControlList[controlIndex]._sub_Bg:setRenderTexture(memberControlList[controlIndex]._sub_Bg:getBaseTexture())
              if selfUserNo32 == userNo then
                memberControlList[controlIndex]._txt_NameTier:SetFontColor(Defines.Color.C_FFF5BA3A)
                memberControlList[controlIndex]._sub_Bg:ChangeTextureInfoNameAsync("combine/etc/combine_etc_solare_war_02.dds")
                local x1, y1, x2, y2 = setTextureUV_Func(memberControlList[controlIndex]._sub_Bg, 671, 476, 1179, 563)
                memberControlList[controlIndex]._sub_Bg:getBaseTexture():setUV(x1, y1, x2, y2)
                memberControlList[controlIndex]._sub_Bg:setRenderTexture(memberControlList[controlIndex]._sub_Bg:getBaseTexture())
                isSelfMVP = true == isMVP or true == isAce
              end
              if solareMatchMode ~= __eSolareMode_Normal_1vs1 and solareMatchMode ~= __eSolareMode_Normal_3vs3 and solareMatchMode ~= __eSolareMode_Custom then
                PaGlobalFunc_Solrare_Ranking_SetTierIconByScore(memberControlList[controlIndex]._stc_Tier, rankRating)
              else
                memberControlList[controlIndex]._stc_Tier:SetShow(false)
              end
              if preRankRating > 0 then
                PaGlobalFunc_Solrare_Ranking_SetTierFrameByPreSeasonScore(memberControlList[controlIndex]._stc_PreSeasonTier, preRankRating, 0, false)
                memberControlList[controlIndex]._stc_PreSeasonTier:SetShow(true)
              else
                memberControlList[controlIndex]._stc_PreSeasonTier:SetShow(false)
              end
              if nil ~= PaGlobalFunc_Util_SetSolrareIngameClassBg then
                PaGlobalFunc_Util_SetSolrareIngameClassBg(memberControlList[controlIndex]._stc_Class, classTypeRaw)
              end
            end
          end
        end
      end
      resultControl._bg:SetShow(true)
      if _ContentsGroup_SolareCeremony == true then
        self._ui._blackBg:SetShow(false)
        self._ui._txt_Round:SetShow(false)
        Panel_Window_Solrare_RoundNotice:setConvetableInputMode(CppEnums.EProcessorInputMode.eProcessorInputMode_UiModeNotInput)
        self:setRenderMode(true)
      else
        self._ui._txt_Round:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SA_WIDGET_SCOREBOARD_RESURT"))
        local gap = 50
        self._ui._txt_Round:SetSpanSize(self._ui._txt_Round:GetSpanSize().x, self._ui._txt_Round:GetSpanSize().y - gap)
        local controlSize = resultControl._memberControl[1]._sub_Bg:GetSizeX() + gap
        resultControl._bg:SetSpanSize(self._ui._stc_FinalResult_Win:GetSpanSize().x - controlSize, resultControl._bg:GetSpanSize().y)
      end
    end
    self._ui._stc_RewardBg:SetShow(false)
    local gameResultType = __eSolareRoundResult_Count
    if true == isRedTeamWin then
      if myTeamNo == __eSolareTeamNo_Red then
        self._ui._stc_FinalResult_Win:SetShow(true)
        self._ui._stc_FinalResult_Win:AddEffect("fUI_Solrare_Win_01A", false, 0, 0)
        audioPostEvent_SystemUi(30, 5)
        _AudioPostEvent_SystemUiForXBOX(30, 5)
        gameResultType = __eSolareRoundResult_Win
      else
        self._ui._stc_FinalResult_Lose:SetShow(true)
        self._ui._stc_FinalResult_Lose:AddEffect("fUI_Solrare_Lose_01A", false, 0, 0)
        audioPostEvent_SystemUi(30, 6)
        _AudioPostEvent_SystemUiForXBOX(30, 6)
        gameResultType = __eSolareRoundResult_Lose
      end
    elseif true == isBlueTeamWin then
      if myTeamNo == __eSolareTeamNo_Red then
        self._ui._stc_FinalResult_Lose:SetShow(true)
        self._ui._stc_FinalResult_Lose:AddEffect("fUI_Solrare_Lose_01A", false, 0, 0)
        audioPostEvent_SystemUi(30, 6)
        _AudioPostEvent_SystemUiForXBOX(30, 6)
        gameResultType = __eSolareRoundResult_Lose
      else
        self._ui._stc_FinalResult_Win:SetShow(true)
        self._ui._stc_FinalResult_Win:AddEffect("fUI_Solrare_Win_01A", false, 0, 0)
        audioPostEvent_SystemUi(30, 5)
        _AudioPostEvent_SystemUiForXBOX(30, 5)
        gameResultType = __eSolareRoundResult_Win
      end
    else
      self._ui._stc_RoundResult_Tie:SetShow(false)
      self._ui._stc_FinalResult_Tie:SetShow(true)
      self._ui._stc_FinalResult_Tie:AddEffect("fUI_Solrare_Lose_01A", false, 0, 0)
      audioPostEvent_SystemUi(30, 13)
      _AudioPostEvent_SystemUiForXBOX(30, 13)
      gameResultType = __eSolareRoundResult_Draw
    end
    local prevRating = ToClient_GetSolarePrevRankRating()
    local rewardItemSSW = ToClient_GetSolareRewardItemStaticStatusWrapper(solareMatchMode, prevRating, gameResultType)
    if rewardItemSSW ~= nil then
      self._ui._stc_RewardBg:SetShow(true)
      if _ContentsGroup_SolareCeremony == false then
        self._ui._stc_rewardFrameBg:SetShow(true)
        self._ui._stc_rewardItemSlotBg:SetShow(true)
      end
      local rewardItemCount_s64 = ToClient_GetSolareRewardItemCount(solareMatchMode, prevRating, gameResultType)
      local slot = {}
      SlotItem.reInclude(slot, "SolareRewardItemSlot", 0, self._ui._stc_rewardItemSlot, self._rewardItemSlotConfing)
      slot:setItemByStaticStatus(rewardItemSSW, rewardItemCount_s64, -1, false)
      slot.icon:SetShow(true)
      self._ui._txt_rewardItemName:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SOLARE_REWARD_DESCRIPTION", "itemName", rewardItemSSW:getName(), "count", Int64toInt32(rewardItemCount_s64)))
    end
  end
  PaGlobal_Solrare_MatchNotice:prepareOpen()
end
function FromClient_SolareVaryRankRating(prevRating, currentRating, isPlacementMatchOver)
  if nil == Panel_Widget_Solare_TierUpgrade then
    return
  end
  if isPlacementMatchOver == true then
    PaGlobalFunc_Solrare_Ranking_SetTierIconByScore(self._ui._stc_TierIcon, currentRating)
    PaGlobalFunc_Solrare_MatchNotice_OpenTierUp(currentRating, isPlacementMatchOver)
  else
    PaGlobalFunc_Solrare_Ranking_SetTierIconByScore(self._ui._stc_TierIcon, prevRating)
    local beforeTier = CovertSolrareRankScoreToTierGrade(prevRating)
    local currentTier = CovertSolrareRankScoreToTierGrade(currentRating)
    if beforeTier < currentTier then
      PaGlobalFunc_Solrare_MatchNotice_OpenTierUp(currentRating, isPlacementMatchOver)
    end
  end
end
function PaGlobalFunc_Solrare_MatchNotice_Open(solareMatchMode, redMVPUserNo, blueMVPUserNo)
  if nil == Panel_Window_Solrare_RoundNotice then
    return
  end
  PaGlobal_Solrare_MatchNotice:updateTeamUI_Round(solareMatchMode, redMVPUserNo, blueMVPUserNo)
end
function FromClient_SolrareMatchNotice_UpdatePerFrame(deltaTime)
  PaGlobal_Solrare_MatchNotice._currentTime = PaGlobal_Solrare_MatchNotice._currentTime + deltaTime
  if PaGlobal_Solrare_MatchNotice._showTime <= PaGlobal_Solrare_MatchNotice._currentTime then
    PaGlobal_Solrare_MatchNotice:prepareClose()
  end
end
function FromClient_SolareMatchNotice_IntialControlSetting()
  if nil == Panel_Window_Solrare_RoundNotice or PaGlobal_Solrare_MatchNotice._initialize == false then
    return
  end
  PaGlobal_Solrare_MatchNotice:playerSetting(__eSolareMode_Count)
end
function FromClient_SolareMatchNotice_UpdateNoticeByResult(solareMatchMode, winnerTeamNo, reason, redWinCount, blueWinCount)
  PaGlobalFunc_SolareHud_SetWinCountUI(redWinCount, blueWinCount)
  Panel_Window_Solrare_RoundNotice:EraseAllEffect()
  local self = PaGlobal_Solrare_MatchNotice
  for idx = 1, self._maxTeamCount do
    if nil ~= self._ui._stc_TeamControl[idx] then
      self._ui._stc_TeamControl[idx]._bg:SetShow(false)
    end
  end
  self._ui._stc_Versus:SetShow(false)
  local myTeamNo = ToClient_GetSolareMyTeamType()
  self._ui._stc_RoundResult_Win:SetShow(false)
  self._ui._stc_RoundResult_Lose:SetShow(false)
  self._ui._stc_RoundResult_Tie:SetShow(false)
  if -1 ~= winnerTeamNo then
    if myTeamNo == winnerTeamNo then
      self._ui._stc_RoundResult_Win:SetShow(true)
      self._ui._stc_RoundResult_Win:AddEffect("fUI_Solrare_Win_01A", false, 0, 0)
      audioPostEvent_SystemUi(30, 3)
      _AudioPostEvent_SystemUiForXBOX(30, 3)
    else
      self._ui._stc_RoundResult_Lose:SetShow(true)
      self._ui._stc_RoundResult_Lose:AddEffect("fUI_Solrare_Lose_01A", false, 0, 0)
      audioPostEvent_SystemUi(30, 4)
      _AudioPostEvent_SystemUiForXBOX(30, 4)
    end
  else
    if false == self._ui._stc_FinalResult_Tie:GetShow() then
      self._ui._stc_RoundResult_Tie:SetShow(true)
    end
    audioPostEvent_SystemUi(30, 12)
    _AudioPostEvent_SystemUiForXBOX(30, 12)
  end
  local currentRound = ToClient_GetSolareCurrentRound()
  self._ui._txt_Round:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_COMPETITION_ROUND", "round", currentRound))
  Proc_NoticeAlert_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_SYSMSG_END"), CppEnums.EChatNoticeType.ActionNakAll, 0)
  PaGlobalFunc_Solrare_MatchNotice_Open(solareMatchMode, -1, -1)
end
function PaGlobalFunc_Solrare_MatchNotice_OpenTierUp(myRankRating, isPlacementMatchOver)
  PaGlobal_Solrare_MatchNotice:prepareOpenTierUp(myRankRating, isPlacementMatchOver)
end
function PaGlobal_Solrare_MatchNotice:prepareOpenTierUp(myRankRating, isPlacementMatchOver)
  if nil == Panel_Widget_Solare_TierUpgrade then
    return
  end
  local isPanelOpen = false
  PaGlobal_Solrare_MatchNotice:openPlacementMatchEnd()
  self._ui._stc_Effect:EraseAllEffect()
  local myTier = CovertSolrareRankScoreToTierGrade(myRankRating)
  local rankOrder = Defines.SolrareRankOrder[myTier]
  if rankOrder < 10 then
    rankOrder = "0" .. tostring(rankOrder)
  end
  if isPlacementMatchOver == true then
    isPanelOpen = true
    self._ui._txt_TierDesc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SOLARE_TIERUPGRADE_MAINDESC_ARRANGEMENT", "tier", PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_RANK_TIER_" .. tostring(rankOrder))))
    PaGlobalFunc_Solrare_Ranking_SetTierIconByScore(self._ui._stc_TierIcon, myRankRating)
    if myRankRating >= Defines.SolrareRank.RANK1_1 then
      self._ui._stc_Effect:AddEffect("fUI_Solrare_TierStart_01A", true, 0, 150)
    elseif myRankRating >= Defines.SolrareRank.RANK2_3 and myRankRating < Defines.SolrareRank.RANK1_1 then
      self._ui._stc_Effect:AddEffect("fUI_Solrare_TierStart_01B", true, 0, 150)
    elseif myRankRating >= Defines.SolrareRank.RANK3_3 and myRankRating < Defines.SolrareRank.RANK2_3 then
      self._ui._stc_Effect:AddEffect("fUI_Solrare_TierStart_01C", true, 0, 150)
    elseif myRankRating >= Defines.SolrareRank.RANK4_3 and myRankRating < Defines.SolrareRank.RANK3_3 then
      self._ui._stc_Effect:AddEffect("fUI_Solrare_TierStart_01D", true, 0, 150)
    elseif myRankRating >= Defines.SolrareRank.RANK5_3 and myRankRating < Defines.SolrareRank.RANK4_3 then
      self._ui._stc_Effect:AddEffect("fUI_Solrare_TierStart_01E", true, 0, 150)
    elseif myRankRating >= Defines.SolrareRank.RANK6_4 and myRankRating < Defines.SolrareRank.RANK5_3 then
      self._ui._stc_Effect:AddEffect("fUI_Solrare_TierStart_01F", true, 0, 150)
    elseif myRankRating >= Defines.SolrareRank.RANK7_4 and myRankRating < Defines.SolrareRank.RANK6_4 then
      self._ui._stc_Effect:AddEffect("fUI_Solrare_TierStart_01G", true, 0, 150)
    else
      self._ui._stc_Effect:AddEffect("fUI_Solrare_TierStart_01H", true, 0, 150)
    end
    audioPostEvent_SystemUi(30, 23)
    _AudioPostEvent_SystemUiForXBOX(30, 23)
  else
    self._ui._txt_TierDesc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SOLARE_TIERUPGRADE_MAINDESC", "tier", PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_RANK_TIER_" .. tostring(rankOrder))))
    luaTimer_AddEvent(PaGlobalFunc_Solrare_Ranking_SetTierIconByScore, 2000, false, 0, self._ui._stc_TierIcon, myRankRating)
    if myTier == Defines.SolrareRank.RANK1_1 then
      self._ui._stc_Effect:AddEffect("fUI_Solrare_TierUp_01A", true, 0, 150)
      audioPostEvent_SystemUi(30, 27)
      _AudioPostEvent_SystemUiForXBOX(30, 27)
      isPanelOpen = true
    elseif myTier == Defines.SolrareRank.RANK2_3 then
      self._ui._stc_Effect:AddEffect("fUI_Solrare_TierUp_01B", true, 0, 150)
      audioPostEvent_SystemUi(30, 26)
      _AudioPostEvent_SystemUiForXBOX(30, 26)
      isPanelOpen = true
    elseif myTier == Defines.SolrareRank.RANK3_3 then
      self._ui._stc_Effect:AddEffect("fUI_Solrare_TierUp_01C", true, 0, 150)
      audioPostEvent_SystemUi(30, 25)
      _AudioPostEvent_SystemUiForXBOX(30, 25)
      isPanelOpen = true
    elseif myTier == Defines.SolrareRank.RANK4_3 then
      self._ui._stc_Effect:AddEffect("fUI_Solrare_TierUp_01D", true, 0, 150)
      audioPostEvent_SystemUi(30, 24)
      _AudioPostEvent_SystemUiForXBOX(30, 24)
      isPanelOpen = true
    elseif myTier == Defines.SolrareRank.RANK5_3 then
      self._ui._stc_Effect:AddEffect("fUI_Solrare_TierUp_01E", true, 0, 150)
      audioPostEvent_SystemUi(30, 23)
      _AudioPostEvent_SystemUiForXBOX(30, 23)
      isPanelOpen = true
    elseif myTier == Defines.SolrareRank.RANK6_4 then
      self._ui._stc_Effect:AddEffect("fUI_Solrare_TierUp_01F", true, 0, 150)
      audioPostEvent_SystemUi(30, 23)
      _AudioPostEvent_SystemUiForXBOX(30, 23)
      isPanelOpen = true
    elseif myTier == Defines.SolrareRank.RANK7_4 then
      self._ui._stc_Effect:AddEffect("fUI_Solrare_TierUp_01G", true, 0, 150)
      audioPostEvent_SystemUi(30, 23)
      _AudioPostEvent_SystemUiForXBOX(30, 23)
      isPanelOpen = true
    end
  end
  if isPanelOpen == true then
    PaGlobal_Solrare_MatchNotice:openTierUp()
  end
end
function PaGlobal_Solrare_MatchNotice:openTierUp()
  if nil == Panel_Widget_Solare_TierUpgrade then
    return
  end
  Panel_Widget_Solare_TierUpgrade:SetShow(true)
end
function PaGlobal_Solrare_MatchNotice:closeTierUp()
  if nil == Panel_Widget_Solare_TierUpgrade then
    return
  end
  self._ui._stc_Effect:EraseAllEffect()
  Panel_Widget_Solare_TierUpgrade:EraseAllEffect()
  Panel_Widget_Solare_TierUpgrade:SetShow(false)
end
function PaGlobal_Solrare_MatchNotice:openPlacementMatchEnd()
  if nil == Panel_Widget_Solare_TierUpgrade then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isPlacementMatchEnd = false
  local currentGameMode = ToClient_GetSolareGameMode()
  local rankMatchCount = ToClient_GetSolarePlacementMatchRecordCount(currentGameMode)
  if currentGameMode == __ePVPArenaMode_SOLARE1vs1 then
    isPlacementMatchEnd = rankMatchCount == self._placementMatchMaxCount_1vs1
  elseif currentGameMode == __ePVPArenaMode_SOLARE3vs3 then
    isPlacementMatchEnd = rankMatchCount == self._placementMatchMaxCount_3vs3
  else
    return
  end
  self._ui._placementBg:SetShow(false)
  if isPlacementMatchEnd == false then
    return
  end
  local selfUserNo = selfPlayer:get():getUserNo()
  self._ui._placementBg:SetShow(true)
  local rankInfoDataTable = Array.new()
  for idx = 0, rankMatchCount do
    local rankMatchData = ToClient_GetSolarePlacementMatchInfoIndex(currentGameMode, idx)
    if nil ~= rankMatchData then
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
  end
  for idx = 1, #rankInfoDataTable do
    if self._ui._placementRecordIcon[idx] ~= nil then
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
function PaGloabalFunc_SolareCeremony_CloseRenderMode()
  if Panel_Window_Solrare_RoundNotice == nil and PaGlobal_Solrare_MatchNotice._initialize == false then
    return
  end
  PaGlobal_Solrare_MatchNotice:setRenderMode(false)
end
