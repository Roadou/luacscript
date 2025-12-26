function PaGlobal_NakMessage_KillCombo:initialize()
  if self._initialize == true then
    return
  end
  self._ui._stc_firstKill = UI.getChildControl(Panel_NakMessage_KillCombo, "Static_FirstKill")
  self._ui._txt_firstKill = UI.getChildControl(self._ui._stc_firstKill, "StaticText_Content")
  self._ui._stc_doubleKill = UI.getChildControl(Panel_NakMessage_KillCombo, "Static_Duo")
  self._ui._stc_tripleKill = UI.getChildControl(Panel_NakMessage_KillCombo, "Static_Trio")
  self._ui._stc_quadraKill = UI.getChildControl(Panel_NakMessage_KillCombo, "Static_Quartet")
  self._ui._stc_pentaKill = UI.getChildControl(Panel_NakMessage_KillCombo, "Static_Quintet")
  self._ui._stc_firstKill:SetShow(false)
  self._ui._stc_doubleKill:SetShow(false)
  self._ui._stc_tripleKill:SetShow(false)
  self._ui._stc_quadraKill:SetShow(false)
  self._ui._stc_pentaKill:SetShow(false)
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_NakMessage_KillCombo:registEventHandler()
  if Panel_NakMessage_KillCombo == nil then
    return
  end
  if _ContentsGroup_GuildMatch == true then
    registerEvent("FromClient_UpdateGuildMatchStreak", "FromClient_UpdateGuildMatchStreak")
    registerEvent("FromClient_NotifyGuildMatchFirstKill", "FromClient_NotifyGuildMatchFirstKill")
  end
end
function PaGlobal_NakMessage_KillCombo:validate()
  if Panel_NakMessage_KillCombo == nil then
    return
  end
  self._ui._stc_firstKill:isValidate()
  self._ui._txt_firstKill:isValidate()
  self._ui._stc_doubleKill:isValidate()
  self._ui._stc_tripleKill:isValidate()
  self._ui._stc_quadraKill:isValidate()
  self._ui._stc_pentaKill:isValidate()
end
function PaGlobal_NakMessage_KillCombo:prepareOpen()
  if Panel_NakMessage_KillCombo == nil then
    return
  end
  self:open()
end
function PaGlobal_NakMessage_KillCombo:open()
  if Panel_NakMessage_KillCombo == nil then
    return
  end
  Panel_NakMessage_KillCombo:RegisterUpdateFunc("PaGlobal_NakMessage_KillCombo_UpdateFunc")
  Panel_NakMessage_KillCombo:SetShow(true)
end
function PaGlobal_NakMessage_KillCombo:prepareClose()
  if Panel_NakMessage_KillCombo == nil then
    return
  end
  self._showingInfo = nil
  self:close()
end
function PaGlobal_NakMessage_KillCombo:close()
  if Panel_NakMessage_KillCombo == nil then
    return
  end
  Panel_NakMessage_KillCombo:ClearUpdateLuaFunc()
  Panel_NakMessage_KillCombo:SetShow(false)
end
function PaGlobal_NakMessage_KillCombo:update(deltaTime)
  if Panel_NakMessage_KillCombo == nil then
    return
  end
  if self._showingInfo == nil then
    return
  end
  for index = 1, #self._showingInfo do
    local showInfo = self._showingInfo[index]
    if showInfo ~= nil then
      showInfo._deltaTime = showInfo._deltaTime + deltaTime
      if showInfo._showTime <= showInfo._deltaTime then
        showInfo._control:SetShow(false)
        table.remove(self._showingInfo, index)
      end
    end
  end
  if self._showingInfo:length() == 0 then
    self:prepareClose()
  else
    self:sortShowingInfoPosition()
  end
end
function PaGlobal_NakMessage_KillCombo:addShowingAnimationInfoAndShow(control)
  if Panel_NakMessage_KillCombo == nil then
    return
  end
  if control == nil then
    return
  end
  local showInfo = {
    _control = control,
    _alphaAniTime = 0.3,
    _showTime = 4,
    _deltaTime = 0
  }
  showInfo._control:SetShow(true)
  showInfo._control:ResetVertexAni()
  local showAni = showInfo._control:addColorAnimation(0, showInfo._alphaAniTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  showAni:SetStartColor(Defines.Color.C_00FFFFFF)
  showAni:SetEndColor(Defines.Color.C_FFFFFFFF)
  showAni.IsChangeChild = true
  local hideAni = showInfo._control:addColorAnimation(showInfo._showTime - showInfo._alphaAniTime, showInfo._showTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  hideAni:SetStartColor(Defines.Color.C_FFFFFFFF)
  hideAni:SetEndColor(Defines.Color.C_00FFFFFF)
  hideAni.IsChangeChild = true
  if self._showingInfo == nil then
    self._showingInfo = Array.new()
  end
  self._showingInfo:push_back(showInfo)
  self:sortShowingInfoPosition()
end
function PaGlobal_NakMessage_KillCombo:sortShowingInfoPosition()
  if Panel_NakMessage_KillCombo == nil then
    return
  end
  if self._showingInfo == nil then
    return
  end
  local nextSpanY = 0
  for index = 1, #self._showingInfo do
    local tempShowInfo = self._showingInfo[index]
    if tempShowInfo ~= nil then
      tempShowInfo._control:SetSpanSize(0, nextSpanY)
      tempShowInfo._control:ComputePos()
      nextSpanY = tempShowInfo._control:GetSpanSize().y + tempShowInfo._control:GetSizeY()
    end
  end
end
function PaGlobal_NakMessage_KillCombo:removeShowingAnimationInfoAndHide(control)
  if Panel_NakMessage_KillCombo == nil then
    return
  end
  if control == nil then
    return
  end
  control:SetShow(false)
  if self._showingInfo == nil then
    return
  end
  for index = 1, #self._showingInfo do
    local showInfo = self._showingInfo[index]
    if showInfo ~= nil and showInfo._control == control then
      table.remove(self._showingInfo, index)
    end
  end
  if self._showingInfo:length() == 0 then
    self:prepareClose()
  end
end
function PaGlobal_NakMessage_KillCombo:updateGuildMatchStreak(killStreak)
  if Panel_NakMessage_KillCombo == nil then
    return
  end
  if killStreak < 2 then
    return
  end
  self:removeShowingAnimationInfoAndHide(self._ui._stc_doubleKill)
  self:removeShowingAnimationInfoAndHide(self._ui._stc_tripleKill)
  self:removeShowingAnimationInfoAndHide(self._ui._stc_quadraKill)
  self:removeShowingAnimationInfoAndHide(self._ui._stc_pentaKill)
  if killStreak == 2 then
    self:addShowingAnimationInfoAndShow(self._ui._stc_doubleKill)
    self._ui._stc_doubleKill:AddEffect("fUI_KillCombo_01A_Orange", false, 0, 0)
    audioPostEvent_SystemUi(24, 1)
  elseif killStreak == 3 then
    self:addShowingAnimationInfoAndShow(self._ui._stc_tripleKill)
    self._ui._stc_tripleKill:AddEffect("fUI_KillCombo_01A_Red", false, 0, 0)
    audioPostEvent_SystemUi(24, 2)
  elseif killStreak == 4 then
    self:addShowingAnimationInfoAndShow(self._ui._stc_quadraKill)
    self._ui._stc_quadraKill:AddEffect("fUI_KillCombo_01A_Violet", false, 0, 0)
    audioPostEvent_SystemUi(24, 3)
  else
    self:addShowingAnimationInfoAndShow(self._ui._stc_pentaKill)
    self._ui._stc_pentaKill:AddEffect("fUI_KillCombo_01A_Pink", false, 0, 0)
    audioPostEvent_SystemUi(24, 3)
  end
  self:prepareOpen()
end
function PaGlobal_NakMessage_KillCombo:showFirstKill(guildName, point)
  if Panel_NakMessage_KillCombo == nil then
    return
  end
  self._ui._txt_firstKill:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_SCORE", "guildName", guildName, "point", point))
  self:removeShowingAnimationInfoAndHide(self._ui._stc_firstKill)
  self:addShowingAnimationInfoAndShow(self._ui._stc_firstKill)
  self._ui._stc_firstKill:AddEffect("fUI_KillCombo_01A_Yellow", false, 0, 0)
  self:prepareOpen()
end
