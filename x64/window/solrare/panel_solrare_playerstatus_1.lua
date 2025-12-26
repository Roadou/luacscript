function PaGlobal_Solrare_PlayerStatus:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._leftTeam.stc_mainBg = UI.getChildControl(Panel_Widget_Solare_PlayerStatus, "Static_LeftTeam")
  self._ui._leftTeam.stc_teamNameBg = UI.getChildControl(self._ui._leftTeam.stc_mainBg, "Static_TeamTitleBG")
  self._ui._leftTeam.txt_teamName = UI.getChildControl(self._ui._leftTeam.stc_teamNameBg, "StaticText_TeamName")
  self._ui._leftTeam.stc_memberTemplate = UI.getChildControl(self._ui._leftTeam.stc_mainBg, "Static_MemberArea")
  self._ui._leftTeam.stc_MyTeam = UI.getChildControl(self._ui._leftTeam.stc_teamNameBg, "StaticText_MyTeam")
  self._ui._leftTeam.stc_MyTeam:SetShow(false)
  self._ui._rightTeam.stc_mainBg = UI.getChildControl(Panel_Widget_Solare_PlayerStatus, "Static_RightTeam")
  self._ui._rightTeam.stc_teamNameBg = UI.getChildControl(self._ui._rightTeam.stc_mainBg, "Static_TeamTitleBG")
  self._ui._rightTeam.txt_teamName = UI.getChildControl(self._ui._rightTeam.stc_teamNameBg, "StaticText_TeamName")
  self._ui._rightTeam.stc_memberTemplate = UI.getChildControl(self._ui._rightTeam.stc_mainBg, "Static_MemberArea")
  self._ui._rightTeam.stc_MyTeam = UI.getChildControl(self._ui._rightTeam.stc_teamNameBg, "StaticText_MyTeam")
  self._ui._rightTeam.stc_MyTeam:SetShow(false)
  self._ui.stc_VoiceIcon = UI.getChildControl(Panel_Widget_Solare_PlayerStatus, "Button_SetState")
  self._ui.stc_VoiceListen = UI.getChildControl(self._ui.stc_VoiceIcon, "Static_Headphone")
  self._ui.stc_MICOnOff = UI.getChildControl(self._ui.stc_VoiceIcon, "Static_Mic")
  self._ui._leftTeam.txt_teamName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_TEAMNAME_0"))
  self._ui._rightTeam.txt_teamName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_TEAMNAME_1"))
  self:registEventHandler()
  PaGlobalFunc_Solrare_PlayerStatus_Create()
  self._initialize = true
  if ToClient_GetSolareRoomState() == __eInstanceSolareManagerState_Play then
    FromClient_Solare_SetPlayerStatus()
  end
end
function PaGlobal_Solrare_PlayerStatus:prepareOpen()
  if Panel_Widget_Solare_PlayerStatus == nil then
    return
  end
  self._ui.stc_VoiceIcon:SetShow(_ContentsGroup_VoiceChat)
  self:resize()
  self:open()
  if 0 < ToClient_getPetUnsealedList() and nil ~= HandleEventLUp_PetList_SealAllPet_All then
    HandleEventLUp_PetList_SealAllPet_All()
  end
  if true == _ContentsGroup_VoiceChat then
    self._ui.stc_VoiceListen:SetShow(ToClient_isVoiceChatListen())
    self._ui.stc_MICOnOff:SetShow(ToClient_isVoiceChatMic())
  end
end
function PaGlobal_Solrare_PlayerStatus:open()
  if Panel_Widget_Solare_PlayerStatus == nil then
    return
  end
  self._ui._leftTeam.stc_mainBg:SetShow(true)
  self._ui._rightTeam.stc_mainBg:SetShow(true)
  Panel_Widget_Solare_PlayerStatus:SetShow(true)
end
function PaGlobal_Solrare_PlayerStatus:prepareClose()
  if Panel_Widget_Solare_PlayerStatus == nil then
    return
  end
  self:close()
end
function PaGlobal_Solrare_PlayerStatus:close()
  if Panel_Widget_Solare_PlayerStatus == nil then
    return
  end
  self._ui._leftTeam.stc_mainBg:SetShow(false)
  self._ui._rightTeam.stc_mainBg:SetShow(false)
  Panel_Widget_Solare_PlayerStatus:SetShow(false)
end
function PaGlobal_Solrare_PlayerStatus:createTeamUi_Round()
  if Panel_Widget_Solare_PlayerStatus == nil then
    return
  end
  if 0 < #self._redTeamMemberUI or 0 < #self._blueTeamMemberUI then
    return
  end
  Panel_Widget_Solare_PlayerStatus:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_Widget_Solare_PlayerStatus:ComputePosAllChild()
  self._ui._leftTeam.stc_memberTemplate:SetShow(true)
  self._ui._rightTeam.stc_memberTemplate:SetShow(true)
  self._ui._leftTeam.stc_teamNameBg:SetShow(true)
  self._ui._rightTeam.stc_teamNameBg:SetShow(true)
  local selfPlayer = getSelfPlayer()
  local ATeamContorlNum = 0
  local BTeamContorlNum = 0
  for teamIndex = 1, self._maxTeamCount do
    for memberIndex = 1, self._maxControlCount do
      local temp = {}
      local redTeamControlCount = #self._redTeamMemberUI
      local blueTeamControlCount = #self._blueTeamMemberUI
      local gab = 5
      local spanY = 0
      if teamIndex == 1 then
        temp._memberBg = UI.cloneControl(self._ui._leftTeam.stc_memberTemplate, self._ui._leftTeam.stc_mainBg, "Static_MemberArea_Left_" .. teamIndex .. "_" .. redTeamControlCount + 1)
        spanY = self._ui._leftTeam.stc_memberTemplate:GetPosY() + (temp._memberBg:GetSizeY() + gab) * redTeamControlCount + 1
      elseif teamIndex == 2 then
        temp._memberBg = UI.cloneControl(self._ui._rightTeam.stc_memberTemplate, self._ui._rightTeam.stc_mainBg, "Static_MemberArea_Right_" .. teamIndex .. "_" .. blueTeamControlCount + 1)
        spanY = self._ui._rightTeam.stc_memberTemplate:GetPosY() + (temp._memberBg:GetSizeY() + gab) * blueTeamControlCount + 1
      end
      temp._memberBg:SetSpanSize(temp._memberBg:GetSpanSize().x, spanY)
      temp._memberBg:SetShow(false)
      if temp._memberBg ~= nil then
        temp._teamNo = teamIndex
        temp._circleBg = UI.getChildControl(temp._memberBg, "Static_CircleBG")
        temp._classIcon = UI.getChildControl(temp._circleBg, "Static_ClassIcon")
        temp._leftCount = UI.getChildControl(temp._circleBg, "StaticText_LeftCount")
        temp._name = UI.getChildControl(temp._memberBg, "StaticText_CharName")
        temp._gaugeRate = UI.getChildControl(temp._memberBg, "StaticText_BlackSpiritPercent")
        temp._progress = UI.getChildControl(temp._memberBg, "Progress2_1")
        temp._percent = UI.getChildControl(temp._memberBg, "StaticText_Percent")
        temp._replayCam = UI.getChildControl(temp._memberBg, "Static_ReplayCameraIcon")
        temp._replayCamKey = UI.getChildControl(temp._memberBg, "StaticText_ReplayCameraKeyGuide")
        temp._solareRanking = UI.getChildControl(temp._memberBg, "StaticText_SolareRanking")
        temp._preSeasonRank = UI.getChildControl(temp._memberBg, "Static_Border")
        temp._buffList = {}
        temp._userNo = nil
        temp._actorKeyRaw = nil
        temp._isLogin = false
        temp._hpPercent = 0
        for ii = 1, self._buffMaxCount do
          temp._buffList[ii] = UI.getChildControl(temp._memberBg, "Static_Buff_Temp_" .. ii)
        end
        if teamIndex == 1 then
          self._redTeamMemberUI:push_back(temp)
        elseif teamIndex == 2 then
          self._blueTeamMemberUI:push_back(temp)
        end
      end
    end
  end
  self._ui._leftTeam.stc_memberTemplate:SetShow(false)
  self._ui._rightTeam.stc_memberTemplate:SetShow(false)
end
function PaGlobal_Solrare_PlayerStatus:setting_Round(userInfo, userInfoIndex)
  if Panel_Widget_Solare_PlayerStatus == nil then
    return
  end
  self:createTeamUi_Round()
  self._ui._leftTeam.stc_MyTeam:SetShow(false)
  self._ui._rightTeam.stc_MyTeam:SetShow(false)
  local myTeamNo = ToClient_GetSolareMyTeamType()
  if myTeamNo ~= -1 then
    if myTeamNo == __eSolareTeamNo_Red then
      self._ui._leftTeam.stc_MyTeam:SetShow(true)
      self._ui.stc_VoiceIcon:SetHorizonLeft()
    else
      self._ui._rightTeam.stc_MyTeam:SetShow(true)
      self._ui.stc_VoiceIcon:SetHorizonRight()
    end
  end
  self._ui.stc_VoiceIcon:ComputePos()
  if userInfo == nil or userInfoIndex == nil then
    return
  end
  local teamNo = userInfo:getTeamNo()
  local actorkeyRaw = userInfo:getActorKeyRaw()
  local userNo = userInfo:getUserNo()
  local isLogin = userInfo:isLogin()
  local userSlot
  local isReplay = ToClient_IsPlayingReplay()
  if teamNo == __eSolareTeamNo_Red then
    if self._redTeamMemberUI[self._redTeamSettedCount] ~= nil then
      self._redTeamMemberUI[self._redTeamSettedCount]._userNo = userNo
      self._redTeamMemberUI[self._redTeamSettedCount]._actorKeyRaw = actorkeyRaw
      self._redTeamMemberUI[self._redTeamSettedCount]._isLogin = isLogin
      userSlot = self._redTeamMemberUI[self._redTeamSettedCount]
      self._redTeamSettedCount = self._redTeamSettedCount + 1
    end
  elseif teamNo == __eSolareTeamNo_Blue and self._blueTeamMemberUI[self._blueTeamSettedCount] ~= nil then
    self._blueTeamMemberUI[self._blueTeamSettedCount]._userNo = userNo
    self._blueTeamMemberUI[self._blueTeamSettedCount]._actorKeyRaw = actorkeyRaw
    self._blueTeamMemberUI[self._blueTeamSettedCount]._isLogin = isLogin
    userSlot = self._blueTeamMemberUI[self._blueTeamSettedCount]
    self._blueTeamSettedCount = self._blueTeamSettedCount + 1
  end
  if userSlot ~= nil then
    userSlot._memberBg:SetShow(true)
    userSlot._circleBg:SetShow(true)
    userSlot._classIcon:SetShow(true)
    PaGlobalFunc_Util_ChangeTextureClass(userSlot._classIcon, userInfo:getClassTypeRaw())
    userSlot._gaugeRate:SetShow(false)
    userSlot._gaugeRate:SetText("")
    userSlot._name:SetShow(true)
    if isReplay == true then
      local classRanking = userInfo:getClassRanking()
      local rankRating = userInfo:getRankRating()
      local classRankingStr
      if classRanking == -1 then
        classRankingStr = PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_REPLAYLIST_OUTOFRANK_OTHERSERVICE")
      else
        classRankingStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SOLARE_REPLAYLIST_RANKING_OTHERSERVICE", "rank", tostring(classRanking))
      end
      local rankRatingStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SOLARE_REPLAYLIST_RANKRATING_OTHERSERVICE", "rating", tostring(rankRating))
      userSlot._solareRanking:SetText(classRankingStr .. " (" .. rankRatingStr .. ")")
      userSlot._name:SetText(userInfo:getLevel() .. " " .. userInfo:getName())
      userSlot._solareRanking:SetShow(true)
    else
      userSlot._name:SetText(userInfo:getLevel() .. " " .. userInfo:getName())
      userSlot._solareRanking:SetShow(false)
    end
    local preSeasonRankRating = userInfo:getPreSeasonRankRating()
    if preSeasonRankRating > 0 then
      PaGlobalFunc_Solrare_Ranking_SetTierFrameByPreSeasonScore(userSlot._preSeasonRank, preSeasonRankRating, teamNo, true)
      userSlot._preSeasonRank:SetShow(true)
    else
      userSlot._preSeasonRank:SetShow(false)
    end
    userSlot._leftCount:SetShow(false)
    userSlot._progress:SetShow(true)
    userSlot._memberBg:SetMonoTone(not isLogin, not isLogin)
    if isReplay == true then
      userSlot._replayCam:SetShow(true)
      userSlot._replayCam:addInputEvent("Mouse_LUp", "SolareReplay_PlayerStatus_ChangeCameraTarget(" .. tostring(userNo) .. ")")
      userSlot._replayCamKey:SetShow(true)
      local isMode_1vs1 = false
      local solareMode = userInfo:getSolareMode()
      if solareMode == __eSolareMode_Ranking_1vs1 or solareMode == __eSolareMode_Normal_1vs1 then
        isMode_1vs1 = true
      else
        isMode_1vs1 = false
      end
      if teamNo == __eSolareTeamNo_Red then
        if isMode_1vs1 == true then
          userSlot._replayCamKey:SetText(PAGetString(Defines.StringSheet_GAME, "InputCustomizer_F1"))
        else
          local camKeyGuideArray = Array.new()
          camKeyGuideArray:push_back(PAGetString(Defines.StringSheet_GAME, "InputCustomizer_F1"))
          camKeyGuideArray:push_back(PAGetString(Defines.StringSheet_GAME, "InputCustomizer_F2"))
          camKeyGuideArray:push_back(PAGetString(Defines.StringSheet_GAME, "InputCustomizer_F3"))
          userSlot._replayCamKey:SetText(camKeyGuideArray[userInfoIndex + 1])
        end
      elseif teamNo == __eSolareTeamNo_Blue then
        if isMode_1vs1 == true then
          userSlot._replayCamKey:SetText(PAGetString(Defines.StringSheet_GAME, "InputCustomizer_F5"))
        else
          local camKeyGuideArray = Array.new()
          camKeyGuideArray:push_back(PAGetString(Defines.StringSheet_GAME, "InputCustomizer_F5"))
          camKeyGuideArray:push_back(PAGetString(Defines.StringSheet_GAME, "InputCustomizer_F6"))
          camKeyGuideArray:push_back(PAGetString(Defines.StringSheet_GAME, "InputCustomizer_F7"))
          userSlot._replayCamKey:SetText(camKeyGuideArray[userInfoIndex + 1])
        end
      else
        userSlot._replayCamKey:SetText("")
      end
    else
      userSlot._replayCam:SetShow(false)
      userSlot._replayCamKey:SetShow(false)
    end
    for ii = 1, self._buffMaxCount do
      userSlot._buffList[ii]:SetShow(false)
    end
  end
end
function PaGlobal_Solrare_PlayerStatus:updateUserHP_Round(teamNo, userNo, currentHp, maxHp, leftPercent)
  if Panel_Widget_Solare_PlayerStatus == nil then
    return
  end
  local userNo32 = Int64toInt32(userNo)
  local userSlot
  if teamNo == __eSolareTeamNo_Red then
    for idx = 1, #self._redTeamMemberUI do
      if self._redTeamMemberUI ~= nil and self._redTeamMemberUI[idx]._userNo == userNo32 then
        userSlot = self._redTeamMemberUI[idx]
        break
      end
    end
  elseif teamNo == __eSolareTeamNo_Blue then
    for idx = 1, #self._blueTeamMemberUI do
      if self._blueTeamMemberUI ~= nil and self._blueTeamMemberUI[idx]._userNo == userNo32 then
        userSlot = self._blueTeamMemberUI[idx]
        break
      end
    end
  end
  if userSlot ~= nil and leftPercent ~= nil then
    local hpPercent = math.ceil(leftPercent + 0.5)
    if hpPercent >= 100 then
      hpPercent = 100
    end
    if currentHp <= 0 then
      hpPercent = 0
      userSlot._name:SetMonoTone(true, true)
    else
      userSlot._name:SetMonoTone(false, false)
    end
    userSlot._progress:SetProgressRate(hpPercent)
    userSlot._hpPercent = hpPercent
    userSlot._percent:SetText(hpPercent .. "%")
  end
  if teamNo == __eSolareTeamNo_Red then
    local totalCurHpPercent = 0
    local totalMaxHpPercent = 0
    for idx = 1, #self._redTeamMemberUI do
      if self._redTeamMemberUI[idx] ~= nil and self._redTeamMemberUI[idx]._userNo ~= nil then
        totalCurHpPercent = totalCurHpPercent + self._redTeamMemberUI[idx]._hpPercent
        totalMaxHpPercent = totalMaxHpPercent + 100
      end
    end
    local percent = 0
    if totalCurHpPercent > 0 then
      percent = math.floor(totalCurHpPercent / totalMaxHpPercent * 100 + 0.5)
      if percent >= 100 then
        percent = 100
      end
    end
    if PaGlobalFunc_SolareHud_SetHPProgressBar ~= nil then
      PaGlobalFunc_SolareHud_SetHPProgressBar(true, percent)
    end
  elseif teamNo == __eSolareTeamNo_Blue then
    local totalCurHpPercent = 0
    local totalMaxHpPercent = 0
    for idx = 1, #self._blueTeamMemberUI do
      if self._blueTeamMemberUI[idx] ~= nil and self._blueTeamMemberUI[idx]._userNo ~= nil then
        totalCurHpPercent = totalCurHpPercent + self._blueTeamMemberUI[idx]._hpPercent
        totalMaxHpPercent = totalMaxHpPercent + 100
      end
    end
    local percent = 0
    if totalCurHpPercent > 0 then
      percent = math.floor(totalCurHpPercent / totalMaxHpPercent * 100 + 0.5)
      if percent >= 100 then
        percent = 100
      end
    end
    if PaGlobalFunc_SolareHud_SetHPProgressBar ~= nil then
      PaGlobalFunc_SolareHud_SetHPProgressBar(false, percent)
    end
  end
end
function PaGlobal_Solrare_PlayerStatus:registEventHandler()
  if Panel_Widget_Solare_PlayerStatus == nil then
    return
  end
  registerEvent("FromClient_SolareKillLog", "FromClient_Solrare_PlayerStatus_DeadHP")
  registerEvent("FromClient_SolareUpdateHp", "FromClient_Solrare_PlayerStatus_UpdateUserHP")
  registerEvent("FromClient_SolareUnJoinAck", "FromClient_SolareUnJoinAck")
  registerEvent("onScreenResize", "PaGlobalFunc_Solrare_PlayerStatus_Resize")
  registerEvent("FromClient_UpdateSolareReplayUserHPInfo", "FromClient_Solrare_PlayerStatus_UpdateUserHP")
  if _ContentsGroup_VoiceChat == true then
    if nil ~= Widget_Function_Type and nil ~= PaGlobalFunc_Widget_FunctionButton_HandleOver then
      self._ui.stc_VoiceIcon:addInputEvent("Mouse_On", "PaGlobalFunc_Widget_FunctionButton_HandleOver(" .. Widget_Function_Type.SetVoice .. ")")
      self._ui.stc_VoiceIcon:addInputEvent("Mouse_Out", "PaGlobalFunc_Widget_FunctionButton_HandleOut(" .. Widget_Function_Type.SetVoice .. ")")
      self._ui.stc_VoiceIcon:addInputEvent("Mouse_LUp", "PaGlobalFunc_Solrare_PlayerStatus_VoiceLClick()")
      self._ui.stc_VoiceIcon:addInputEvent("Mouse_RUp", "PaGlobalFunc_Widget_FunctionButton_HandleRClick(" .. Widget_Function_Type.SetVoice .. ")")
    end
    registerEvent("FromClient_ListenOnOffPAVoiceChat", "PaGlobalFunc_Solrare_PlayerStatus_VoiceOnOff")
    registerEvent("FromClient_SpeakOnOffPAVoiceChat", "PaGlobalFunc_Solrare_PlayerStatus_SpeakOnOff")
  else
    self._ui.stc_VoiceIcon:SetShow(false)
  end
end
function PaGlobal_Solrare_PlayerStatus:resize()
  if Panel_Widget_Solare_PlayerStatus == nil then
    return
  end
  Panel_Widget_Solare_PlayerStatus:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_Widget_Solare_PlayerStatus:ComputePosAllChild()
  self._ui._leftTeam.stc_MyTeam:SetShow(false)
  self._ui._rightTeam.stc_MyTeam:SetShow(false)
  local myTeamNo = ToClient_GetSolareMyTeamType()
  if myTeamNo ~= -1 then
    if myTeamNo == __eSolareTeamNo_Red then
      self._ui._leftTeam.stc_MyTeam:SetShow(true)
      self._ui.stc_VoiceIcon:SetHorizonLeft()
    else
      self._ui._rightTeam.stc_MyTeam:SetShow(true)
      self._ui.stc_VoiceIcon:SetHorizonRight()
    end
  end
end
