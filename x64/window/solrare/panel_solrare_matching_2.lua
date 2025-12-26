function PaGlobalFunc_SolareMain_Open()
  local self = PaGlobal_Solrare_Matching
  if self == nil then
    return
  end
  ToClient_RequestSolareRecentRecordInfo()
end
function HandleEventLUp_Solrare_JoinRankMatching()
  local self = PaGlobal_Solrare_Matching
  if self == nil then
    return
  end
  if ToClient_isPlayingSolareCustomMatch() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_CANT_NAK_EXISTCUSTOMMATCHING"))
    return
  end
  if self._matchingTime < self._matchingDelayTime then
    local remainSecTime = math.floor(self._matchingDelayTime - self._matchingTime)
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "GAME_CONSOLE_REFRESH_MAIL_COOLTIME", "cooltime", remainSecTime))
    return
  end
  self._matchingTime = 0
  local arenaMode = 0
  if ToClient_IsDevelopment() == true then
    arenaMode = self._currentSelectMode
  else
    arenaMode = __ePVPArenaMode_SOLARE3vs3
  end
  audioPostEvent_SystemUi(30, 15)
  _AudioPostEvent_SystemUiForXBOX(30, 15)
  ToClient_requestJoinMatching(__eMatchMode_Normal, __eInstanceContentsType_Solare, 0, -100, arenaMode)
end
function HandleEventLUp_Solrare_NormalMatching()
  local self = PaGlobal_Solrare_Matching
  if self == nil then
    return
  end
  if ToClient_isPlayingSolareCustomMatch() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_CANT_NAK_EXISTCUSTOMMATCHING"))
    return
  end
  if _ContentsGroup_Solare == false then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_OFFSEASON_DESC"))
    return
  end
  if self._matchingTime < self._matchingDelayTime then
    local remainSecTime = math.floor(self._matchingDelayTime - self._matchingTime)
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "GAME_CONSOLE_REFRESH_MAIL_COOLTIME", "cooltime", remainSecTime))
    return
  end
  self._matchingTime = 0
  local arenaMode = 0
  if ToClient_IsDevelopment() == true then
    arenaMode = self._currentSelectMode
  else
    arenaMode = __ePVPArenaMode_SOLARE3vs3
  end
  audioPostEvent_SystemUi(30, 15)
  _AudioPostEvent_SystemUiForXBOX(30, 15)
  ToClient_requestJoinMatching(__eMatchMode_Party, __eInstanceContentsType_Solare, 0, -100, arenaMode)
end
function HandleEventLUp_Solrare_ShowDetailToggle(index)
  local self = PaGlobal_Solrare_Matching
  if self == nil then
    return
  end
  if self._frameControlList[index] == nil then
    return
  end
  for idx = 1, self._maxShowRecentInfoCount do
    if self._frameControlList[idx] ~= nil then
      if index == idx then
        if self._frameControlList[idx]._isDetailControlShow == true then
          self._frameControlList[idx]._isDetailControlShow = false
          self._frameControlList[idx]._chk_ShowDetail:SetCheck(false)
        else
          self._frameControlList[idx]._isDetailControlShow = true
          self._frameControlList[idx]._chk_ShowDetail:SetCheck(true)
        end
      else
        self._frameControlList[idx]._isDetailControlShow = false
        self._frameControlList[idx]._chk_ShowDetail:SetCheck(false)
      end
    end
  end
  self:reAlignFrameControl()
end
function HandleEventLUp_Solrare_OpenCustomMatching()
  if ToClient_IsMatchingStateByMatchServer() == true then
    return
  end
  if _ContentsGroup_Solare == false then
    return
  end
  PaGlobalFunc_Solrare_Matching_Close()
  PaGlobalFunc_SolareCustom_Open()
end
function FromClient_Solrare_MatchServerAlreadyConnected()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoAlreadyConnect"))
end
function FromClient_Solrare_MatchServerConnectSuccess()
  ToClient_requestJoinMatching(__eMatchMode_Count, __eInstanceContentsType_Solare, 0, -1, 0)
end
function FromClient_Solrare_SuccessMatchServerLogin()
  PaGlobalFunc_Solrare_MatchingState_Open()
end
function FromClient_Solrare_MatchingSuccess()
  local self = PaGlobal_Solrare_Matching
  if self == nil then
    return
  end
  local successString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SOLARE_FOUND_MATCH_TITLE")
  self._ui._txt_MatchingState:SetText(successString)
  self._ui._btn_MatchingCancel:SetMonoTone(true, true)
  self._ui._btn_MatchingCancel:SetIgnore(true)
  PaGlobalFunc_Solrare_MatchingConfirm_Close()
  if Panel_Window_GameExit_All ~= nil and Panel_Window_GameExit_All:GetShow() == true then
    PaGlobal_GameExit_All_Close(true)
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CASH_CUSTOMIZATION_BUYITEM_TITLE"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_SOLRARE_LOADING_MSG"),
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FromClient_Solrare_SuccessMatchServerLogout()
  PaGlobalFunc_Solrare_MatchingState_Close()
  PaGlobalFunc_Solrare_MatchingConfirm_Close()
end
function FromClient_Solare_Matching_Resize()
  Panel_Window_Solrare_Matching:ComputePos()
end
function FromClient_Solare_MatchingStateUpdate(isMatching)
  if ToClient_IsMatchingStateByMatchServer() == true then
    PaGlobalFunc_Solrare_MatchingState_Open()
  elseif Panel_Window_Solare_Finding_Match:GetShow() == true then
    PaGlobalFunc_Solrare_MatchingState_Close()
  end
end
function FromClient_SolareNeedSettingEquipPresetAck()
  local confirm = function()
    PaGlobalFunc_PaGlobal_Solare_EquipPreset_Open()
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = PAGetString(Defines.StringSheet_GAME, "SOLARE_EQUIP_ALERT_DESC"),
    functionYes = confirm,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FromClient_SolareRecentRecordLoad()
  if PaGlobalFunc_Solrare_Matching_IsOpen() == true then
    return
  end
  PaGlobalFunc_Solrare_Matching_Open()
end
function FromClient_Solrare_Matching_UpdatePerFrame(deltaTime)
  local self = PaGlobal_Solrare_Matching
  if self == nil then
    return
  end
  self._matchingTime = self._matchingTime + deltaTime
end
function FromClient_Solrare_MatchingState_UpdatePerFrame(deltaTime)
  local self = PaGlobal_Solrare_Matching
  if self == nil then
    return
  end
  self._matchingCloseTime = self._matchingCloseTime + deltaTime
  self._currentDeltaTime = self._currentDeltaTime + deltaTime
  if self._currentDeltaTime > 1 then
    self._currentElapsedTime = self._currentElapsedTime + 1
    self._currentDeltaTime = 0
    self._ui._txt_MatchingElapsedTime:SetText(convertSecondsToClockTime(self._currentElapsedTime))
  end
end
function PaGlobalFunc_Solrare_Matching_Open()
  local self = PaGlobal_Solrare_Matching
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_Solrare_Matching_Close()
  local self = PaGlobal_Solrare_Matching
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_Solrare_Matching_IsOpen()
  if Panel_Window_Solrare_Matching == nil then
    return false
  end
  return Panel_Window_Solrare_Matching:GetShow()
end
function PaGlobalFunc_Solrare_MatchingState_Open()
  local self = PaGlobal_Solrare_Matching
  if self == nil then
    return
  end
  self._ui._txt_MatchingElapsedTime:SetText("")
  self._currentElapsedTime = 0
  self._currentDeltaTime = 0
  Panel_Window_Solare_Finding_Match:ClearUpdateLuaFunc()
  Panel_Window_Solare_Finding_Match:RegisterUpdateFunc("FromClient_Solrare_MatchingState_UpdatePerFrame")
  self._ui._txt_MatchingState:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BLOODALTAR_MATCHING_WAITING"))
  Panel_Window_Solare_Finding_Match:ComputePos()
  Panel_Window_Solare_Finding_Match:SetShow(true)
  self._ui._stc_matchingBg:EraseAllEffect()
  self._ui._stc_matchingBg:AddEffect("fUI_Solrare_Start_01A", true, 16, 1)
  self._ui._btn_MatchingCancel:SetMonoTone(false, false)
  self._ui._btn_MatchingCancel:SetIgnore(false)
  self:switchMatchingBtn(true)
  self:checkPlacementBgOpen()
end
function PaGlobalFunc_Solrare_MatchingState_PrepareClose()
  local self = PaGlobal_Solrare_Matching
  if self == nil then
    return
  end
  if self._matchingCloseTime < self._matchingDelayTime then
    local remainSecTime = math.floor(self._matchingDelayTime - self._matchingCloseTime)
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "GAME_CONSOLE_REFRESH_MAIL_COOLTIME", "cooltime", remainSecTime))
    return
  end
  self._matchingCloseTime = 0
  ToClient_requestCancleMatching()
end
function HandleEventLUp_Solare_ChangeGameMode()
  local self = PaGlobal_Solrare_Matching
  if self == nil then
    return
  end
  self:toggleSelectModeButton()
  self:update()
end
function HandleEventOnOut_Solrare_AccumulateTime(isShow)
  local self = PaGlobal_Solrare_Matching
  if self == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local accumTime = Int64toInt32(ToClient_GetAccumulateMatchTime())
  if accumTime > 0 then
    local convertTime = convertSecondsToClockTime(accumTime)
    local desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SOLARE_MATCH_WAITINGTIME_DESC", "time", convertTime)
    TooltipSimple_Show(self._ui._btn_RankGameReq, "", desc)
  end
end
function PaGlobalFunc_Solrare_MatchingState_Close()
  local self = PaGlobal_Solrare_Matching
  if self == nil then
    return
  end
  self._currentElapsedTime = 0
  self._currentDeltaTime = 0
  self:switchMatchingBtn(false)
  Panel_Window_Solare_Finding_Match:SetShow(false)
  Panel_Window_Solare_Finding_Match:ClearUpdateLuaFunc()
end
function PaGlobalFunc_PaGlobal_Solare_EquipPreset_TierListShow(isShow)
  local self = PaGlobal_Solrare_Matching
  if self == nil then
    return
  end
  if _ContentsGroup_UsePadSnapping == true then
    self._ui._stc_TierListBg:SetShow(self._ui._stc_TierListBg:GetShow() == false)
  else
    self._ui._stc_TierListBg:SetShow(isShow)
  end
end
function PaGlobalFunc_Solrare_Ranking_SetSkillBranchType(control, skillBranchType, classType)
  if control == nil then
    return
  end
  if control._stc_awaken == nil or control._stc_succession == nil or control._stc_shy == nil or control._stc_archer == nil or control._stc_scholar == nil or control._stc_deadeye == nil or control._stc_ogong == nil or control._stc_seraphim == nil then
    return
  end
  _PA_ASSERT_NAME(NewClassData.NewClassType == __eClassType_PDKL, "\236\131\136\235\161\156\236\154\180 ClassType \235\163\168\236\149\132 \236\158\145\236\151\133 \236\139\156 \237\153\149\236\157\184\237\149\180\236\163\188\236\132\184\236\154\148. ", "\236\161\176\236\139\156\236\153\132")
  control._stc_awaken:SetShow(false)
  control._stc_succession:SetShow(false)
  control._stc_shy:SetShow(false)
  control._stc_archer:SetShow(false)
  control._stc_scholar:SetShow(false)
  control._stc_deadeye:SetShow(false)
  control._stc_ogong:SetShow(false)
  control._stc_seraphim:SetShow(false)
  if skillBranchType == __eSkillTypeParam_Normal and PaGlobalFunc_Util_IsSuccessionFirstLearnClassType(classType) == true then
    skillBranchType = __eSkillTypeParam_Inherit
  end
  if classType == __eClassType_ShyWaman then
    control._stc_shy:SetShow(true)
  elseif classType == __eClassType_RangerMan then
    control._stc_archer:SetShow(true)
  elseif classType == __eClassType_Scholar then
    control._stc_scholar:SetShow(true)
  elseif classType == __eClassType_PWGE then
    control._stc_deadeye:SetShow(true)
  elseif classType == __eClassType_PJKD then
    control._stc_ogong:SetShow(true)
  elseif classType == __eClassType_PDKL then
    control._stc_seraphim:SetShow(true)
  elseif skillBranchType == __eSkillTypeParam_Awaken then
    control._stc_awaken:SetShow(true)
  elseif skillBranchType == __eSkillTypeParam_Inherit or skillBranchType == __eSkillTypeParam_Normal then
    control._stc_succession:SetShow(true)
  end
end
function PaGlobalFunc_Solare_CopyUserInformation()
  local confirm = function()
    ToClient_CopyUserInformation()
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_CHARACTER_COPY_MSG"),
    functionYes = confirm,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function UpdateWaitCopyUserInformation(deltaTime)
  local self = PaGlobal_Solrare_Matching
  if self == nil then
    return
  end
  self._copyUserInformationWaitTime = self._copyUserInformationWaitTime - deltaTime
  if self._copyUserInformationWaitTime < 0 then
    FromClient_CopyUserInformation(false, false)
  end
end
function FromClient_CopyUserInformation(isWaiting, isSuccess)
  local self = PaGlobal_Solrare_Matching
  if self == nil then
    return
  end
  if isWaiting == true then
    self._ui._stc_copyProgress:SetShow(true)
    self._copyUserInformationWaitTime = 20
    Panel_Window_Solrare_Matching:RegisterUpdateFunc("UpdateWaitCopyUserInformation")
  else
    if isSuccess == true then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_CHARACTER_COPY_COMPLETE"))
      self:updateChampionShipButton()
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_CHARACTER_COPY_FAILURE"))
    end
    self._ui._stc_copyProgress:SetShow(false)
    Panel_Window_Solrare_Matching:ClearUpdateLuaFunc("UpdateWaitCopyUserInformation")
  end
end
function HandleEventOnOut_Solare_CopyUserTime(isShow)
  local self = PaGlobal_Solrare_Matching
  if self == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local copyTime_s64 = ToClient_GetUserCopyTime()
  local temp = Int64toInt32(copyTime_s64)
  local paTime = PATime(copyTime_s64)
  local year = tostring(paTime:GetYear())
  local month = paTime:GetMonth()
  local day = paTime:GetDay()
  local hour = paTime:GetHour()
  local minute = paTime:GetMinute()
  if month < 10 then
    month = "0" .. tostring(month)
  else
    month = tostring(month)
  end
  if day < 10 then
    day = "0" .. tostring(day)
  else
    day = tostring(day)
  end
  if hour < 10 then
    hour = "0" .. tostring(hour)
  else
    hour = tostring(hour)
  end
  if minute < 10 then
    minute = "0" .. tostring(minute)
  else
    minute = tostring(minute)
  end
  local copyTime = year .. "-" .. month .. "-" .. day .. " " .. hour .. ":" .. minute
  local name = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SOLARE_CHARACTER_COPY_RECENT_INFO", "time", copyTime)
  TooltipSimple_Show(self._ui._btn_CopyUserInformation, name, nil)
end
function PaGlobalFunc_Solrare_Matching_OpenRule()
  local url = "https://www.console.playblackdesert.com/Wiki/Default?wikiNo=303"
  if ToClient_isPS4() == true then
    ToClient_OpenNativeWebBrowserPS4(url)
  else
    ToClient_OpenNativeWebBrowserXB1(url, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SOLARE_GUIDE_BTN"))
  end
end
