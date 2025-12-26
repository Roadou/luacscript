PaGlobal_Sequence_HpMpBar = {
  _define = {
    MP = 0,
    FP = 1,
    EP = 2,
    BP = 3,
    DK = 4,
    COLOR_BLIND = 5
  },
  _combatResources = {
    [0] = UI.getChildControl(Panel_Sequence_HpMpBar, "Progress_MPGauge"),
    UI.getChildControl(Panel_Sequence_HpMpBar, "Progress_FPGauge"),
    UI.getChildControl(Panel_Sequence_HpMpBar, "Progress_EPGauge"),
    UI.getChildControl(Panel_Sequence_HpMpBar, "Progress_BPGauge"),
    UI.getChildControl(Panel_Sequence_HpMpBar, "Progress_DarkGauge"),
    UI.getChildControl(Panel_Sequence_HpMpBar, "Progress_ColorBlindGauge")
  },
  _ui = {
    _staticHP_BG = nil,
    _staticMP_BG = nil,
    _staticGage_HP = nil,
    _staticGage_HP_Later = nil,
    _staticGage_CombatResource = nil,
    _combatResources_Later = nil,
    _combatResources_LaterHead = nil,
    _staticShowHp = nil,
    _staticShowMp = nil
  },
  _prevHP = -1,
  _prevMaxHP = -1,
  _prevMP = -1,
  _prevMaxMP = -1,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_Init_Sequence_HpMpBar")
function FromClient_Init_Sequence_HpMpBar()
  PaGlobal_Sequence_HpMpBar:initialize()
  PaGlobal_Sequence_HpMpBar:registEventHandler()
end
function PaGlobal_Sequence_HpMpBar:initialize()
  Panel_Sequence_HpMpBar:SetShow(false)
  self:setPosition()
  self._ui._staticHP_BG = UI.getChildControl(Panel_Sequence_HpMpBar, "Static_HP_MainBG")
  self._ui._staticMP_BG = UI.getChildControl(Panel_Sequence_HpMpBar, "Static_MP_MainBG")
  self._ui._staticGage_HP = UI.getChildControl(Panel_Sequence_HpMpBar, "Progress_HPGauge")
  self._ui._staticGage_HP_Later = UI.getChildControl(Panel_Sequence_HpMpBar, "Progress2_HpGaugeLater")
  self._ui._staticGage_CombatResource = nil
  self._ui._combatResources_Later = UI.getChildControl(Panel_Sequence_HpMpBar, "Progress2_MpGaugeLater")
  self._ui._combatResources_LaterHead = UI.getChildControl(UI.getChildControl(Panel_Sequence_HpMpBar, "Progress2_MpGaugeLater"), "Progress2_1_Bar_Head")
  self._ui._staticShowHp = UI.getChildControl(Panel_Sequence_HpMpBar, "StaticText_HP")
  self._ui._staticShowMp = UI.getChildControl(Panel_Sequence_HpMpBar, "StaticText_MP")
  self._initialize = true
end
function PaGlobal_Sequence_HpMpBar:resourceTypeCheck(selfPlayerWrapper, classType)
  local resourceType = selfPlayerWrapper:getCombatResourceType()
  local mpType = NewClassData.newClass_CategoryType[classType]._mpType
  local isColorBlindMode = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eColorBlindMode)
  if mpType == CppEnums.MpBarColor.DARKELF then
    resourceType = 4
  end
  for _, control in pairs(self._combatResources) do
    control:SetShow(false)
  end
  if 0 == isColorBlindMode then
    if resourceType >= self._define.MP then
      self._ui._staticGage_CombatResource = self._combatResources[resourceType]
    end
    self._ui._staticGage_HP:ChangeTextureInfoNameAsync("Renewal/Progress/Console_Progressbar_03.dds")
    local xx1, yy1, xx2, yy2 = setTextureUV_Func(self._ui._staticGage_HP, 380, 17, 413, 26)
    self._ui._staticGage_HP:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
    self._ui._staticGage_HP:setRenderTexture(self._ui._staticGage_HP:getBaseTexture())
  elseif 1 == isColorBlindMode then
    self._ui._staticGage_HP:ChangeTextureInfoNameAsync("Renewal/Progress/Console_Progressbar_03.dds")
    local xx1, yy1, xx2, yy2 = setTextureUV_Func(self._ui._staticGage_HP, 448, 12, 481, 21)
    self._ui._staticGage_HP:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
    self._ui._staticGage_HP:setRenderTexture(self._ui._staticGage_HP:getBaseTexture())
    self._ui._staticGage_CombatResource = self._combatResources[self._define.COLOR_BLIND]
  elseif 2 == isColorBlindMode then
    self._ui._staticGage_HP:ChangeTextureInfoNameAsync("Renewal/Progress/Console_Progressbar_03.dds")
    local xx1, yy1, xx2, yy2 = setTextureUV_Func(self._ui._staticGage_HP, 448, 12, 481, 21)
    self._ui._staticGage_HP:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
    self._ui._staticGage_HP:setRenderTexture(self._ui._staticGage_HP:getBaseTexture())
    self._ui._staticGage_CombatResource = self._combatResources[self._define.COLOR_BLIND]
  end
  self._ui._staticGage_CombatResource:SetShow(true)
  self._ui._combatResources_Later:SetShow(true)
end
function PaGlobalFunc_SequenceUserBar_CharacterInfoWindowUpdate()
  if Panel_Sequence_HpMpBar:GetShow() == false then
    return
  end
  local self = PaGlobal_Sequence_HpMpBar
  if self._initialize == false then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  local hp = math.floor(selfPlayer:getHp())
  local maxHp = math.floor(selfPlayer:getMaxHp())
  local mp = selfPlayer:getMp()
  local maxMp = selfPlayer:getMaxMp()
  PaGlobalFunc_SequenceUserBar_CharacterInfoWindowUpdateHp()
  PaGlobalFunc_SequenceUserBar_CharacterInfoWindowUpdateMp(mp, maxMp, mp / maxMp * 100)
end
function PaGlobalFunc_SequenceUserBar_CharacterInfoWindowUpdateMp(mp, maxMp, percent)
  if Panel_Sequence_HpMpBar:GetShow() == false then
    return
  end
  local self = PaGlobal_Sequence_HpMpBar
  if self._initialize == false then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  local classType = selfPlayerWrapper:getClassType()
  self:resourceTypeCheck(selfPlayerWrapper, classType)
  local effectName = ""
  local isEP_Character = __eClassType_ElfRanger == classType or __eClassType_RangerMan == classType
  local isFP_Character = __eClassType_Warrior == classType or __eClassType_Giant == classType or __eClassType_BladeMaster == classType or __eClassType_BladeMasterWoman == classType or __eClassType_Kunoichi == classType or __eClassType_Combattant == classType or __eClassType_Lhan == classType or __eClassType_Guardian == classType
  local isBP_Character = __eClassType_Valkyrie == classType
  local isMP_Character = not isEP_Character and not isFP_Character and not isBP_Character
  if isEP_Character then
    effectName = "fUI_Gauge_Green"
  elseif isFP_Character then
    effectName = "fUI_Gauge_Mental"
  elseif isBP_Character then
    effectName = "fUI_Gauge_Blue"
  elseif isMP_Character then
    effectName = "fUI_Gauge_Blue"
  end
  if maxMp ~= 0 then
    self._ui._staticGage_CombatResource:SetProgressRate(percent)
    self._ui._staticGage_CombatResource:SetShow(true)
    if self._prevMP ~= mp or self._prevMaxMP ~= maxMp then
      self._ui._staticShowMp:SetText(tostring(mp) .. "/" .. tostring(maxMp))
      self._ui._combatResources_Later:SetProgressRate(percent)
      self._ui._combatResources_Later:SetShow(true)
      if mp - self._prevMP > 10 then
        local MP_BG_PosX = self._ui._staticMP_BG:GetPosX()
        local MP_BG_PosY = self._ui._staticMP_BG:GetPosY()
        self._ui._staticGage_CombatResource:AddEffect(effectName, false, 0, 0)
      end
      self._prevMP = mp
      self._prevMaxMP = maxMp
    end
  end
  self._ui._staticShowMp:SetPosX(2.85 * self._ui._staticGage_CombatResource:GetProgressRate() + 43)
  self._ui._staticShowMp:SetTextSpan(0, -14)
end
function PaGlobalFunc_SequenceUserBar_CharacterInfoWindowUpdateHp()
  if Panel_Sequence_HpMpBar:GetShow() == false then
    return
  end
  local self = PaGlobal_Sequence_HpMpBar
  if self._initialize == false then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  local classType = selfPlayerWrapper:getClassType()
  local selfPlayer = selfPlayerWrapper:get()
  self:resourceTypeCheck(selfPlayerWrapper, classType)
  local hp = math.floor(selfPlayer:getHp())
  local maxHp = math.floor(selfPlayer:getMaxHp())
  self._prevHp = hp
  if maxHp ~= 0 and (self._prevHP ~= hp or self._prevMaxHP ~= maxHp) then
    self._ui._staticShowHp:SetText(tostring(hp) .. "/" .. tostring(maxHp))
    self._ui._staticGage_HP_Later:SetProgressRate(hp / maxHp * 100)
    self._ui._staticGage_HP:SetProgressRate(hp / maxHp * 100)
    if hp - self._prevHP > 5 then
      local HP_BG_PosX = self._ui._staticHP_BG:GetPosX()
      local HP_BG_PosY = self._ui._staticHP_BG:GetPosY()
      self._ui._staticGage_HP:AddEffect("fUI_Gauge_Red", false, 0, 0)
    end
    self._prevHP = hp
    self._prevMaxHP = maxHp
  end
  self._ui._staticShowHp:SetPosX(2.85 * self._ui._staticGage_HP:GetProgressRate() + 43)
end
function FromClient_SequenceUserBar_CharacterInfoWindowUpdateHp(hp, maxHp, minorSiegeMaxHp, percentHp, percentProgress, isArenaZone, classType, combatResourceType)
  if Panel_Sequence_HpMpBar:GetShow() == false then
    return
  end
  local self = PaGlobal_Sequence_HpMpBar
  if self._initialize == false then
    return
  end
  local resourceType = combatResourceType
  local mpType = NewClassData.newClass_CategoryType[classType]._mpType
  local isColorBlindMode = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eColorBlindMode)
  if mpType == CppEnums.MpBarColor.DARKELF then
    resourceType = 4
  end
  for _, control in pairs(self._combatResources) do
    control:SetShow(false)
  end
  if 0 == isColorBlindMode then
    if resourceType >= self._define.MP then
      self._ui._staticGage_CombatResource = self._combatResources[resourceType]
    end
    self._ui._staticGage_HP:ChangeTextureInfoNameAsync("Renewal/Progress/Console_Progressbar_03.dds")
    local xx1, yy1, xx2, yy2 = setTextureUV_Func(self._ui._staticGage_HP, 380, 17, 413, 26)
    self._ui._staticGage_HP:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
    self._ui._staticGage_HP:setRenderTexture(self._ui._staticGage_HP:getBaseTexture())
  elseif 1 == isColorBlindMode then
    self._ui._staticGage_HP:ChangeTextureInfoNameAsync("Renewal/Progress/Console_Progressbar_03.dds")
    local xx1, yy1, xx2, yy2 = setTextureUV_Func(self._ui._staticGage_HP, 448, 12, 481, 21)
    self._ui._staticGage_HP:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
    self._ui._staticGage_HP:setRenderTexture(self._ui._staticGage_HP:getBaseTexture())
    self._ui._staticGage_CombatResource = self._combatResources[self._define.COLOR_BLIND]
  elseif 2 == isColorBlindMode then
    self._ui._staticGage_HP:ChangeTextureInfoNameAsync("Renewal/Progress/Console_Progressbar_03.dds")
    local xx1, yy1, xx2, yy2 = setTextureUV_Func(self._ui._staticGage_HP, 448, 12, 481, 21)
    self._ui._staticGage_HP:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
    self._ui._staticGage_HP:setRenderTexture(self._ui._staticGage_HP:getBaseTexture())
    self._ui._staticGage_CombatResource = self._combatResources[self._define.COLOR_BLIND]
  end
  self._ui._staticGage_CombatResource:SetShow(true)
  self._ui._combatResources_Later:SetShow(true)
  self._prevHp = hp
  if maxHp ~= 0 and (self._prevHP ~= hp or self._prevMaxHP ~= maxHp) then
    self._ui._staticShowHp:SetText(tostring(hp) .. "/" .. tostring(maxHp))
    self._ui._staticGage_HP_Later:SetProgressRate(percentProgress)
    self._ui._staticGage_HP:SetProgressRate(percentProgress)
    if hp - self._prevHP > 5 then
      self._ui._staticGage_HP:AddEffect("fUI_Gauge_Red", false, 0, 0)
    end
    self._prevHP = hp
    self._prevMaxHP = maxHp
  end
  self._ui._staticShowHp:SetPosX(2.85 * self._ui._staticGage_HP:GetProgressRate() + 43)
end
function FromClient_EnterSequencePossessMode_Sequence_HpMpBar_Open()
  Panel_Sequence_HpMpBar:SetAlpha(0)
  Panel_Sequence_HpMpBar:SetShow(true)
  local aniInfo = UIAni.AlphaAnimation(1, Panel_Sequence_HpMpBar, 0, 0.8)
  aniInfo:SetDisableWhileAni(true)
  PaGlobalFunc_SequenceUserBar_CharacterInfoWindowUpdate()
end
function FromClient_LeaveSequencePossessMode_Sequence_HpMpBar_Close()
  Panel_Sequence_HpMpBar:SetShow(false)
end
function PaGlobal_Sequence_HpMpBar:registEventHandler()
  registerEvent("onScreenResize", "FromClient_Sequence_HpMpBar_OnResize")
  registerEvent("EventCharacterInfoUpdate", "PaGlobalFunc_SequenceUserBar_CharacterInfoWindowUpdate()")
  registerEvent("FromClient_SelfPlayerHpChanged", "FromClient_SequenceUserBar_CharacterInfoWindowUpdateHp")
  registerEvent("FromClient_SelfPlayerMpChanged", "PaGlobalFunc_SequenceUserBar_CharacterInfoWindowUpdateMp")
  registerEvent("FromClient_EnterSequencePossessMode", "FromClient_EnterSequencePossessMode_Sequence_HpMpBar_Open")
  registerEvent("FromClient_LeaveSequencePossessMode", "FromClient_LeaveSequencePossessMode_Sequence_HpMpBar_Close")
end
function FromClient_Sequence_HpMpBar_OnResize()
  Panel_Sequence_HpMpBar:ComputePos()
  PaGlobal_Sequence_HpMpBar:setPosition()
end
function PaGlobal_Sequence_HpMpBar:setPosition()
  Panel_Sequence_HpMpBar:SetPosX(getScreenSizeX() / 2 - Panel_Sequence_HpMpBar:GetSizeX() / 2)
  Panel_Sequence_HpMpBar:SetPosY(getScreenSizeY() - Panel_Sequence_HpMpBar:GetSizeY() - 200)
end
