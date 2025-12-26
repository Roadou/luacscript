function PaGlobal_Solare_Hud:initialize()
  if self._initialize == true or Panel_Widget_Solare_Hud == nil then
    return
  end
  self._ui._stc_TeamHud = UI.getChildControl(Panel_Widget_Solare_Hud, "Static_TeamHud")
  self._ui._prog2_HPRed = UI.getChildControl(self._ui._stc_TeamHud, "Progress2_Red")
  self._ui._prog2_HPBlue = UI.getChildControl(self._ui._stc_TeamHud, "Progress2_Blue")
  self._ui._txt_prog2HPRed = UI.getChildControl(self._ui._stc_TeamHud, "StaticText_LeftPoint")
  self._ui._txt_prog2HPBlue = UI.getChildControl(self._ui._stc_TeamHud, "StaticText_RightPoint")
  self._ui._txt_LeftName = UI.getChildControl(self._ui._stc_TeamHud, "StaticText_LeftTeamName")
  self._ui._txt_RightName = UI.getChildControl(self._ui._stc_TeamHud, "StaticText_RightTeamName")
  for idx = 1, self._maxRound do
    local redBg = UI.getChildControl(self._ui._stc_TeamHud, "Static_RedDotBG" .. tostring(idx))
    local blueBg = UI.getChildControl(self._ui._stc_TeamHud, "Static_BlueDotBG" .. tostring(idx))
    local redDot = UI.getChildControl(redBg, "Static_Icon")
    local blueDot = UI.getChildControl(blueBg, "Static_Icon")
    self._ui._stc_RedPointDot:push_back(redDot)
    self._ui._stc_BluePointDot:push_back(blueDot)
  end
  self._ui._txt_Round = UI.getChildControl(self._ui._stc_TeamHud, "StaticText_Round")
  self._ui._txt_LeftTime = UI.getChildControl(self._ui._stc_TeamHud, "StaticText_CenterTime")
  self._ui._txt_LeftName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_TEAMNAME_0"))
  self._ui._txt_RightName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_TEAMNAME_1"))
  Panel_Widget_Solare_Countdown:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_Widget_Solare_Countdown:ComputePosAllChild()
  for idx = 0, 10 do
    local control = UI.getChildControl(Panel_Widget_Solare_Countdown, "Static_Count" .. tostring(idx))
    self._ui._stc_countDown:push_back(control)
  end
  self._ui._panel_waitOther = Panel_Widget_Solare_WaitOther
  local waitOtherBg = UI.getChildControl(Panel_Widget_Solare_WaitOther, "Static_Wait_BG")
  self._ui._txt_waitOtherTime = UI.getChildControl(waitOtherBg, "StaticText_Time")
  self:registEventHandler()
  self._initialize = true
  if ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare) == true then
    self:prepareOpen()
    self:unRenderPanel()
  end
end
function PaGlobal_Solare_Hud:registEventHandler()
  if Panel_Widget_Solare_Hud == nil then
    return
  end
  registerEvent("FromClient_SolareKillLog", "FromClient_SolareKillLog")
  registerEvent("FromClient_SolareJoinAck", "FromClient_SolareJoinAck")
  registerEvent("FromClient_SolareChangeStateAck", "FromClient_SolareChangeStateAck")
  registerEvent("onScreenResize", "FromClient_SolrareHud_Resize")
  registerEvent("FromClient_UpdateReplaySolareTeamScore", "SolareReplay_Hud_UpdateTeamScore")
  registerEvent("FromClient_UpdateReplaySolareRoundTime", "SolareReplay_Hud_UpdateRoundTime")
end
function PaGlobal_Solare_Hud:prepareOpen()
  if Panel_Widget_Solare_Hud == nil then
    return
  end
  Panel_Widget_Solare_Hud:ComputePosAllChild()
  self:open()
  self:update()
end
function PaGlobal_Solare_Hud:open()
  if Panel_Widget_Solare_Hud == nil then
    return
  end
  Panel_Widget_Solare_Hud:RegisterUpdateFunc("FromClient_SolareHud_UpdatePerFrame")
  Panel_Widget_Solare_Hud:SetShow(true)
end
function PaGlobal_Solare_Hud:prepareClose()
  if Panel_Widget_Solare_Hud == nil then
    return
  end
  self:close()
end
function PaGlobal_Solare_Hud:close()
  if Panel_Widget_Solare_Hud == nil then
    return
  end
  Panel_Widget_Solare_Hud:ClearUpdateLuaFunc()
  Panel_Widget_Solare_Hud:SetShow(false)
end
function PaGlobal_Solare_Hud:update()
  if Panel_Widget_Solare_Hud == nil then
    return
  end
  self._currentRoomState = ToClient_GetSolareRoomState()
  self._currentPlayState = ToClient_GetSolarePlayState()
  local redTeamPoint = ToClient_GetSolareWinScore(0)
  local blueTeamPoint = ToClient_GetSolareWinScore(1)
  self:setWinCountUI(redTeamPoint, blueTeamPoint)
end
function PaGlobal_Solare_Hud:setWinCountUI(redTeamPoint, blueTeamPoint)
  if Panel_Widget_Solare_Hud == nil then
    return
  end
  if redTeamPoint == nil or blueTeamPoint == nil or redTeamPoint == -1 or blueTeamPoin == -1 then
    return
  end
  for idx = 1, self._maxRound do
    self._ui._stc_RedPointDot[idx]:SetShow(false)
    self._ui._stc_BluePointDot[idx]:SetShow(false)
  end
  if redTeamPoint > 0 then
    for idx = 1, redTeamPoint do
      if self._ui._stc_RedPointDot[idx] ~= nil then
        self._ui._stc_RedPointDot[idx]:SetShow(true)
      end
    end
  end
  if blueTeamPoint > 0 then
    for idx = 1, blueTeamPoint do
      if self._ui._stc_BluePointDot[idx] ~= nil then
        self._ui._stc_BluePointDot[idx]:SetShow(true)
      end
    end
  end
end
function PaGlobal_Solare_Hud:countDownInit()
  if Panel_Widget_Solare_Countdown == nil then
    return
  end
  for idx = 0, 10 do
    if self._ui._stc_countDown[idx] ~= nil then
      self._ui._stc_countDown[idx]:SetShow(false)
    end
  end
  self._currentMaxCountDown = -1
end
function PaGlobal_Solare_Hud:countDownOpen()
  if Panel_Widget_Solare_Countdown == nil then
    return
  end
  Panel_Widget_Solare_Countdown:SetShow(true)
end
function PaGlobal_Solare_Hud:countDownClose()
  if Panel_Widget_Solare_Countdown == nil then
    return
  end
  self._currentMaxCountDown = -1
  Panel_Widget_Solare_Countdown:SetShow(false)
end
function PaGlobal_Solare_Hud:showCountDown(time)
  if Panel_Widget_Solare_Countdown == nil then
    return
  end
  if self._ui._stc_countDown[time + 1] == nil or self._ui._stc_countDown[time] == nil then
    return
  end
  self._ui._stc_countDown[time + 1]:SetShow(false)
  self._ui._stc_countDown[time]:SetShow(true)
  if time ~= 1 then
    if time == 5 or time == 6 then
      audioPostEvent_SystemUi(30, 1)
      _AudioPostEvent_SystemUiForXBOX(30, 1)
    else
      audioPostEvent_SystemUi(30, 16)
      _AudioPostEvent_SystemUiForXBOX(30, 16)
    end
  else
    audioPostEvent_SystemUi(30, 2)
    _AudioPostEvent_SystemUiForXBOX(30, 2)
  end
end
function PaGlobal_Solare_Hud:waitOtherBgShow(isShow)
  if Panel_Widget_Solare_WaitOther == nil then
    return
  end
  Panel_Widget_Solare_WaitOther:SetShow(isShow)
end
function PaGlobal_Solare_Hud:unRenderPanel()
  if Panel_Widget_Solare_Hud == nil then
    return
  end
  local targetPanel = Array.new()
  targetPanel:push_back(Panel_PersonalIcon_Left)
  targetPanel:push_back(Panel_MainQuest)
  targetPanel:push_back(Panel_CheckedQuest)
  targetPanel:push_back(Panel_Widget_Function)
  targetPanel:push_back(Panel_Widget_Function)
  targetPanel:push_back(Panel_Widget_ServantIcon)
  for idx = 1, #targetPanel do
    if targetPanel[idx] ~= nil then
      targetPanel[idx]:SetRenderAndEventHide(true)
    end
  end
end
