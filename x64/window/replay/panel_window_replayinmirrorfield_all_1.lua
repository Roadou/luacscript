function PaGlobal_ReplayControllerInMirrorField:initialize()
  if self._initialize == true then
    return
  end
  self._ui._stc_replayControllerBg = UI.getChildControl(Panel_Window_ReplayInMirrorField_All, "Static_ReplayController")
  self._ui._stc_timeLineBar = UI.getChildControl(self._ui._stc_replayControllerBg, "Slider_Playbar")
  self._ui._btn_timeLine = UI.getChildControl(self._ui._stc_timeLineBar, "Slider_1_Button")
  self._ui._btn_timeLineEventTemplate = UI.getChildControl(self._ui._stc_replayControllerBg, "Button_TimeLineEvent_Template")
  self._ui._btn_timeLineEventTemplate:SetShow(false)
  self._ui._btn_left = UI.getChildControl(self._ui._stc_replayControllerBg, "Button_Left")
  self._ui._btn_right = UI.getChildControl(self._ui._stc_replayControllerBg, "Button_Right")
  self._ui._cbx_play = UI.getChildControl(self._ui._stc_replayControllerBg, "Checkbox_Play")
  self._ui._btn_stop = UI.getChildControl(self._ui._stc_replayControllerBg, "Button_Stop")
  self._ui._txt_replayName = UI.getChildControl(self._ui._stc_replayControllerBg, "StaticText_ReplayName")
  self._ui._txt_replayName:SetShow(ToClient_IsDevelopment() == true)
  self._ui._txt_replayTime = UI.getChildControl(self._ui._stc_replayControllerBg, "StaticText_ReplayTime")
  self._ui._stc_commandBg = UI.getChildControl(Panel_Window_ReplayInMirrorField_All, "Static_CommandBG")
  local stc_command_P = UI.getChildControl(self._ui._stc_commandBg, "StaticText_Key_P")
  local stc_command_BACK = UI.getChildControl(self._ui._stc_commandBg, "StaticText_Key_Back")
  local stc_command_FRONT = UI.getChildControl(self._ui._stc_commandBg, "StaticText_Key_Front")
  local stc_command_F9 = UI.getChildControl(self._ui._stc_commandBg, "StaticText_Key_F9")
  local stc_command_F10 = UI.getChildControl(self._ui._stc_commandBg, "StaticText_Key_F10")
  local stc_command_ESC = UI.getChildControl(self._ui._stc_commandBg, "StaticText_Key_ESC")
  local txt_command_P = UI.getChildControl(self._ui._stc_commandBg, "StaticText_PlayOrPause")
  local txt_command_BACK = UI.getChildControl(self._ui._stc_commandBg, "StaticText_MoveBack")
  local txt_command_FRONT = UI.getChildControl(self._ui._stc_commandBg, "StaticText_MoveFront")
  local txt_command_F9 = UI.getChildControl(self._ui._stc_commandBg, "StaticText_ChangeCam")
  local txt_command_F10 = UI.getChildControl(self._ui._stc_commandBg, "StaticText_RecordCam")
  local txt_command_ESC = UI.getChildControl(self._ui._stc_commandBg, "StaticText_Exit")
  local commandBtnList = Array.new()
  commandBtnList:push_back(stc_command_P)
  commandBtnList:push_back(stc_command_BACK)
  commandBtnList:push_back(stc_command_FRONT)
  commandBtnList:push_back(stc_command_F9)
  commandBtnList:push_back(stc_command_F10)
  commandBtnList:push_back(stc_command_ESC)
  self._commandBtnList = commandBtnList
  local commandTextList = Array.new()
  commandTextList:push_back(txt_command_P)
  commandTextList:push_back(txt_command_BACK)
  commandTextList:push_back(txt_command_FRONT)
  commandTextList:push_back(txt_command_F9)
  commandTextList:push_back(txt_command_F10)
  commandTextList:push_back(txt_command_ESC)
  self._commandTextList = commandTextList
  local commandShow = Array.new()
  commandShow:push_back(true)
  commandShow:push_back(true)
  commandShow:push_back(true)
  commandShow:push_back(true)
  commandShow:push_back(true)
  commandShow:push_back(true)
  self._commandShow = commandShow
  self._prevUIMode = Defines.UIMode.eUIMode_Default
  self._renderMode = RenderModeWrapper.new(99, {
    Defines.RenderMode.eRenderMode_Replay
  }, false)
  self._renderMode:setClosefunctor(nil, PaGloabalFunc_ReplayInMirrorField_Close)
  self:registEventHandler()
  self._initialize = true
  if ToClient_IsPlayingReplay() == true then
    if ToClient_IsSolareReplay() == true then
      FromClient_ReplayInMirrorField_PlaySolareReplay()
    elseif ToClient_IsGuildMatchReplay() == true then
      FromClient_ReplayInMirrorField_PlayGuildMatchReplay()
    elseif ToClient_IsSnowBoardReplay() == true then
      FromClient_ReplayInMirrorField_PlaySnowBoardReplay()
    end
  end
end
function PaGlobal_ReplayControllerInMirrorField:registEventHandler()
  if Panel_Window_ReplayInMirrorField_All == nil then
    return
  end
  self._ui._stc_timeLineBar:addInputEvent("Mouse_LDown", "ReplayInMirrorField_PauseReplay()")
  self._ui._stc_timeLineBar:addInputEvent("Mouse_LUp", "ReplayInMirrorField_ReadyReplayUseTime()")
  self._ui._stc_timeLineBar:SetInterval(1000)
  self._ui._btn_timeLine:addInputEvent("Mouse_LDown", "ReplayInMirrorField_PauseReplay()")
  self._ui._btn_timeLine:addInputEvent("Mouse_LUp", "ReplayInMirrorField_PlayReplay()")
  self._ui._btn_timeLine:addInputEvent("Mouse_LPress", "ReplayInMirrorField_UpdateWhenClickSlideButton()")
  self._ui._btn_left:addInputEvent("Mouse_LUp", "ReplayInMirrorField_ClickRightOrLeftButton(-1)")
  self._ui._btn_right:addInputEvent("Mouse_LUp", "ReplayInMirrorField_ClickRightOrLeftButton(1)")
  self._ui._cbx_play:addInputEvent("Mouse_LUp", "ReplayInMirrorField_PlayOrPauseReplay()")
  self._ui._btn_stop:addInputEvent("Mouse_LUp", "ReplayInMirrorField_ResetReplay()")
  registerEvent("FromClient_PlaySolareReplay", "FromClient_ReplayInMirrorField_PlaySolareReplay")
  registerEvent("FromClient_PlayGuildMatchReplay", "FromClient_ReplayInMirrorField_PlayGuildMatchReplay")
  registerEvent("FromClient_PlaySnowBoardReplay", "FromClient_ReplayInMirrorField_PlaySnowBoardReplay")
  registerEvent("FromClient_LoadReplay", "FromClient_ReplayInMirrorField_LoadReplay")
  registerEvent("FromClient_EndReplay", "FromClient_ReplayInMirrorField_EndReplay")
  registerEvent("FromClient_SetReplayProgressBar", "FromClient_ReplayInMirrorField_SetProgress")
  registerEvent("FromClient_SetChangePlayButton", "FromClient_ReplayInMirrorField_SetChangePlayButton")
  registerEvent("FromClient_SetReplayName", "FromClient_ReplayInMirrorField_SetReplayName")
  registerEvent("FromClient_SetReplayTime", "FromClient_ReplayInMirrorField_SetReplayTime")
  registerEvent("FromClient_PlayReplayInMirrorField", "FromClient_ReplayInMirrorField_PlayReplay")
end
function PaGlobal_ReplayControllerInMirrorField:positionAlign(recordType)
  if Panel_Window_ReplayInMirrorField_All == nil then
    return
  end
  for key, value in pairs(self._commandShow) do
    value = true
  end
  if recordType == __eReplayRecordType_SnowBoard then
    self._commandShow[4] = false
  end
  local yPosGap = 30
  local bgSizeBase = 15
  local bgSize = 15
  local posIndex = 0
  local commandBtnMaxSizeX = 0
  for key, value in pairs(self._commandBtnList) do
    if self._commandShow[key] ~= nil and value ~= nil then
      if self._commandShow[key] == true then
        value:SetShow(true)
        value:SetSpanSize(value:GetSpanSize().x, 10 + yPosGap * posIndex)
        value:ComputePos()
        local valueSizeX = value:GetSizeX()
        if commandBtnMaxSizeX < valueSizeX then
          commandBtnMaxSizeX = valueSizeX
        end
        posIndex = posIndex + 1
      else
        value:SetShow(false)
      end
    end
  end
  posIndex = 0
  local commandTextMaxSizeX = 0
  for key, value in pairs(self._commandTextList) do
    if self._commandShow[key] ~= nil and value ~= nil then
      if self._commandShow[key] == true then
        value:SetShow(true)
        value:SetSpanSize(value:GetSpanSize().x, 11 + yPosGap * posIndex)
        local valueSizeX = value:GetTextSizeX()
        value:SetSize(valueSizeX, value:GetSizeY())
        value:ComputePos()
        if commandTextMaxSizeX < valueSizeX then
          commandTextMaxSizeX = valueSizeX
        end
        posIndex = posIndex + 1
      else
        value:SetShow(false)
      end
    end
  end
  bgSize = bgSizeBase + yPosGap * posIndex
  local guideSpanX = 10
  self._ui._stc_commandBg:SetSize(guideSpanX + commandBtnMaxSizeX + guideSpanX + commandTextMaxSizeX + guideSpanX, bgSize)
  self._ui._stc_commandBg:ComputePos()
end
function PaGlobal_ReplayControllerInMirrorField:prepareOpen(recordType)
  if Panel_Window_ReplayInMirrorField_All == nil then
    return
  end
  if recordType ~= __eReplayRecordType_Solare and recordType ~= __eReplayRecordType_GuildMatch and recordType ~= __eReplayRecordType_SnowBoard then
    return
  end
  self._replayRecordType = recordType
  self:positionAlign(recordType)
  self:setUIMode(true)
  self:setRenderMode(true)
  self:setPanelSizeAndPosition()
  self:setReplayTimeLineEvent(true)
  self:openContentsUI()
  self:open()
end
function PaGlobal_ReplayControllerInMirrorField:open()
  if Panel_Window_ReplayInMirrorField_All == nil then
    return
  end
  Panel_Window_ReplayInMirrorField_All:SetShow(true)
end
function PaGlobal_ReplayControllerInMirrorField:prepareClose()
  if Panel_Window_ReplayInMirrorField_All == nil then
    return
  end
  self:closeContentsUI()
  self:setReplayTimeLineEvent(false)
  self:setUIMode(false)
  self:setRenderMode(false)
  self:clearData()
  self:close()
end
function PaGlobal_ReplayControllerInMirrorField:close()
  if Panel_Window_ReplayInMirrorField_All == nil then
    return
  end
  Panel_Window_ReplayInMirrorField_All:SetShow(false)
end
function PaGlobal_ReplayControllerInMirrorField:clearData()
  if Panel_Window_ReplayInMirrorField_All == nil then
    return
  end
  TooltipSimple_Hide()
  self._replayRecordType = nil
  self._replayLength = 0
  self._currentTime = 0
  self._isFinishLoadReplay = false
  self._ui._stc_timeLineBar:SetControlPos(0)
  self._ui._cbx_play:SetCheck(false)
  self._ui._txt_replayTime:SetText("00:00:00/" .. convertMilliSecondsToClockTime(self._replayLength))
end
function PaGlobal_ReplayControllerInMirrorField:setRenderMode(isSet)
  if Panel_Window_ReplayInMirrorField_All == nil then
    return
  end
  if isSet == true then
    self._renderMode:set()
  else
    self._renderMode:reset()
  end
end
function PaGlobal_ReplayControllerInMirrorField:setUIMode(isSet)
  if Panel_Window_ReplayInMirrorField_All == nil then
    return
  end
  if isSet == true then
    self._prevUIMode = GetUIMode()
    SetUIMode(Defines.UIMode.eUIMode_Replay)
  else
    SetUIMode(self._prevUIMode)
    self._prevUIMode = Defines.UIMode.eUIMode_Default
  end
end
function PaGlobal_ReplayControllerInMirrorField:setPanelSizeAndPosition()
  local panel = Panel_Window_ReplayInMirrorField_All
  if panel == nil then
    return
  end
  local screenX = getScreenSizeX()
  local screenY = getScreenSizeY()
  panel:SetSize(screenX, screenY)
  panel:ComputePos()
  self._ui._stc_commandBg:ComputePos()
  self._ui._stc_replayControllerBg:SetSize(screenX, self._ui._stc_replayControllerBg:GetSizeY())
  self._ui._stc_replayControllerBg:ComputePosAllChild()
  self._ui._txt_replayTime:SetPosX(self._ui._stc_timeLineBar:GetPosX())
  self._ui._txt_replayTime:SetPosY(self._ui._stc_timeLineBar:GetPosY() + self._ui._stc_timeLineBar:GetSizeY() + 15)
  self:setGuideUI()
end
function PaGlobal_ReplayControllerInMirrorField:openContentsUI()
  if Panel_Window_ReplayInMirrorField_All == nil then
    return
  end
  if self._replayRecordType == __eReplayRecordType_Solare then
    SolareReplay_Hud_Open()
    SolareReplay_PlayerStatus_Open()
    SolareReplay_PlayerStatus_SetReplayData()
  elseif self._replayRecordType == __eReplayRecordType_GuildMatch then
  elseif self._replayRecordType == __eReplayRecordType_SnowBoard then
  else
    UI.ASSERT_NAME(false, "replayRecordType \235\140\128\237\149\156 \236\178\152\235\166\172\234\176\128 \235\136\132\235\157\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
end
function PaGlobal_ReplayControllerInMirrorField:closeContentsUI()
  if Panel_Window_ReplayInMirrorField_All == nil then
    return
  end
  if self._replayRecordType == __eReplayRecordType_Solare then
    SolareReplay_Hud_Close()
    SolareReplay_PlayerStatus_Close()
  elseif self._replayRecordType == __eReplayRecordType_GuildMatch then
  elseif self._replayRecordType == __eReplayRecordType_SnowBoard then
  else
    return
  end
end
function PaGlobal_ReplayControllerInMirrorField:setGuideUI()
  if Panel_Window_ReplayInMirrorField_All == nil then
    return
  end
  local stc_photoModeGuide = UI.getChildControl(self._ui._stc_replayControllerBg, "Static_PhotoModeGuide")
  local txt_photoModeDesc = UI.getChildControl(stc_photoModeGuide, "StaticText_Desc")
  local stc_shortCutGuide = UI.getChildControl(self._ui._stc_replayControllerBg, "StaticText_ShortCutGuide")
  local txt_shortCutDesc = UI.getChildControl(stc_shortCutGuide, "StaticText_Desc")
  txt_photoModeDesc:SetSize(txt_photoModeDesc:GetTextSizeX(), txt_photoModeDesc:GetSizeY())
  stc_photoModeGuide:SetSize(txt_photoModeDesc:GetSpanSize().x + txt_photoModeDesc:GetSizeX())
  txt_shortCutDesc:SetSize(txt_shortCutDesc:GetTextSizeX(), txt_shortCutDesc:GetSizeY())
  stc_shortCutGuide:SetSize(txt_shortCutDesc:GetSpanSize().x + txt_shortCutDesc:GetSizeX())
  stc_shortCutGuide:SetSpanSize(10, 10)
  stc_shortCutGuide:ComputePosAllChild()
  stc_photoModeGuide:SetSpanSize(stc_shortCutGuide:GetSpanSize().x + stc_shortCutGuide:GetSizeX() + 20, 10)
  stc_photoModeGuide:ComputePosAllChild()
end
function PaGlobal_ReplayControllerInMirrorField:expandTimeLineEventPool()
  if Panel_Window_ReplayInMirrorField_All == nil then
    return
  end
  if self._ui._stc_timeLineEventPool == nil then
    self._ui._stc_timeLineEventPool = Array.new()
  end
  local addCount = 1
  local startIndex = self._timeLineEventPoolCount + 1
  local endIndex = self._timeLineEventPoolCount + addCount
  for index = startIndex, endIndex do
    local controlId = "Button_TimeLineEvent_" .. tostring(index)
    local newControl = UI.cloneControl(self._ui._btn_timeLineEventTemplate, self._ui._stc_replayControllerBg, controlId)
    if newControl ~= nil then
      newControl:SetShow(false)
      self._ui._stc_timeLineEventPool:push_back(newControl)
      self._timeLineEventPoolCount = #self._ui._stc_timeLineEventPool
    else
      UI.ASSERT_NAME(false, "\236\136\152\236\160\149\236\157\180 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164. \235\176\156\236\131\157\236\139\156 \236\160\156\235\179\180 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    end
  end
end
function PaGlobal_ReplayControllerInMirrorField:setReplayTimeLineEvent(isSet)
  if Panel_Window_ReplayInMirrorField_All == nil then
    return
  end
  if self._ui._stc_timeLineEventPool == nil then
    self._ui._stc_timeLineEventPool = Array.new()
  end
  for key, value in pairs(self._ui._stc_timeLineEventPool) do
    if value ~= nil then
      value:ComputePos()
      value:SetShow(false)
    end
  end
  if isSet == false then
    return
  end
  local sliderArea = self._ui._stc_timeLineBar:getEnableEnd().x - self._ui._stc_timeLineBar:getEnableStart().x - self._ui._btn_timeLine:GetSizeX()
  local sliderEnableStartX = self._ui._stc_timeLineBar:getEnableStart().x
  local sliderPosX = self._ui._stc_timeLineBar:GetPosX()
  local sliderPosY = self._ui._stc_timeLineBar:GetPosY()
  local sliderButtonHalfSizeX = self._ui._btn_timeLine:GetSizeX() / 2
  local count = ToClient_GetInstanceContentsReplayTimeLineInfoCount()
  for index = 1, count do
    local timeLineEventWrapper = ToClient_GetInstanceContentsReplayTimeLineInfo(index - 1)
    if timeLineEventWrapper ~= nil then
      local eventControl = self._ui._stc_timeLineEventPool[index]
      if eventControl == nil then
        self:expandTimeLineEventPool()
        eventControl = self._ui._stc_timeLineEventPool[index]
      end
      if eventControl == nil then
        UI.ASSERT_NAME(false, "\237\131\128\236\158\132\235\157\188\236\157\184 \236\157\180\235\178\164\237\138\184 \237\146\128 \235\182\128\236\161\177. \237\153\149\236\158\165\236\151\144 \236\139\164\237\140\168\237\150\136\235\139\164?", "\236\157\180\236\163\188")
      else
        local eventType = timeLineEventWrapper:getEventType()
        local eventParam = timeLineEventWrapper:getParam()
        if eventType == __eReplayInstanceContentsTimeLineEventType_Kill then
          if eventParam == __eSolareTeamNo_Red then
            eventControl:ChangeTextureInfoTextureIDAsync("Combine_Etc_Arsha_Replay_Pin_Redkill_Normal", 0)
            eventControl:ChangeTextureInfoTextureIDAsync("Combine_Etc_Arsha_Replay_Pin_Redkill_Over", 1)
            eventControl:ChangeTextureInfoTextureIDAsync("Combine_Etc_Arsha_Replay_Pin_Redkill_Click", 2)
          elseif eventParam == __eSolareTeamNo_Blue then
            eventControl:ChangeTextureInfoTextureIDAsync("Combine_Etc_Arsha_Replay_Pin_BlueKill_Normal", 0)
            eventControl:ChangeTextureInfoTextureIDAsync("Combine_Etc_Arsha_Replay_Pin_BlueKill_Over", 1)
            eventControl:ChangeTextureInfoTextureIDAsync("Combine_Etc_Arsha_Replay_Pin_BlueKill_Click", 2)
          else
            UI.ASSERT_NAME(false, "\236\160\149\236\157\152\235\144\152\236\167\128 \236\149\138\236\157\128 \237\131\128\236\158\132\236\149\132\236\155\131 \236\157\180\235\178\164\237\138\184\235\139\164!", "\236\157\180\236\163\188")
            eventControl:ChangeTextureInfoTextureIDAsync("Combine_Etc_Arsha_Replay_Pin_Normal", 0)
            eventControl:ChangeTextureInfoTextureIDAsync("Combine_Etc_Arsha_Replay_Pin_Over", 1)
            eventControl:ChangeTextureInfoTextureIDAsync("Combine_Etc_Arsha_Replay_Pin_Cick", 2)
          end
        elseif eventType == __eReplayInstanceContentsTimeLineEventType_RoundStart or eventType == __eReplayInstanceContentsTimeLineEventType_RoundFinish then
          if eventParam == 1 then
            eventControl:ChangeTextureInfoTextureIDAsync("Combine_Etc_Arsha_Replay_Pin_1Round_Normal", 0)
            eventControl:ChangeTextureInfoTextureIDAsync("Combine_Etc_Arsha_Replay_Pin_1Round_Over", 1)
            eventControl:ChangeTextureInfoTextureIDAsync("Combine_Etc_Arsha_Replay_Pin_1Round_Click", 2)
          elseif eventParam == 2 then
            eventControl:ChangeTextureInfoTextureIDAsync("Combine_Etc_Arsha_Replay_Pin_2Round_Normal", 0)
            eventControl:ChangeTextureInfoTextureIDAsync("Combine_Etc_Arsha_Replay_Pin_2Round_Over", 1)
            eventControl:ChangeTextureInfoTextureIDAsync("Combine_Etc_Arsha_Replay_Pin_2Round_Click", 2)
          elseif eventParam == 3 then
            eventControl:ChangeTextureInfoTextureIDAsync("Combine_Etc_Arsha_Replay_Pin_3Round_Normal", 0)
            eventControl:ChangeTextureInfoTextureIDAsync("Combine_Etc_Arsha_Replay_Pin_3Round_Over", 1)
            eventControl:ChangeTextureInfoTextureIDAsync("Combine_Etc_Arsha_Replay_Pin_3Round_Click", 2)
          elseif eventParam == 4 then
            eventControl:ChangeTextureInfoTextureIDAsync("Combine_Etc_Arsha_Replay_Pin_4Round_Normal", 0)
            eventControl:ChangeTextureInfoTextureIDAsync("Combine_Etc_Arsha_Replay_Pin_4Round_Over", 1)
            eventControl:ChangeTextureInfoTextureIDAsync("Combine_Etc_Arsha_Replay_Pin_4Round_Click", 2)
          elseif eventParam == 5 then
            eventControl:ChangeTextureInfoTextureIDAsync("Combine_Etc_Arsha_Replay_Pin_5Round_Normal", 0)
            eventControl:ChangeTextureInfoTextureIDAsync("Combine_Etc_Arsha_Replay_Pin_5Round_Over", 1)
            eventControl:ChangeTextureInfoTextureIDAsync("Combine_Etc_Arsha_Replay_Pin_5Round_Click", 2)
          else
            UI.ASSERT_NAME(false, "\236\160\149\236\157\152\235\144\152\236\167\128 \236\149\138\236\157\128 \237\131\128\236\158\132\236\149\132\236\155\131 \236\157\180\235\178\164\237\138\184\235\139\164!", "\236\157\180\236\163\188")
            eventControl:ChangeTextureInfoTextureIDAsync("Combine_Etc_Arsha_Replay_Pin_Normal", 0)
            eventControl:ChangeTextureInfoTextureIDAsync("Combine_Etc_Arsha_Replay_Pin_Over", 1)
            eventControl:ChangeTextureInfoTextureIDAsync("Combine_Etc_Arsha_Replay_Pin_Cick", 2)
          end
        else
          eventControl:ChangeTextureInfoTextureIDAsync("Combine_Etc_Arsha_Replay_Pin_Normal", 0)
          eventControl:ChangeTextureInfoTextureIDAsync("Combine_Etc_Arsha_Replay_Pin_Over", 1)
          eventControl:ChangeTextureInfoTextureIDAsync("Combine_Etc_Arsha_Replay_Pin_Cick", 2)
        end
        eventControl:setRenderTexture(eventControl:getBaseTexture())
        local eventTime = Uint64toUint32(timeLineEventWrapper:getEventTime())
        if eventTime > self._replayLength then
          eventTime = self._replayLength
        end
        local posRatio = eventTime / self._replayLength
        local posRatioX = sliderArea * posRatio
        local eventTimePosX = sliderEnableStartX + posRatioX - eventControl:GetSizeX() / 2
        local eventTimePosY = sliderPosY - eventControl:GetSizeY()
        local sliderIndex = self._ui._stc_timeLineBar:SearchIndexforPos(eventTimePosX)
        local posXFromIndex = sliderPosX + sliderButtonHalfSizeX + self._ui._stc_timeLineBar:GetControlPosforIndex(sliderIndex)
        eventControl:SetPosX(posXFromIndex)
        eventControl:SetPosY(eventTimePosY)
        eventControl:SetShow(true)
        eventControl:addInputEvent("Mouse_On", "HandleEventOnOut_ReplayInMirrorField_ToggleTimeEventToolTip(true," .. tostring(index) .. ")")
        eventControl:addInputEvent("Mouse_Out", "HandleEventOnOut_ReplayInMirrorField_ToggleTimeEventToolTip(false," .. tostring(index) .. ")")
        eventControl:addInputEvent("Mouse_LUp", "HandleEventLUp_ReplayInMirrorField_MoveTimeEvent(" .. tostring(index) .. ")")
      end
    end
  end
end
