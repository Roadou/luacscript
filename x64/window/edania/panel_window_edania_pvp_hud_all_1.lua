function PaGlobal_Edania_PVP_HUD:initialize()
  if self._initialize == true then
    return
  end
  self._ui._stc_TeamHud = UI.getChildControl(Panel_Window_Edania_PVP_HUD, "Static_TeamHud")
  self._ui._progress_Red = UI.getChildControl(self._ui._stc_TeamHud, "Progress2_Red")
  self._ui._progress_Blue = UI.getChildControl(self._ui._stc_TeamHud, "Progress2_Blue")
  self._ui._txt_CenterTime = UI.getChildControl(self._ui._stc_TeamHud, "StaticText_CenterTime")
  self._ui._txt_LeftPoint = UI.getChildControl(self._ui._stc_TeamHud, "StaticText_LeftPoint")
  self._ui._txt_RightPoint = UI.getChildControl(self._ui._stc_TeamHud, "StaticText_RightPoint")
  self._ui._txt_LeftTeamName = UI.getChildControl(self._ui._stc_TeamHud, "StaticText_LeftTeamName")
  self._ui._txt_RightTeamName = UI.getChildControl(self._ui._stc_TeamHud, "StaticText_RightTeamName")
  for idx = 1, __eEdaniaWinRoundMaxCount do
    local redBg = UI.getChildControl(self._ui._stc_TeamHud, "Static_RedDotBG" .. tostring(idx))
    local blueBg = UI.getChildControl(self._ui._stc_TeamHud, "Static_BlueDotBG" .. tostring(idx))
    local redDot = UI.getChildControl(redBg, "Static_Icon")
    local blueDot = UI.getChildControl(blueBg, "Static_Icon")
    self._ui._stc_RedPointDot:push_back(redDot)
    self._ui._stc_BluePointDot:push_back(blueDot)
  end
  self._ui._txt_Round = UI.getChildControl(self._ui._stc_TeamHud, "StaticText_Round")
  self._ui._txt_MultiRound = UI.getChildControl(Panel_Window_Edania_PVP_HUD, "MultilineText_Round")
  self._ui._stc_Result = UI.getChildControl(Panel_Window_Edania_PVP_HUD, "Static_Result_Middle")
  self._ui._stc_Win = UI.getChildControl(self._ui._stc_Result, "Static_Win")
  self._ui._stc_Lose = UI.getChildControl(self._ui._stc_Result, "Static_Lose")
  self._ui._txt_MultiRound:SetShow(false)
  self._ui._stc_Result:SetShow(false)
  self:registEventHandler()
  self:validate()
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._initialize = true
  if ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Edania) == true and ToClient_GetEdanaInstanceFieldMode() == __eEdaniaInstanceContentsMode_Edana then
    self:prepareOpen()
  end
end
function PaGlobal_Edania_PVP_HUD:registEventHandler()
  if Panel_Window_Edania_PVP_HUD == nil then
    return
  end
  registerEvent("FromClient_UpdateEdaniaInstanceField", "FromClient_UpdateEdaniaInstanceField")
  registerEvent("FromClient_UpdateEdaniaInstanceFieldRoundResult", "FromClient_UpdateEdaniaInstanceFieldRoundResult")
  registerEvent("FromClient_UpdateEdaniaInstanceFieldEdanaHp", "FromClient_UpdateEdaniaInstanceFieldEdanaHp")
end
function PaGlobal_Edania_PVP_HUD:prepareOpen()
  if Panel_Window_Edania_PVP_HUD == nil then
    return
  end
  Panel_Window_Edania_PVP_HUD:RegisterUpdateFunc("FromClient_Edania_PVP_HUD_UpdatePerFrame")
  self:update()
  self:unRenderPanel()
  Panel_Window_Edania_PVP_HUD:ComputePosAllChild()
  self:open()
end
function PaGlobal_Edania_PVP_HUD:open()
  if Panel_Window_Edania_PVP_HUD == nil then
    return
  end
  PaGlobal_Edania_PVP_Challenger_Close()
  Panel_Window_Edania_PVP_HUD:SetShow(true)
end
function PaGlobal_Edania_PVP_HUD:prepareClose()
  if Panel_Window_Edania_PVP_HUD == nil then
    return
  end
  Panel_Window_Edania_PVP_HUD:ClearUpdateLuaFunc()
  self:close()
end
function PaGlobal_Edania_PVP_HUD:close()
  if Panel_Window_Edania_PVP_HUD == nil then
    return
  end
  Panel_Window_Edania_PVP_HUD:SetShow(false)
end
function PaGlobal_Edania_PVP_HUD:update()
  if Panel_Window_Edania_PVP_HUD == nil then
    return
  end
  local state = ToClient_GetEdanaInstanceFieldState()
  local roundState = ToClient_GetEdanaInstanceFieldRoundState()
  if state == __eEdaniaInstanceContentsState_Ready then
    self._ui._txt_CenterTime:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CREW_MAIN_WAIT_DESC"))
    self:hideUserHp()
  elseif state == __eEdaniaInstanceContentsState_Play then
    if roundState == __eEdaniaInstanceContentsRoundState_Ready then
      self:resetUserHp()
      self._ui._txt_MultiRound:SetShow(false)
      self._ui._stc_Result:SetShow(false)
    elseif roundState == __eEdaniaInstanceContentsRoundState_Play then
      self:resetUserHp()
    else
    end
  elseif roundState == __eEdaniaInstanceContentsRoundState_End and state == __eEdaniaInstanceContentsState_Result then
    self._ui._txt_CenterTime:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CASH_CUSTOMIZATION_BTN_EXIT"))
    self:hideUserHp()
    self._ui._txt_MultiRound:SetShow(false)
    self._ui._stc_Result:SetShow(false)
  end
  self:setWinCountUI(ToClient_GetInstanceFieldTeamWinCount(true), ToClient_GetInstanceFieldTeamWinCount(false))
  self._ui._txt_Round:SetText(ToClient_GetInstanceFieldRound())
end
function PaGlobal_Edania_PVP_HUD:setWinCountUI(edanaTeamPoint, challengerTeamPoint)
  if Panel_Window_Edania_PVP_HUD == nil then
    return
  end
  for idx = 1, __eEdaniaWinRoundMaxCount do
    self._ui._stc_RedPointDot[idx]:SetShow(false)
    self._ui._stc_BluePointDot[idx]:SetShow(false)
  end
  if edanaTeamPoint > 0 then
    for idx = 1, edanaTeamPoint do
      self._ui._stc_RedPointDot[idx]:SetShow(true)
    end
  end
  if challengerTeamPoint > 0 then
    for idx = 1, challengerTeamPoint do
      self._ui._stc_BluePointDot[idx]:SetShow(true)
    end
  end
end
function PaGlobal_Edania_PVP_HUD:updateUserHp(teamNo, leftPercent)
  if Panel_Window_Edania_PVP_HUD == nil then
    return
  end
  local leftpercentRate = math.floor(leftPercent / 10000)
  if teamNo == __eEdaniaEdanaTeamNo then
    self._ui._progress_Red:SetProgressRate(leftpercentRate)
    self._ui._txt_LeftPoint:SetShow(true)
    self._ui._txt_LeftPoint:SetText(leftpercentRate .. "%")
  elseif teamNo == __eEdaniaFinalChallengerTeamNo then
    self._ui._progress_Blue:SetProgressRate(leftpercentRate)
    self._ui._txt_RightPoint:SetShow(true)
    self._ui._txt_RightPoint:SetText(leftpercentRate .. "%")
  end
end
function PaGlobal_Edania_PVP_HUD:resetUserHp()
  if Panel_Window_Edania_PVP_HUD == nil then
    return
  end
  self._ui._progress_Red:SetProgressRate(100)
  self._ui._txt_LeftPoint:SetText(100 .. "%")
  self._ui._progress_Blue:SetProgressRate(100)
  self._ui._txt_RightPoint:SetText(100 .. "%")
  self._ui._txt_LeftPoint:SetShow(true)
  self._ui._txt_RightPoint:SetShow(true)
end
function PaGlobal_Edania_PVP_HUD:hideUserHp()
  if Panel_Window_Edania_PVP_HUD == nil then
    return
  end
  self._ui._txt_LeftPoint:SetShow(false)
  self._ui._txt_RightPoint:SetShow(false)
end
function PaGlobal_Edania_PVP_HUD:updateResult(winState)
  if Panel_Window_Edania_PVP_HUD == nil then
    return
  end
  self:setWinCountUI(ToClient_GetInstanceFieldTeamWinCount(true), ToClient_GetInstanceFieldTeamWinCount(false))
  if winState == 0 then
    self._ui._txt_MultiRound:SetShow(false)
    self._ui._stc_Result:SetShow(false)
  else
    self._ui._txt_MultiRound:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_COMPETITION_ROUND", "round", ToClient_GetInstanceFieldRound()))
    self._ui._txt_MultiRound:SetShow(true)
    self._ui._stc_Result:SetShow(true)
    self._ui._stc_Win:SetShow(winState == 1)
    self._ui._stc_Lose:SetShow(winState == -1)
    Proc_NoticeAlert_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_SYSMSG_END"), CppEnums.EChatNoticeType.ActionNakAll, 0)
  end
end
function PaGlobal_Edania_PVP_HUD:unRenderPanel()
  if Panel_Window_Edania_PVP_HUD == nil then
    return
  end
  local targetPanel = Array.new()
  targetPanel:push_back(Panel_PersonalIcon_Left)
  targetPanel:push_back(Panel_MainQuest)
  targetPanel:push_back(Panel_CheckedQuest)
  targetPanel:push_back(Panel_Widget_Function)
  for idx = 1, #targetPanel do
    if targetPanel[idx] ~= nil then
      targetPanel[idx]:SetRenderAndEventHide(true)
    end
  end
end
function PaGlobal_Edania_PVP_HUD:validate()
  if Panel_Window_Edania_PVP_HUD == nil then
    return
  end
  self._ui._stc_TeamHud:isValidate()
  self._ui._progress_Red:isValidate()
  self._ui._progress_Blue:isValidate()
  self._ui._txt_CenterTime:isValidate()
  self._ui._txt_LeftPoint:isValidate()
  self._ui._txt_RightPoint:isValidate()
  self._ui._txt_LeftTeamName:isValidate()
  self._ui._txt_RightTeamName:isValidate()
  for idx = 1, __eEdaniaWinRoundMaxCount do
    self._ui._stc_RedPointDot[idx]:isValidate()
    self._ui._stc_BluePointDot[idx]:isValidate()
  end
  self._ui._txt_Round:isValidate()
  self._ui._txt_MultiRound:isValidate()
  self._ui._stc_Result:isValidate()
  self._ui._stc_Win:isValidate()
  self._ui._stc_Lose:isValidate()
end
