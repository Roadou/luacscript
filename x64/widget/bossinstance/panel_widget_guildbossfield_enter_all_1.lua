function PaGlobal_GuildBossField_Enter_All:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._stc_blackBG = UI.getChildControl(Panel_Widget_GuildBossField_Enter, "Static_BlackBG")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_GuildBossField_Enter_All:validate()
  if Panel_Widget_GuildBossField_Enter == nil then
    return
  end
  self._ui._stc_blackBG:isValidate()
end
function PaGlobal_GuildBossField_Enter_All:registEventHandler()
  if Panel_Widget_GuildBossField_Enter == nil then
    return
  end
  registerEvent("onScreenResize", "FromClient_GuildBossField_Enter_All_Resize")
  registerEvent("FromClient_UpdateGuildBossFieldEnterState", "PaGlobal_GuildBossField_Enter_All_Open")
end
function PaGlobal_GuildBossField_Enter_All:prepareOpen()
  if Panel_Widget_GuildBossField_Enter == nil then
    return
  end
  if _ContentsGroup_GuildBossField == false then
    return
  end
  Panel_Widget_GuildBossField_Enter:EraseAllEffect()
  Panel_Widget_GuildBossField_Enter:ClearUpdateLuaFunc()
  self._isShowEffect = false
  self._curEffectTime = 0
  FromClient_GuildBossField_Enter_All_Resize()
  self:showEffect()
  self:open()
end
function PaGlobal_GuildBossField_Enter_All:open()
  if Panel_Widget_GuildBossField_Enter == nil then
    return
  end
  Panel_Widget_GuildBossField_Enter:SetShow(true)
end
function PaGlobal_GuildBossField_Enter_All:prepareClose()
  if Panel_Widget_GuildBossField_Enter == nil then
    return
  end
  Panel_Widget_GuildBossField_Enter:EraseAllEffect()
  Panel_Widget_GuildBossField_Enter:ClearUpdateLuaFunc()
  self._isShowEffect = false
  self._curEffectTime = 0
  self:close()
end
function PaGlobal_GuildBossField_Enter_All:close()
  if Panel_Widget_GuildBossField_Enter == nil then
    return
  end
  Panel_Widget_GuildBossField_Enter:SetShow(false)
end
function PaGlobal_GuildBossField_Enter_All:updateEnterEffect(deltaTime)
  if Panel_Widget_GuildBossField_Enter == nil then
    return
  end
  self._curEffectTime = self._curEffectTime + deltaTime
  if self._curEffectTime < self._maxEffectTime then
    return
  end
  self:prepareClose()
end
function PaGlobal_GuildBossField_Enter_All:showEffect()
  if Panel_Widget_GuildBossField_Enter == nil then
    return
  end
  self._isShowEffect = true
  self._curEffectTime = 0
  Panel_Widget_GuildBossField_Enter:EraseAllEffect()
  Panel_Widget_GuildBossField_Enter:AddEffect("fUI_InGame_Light_01D", false, 0, 0)
  audioPostEvent_SystemUi(32, 1)
  _AudioPostEvent_SystemUiForXBOX(32, 1)
  Panel_Widget_GuildBossField_Enter:RegisterUpdateFunc("PaGlobal_GuildBossField_Enter_All_UpdateEnterEffect")
  local blackShowStartTime = 0
  local blackShowEndTime = 0.5
  local blackHideTime = 0.5
  local blackHideStartTime = math.max(self._maxEffectTime - blackHideTime, 0)
  local blackHideEndTime = self._maxEffectTime
  self._ui._stc_blackBG:SetShow(true)
  self:setAniToControl(true, self._ui._stc_blackBG, blackShowStartTime, blackShowEndTime, Defines.Color.C_55FFFFFF, Defines.Color.C_CCFFFFFF)
  self:setAniToControl(false, self._ui._stc_blackBG, blackHideStartTime, blackHideEndTime, Defines.Color.C_CCFFFFFF, Defines.Color.C_55FFFFFF)
end
function PaGlobal_GuildBossField_Enter_All:setAniToControl(isShow, control, startTime, endTime, startValue, endValue)
  if control == nil then
    return
  end
  local aniInfo = control:addColorAnimation(startTime, endTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo:SetStartColor(startValue)
  aniInfo:SetEndColor(endValue)
  aniInfo.IsChangeChild = true
end
