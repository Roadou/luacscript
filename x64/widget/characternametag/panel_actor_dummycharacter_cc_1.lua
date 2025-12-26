ToClient_SetCCStatusPanel(Panel_Actor_DummyCharacter_CC)
ToClient_InitializeCCtatusPanelPool(20)
function PaGlobal_Actor_DummyCharacter_CC:initialize()
  if true == self._initialize then
    return
  end
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Actor_DummyCharacter_CC:registEventHandler()
  if nil == Panel_Actor_DummyCharacter_CC then
    return
  end
  registerEvent("FromClient_ChangeCCCountState", "FromClient_DummyCharacter_CC_ChangeCCCount")
end
function PaGlobal_Actor_DummyCharacter_CC:prepareOpen()
  if nil == Panel_Actor_DummyCharacter_CC then
    return
  end
  self:open()
end
function PaGlobal_Actor_DummyCharacter_CC:open()
  if nil == Panel_Actor_DummyCharacter_CC then
    return
  end
  Panel_Actor_DummyCharacter_CC:SetShow(true)
end
function PaGlobal_Actor_DummyCharacter_CC:prepareClose()
  if nil == Panel_Actor_DummyCharacter_CC then
    return
  end
  self:close()
end
function PaGlobal_Actor_DummyCharacter_CC:close()
  if nil == Panel_Actor_DummyCharacter_CC then
    return
  end
  Panel_Actor_DummyCharacter_CC:SetShow(false)
end
function PaGlobal_Actor_DummyCharacter_CC:setCurrentCCType(actorKey, bgControl, iconControl)
  local actionRestrictionType = ToClient_getActionRestrictionType(actorKey)
  local path = "Combine/Etc/Combine_Etc_Skill_00.dds"
  iconControl:ChangeTextureInfoNameAsync(path)
  if actionRestrictionType == __eActionRestrictionTypeRigid then
    bgControl:SetShow(true)
    iconControl:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_STIFFNESS"))
    local x1, y1, x2, y2 = setTextureUV_Func(iconControl, 314, 838, 334, 858)
    iconControl:getBaseTexture():setUV(x1, y1, x2, y2)
    iconControl:setRenderTexture(iconControl:getBaseTexture())
  elseif actionRestrictionType == __eActionRestrictionTypeIceFreeze then
    bgControl:SetShow(true)
    iconControl:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_FREEZE"))
    local x1, y1, x2, y2 = setTextureUV_Func(iconControl, 335, 838, 355, 858)
    iconControl:getBaseTexture():setUV(x1, y1, x2, y2)
    iconControl:setRenderTexture(iconControl:getBaseTexture())
  elseif actionRestrictionType == __eActionRestrictionTypeKnockBack then
    bgControl:SetShow(true)
    iconControl:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_KNOCKBACK"))
    local x1, y1, x2, y2 = setTextureUV_Func(iconControl, 356, 838, 376, 858)
    iconControl:getBaseTexture():setUV(x1, y1, x2, y2)
    iconControl:setRenderTexture(iconControl:getBaseTexture())
  elseif actionRestrictionType == __eActionRestrictionTypeStun then
    bgControl:SetShow(true)
    iconControl:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_FAINT"))
    local x1, y1, x2, y2 = setTextureUV_Func(iconControl, 314, 817, 334, 837)
    iconControl:getBaseTexture():setUV(x1, y1, x2, y2)
    iconControl:setRenderTexture(iconControl:getBaseTexture())
  elseif actionRestrictionType == __eActionRestrictionTypeBound then
    bgControl:SetShow(true)
    iconControl:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_BOUND"))
    local x1, y1, x2, y2 = setTextureUV_Func(iconControl, 356, 817, 376, 837)
    iconControl:getBaseTexture():setUV(x1, y1, x2, y2)
    iconControl:setRenderTexture(iconControl:getBaseTexture())
  elseif actionRestrictionType == __eActionRestrictionTypeAirFloat then
    bgControl:SetShow(true)
    iconControl:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_JUMP"))
    local x1, y1, x2, y2 = setTextureUV_Func(iconControl, 293, 838, 313, 858)
    iconControl:getBaseTexture():setUV(x1, y1, x2, y2)
    iconControl:setRenderTexture(iconControl:getBaseTexture())
  elseif actionRestrictionType == __eActionRestrictionTypeKnockDown then
    bgControl:SetShow(true)
    iconControl:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_KNOCKDOWN"))
    local x1, y1, x2, y2 = setTextureUV_Func(iconControl, 293, 817, 313, 837)
    iconControl:getBaseTexture():setUV(x1, y1, x2, y2)
    iconControl:setRenderTexture(iconControl:getBaseTexture())
  elseif actionRestrictionType == __eActionRestrictionTypeCatched then
    bgControl:SetShow(true)
    iconControl:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_CATCH"))
    local x1, y1, x2, y2 = setTextureUV_Func(iconControl, 335, 817, 355, 837)
    iconControl:getBaseTexture():setUV(x1, y1, x2, y2)
    iconControl:setRenderTexture(iconControl:getBaseTexture())
  else
    bgControl:SetShow(false)
  end
end
function PaGlobal_Actor_DummyCharacter_CC:update(actorKey, isUpdate)
  if nil == Panel_Actor_DummyCharacter_CC then
    return false
  end
  local actorProxyWrapper = getActor(actorKey)
  if nil == actorProxyWrapper then
    return false
  end
  local panel = actorProxyWrapper:get():getCCStatusUIPanel()
  if nil == panel then
    return false
  end
  local monsterActorProxyWrapper = getMonsterActor(actorKey)
  if nil == monsterActorProxyWrapper then
    return false
  end
  local stc_ccCountBG = UI.getChildControl(panel, "Static_BG_CCcount")
  if 0 == stc_ccCountBG:getChildControlCount() then
    local originControl = UI.getChildControl(Panel_Actor_DummyCharacter_CC, "Static_BG_CCcount")
    local origin_progressBG = UI.getChildControl(originControl, "Static_Count_ProgressBG")
    local origin_progress = UI.getChildControl(originControl, "CircularProgress_1")
    local origin_count = UI.getChildControl(originControl, "StaticText_Count")
    local origin_countValue = UI.getChildControl(originControl, "StaticText_Count_Value")
    UI.cloneControl(origin_progressBG, stc_ccCountBG, "Static_Count_ProgressBG")
    UI.cloneControl(origin_progress, stc_ccCountBG, "CircularProgress_1")
    UI.cloneControl(origin_count, stc_ccCountBG, "StaticText_Count")
    UI.cloneControl(origin_countValue, stc_ccCountBG, "StaticText_Count_Value")
  end
  local progress_ccCount = UI.getChildControl(stc_ccCountBG, "CircularProgress_1")
  local txt_ccCount = UI.getChildControl(stc_ccCountBG, "StaticText_Count")
  local txt_ccCountValue = UI.getChildControl(stc_ccCountBG, "StaticText_Count_Value")
  local stc_immuneBG = UI.getChildControl(panel, "Static_BG_Immune")
  if 0 == stc_immuneBG:getChildControlCount() then
    local originControl = UI.getChildControl(Panel_Actor_DummyCharacter_CC, "Static_BG_Immune")
    local origin_progressBG = UI.getChildControl(originControl, "Static_Immune_ProgressBG")
    local origin_progress = UI.getChildControl(originControl, "CircularProgress_1")
    local origin_immune = UI.getChildControl(originControl, "Static_Icon_Immune")
    local origin_bgText = UI.getChildControl(originControl, "StaticText_BG_Text")
    UI.cloneControl(origin_progressBG, stc_immuneBG, "Static_Immune_ProgressBG")
    UI.cloneControl(origin_progress, stc_immuneBG, "CircularProgress_1")
    UI.cloneControl(origin_immune, stc_immuneBG, "Static_Icon_Immune")
    UI.cloneControl(origin_bgText, stc_immuneBG, "StaticText_BG_Text")
  end
  local progress_immune = UI.getChildControl(stc_immuneBG, "CircularProgress_1")
  local stc_ccActiveBG = UI.getChildControl(panel, "Static_BG_CC_Active")
  if 0 == stc_ccActiveBG:getChildControlCount() then
    local originControl = UI.getChildControl(Panel_Actor_DummyCharacter_CC, "Static_BG_CC_Active")
    local origin_ccIcon = UI.getChildControl(originControl, "StaticText_CCIcon")
    UI.cloneControl(origin_ccIcon, stc_ccActiveBG, "StaticText_CCIcon")
  end
  local txt_activeCC = UI.getChildControl(stc_ccActiveBG, "StaticText_CCIcon")
  if false == stc_immuneBG:GetShow() and false == stc_ccCountBG:GetShow() and true == isUpdate then
    stc_ccActiveBG:SetShow(false)
    return false
  end
  if monsterActorProxyWrapper:get():getCurrentCCCount() < self._maxCCCount then
    stc_ccActiveBG:SetShow(false)
    stc_immuneBG:SetShow(false)
    progress_immune:SetSmoothMode(false)
    progress_immune:SetProgressRate(100)
  else
    stc_immuneBG:SetShow(true)
    local leftImmunTime = monsterActorProxyWrapper:get():getCCCountRemainTime() / monsterActorProxyWrapper:get():getMaxImmuneTime() * 100
    progress_immune:SetSmoothMode(true)
    progress_immune:SetProgressRate(leftImmunTime)
    stc_ccCountBG:SetShow(false)
    progress_ccCount:SetProgressRate(0)
    txt_ccCountValue:SetText(0)
  end
  if 0 == monsterActorProxyWrapper:get():getCCCountRemainTime() then
    stc_ccCountBG:SetShow(false)
    progress_ccCount:SetProgressRate(0)
    txt_ccCountValue:SetText(0)
  elseif false == stc_immuneBG:GetShow() then
    stc_immuneBG:SetShow(false)
    progress_immune:SetProgressRate(100)
    stc_ccCountBG:SetShow(true)
    local ccCountRate = monsterActorProxyWrapper:get():getCurrentCCCount() / self._maxCCCount * 100
    progress_ccCount:SetProgressRate(ccCountRate)
    txt_ccCountValue:SetText(tostring(monsterActorProxyWrapper:get():getCurrentCCCount() * 0.1))
    txt_ccCount:SetText((monsterActorProxyWrapper:get():getCCCountRemainTime()))
  end
  self:setCurrentCCType(actorKey, stc_ccActiveBG, txt_activeCC)
  return true
end
function PaGlobal_Actor_DummyCharacter_CC:setCCountSetting(actorKey)
  if nil == Panel_Actor_DummyCharacter_CC then
    return
  end
  local addTimer = self:update(actorKey, false)
  if nil ~= self._timerNo[actorKey] then
    luaTimer_RemoveEvent(self._timerNo[actorKey])
    self._timerNo[actorKey] = nil
  end
  if true == addTimer then
    self._timerNo[actorKey] = luaTimer_AddEvent(PaGlobal_Actor_DummyCharacter_CC_UpdateFunc, 1, true, 1, actorKey)
  end
end
function PaGlobal_Actor_DummyCharacter_CC:validate()
  if nil == Panel_Actor_DummyCharacter_CC then
    return
  end
end
