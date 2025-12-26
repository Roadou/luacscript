Panel_Arsha_Replay_All:SetShow(false)
local ReplayHpIndexTable = Array.new()
local arshaReplayWidget = {
  _replayArea = UI.getChildControl(Panel_Arsha_Replay_All, "Static_ReplayArea"),
  _txt_SpeedBuff = UI.getChildControl(Panel_Arsha_Replay_All, "StaticText_Buff"),
  _txt_SpeedBuffDetail = UI.getChildControl(Panel_Arsha_Replay_All, "StaticText_BuffDetail"),
  _txt_CamMode = UI.getChildControl(Panel_Arsha_Replay_All, "StaticText_CamMode"),
  _bookmarkCount = 0,
  _isFinishLoadReplay = false,
  _actionLogPoolCount = 7,
  _accumulatedActionLogAddCount = 0
}
arshaReplayWidget._playBar = UI.getChildControl(arshaReplayWidget._replayArea, "Slider_Playbar")
arshaReplayWidget._progressBarButton = UI.getChildControl(arshaReplayWidget._playBar, "Slider_1_Button")
arshaReplayWidget._playCheckBox = UI.getChildControl(arshaReplayWidget._replayArea, "Checkbox_Play")
arshaReplayWidget._stopButton = UI.getChildControl(arshaReplayWidget._replayArea, "Button_Stop")
arshaReplayWidget._roundTime = UI.getChildControl(arshaReplayWidget._replayArea, "StaticText_RoundTime")
arshaReplayWidget._replayName = UI.getChildControl(arshaReplayWidget._replayArea, "StaticText_ReplayName")
arshaReplayWidget._replayState = UI.getChildControl(arshaReplayWidget._replayArea, "StaticText_ReplayState")
arshaReplayWidget._bookmarkBase = UI.getChildControl(arshaReplayWidget._replayArea, "StaticText_KillTimingShow")
arshaReplayWidget._bookmarkPool = Array.new()
arshaReplayWidget._bookmarkList = Array.new()
arshaReplayWidget._bookmarkTimeList = Array.new()
arshaReplayWidget._bookmarkActorKeyList = Array.new()
arshaReplayWidget._rightButton = UI.getChildControl(arshaReplayWidget._replayArea, "Button_Right")
arshaReplayWidget._leftButton = UI.getChildControl(arshaReplayWidget._replayArea, "Button_Left")
arshaReplayWidget._replayRateText = UI.getChildControl(arshaReplayWidget._replayArea, "StaticText_ReplayRate")
arshaReplayWidget._slowPlayButton = UI.getChildControl(arshaReplayWidget._replayRateText, "Button_SlowPlay")
arshaReplayWidget._fastPlayButton = UI.getChildControl(arshaReplayWidget._replayRateText, "Button_FastPlay")
arshaReplayWidget._camDistText = UI.getChildControl(arshaReplayWidget._replayArea, "StaticText_CamDist")
arshaReplayWidget._camDistEditBox = UI.getChildControl(arshaReplayWidget._replayArea, "Edit_CamDist")
arshaReplayWidget._edit_setTimer = UI.getChildControl(arshaReplayWidget._replayArea, "Edit_SetTimer")
arshaReplayWidget._chk_isSyncMaster = UI.getChildControl(arshaReplayWidget._replayArea, "CheckButton_IsSyncMaster")
arshaReplayWidget._chk_isSyncRecive = UI.getChildControl(arshaReplayWidget._replayArea, "CheckButton_IsSyncRecive")
arshaReplayWidget._stc_SyncMember = UI.getChildControl(arshaReplayWidget._replayArea, "Static_SyncMember")
arshaReplayWidget._txt_SyncMember = UI.getChildControl(arshaReplayWidget._stc_SyncMember, "StaticText_SyncMember")
arshaReplayWidget._btn_Sync = UI.getChildControl(arshaReplayWidget._replayArea, "Button_Sync")
arshaReplayWidget._btn_SyncPlay = UI.getChildControl(arshaReplayWidget._replayArea, "Button_SyncPlay")
arshaReplayWidget._edit_MoveTime = UI.getChildControl(arshaReplayWidget._replayArea, "Edit_MoveTime")
arshaReplayWidget._replayLength = 0
arshaReplayWidget._currentTime = 0
arshaReplayWidget._editCount = 0
arshaReplayWidget._frm_actionLog = UI.getChildControl(Panel_Arsha_Replay_All, "ActionLogFrame_1")
arshaReplayWidget._frmContent_actionLog = UI.getChildControl(arshaReplayWidget._frm_actionLog, "Frame_1_Content")
arshaReplayWidget._stc_actionLogTeamplate = UI.getChildControl(arshaReplayWidget._frmContent_actionLog, "Static_Template")
arshaReplayWidget._stc_frameVScroll = arshaReplayWidget._frm_actionLog:GetVScroll()
local ReplayState_Type = {RECORDING = 0, STOP_RECORDING = 1}
function ArshaReplayWidget_Init()
  local self = arshaReplayWidget
  self._bookmarkBase:SetShow(false)
  self._playBar:addInputEvent("Mouse_LDown", "ArshaReplayWidget_PauseReplay()")
  self._playBar:addInputEvent("Mouse_LUp", "ArshaReplayWidget_ReadyReplayUseTime()")
  self._progressBarButton:addInputEvent("Mouse_LDown", "ArshaReplayWidget_PauseReplay()")
  self._progressBarButton:addInputEvent("Mouse_LUp", "ArshaReplayWidget_PlayReplay()")
  self._progressBarButton:addInputEvent("Mouse_LPress", "ArshaReplayWidget_UpdateWhenClickSlideButton()")
  self._playCheckBox:addInputEvent("Mouse_LUp", "ArshaReplayWidget_PlayOrPauseReplay()")
  self._playCheckBox:SetCheck(true)
  self._stopButton:addInputEvent("Mouse_LUp", "ArshaReplayWidget_StopReplay()")
  self._replayState:SetText("Stop Recording")
  self._rightButton:addInputEvent("Mouse_LDown", "ArshaReplayWidget_PauseReplay()")
  self._rightButton:addInputEvent("Mouse_LUp", "ArshaReplayWidget_ClickRightOrLeftButton(1)")
  self._leftButton:addInputEvent("Mouse_LDown", "ArshaReplayWidget_PauseReplay()")
  self._leftButton:addInputEvent("Mouse_LUp", "ArshaReplayWidget_ClickRightOrLeftButton(-1)")
  self._slowPlayButton:addInputEvent("Mouse_LUp", "ArshaReplayWidget_SetPlayRate(false)")
  self._fastPlayButton:addInputEvent("Mouse_LUp", "ArshaReplayWidget_SetPlayRate(true)")
  self._edit_setTimer:addInputEvent("Mouse_LUp", "ArshaReplayWidget_ClickSetTimer()")
  self._edit_setTimer:RegistReturnKeyEvent("ArshaReplayWidget_ReturnKeyEventSetTimer()")
  self._edit_setTimer:RegistAllKeyEvent("ArshaReplayWidget_KeyEventSetTimer()")
  self._edit_MoveTime:RegistAllKeyEvent("ArshaReplayWidget_KeyEventMoveTime()")
  self._edit_MoveTime:RegistReturnKeyEvent("ArshaReplayWidget_ReturnKeyEventMoveTime()")
  self._playBar:SetInterval(1000)
  self._camDistText:SetIgnore(false)
  self._camDistText:SetShow(false)
  self._camDistEditBox:SetShow(true)
  self._camDistEditBox:addInputEvent("Mouse_LUp", "ArshaReplayWidget_EditBoxToggle()")
  self._camDistEditBox:RegistReturnKeyEvent("ArshaReplayWidget_ConfirmEditBox()")
  self._chk_isSyncMaster:addInputEvent("Mouse_LUp", "ArshaReplayWidget_ClickIsSyncMaster()")
  self._chk_isSyncRecive:addInputEvent("Mouse_LUp", "ArshaReplayWidget_ClickIsSyncRecive()")
  self._camDistEditBox:SetNumberMode(true)
  self._camDistEditBox:SetMaxInput(4)
  self._btn_Sync:addInputEvent("Mouse_LUp", "ArshaReplayWidget_SetSyncTime()")
  self._btn_SyncPlay:addInputEvent("Mouse_LUp", "ArshaReplayWidget_RequestSyncPlay()")
  self._edit_MoveTime:addInputEvent("Mouse_LUp", "ArshaReplayWidget_ClickMoveTime()")
  self._chk_isSyncMaster:SetCheck(ToClient_getIsSyncMaster())
  self._chk_isSyncRecive:SetCheck(ToClient_getIsSyncRecive())
  self._stc_SyncMember:SetShow(false)
  self._btn_Sync:SetShow(false)
  self._btn_SyncPlay:SetShow(false)
  self._txt_SpeedBuff:SetShow(false)
  self._txt_SpeedBuffDetail:SetShow(false)
  self._txt_CamMode:SetShow(false)
  ArshaReplayWidgetClearHpColorIndex()
  self._stc_actionLogTeamplate:SetShow(false)
  self._stc_frameVScroll:SetControlPos(1)
  self._stc_frameVScroll:SetInterval(self._actionLogPoolCount)
  self._stc_frameVScroll:SetShow(false)
  ArshaReplayWidget_MakeActionLogPool()
end
function ArshaReplayWidget_SetPlayRate(isAdd)
  ToClient_SetReplayRate(isAdd)
end
function ArshaReplayWidget_ReadyReplayUseTime()
  local self = arshaReplayWidget
  self._playCheckBox:SetCheck(true)
  ToClient_ReadyReplayUseTime(self._playBar:GetControlPos())
  PaGlobalFunc_Arsha_Replay_Party_All_clearIsFinish()
  ToClient_PlayReplay(false)
end
function ArshaReplayWidget_UpdateWhenClickSlideButton()
  local self = arshaReplayWidget
  self._playCheckBox:SetCheck(false)
  local elepsedTime = math.ceil(self._replayLength * self._playBar:GetControlPos())
  self._roundTime:SetText(convertMilliSecondsToClockTime(elepsedTime) .. "/" .. convertMilliSecondsToClockTime(self._replayLength))
  ToClient_ReadyReplayUseTime(self._playBar:GetControlPos())
  PaGlobalFunc_Arsha_Replay_Party_All_clearIsFinish()
  ToClient_PlayReplay(true)
  ToClient_PauseReplay()
end
function ArshaReplayWidget_SetReplayName(replayName)
  if ToClient_IsInstanceContentsReplay() == true or ToClient_IsMirrorFieldContentsReplay() == true then
    return
  end
  local self = arshaReplayWidget
  self._replayName:SetText(replayName)
end
function ArshaReplayWidget_ClickRightOrLeftButton(sign)
  local self = arshaReplayWidget
  local isPause = ToClient_IsPauseReplay()
  local elepsedTime = self._currentTime
  local editTime = 5
  if self._edit_MoveTime:GetText() ~= "" then
    editTime = tonumber(self._edit_MoveTime:GetText())
  end
  if editTime == nil then
    self._edit_MoveTime:SetText("5.000")
    editTime = 5
  end
  local moveTime = editTime * 1000 * sign
  elepsedTime = elepsedTime + moveTime
  if elepsedTime < 0 then
    elepsedTime = 0
  end
  if elepsedTime > self._replayLength then
    elepsedTime = self._replayLength
  end
  self._roundTime:SetText(convertMilliSecondsToClockTime(elepsedTime) .. "/" .. convertMilliSecondsToClockTime(self._replayLength))
  self._playBar:SetControlPos(elepsedTime / self._replayLength * 100)
  ToClient_ReadyReplayUseTime(self._playBar:GetControlPos())
  PaGlobalFunc_Arsha_Replay_Party_All_clearIsFinish()
  if isPause == true then
    self._currentTime = elepsedTime
  else
    ArshaReplayWidget_PlayReplay()
  end
end
function ArshaReplayWidget_PlayOrPauseReplay(isHotKey)
  local self = arshaReplayWidget
  if nil ~= isHotKey then
    if true == self._playCheckBox:IsCheck() then
      self._playCheckBox:SetCheck(false)
    else
      self._playCheckBox:SetCheck(true)
    end
  end
  if true == self._playCheckBox:IsCheck() then
    ArshaReplayWidget_PlayReplay()
  else
    ArshaReplayWidget_PauseReplay()
  end
end
function ArshaReplayWidget_PlayReplay()
  local self = arshaReplayWidget
  self._playCheckBox:SetCheck(true)
  ToClient_PlayReplay(false)
end
function ArshaReplayWidget_PauseReplay()
  local self = arshaReplayWidget
  self._playCheckBox:SetCheck(false)
  ToClient_PauseReplay()
end
function ArshaReplayWidget_StopReplay()
  local self = arshaReplayWidget
  self._roundTime:SetText("00:00:00/" .. convertMilliSecondsToClockTime(self._replayLength))
  self._playCheckBox:SetCheck(false)
  self._playBar:SetControlPos(0)
  ToClient_StopReplay()
end
function ArshaReplayWidget_LoadReplay(replayLength)
  if ToClient_IsInstanceContentsReplay() == true or ToClient_IsMirrorFieldContentsReplay() == true then
    return
  end
  local self = arshaReplayWidget
  local prevReplayLength = self._replayLength
  self._replayLength = Uint64toUint32(replayLength)
  if 0 == prevReplayLength then
    self._playBar:SetControlPos(0)
    self._roundTime:SetText("00:00:00/" .. convertMilliSecondsToClockTime(self._replayLength))
  else
    local elepsedTimePercent = self._currentTime / Uint64toUint32(replayLength / toUint64(0, 1000)) * 100
    self._playBar:SetControlPos(elepsedTimePercent)
    self._roundTime:SetText(convertMilliSecondsToClockTime(self._currentTime) .. "/" .. convertMilliSecondsToClockTime(self._replayLength))
  end
  if false == self._isFinishLoadReplay then
    if false == ToClient_IsProductionReplay() then
      Panel_Arsha_Replay_All:SetShow(true)
      PaGlobalFunc_Arsha_Replay_Party_All_clearIsFinish()
    end
    self._isFinishLoadReplay = true
  end
  FromClient_ChangeReplayCamMode(0)
  ToClient_requestSyncUser(true, false, false)
end
function ArshaReplayWidget_EndReplay()
  if ToClient_IsInstanceContentsReplay() == true or ToClient_IsMirrorFieldContentsReplay() == true then
    return
  end
  local self = arshaReplayWidget
  self._isFinishLoadReplay = false
  PaGlobalFunc_MainStatus_UpdateHP()
  PaGlobalFunc_MainStatus_UpdateMP()
  Panel_Arsha_Replay_All:SetShow(false)
  self._replayLength = 0
  self._roundTime:SetText("00:00:00/" .. convertMilliSecondsToClockTime(self._replayLength))
  self._playCheckBox:SetCheck(false)
  self._playBar:SetControlPos(0)
  self._currentTime = 0
  ArshaReplayWidgetClearHpColorIndex()
end
function ArshaReplayWidget_SetReplayProgressBar(elepsedTimePercent)
  if ToClient_IsInstanceContentsReplay() == true or ToClient_IsMirrorFieldContentsReplay() == true then
    return
  end
  local self = arshaReplayWidget
  if nil == self._replayLength then
    return
  end
  local elepsedTime = math.ceil(self._replayLength * elepsedTimePercent / 100)
  self._currentTime = elepsedTime
  self._roundTime:SetText(convertMilliSecondsToClockTime(elepsedTime) .. "/" .. convertMilliSecondsToClockTime(self._replayLength))
  self._playBar:SetControlPos(elepsedTimePercent)
end
function ArshaReplayWidget_SetChangePlayButton()
  if ToClient_IsInstanceContentsReplay() == true or ToClient_IsMirrorFieldContentsReplay() == true then
    return
  end
  local self = arshaReplayWidget
  self._playCheckBox:SetCheck(true)
end
function ArshaReplayWidget_OffNotReplayUI()
  if ToClient_IsInstanceContentsReplay() == true or ToClient_IsMirrorFieldContentsReplay() == true then
    return
  end
  if true == ToClient_IsProductionReplay() then
    return
  end
  local self = arshaReplayWidget
  PaGlobal_Prepare_Replay()
  PaGlobal_UIModify:applyDefaultSet(false, true)
  Panel_QuickSlot:SetShow(false)
  Panel_PvpMode:SetShow(false)
  Panel_Adrenallin:SetShow(false)
  Panel_MainStatus_User_Bar:SetShow(false)
  Panel_MainStatus_Remaster:SetShow(false)
  self._playCheckBox:SetCheck(false)
  PaGlobal_Menu_Remake:prepareClose()
  Panel_Menu_Close()
  if ToClient_IsAbusingReplay() == false then
    setRenderCrossHair(false)
  end
  SetUIMode(Defines.UIMode.eUIMode_Arsha_Replay)
  Panel_CommandGuide:SetShow(false)
  Panel_Stamina_HideAni()
  Panel_ClassResource_SetShow(false)
  Panel_Radar_NightAlert:SetShow(false)
  PaGlobalFunc_UseTab_Show(0, false)
  PaGlobalFunc_UseTab_Show(1, false)
  PaGlobalFunc_UseTab_Show(2, false)
  PaGlobalFunc_Arsha_Party_All_Close()
  local selfPlayer = getSelfPlayer()
  local selfActorKeyRaw = selfPlayer:getActorKey()
  if true == selfPlayer:isPartyMemberActorKey(selfActorKeyRaw) then
    if true == _ContentsGroup_NewUI_PartyWidget_All then
      Panel_Widget_Party_All:SetShow(false)
    else
      Panel_Widget_Party:SetShow(false)
    end
  end
  PaGlobalFunc_Arsha_Hud_All_setReplayMode(true)
  if nil ~= Panel_SkillCooltime then
    Panel_SkillCooltime:SetShow(false)
  end
  Panel_CashShopAlert:ActiveMouseEventEffect(false)
  Panel_CashShopAlert:setGlassBackground(false)
  Panel_CashShopAlert:SetShow(false)
  Panel_CommonGameScreenUI:SetShow(false)
  setSelfPlayerOnlyEffect(false)
end
function ArshaReplayWidget_OnNotReplayUI()
  if ToClient_IsInstanceContentsReplay() == true or ToClient_IsMirrorFieldContentsReplay() == true then
    return
  end
  if true == ToClient_IsProductionReplay() then
    return
  end
  local self = arshaReplayWidget
  self._replayLength = 0
  self._roundTime:SetText("00:00:00/" .. convertMilliSecondsToClockTime(self._replayLength))
  self._playCheckBox:SetCheck(false)
  self._playBar:SetControlPos(0)
  self._currentTime = 0
  Panel_QuickSlot:SetShow(true)
  setRenderCrossHair(true)
  SetUIMode(Defines.UIMode.eUIMode_Default)
  Panel_ClassResource_SetShow(true)
  PaGlobalFunc_Arsha_Party_All_Open()
  HandleEventLUp_ApplyPresetInfo(3, false)
  local selfPlayer = getSelfPlayer()
  local selfActorKeyRaw = selfPlayer:getActorKey()
  if true == selfPlayer:isPartyMemberActorKey(selfActorKeyRaw) then
    if true == _ContentsGroup_NewUI_PartyWidget_All then
      Panel_Widget_Party_All:SetShow(true)
    else
      Panel_Widget_Party:SetShow(true)
    end
  end
  PaGlobalFunc_Arsha_Replay_Party_All_Close()
  PaGlobalFunc_Arsha_Hud_All_setReplayMode(false)
  if nil ~= Panel_SkillCooltime then
    Panel_SkillCooltime:SetShow(true)
  end
  Panel_CashShopAlert:ActiveMouseEventEffect(true)
  Panel_CashShopAlert:setGlassBackground(true)
  Panel_CashShopAlert:SetShow(false)
  Panel_CommonGameScreenUI:SetShow(true)
  PaGlobal_Menu_Remake:prepareClose()
end
function ArshaReplayWidget_SetReplayRate(replayRate)
  if ToClient_IsInstanceContentsReplay() == true or ToClient_IsMirrorFieldContentsReplay() == true then
    return
  end
  local self = arshaReplayWidget
  self._replayRateText:SetText("X " .. string.format("%.2f", replayRate))
end
function ArshaReplayWidget_SetHpUI(isOnUI)
  if ToClient_IsInstanceContentsReplay() == true or ToClient_IsMirrorFieldContentsReplay() == true then
    return
  end
end
function ArshaReplayWidget_ClearBookmark()
  if ToClient_IsInstanceContentsReplay() == true or ToClient_IsMirrorFieldContentsReplay() == true then
    return
  end
  local self = arshaReplayWidget
  while 0 < self._bookmarkList:length() do
    local bookmark = self._bookmarkList:pop_back()
    bookmark:SetShow(false)
    self._bookmarkPool:push_back(bookmark)
  end
  self._bookmarkTimeList = Array.new()
  self._bookmarkActorKeyList = Array.new()
end
function ArshaReplayWidget_SetBookmark(bookmarkPercent, actorKeyRaw)
  if ToClient_IsInstanceContentsReplay() == true or ToClient_IsMirrorFieldContentsReplay() == true then
    return
  end
  local self = arshaReplayWidget
  local barButtonSize = arshaReplayWidget._progressBarButton:GetSizeX()
  local startPos = self._playBar:GetPosX() + barButtonSize / 2
  local addPos = (self._playBar:GetSizeX() - barButtonSize) * bookmarkPercent
  local bookmark = ArshaReplayWidget_GetBookMark()
  bookmark:SetSize(self._bookmarkBase:GetSizeX(), self._bookmarkBase:GetSizeY())
  bookmark:SetPosX(startPos + addPos - self._bookmarkBase:GetSizeX() / 2)
  bookmark:SetShow(true)
  bookmark:addInputEvent("Mouse_LUp", "ArshaReplayWidget_PlayBookMark(" .. bookmarkPercent .. "," .. actorKeyRaw .. ")")
  bookmark:SetText(tostring(self._bookmarkList:length()))
  self._bookmarkTimeList:push_back(bookmarkPercent)
  self._bookmarkActorKeyList:push_back(actorKeyRaw)
end
function ArshaReplayWidget_PlayBookMark(bookmarkTime, actorKeyRaw)
  local self = arshaReplayWidget
  local isPause = ToClient_IsPauseReplay()
  ToClient_ReadyReplayUseTime(bookmarkTime)
  ToClient_AttachBookmarkActor(actorKeyRaw)
  PaGlobalFunc_Arsha_Replay_Party_All_clearIsFinish()
  self._currentTime = self._replayLength * bookmarkTime
  if isPause == true then
    self._roundTime:SetText(convertMilliSecondsToClockTime(self._replayLength * bookmarkTime) .. "/" .. convertMilliSecondsToClockTime(self._replayLength))
    self._playBar:SetControlPos(bookmarkTime * 100)
  else
    ToClient_PlayReplay(false)
  end
end
function ArshaReplayWidget_PlayBookMarkHotKey(bookmarkIndex)
  local self = arshaReplayWidget
  if bookmarkIndex > self._bookmarkTimeList:length() then
    return
  end
  ArshaReplayWidget_PlayBookMark(self._bookmarkTimeList[bookmarkIndex], self._bookmarkActorKeyList[bookmarkIndex])
end
function ArshaReplayWidget_GetBookMark()
  local self = arshaReplayWidget
  local bookmark
  if 0 < self._bookmarkPool:length() then
    bookmark = self._bookmarkPool:pop_back()
  else
    bookmark = ArshaReplayWidget_CreateNewBookmark()
  end
  self._bookmarkList:push_back(bookmark)
  return bookmark
end
function ArshaReplayWidget_CreateNewBookmark()
  local self = arshaReplayWidget
  local bookmark = UI.createControl(__ePAUIControl_StaticText, self._replayArea, "Bookmark" .. tostring(self._bookmarkCount))
  self._bookmarkCount = self._bookmarkCount + 1
  CopyBaseProperty(self._bookmarkBase, bookmark)
  bookmark:SetSize(self._bookmarkBase:GetSizeX(), self._bookmarkBase:GetSizeY())
  bookmark:SetPosX(self._bookmarkBase:GetPosX())
  bookmark:SetShow(true)
  return bookmark
end
function ArshaReplayWidget_ToggleShowReplayUI()
  if true == arshaReplayWidget._replayArea:GetShow() or false == ToClient_IsPlayingReplay() then
    arshaReplayWidget._replayArea:SetShow(false)
  else
    arshaReplayWidget._replayArea:SetShow(true)
  end
end
function ArshaReplayWidget_SetReplayState(replayState)
  if ToClient_IsInstanceContentsReplay() == true or ToClient_IsMirrorFieldContentsReplay() == true then
    return
  end
  local self = arshaReplayWidget
  if ReplayState_Type.STOP_RECORDING == replayState then
    self._replayState:SetText("Stop Recording")
  else
    self._replayState:SetText("Recording")
  end
end
function ArshaReplayWidgetClearHpColorIndex()
  ReplayHpIndexTable = Array.new()
  for i = 1, 5 do
    ReplayHpIndexTable[i] = 0
  end
end
function PaGlobalFunc_Arsha_Party_All_Get_Hp_Color_Index(teamNo)
  for i = 1, 5 do
    if 0 == ReplayHpIndexTable[i] or teamNo == ReplayHpIndexTable[i] then
      ReplayHpIndexTable[i] = teamNo
      return i
    end
  end
  return 5
end
function ArshaReplayWidget_EditBoxToggle()
  if nil == Panel_Arsha_Replay_All then
    return
  end
  if nil == arshaReplayWidget then
    return
  end
  self = arshaReplayWidget
  self._camDistEditBox:SetEditText("")
end
function ArshaReplayWidget_ConfirmEditBox()
  if nil == Panel_Arsha_Replay_All then
    return
  end
  if nil == arshaReplayWidget then
    return
  end
  ClearFocusEdit()
  self = arshaReplayWidget
  local timeString = self._camDistEditBox:GetText()
  self._camDistEditBox:SetEditText(timeString)
  local dist = tonumber(timeString)
  if dist == nil then
    dist = 1000
  end
  ToClient_setCamDistFromCharacterForReplay(dist)
  ArshaReplayWidget_CloseCamDistEditBox()
end
function ArshaReplayWidget_SetCamDistText(camDist)
  if ToClient_IsInstanceContentsReplay() == true or ToClient_IsMirrorFieldContentsReplay() == true then
    return
  end
  if nil == Panel_Arsha_Replay_All then
    return
  end
  if nil == arshaReplayWidget then
    return
  end
  self = arshaReplayWidget
  if self._camDistEditBox:GetFocusEdit() == false then
    self._camDistEditBox:SetText(tostring(camDist))
  end
end
function ArshaReplayWidget_OpenCamDistEditBox()
end
function ArshaReplayWidget_CloseCamDistEditBox()
end
function ArshaReplayWidget_SyncPlay()
  if ToClient_IsInstanceContentsReplay() == true or ToClient_IsMirrorFieldContentsReplay() == true then
    return
  end
  if Panel_Arsha_Replay_All == nil then
    return
  end
  if arshaReplayWidget == nil then
    return
  end
  local self = arshaReplayWidget
  self._playCheckBox:SetCheck(true)
  PaGlobalFunc_Arsha_Replay_Party_All_clearIsFinish()
  ArshaReplayWidget_PlayReplay()
end
function ArshaReplayWidget_ClickIsSyncMaster()
  local self = arshaReplayWidget
  if self._chk_isSyncMaster:IsCheck() == true then
    self._chk_isSyncMaster:SetCheck(false)
    ToClient_requestSyncUser(true, true, false)
  else
    ToClient_requestSyncUser(false, true, false)
  end
end
function ArshaReplayWidget_ClickIsSyncRecive()
  local self = arshaReplayWidget
  if self._chk_isSyncRecive:IsCheck() == true then
    self._chk_isSyncRecive:SetCheck(false)
    ToClient_requestSyncUser(true, false, false)
  else
    ToClient_requestSyncUser(false, false, false)
  end
end
function ArshaReplayWidget_SetReplayTime(startTime)
  if ToClient_IsInstanceContentsReplay() == true or ToClient_IsMirrorFieldContentsReplay() == true then
    return
  end
  ToClient_ReadyReplay(startTime, 0)
  PaGlobalFunc_Arsha_Replay_Party_All_clearIsFinish()
  local self = arshaReplayWidget
  self._playCheckBox:SetCheck(false)
  startTime = Uint64toUint32(startTime)
  self._roundTime:SetText(convertMilliSecondsToClockTime(startTime) .. "/" .. convertMilliSecondsToClockTime(self._replayLength))
  if self._replayLength ~= 0 and startTime < self._replayLength then
    self._playBar:SetControlPos(startTime / self._replayLength * 100)
  end
  ToClient_PlayReplay(true)
end
function ArshaReplayWidget_ClickSetTimer()
  local self = arshaReplayWidget
  self._edit_setTimer:SetMaxInput(5)
  self._edit_setTimer:SetEditText("00:00")
  self._edit_setTimer:SetText("00:00")
  arshaReplayWidget._editCount = 0
end
function ArshaReplayWidget_ReturnKeyEventSetTimer()
  local self = arshaReplayWidget
  local result = string.split(self._edit_setTimer:GetText(), ":")
  ClearFocusEdit()
  if #result ~= 2 then
    return
  end
  local startTime = tonumber(result[1]) * 60000 + tonumber(result[2]) * 1000
  self._currentTime = startTime
  ArshaReplayWidget_SetReplayTime(startTime)
end
function ArshaReplayWidget_ReturnKeyEventMoveTime()
  ClearFocusEdit()
end
function ArshaReplayWidget_CheckSyncMaster(isSyncMaster)
  if ToClient_IsInstanceContentsReplay() == true or ToClient_IsMirrorFieldContentsReplay() == true then
    return
  end
  arshaReplayWidget._btn_Sync:SetShow(isSyncMaster)
  arshaReplayWidget._btn_SyncPlay:SetShow(isSyncMaster)
  arshaReplayWidget._chk_isSyncMaster:SetCheck(isSyncMaster)
end
function ArshaReplayWidget_CheckSyncRecive(isSyncRecive)
  if ToClient_IsInstanceContentsReplay() == true or ToClient_IsMirrorFieldContentsReplay() == true then
    return
  end
  arshaReplayWidget._stc_SyncMember:SetShow(isSyncRecive)
  arshaReplayWidget._chk_isSyncRecive:SetCheck(isSyncRecive)
end
function ArshaReplayWidget_SetSyncUserResult(isSuccess, masterName)
  if ToClient_IsInstanceContentsReplay() == true or ToClient_IsMirrorFieldContentsReplay() == true then
    return
  end
  if isSuccess == true then
    return
  end
  local yesFunc = function()
    ToClient_requestSyncUser(true, true, true)
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_REPLAY"),
    content = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_EXIST_SYNCMASTER", "syncMasterName", masterName),
    functionYes = yesFunc,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function ArshaReplayWidget_SetSyncUserList(userList)
  if ToClient_IsInstanceContentsReplay() == true or ToClient_IsMirrorFieldContentsReplay() == true then
    return
  end
  arshaReplayWidget._txt_SyncMember:SetText("SyncMember : " .. userList)
end
function ArshaReplayWidget_SetSyncTime()
  if ToClient_IsPauseReplay() == false then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_REPLAY"),
      content = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_ONLY_PAUSE"),
      functionYes = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  ToClient_SetSyncTime()
end
function ArshaReplayWidget_RequestSyncPlay()
  if ToClient_IsPauseReplay() == false then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_REPLAY"),
      content = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_ONLY_PAUSE"),
      functionYes = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  ToClient_PlaySync()
end
function ArshaReplayWidget_KeyEventSetTimer()
  local self = arshaReplayWidget
  local editString = self._edit_setTimer:GetEditText()
  local result = string.split(editString, ":")
  local timeString = result[1] .. result[2]
  local resultStr = ""
  if isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_BACK) == true then
    if self._editCount <= 0 then
      editString = editString .. "0"
      self._edit_setTimer:SetEditText(editString)
      self._edit_setTimer:SetText(editString)
      return
    end
    timeString = "0" .. timeString
    timeString = string.sub(timeString, 1, 2) .. ":" .. string.sub(timeString, 3, 4)
    self._edit_setTimer:SetEditText(timeString)
    self._edit_setTimer:SetText(timeString)
    self._editCount = self._editCount - 1
    return
  end
  local changeString = ""
  if isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_0) == true or isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_NUMPAD0) == true then
    changeString = "0"
  elseif isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_1) == true or isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_NUMPAD1) == true then
    changeString = "1"
  elseif isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_2) == true or isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_NUMPAD2) == true then
    changeString = "2"
  elseif isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_3) == true or isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_NUMPAD3) == true then
    changeString = "3"
  elseif isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_4) == true or isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_NUMPAD4) == true then
    changeString = "4"
  elseif isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_5) == true or isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_NUMPAD5) == true then
    changeString = "5"
  elseif isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_6) == true or isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_NUMPAD6) == true then
    changeString = "6"
  elseif isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_7) == true or isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_NUMPAD7) == true then
    changeString = "7"
  elseif isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_8) == true or isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_NUMPAD8) == true then
    changeString = "8"
  elseif isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_9) == true or isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_NUMPAD9) == true then
    changeString = "9"
  end
  if changeString == "" then
    return
  end
  if self._editCount == 4 then
    return
  end
  for ii = 2, 4 do
    resultStr = resultStr .. string.sub(timeString, ii, ii)
  end
  resultStr = resultStr .. changeString
  resultStr = string.sub(resultStr, 1, 2) .. ":" .. string.sub(resultStr, 3, 4)
  self._edit_setTimer:SetEditText(resultStr)
  self._edit_setTimer:SetText(resultStr)
  self._editCount = self._editCount + 1
end
function ArshaReplayWidget_KeyEventMoveTime()
  if isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_RETURN) == true then
    return
  end
  if isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_BACK) == true then
    return
  end
  local self = arshaReplayWidget
  local editString = self._edit_MoveTime:GetEditText()
  editString = string.sub(editString, 1, string.len(editString) - 1)
  local changeString = ""
  if isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_0) == true or isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_NUMPAD0) == true then
    changeString = "0"
  elseif isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_1) == true or isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_NUMPAD1) == true then
    changeString = "1"
  elseif isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_2) == true or isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_NUMPAD2) == true then
    changeString = "2"
  elseif isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_3) == true or isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_NUMPAD3) == true then
    changeString = "3"
  elseif isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_4) == true or isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_NUMPAD4) == true then
    changeString = "4"
  elseif isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_5) == true or isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_NUMPAD5) == true then
    changeString = "5"
  elseif isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_6) == true or isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_NUMPAD6) == true then
    changeString = "6"
  elseif isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_7) == true or isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_NUMPAD7) == true then
    changeString = "7"
  elseif isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_8) == true or isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_NUMPAD8) == true then
    changeString = "8"
  elseif isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_9) == true or isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_NUMPAD9) == true then
    changeString = "9"
  elseif isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_OEM_PERIOD) == true or isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_OEM_NUMPADPERIOD) == true then
    changeString = "."
  end
  if changeString == "" then
    self._edit_MoveTime:SetEditText(editString)
    self._edit_MoveTime:SetText(editString)
    return
  end
  local resultStr = editString .. changeString
  self._edit_MoveTime:SetEditText(resultStr)
  self._edit_MoveTime:SetText(resultStr)
end
function ArshaReplayWidget_ClickMoveTime()
  local self = arshaReplayWidget
  self._edit_MoveTime:SetText("")
  self._edit_MoveTime:SetEditText("")
end
function ArshaReplayWidget_UpdateSpeedBuffAndPenalty(actorKeyRaw)
  if ToClient_IsInstanceContentsReplay() == true or ToClient_IsMirrorFieldContentsReplay() == true then
    return
  end
  local playerActorProxyWrapper = getPlayerActor(actorKeyRaw)
  if playerActorProxyWrapper == nil then
    arshaReplayWidget._txt_SpeedBuff:SetShow(false)
    arshaReplayWidget._txt_SpeedBuffDetail:SetShow(false)
    arshaReplayWidget._txt_CamMode:SetShow(false)
    return
  end
  arshaReplayWidget._txt_SpeedBuff:SetShow(true)
  arshaReplayWidget._txt_SpeedBuffDetail:SetShow(true)
  arshaReplayWidget._txt_CamMode:SetShow(true)
  local moveSpeedString = PAGetString(Defines.StringSheet_GAME, "LUA_POTENCIAL_KIND_3")
  local attackSepedString = PAGetString(Defines.StringSheet_GAME, "LUA_POTENCIAL_KIND_1")
  local castSpeedString = PAGetString(Defines.StringSheet_GAME, "LUA_POTENCIAL_KIND_2")
  local buffString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_REPLAYCONTROLLER_BUFF")
  local debuffString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_REPLAYCONTROLLER_DEBUFF")
  local str = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_REPLAYCONTROLLER_CHECK_DATA") .. "\n"
  str = str .. moveSpeedString .. " : " .. playerActorProxyWrapper:get():getSpeedCheckRateByType(0) / 10000 .. "%\n"
  str = str .. attackSepedString .. " : " .. playerActorProxyWrapper:get():getSpeedCheckRateByType(1) / 10000 .. "%\n"
  str = str .. castSpeedString .. " : " .. playerActorProxyWrapper:get():getSpeedCheckRateByType(2) / 10000 .. [[
%

]]
  str = str .. buffString .. "\n"
  str = str .. moveSpeedString .. " : " .. playerActorProxyWrapper:get():getSpeedRateBuffByType(0) / 10000 .. "%\n"
  str = str .. attackSepedString .. " : " .. playerActorProxyWrapper:get():getSpeedRateBuffByType(1) / 10000 .. "%\n"
  str = str .. castSpeedString .. " : " .. playerActorProxyWrapper:get():getSpeedRateBuffByType(2) / 10000 .. [[
%

]]
  str = str .. debuffString .. "\n"
  str = str .. moveSpeedString .. " : " .. playerActorProxyWrapper:get():getSpeedRatePenaltyByType(0) / 10000 .. "%\n"
  str = str .. attackSepedString .. " : " .. playerActorProxyWrapper:get():getSpeedRatePenaltyByType(1) / 10000 .. "%\n"
  str = str .. castSpeedString .. " : " .. playerActorProxyWrapper:get():getSpeedRatePenaltyByType(2) / 10000 .. [[
%

]]
  arshaReplayWidget._txt_SpeedBuff:SetText(str)
  arshaReplayWidget._txt_SpeedBuffDetail:SetText(ToClient_ClacSpeedRate(actorKeyRaw))
end
function FromClient_ChangeReplayCamMode(camType)
  if ToClient_IsInstanceContentsReplay() == true or ToClient_IsMirrorFieldContentsReplay() == true then
    return
  end
  local curCamModeStr = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_REPLAYCONTROLLER_CURRENT_CAM_MODE")
  local basicCamModeStr = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_REPLAYCONTROLLER_BASIC_CAM_MODE")
  local characterCamModeStr = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_REPLAYCONTROLLER_CHARACTER_CAM_MODE")
  local freeCamModeStr = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_REPLAYCONTROLLER_FREE_CAM_MODE")
  local freeCamModeEndStr = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_REPLAYCONTROLLER_END_FREE_CAM_MODE")
  local fixedCamModeStr = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_REPLAYCONTROLLER_FIXED_CAM_MODE")
  local recordCamModeStr = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_REPLAYCONTROLLER_RECORD_CAM_MODE")
  if camType == 0 then
    arshaReplayWidget._txt_CamMode:SetText(curCamModeStr .. " : " .. basicCamModeStr .. [[


F9 : ]] .. freeCamModeStr .. " / F10 : " .. characterCamModeStr)
  elseif camType == 1 then
    arshaReplayWidget._txt_CamMode:SetText(curCamModeStr .. " : " .. characterCamModeStr .. [[


F7 : ]] .. basicCamModeStr .. " / F8 : " .. fixedCamModeStr)
  elseif camType == 2 then
    arshaReplayWidget._txt_CamMode:SetText(curCamModeStr .. " : " .. fixedCamModeStr .. [[


F7 : ]] .. basicCamModeStr .. " / F8 : " .. recordCamModeStr)
  elseif camType == 3 then
    arshaReplayWidget._txt_CamMode:SetText(curCamModeStr .. " : " .. recordCamModeStr .. [[


F7 : ]] .. basicCamModeStr .. " / F8 : " .. characterCamModeStr)
  elseif camType == 4 then
    arshaReplayWidget._txt_CamMode:SetText(curCamModeStr .. " : " .. freeCamModeStr .. [[


F9 : ]] .. freeCamModeEndStr)
  end
end
function ArshaReplayWidget_MakeActionLogPool()
  local self = arshaReplayWidget
  if self._actionLogPool ~= nil then
    return
  end
  self._actionLogPool = Array.new()
  for index = 1, self._actionLogPoolCount do
    local controlId = "Static_ActionLog_" .. tostring(index)
    local newControl = UI.cloneControl(self._stc_actionLogTeamplate, self._frmContent_actionLog, controlId)
    if newControl == nil then
      UI.ASSERT_NAME(false, "\236\136\152\236\160\149\236\157\180 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164. \235\176\156\236\131\157\236\139\156 \236\160\156\235\179\180 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\236\157\180\236\162\133\234\177\180")
      return
    end
    local actionLogData = {
      _control = newControl,
      _txt_actionLogTime = UI.getChildControl(newControl, "StaticText_ActionTime"),
      _txt_actionLog = UI.getChildControl(newControl, "StaticText_ActionName"),
      _posIndex = nil
    }
    actionLogData._control:SetShow(false)
    actionLogData._control:SetSpanSize(0, 10)
    actionLogData._control:ComputePos()
    self._actionLogPool:push_back(actionLogData)
  end
  self._accumulatedActionLogAddCount = 0
end
function ArshaReplayWidget_resetActionLog()
  local self = arshaReplayWidget
  if self._actionLogPool == nil then
    return
  end
  for index = 1, self._actionLogPoolCount do
    local actionLogData = self._actionLogPool[index]
    if actionLogData ~= nil then
      actionLogData._control:SetShow(false)
      actionLogData._posIndex = nil
    end
  end
  self._accumulatedActionLogAddCount = 0
  self._stc_frameVScroll:SetShow(false)
  self._stc_frameVScroll:SetControlPos(1)
  self._frm_actionLog:UpdateContentPos()
end
function ArshaReplayWidget_addActionLogData(time, actionName)
  local self = arshaReplayWidget
  if self._actionLogPool == nil then
    return
  end
  local getIndex = self._accumulatedActionLogAddCount % self._actionLogPoolCount + 1
  local getData = self._actionLogPool[getIndex]
  if getData == nil then
    UI.ASSERT_NAME(false, "\235\185\132\236\160\149\236\131\129\236\157\180\235\139\164. getData \236\176\190\236\157\132 \236\136\152 \236\151\134\236\150\180 addDamageData \236\178\152\235\166\172\236\151\144 \236\139\164\237\140\168\237\150\136\235\139\164.", "\236\157\180\236\162\133\234\177\180")
    return
  end
  getData._control:SetShow(true)
  getData._posIndex = self._actionLogPoolCount
  getData._txt_actionLogTime:SetText(string.format("%.3f", time) .. "second")
  getData._txt_actionLogTime:SetSize(getData._txt_actionLogTime:GetTextSizeX() + 5, getData._txt_actionLogTime:GetSizeY())
  getData._txt_actionLog:SetText(actionName)
  getData._txt_actionLog:SetSize(getData._txt_actionLog:GetTextSizeX() + 10, getData._txt_actionLog:GetSizeY())
  local sizeY = getData._control:GetSizeY()
  local termY = 5
  local contentSizeY = 0
  local highestSpanY = -1
  local currentScrollPos = self._stc_frameVScroll:GetControlPos()
  for index = self._actionLogPoolCount, 1, -1 do
    local actionLogData = self._actionLogPool[index]
    if actionLogData ~= nil and actionLogData._control:GetShow() == true then
      actionLogData._posIndex = actionLogData._posIndex - 1
      if self._actionLogPoolCount < actionLogData._posIndex then
        actionLogData._posIndex = actionLogData._posIndex % self._actionLogPoolCount
      end
      local spanX = actionLogData._control:GetSpanSize().x
      local spanY = sizeY * (actionLogData._posIndex + 1) + termY * actionLogData._posIndex
      actionLogData._control:SetSpanSize(spanX, spanY)
      if highestSpanY < spanY then
        highestSpanY = spanY
      end
    end
  end
  self._frmContent_actionLog:SetSize(self._frmContent_actionLog:GetSizeX(), highestSpanY + sizeY + termY)
  self._frmContent_actionLog:ComputePosAllChild()
  if self._frm_actionLog:GetSizeY() < self._frmContent_actionLog:GetSizeY() then
    self._stc_frameVScroll:SetShow(true)
  else
    self._stc_frameVScroll:SetShow(false)
  end
  self._stc_frameVScroll:SetControlPos(currentScrollPos)
  self._frm_actionLog:UpdateContentPos()
  self._accumulatedActionLogAddCount = self._accumulatedActionLogAddCount + 1
end
function FromClient_UpdateReplayAbusingActionLog(actorKeyRaw, time, actionName)
  if ToClient_IsInstanceContentsReplay() == true or ToClient_IsMirrorFieldContentsReplay() == true then
    return
  end
  local playerActorProxyWrapper = getPlayerActor(actorKeyRaw)
  if playerActorProxyWrapper == nil then
    ArshaReplayWidget_resetActionLog()
    return
  end
  ArshaReplayWidget_addActionLogData(time, actionName)
end
ArshaReplayWidget_Init()
registerEvent("FromClient_LoadReplay", "ArshaReplayWidget_LoadReplay")
registerEvent("FromClient_EndReplay", "ArshaReplayWidget_EndReplay")
registerEvent("FromClient_SetReplayProgressBar", "ArshaReplayWidget_SetReplayProgressBar")
registerEvent("FromClient_SetChangePlayButton", "ArshaReplayWidget_SetChangePlayButton")
registerEvent("FromClient_OffNotReplayUI", "ArshaReplayWidget_OffNotReplayUI")
registerEvent("FromClient_OnNotReplayUI", "ArshaReplayWidget_OnNotReplayUI")
registerEvent("FromClient_SetReplayRate", "ArshaReplayWidget_SetReplayRate")
registerEvent("FromClient_SetHpUI", "ArshaReplayWidget_SetHpUI")
registerEvent("FromClient_ClearBookmark", "ArshaReplayWidget_ClearBookmark")
registerEvent("FromClient_SetBookmark", "ArshaReplayWidget_SetBookmark")
registerEvent("FromClient_SetReplayName", "ArshaReplayWidget_SetReplayName")
registerEvent("FromClient_SetReplayState", "ArshaReplayWidget_SetReplayState")
registerEvent("FromClient_SetCamDistFromCharacter", "ArshaReplayWidget_SetCamDistText")
registerEvent("FromClient_SyncPlay", "ArshaReplayWidget_SyncPlay")
registerEvent("FromClient_SetReplayTime", "ArshaReplayWidget_SetReplayTime")
registerEvent("FromClient_AddSyncUserReustlt", "ArshaReplayWidget_SetSyncUserResult")
registerEvent("FromClient_SetSyncUserList", "ArshaReplayWidget_SetSyncUserList")
registerEvent("FromClient_CheckSyncMaster", "ArshaReplayWidget_CheckSyncMaster")
registerEvent("FromClient_CheckSyncRecive", "ArshaReplayWidget_CheckSyncRecive")
registerEvent("FromClient_UpdateSpeedBuffAndPenalty", "ArshaReplayWidget_UpdateSpeedBuffAndPenalty")
registerEvent("FromClient_ChangeReplayCamMode", "FromClient_ChangeReplayCamMode")
registerEvent("FromClient_UpdateReplayAbusingActionLog", "FromClient_UpdateReplayAbusingActionLog")
