function FromClient_CharInfoBasic_All_TendecyUpdate()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  PaGlobal_CharInfoBasic_All._ui.txt_Tendency:SetText(PaGlobal_CharInfoBasic_All._selfPlayer:get():getTendency())
  PaGlobal_CharInfoBasic_All:SetEnableAreaByTextSize(PaGlobal_CharInfoBasic_All._ui.txt_Tendency)
end
function FromClient_CharInfoBasic_All_OceanTendecyUpdate()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  if false == _ContentsGroup_OceanTendency then
    return
  end
  local oceanTendency = PaGlobal_CharInfoBasic_All._selfPlayer:get():getOceanTendency()
  PaGlobal_CharInfoBasic_All._ui.txt_OceanTendency:SetText(oceanTendency)
  if oceanTendency >= 0 then
    PaGlobal_CharInfoBasic_All._ui.stc_OceanTendencyPirateIcon:SetShow(false)
    PaGlobal_CharInfoBasic_All._ui.stc_OceanTendencyNavyIcon:SetShow(true)
  else
    PaGlobal_CharInfoBasic_All._ui.stc_OceanTendencyPirateIcon:SetShow(true)
    PaGlobal_CharInfoBasic_All._ui.stc_OceanTendencyNavyIcon:SetShow(false)
  end
  PaGlobal_CharInfoBasic_All:SetEnableAreaByTextSize(PaGlobal_CharInfoBasic_All._ui.txt_OceanTendency)
end
function FromClient_CharInfoBasic_All_ContributeUpdate()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  PaGlobal_CharInfoBasic_All._ui.txt_Contribute:SetText(PaGlobal_CharInfo_All:getContributeString())
  PaGlobal_CharInfoBasic_All:SetEnableAreaByTextSize(PaGlobal_CharInfoBasic_All._ui.txt_Contribute)
end
function FromClient_CharInfoBasic_All_MentalUpdate()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  PaGlobal_CharInfoBasic_All._ui.txt_Wp:SetText(tostring(PaGlobal_CharInfoBasic_All._selfPlayer:getWp()) .. " / " .. tostring(PaGlobal_CharInfoBasic_All._selfPlayer:getMaxWp()))
  PaGlobal_CharInfoBasic_All:SetEnableAreaByTextSize(PaGlobal_CharInfoBasic_All._ui.txt_Wp)
end
function FromClient_CharInfoBasic_All_LevelUpdate()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  local lv = PaGlobal_CharInfoBasic_All._selfPlayer:get():getLevel()
  PaGlobal_CharInfoBasic_All._ui.txt_PlayerLv:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORKERAUCTION_WORKERLEVEL", "level", tostring(lv)))
end
function PaGlobalFunc_CharInfoBasic_All_HpUpdate()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  local hp = math.floor(PaGlobal_CharInfoBasic_All._selfPlayer:get():getHp())
  local maxHp = math.floor(PaGlobal_CharInfoBasic_All._selfPlayer:get():getMaxHp())
  PaGlobal_CharInfoBasic_All._ui.txt_HpVal:SetText(tostring(hp) .. " / " .. tostring(maxHp))
end
function FromClient_CharInfoBasic_All_HpUpdate(hp, maxHp, minorSiegeMaxHp, percentHp, percentProgress, isArenaZone, classType, combatResourceType)
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  PaGlobal_CharInfoBasic_All._ui.txt_HpVal:SetText(tostring(hp) .. " / " .. tostring(maxHp))
end
function PaGlobalFunc_CharInfoBasic_All_MpUpdate(Mp, maxMp, percent)
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  local mp = PaGlobal_CharInfoBasic_All._selfPlayer:get():getMp()
  local maxMp = PaGlobal_CharInfoBasic_All._selfPlayer:get():getMaxMp()
  PaGlobal_CharInfoBasic_All._ui.txt_Mp_Val:SetText(tostring(mp) .. " / " .. tostring(maxMp))
end
function FromClient_CharInfoBasic_All_MpUpdate(Mp, maxMp, percent)
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  PaGlobal_CharInfoBasic_All._ui.txt_Mp_Val:SetText(tostring(Mp) .. " / " .. tostring(maxMp))
end
function FromClient_CharInfoBasic_All_WeightUpdate()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  local selfPlayerGet = PaGlobal_CharInfoBasic_All._selfPlayer:get()
  local s64_allWeight = selfPlayerGet:getCurrentWeight_s64()
  local s64_maxWeight = selfPlayerGet:getPossessableWeight_s64()
  local s64_maxWeight_div = s64_maxWeight / Defines.s64_const.s64_100
  local str_AllWeight = makeWeightString(s64_allWeight, 1)
  local str_MaxWeight = makeWeightString(s64_maxWeight, 0)
  local rate = Int64toInt32(s64_allWeight / s64_maxWeight_div)
  local isShow = rate > 0
  PaGlobal_CharInfoBasic_All._ui.txt_LTVal:SetText(str_AllWeight .. " / " .. str_MaxWeight .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT"))
end
function FromClient_CharInfoBasic_All_AtkDefUpdate()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) or false == PaGlobal_CharInfoBasic_All._ui.stc_BattleInfoBg:GetShow() then
    return
  end
  ToClient_updateAttackStat()
  local self = PaGlobal_CharInfoBasic_All
  self._ui.txt_Atk:SetText(tostring(ToClient_getAttackDisplayOffence(__eSkillTypeParam_Normal, true)))
  self._ui.txt_Def:SetText(tostring(ToClient_getAttackDisplayDefence(true)))
  local BattileInfoTitleSpanY = 5
  local gap = 25
  local isSetAwakenWeapon = ToClient_getEquipmentItem(__eEquipSlotNoAwakenWeapon)
  local isShyWomen = __eClassType_ShyWaman == self._selfPlayer:getClassType()
  local flag = nil ~= isSetAwakenWeapon and self._isAwakenWeaponContentsOpen
  self._ui.txt_AwakenTitle:SetText(flag)
  if true == flag then
    self._ui.txt_AwakenAtk:SetText(tostring(ToClient_getAttackDisplayOffence(__eSkillTypeParam_Awaken, true)))
  end
  if flag ~= self._checkAwaken then
    self._checkAwaken = flag
    self._ui.txt_AwakenTitle:SetShow(flag)
    self._ui.txt_AwakenAtk:SetShow(flag)
    local statUI = {
      [1] = self._ui.txt_AtkTitle,
      [2] = nil,
      [3] = self._ui.txt_DefTitle,
      [4] = self._ui.txt_AtkTypeTitle,
      [5] = self._ui.txt_StaminaTitle,
      [6] = self._ui.txt_StunRegistTitle,
      [7] = self._ui.txt_DownRegistTitle,
      [8] = self._ui.txt_AirRegistTitle,
      [9] = self._ui.txt_ItemDropRateTitle
    }
    if true == flag then
      statUI[2] = self._ui.txt_AwakenTitle
      if true == isShyWomen then
        self._ui.txt_AwakenTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SHYSTAT_1"))
      else
        self._ui.txt_AwakenTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_AWAKENATTACK"))
      end
    end
    local uiCount = 1
    for i = 1, 10 do
      if nil ~= statUI[i] then
        statUI[i]:SetSpanSize(statUI[i]:GetSpanSize().x, 0)
        statUI[i]:SetSpanSize(self._statOriginSpanX, BattileInfoTitleSpanY + statUI[i]:GetSpanSize().y + (gap * uiCount - 0))
        uiCount = uiCount + 1
      end
    end
    self._ui.txt_Atk:SetSpanSize(self._statOriginSpanX, self._ui.txt_AtkTitle:GetSpanSize().y)
    self._ui.txt_AwakenAtk:SetSpanSize(self._statOriginSpanX, self._ui.txt_AwakenTitle:GetSpanSize().y)
    self._ui.txt_Def:SetSpanSize(self._statOriginSpanX, self._ui.txt_DefTitle:GetSpanSize().y)
    self._ui.txt_AtkTypeRegist:SetSpanSize(self._statOriginSpanX, self._ui.txt_AtkTypeTitle:GetSpanSize().y)
    self._ui.txt_Stamina:SetSpanSize(self._statOriginSpanX, self._ui.txt_StaminaTitle:GetSpanSize().y)
    self._ui.txt_StunRegist:SetSpanSize(self._statOriginSpanX, self._ui.txt_StunRegistTitle:GetSpanSize().y)
    self._ui.txt_DownRegist:SetSpanSize(self._statOriginSpanX, self._ui.txt_DownRegistTitle:GetSpanSize().y)
    self._ui.txt_AirRegist:SetSpanSize(self._statOriginSpanX, self._ui.txt_AirRegistTitle:GetSpanSize().y)
    self._ui.txt_ItemDropRate:SetSpanSize(self._statOriginSpanX, self._ui.txt_ItemDropRateTitle:GetSpanSize().y)
    if 1 >= Panel_CharacterInfo_All:GetScale().x then
      HandleEventLUp_ChracterInfo_All_ScaleResizeLDown()
      HandleEventLUp_ChracterInfo_All_ScaleResizeLPress()
      HandleEventLUp_ChracterInfo_All_ScaleResizeLUp()
    end
  end
end
function FromClient_CharInfoBasic_All_StaminaUpdate()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) and false == PaGlobal_CharInfoBasic_All._ui.stc_BattleInfoBg:GetShow() then
    return
  end
  PaGlobal_CharInfoBasic_All._ui.txt_Stamina:SetText(tostring(ToClient_GetSelfPlayerMaxSP()))
end
function FromClient_CharInfoBasic_All_SPUpdate()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  local spInfo = ToClient_getSkillPointInfo(0)
  if nil ~= spInfo then
    PaGlobal_CharInfoBasic_All._ui.txt_SkillPoint:SetText(tostring(spInfo._remainPoint .. " / " .. spInfo._acquirePoint))
    PaGlobal_CharInfoBasic_All:SetEnableAreaByTextSize(PaGlobal_CharInfoBasic_All._ui.txt_SkillPoint)
  end
end
function FromClient_CharInfoBasic_All_FamliyFameUpdate()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) and false == PaGlobal_CharInfoBasic_All._ui.stc_BattleInfoBg:GetShow() then
    return
  end
  PaGlobal_CharInfoBasic_All._familyBattlePoint = PaGlobal_CharInfoBasic_All._selfPlayer:get():getBattleFamilyPoint()
  PaGlobal_CharInfoBasic_All._familyLifePoint = PaGlobal_CharInfoBasic_All._selfPlayer:get():getLifeFamilyPoint()
  PaGlobal_CharInfoBasic_All._familyEtcPoint = PaGlobal_CharInfoBasic_All._selfPlayer:get():getEtcFamilyPoint()
  PaGlobal_CharInfoBasic_All._familySumPoint = PaGlobal_CharInfoBasic_All._familyBattlePoint + PaGlobal_CharInfoBasic_All._familyLifePoint + PaGlobal_CharInfoBasic_All._familyEtcPoint
  PaGlobal_CharInfoBasic_All._ui.txt_BattlePoint:SetText(PaGlobal_CharInfoBasic_All._familyBattlePoint)
  PaGlobal_CharInfoBasic_All._ui.txt_LifePoint:SetText(PaGlobal_CharInfoBasic_All._familyLifePoint)
  PaGlobal_CharInfoBasic_All._ui.txt_SpecialPoint:SetText(PaGlobal_CharInfoBasic_All._familyEtcPoint)
  PaGlobal_CharInfoBasic_All._ui.txt_FamilyPoint:SetText(PaGlobal_CharInfoBasic_All._familySumPoint)
end
function FromClient_CharInfoBasic_All_ResistUpdate()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  local defenceStat = ToClient_getCharacterAttackDefenceStat()
  if defenceStat == nil then
    PaGlobal_CharInfoBasic_All._ui.txt_StunRegist:SetText(math.floor(0) .. "%")
    PaGlobal_CharInfoBasic_All._ui.txt_DownRegist:SetText(math.floor(0) .. "%")
    PaGlobal_CharInfoBasic_All._ui.txt_AirRegist:SetText(math.floor(0) .. "%")
    return
  end
  local cc1 = tostring(defenceStat:getActionRestrictResistance(__eActionRestrictStatType_Stun) / CppDefine.e1Percent) .. "%"
  local cc2 = tostring(defenceStat:getActionRestrictResistance(__eActionRestrictStatType_Knockdown) / CppDefine.e1Percent) .. "%"
  local cc3 = tostring(defenceStat:getActionRestrictResistance(__eActionRestrictStatType_Knockback) / CppDefine.e1Percent) .. "%"
  PaGlobal_CharInfoBasic_All._ui.txt_StunRegist:SetText(cc1)
  PaGlobal_CharInfoBasic_All._ui.txt_DownRegist:SetText(cc2)
  PaGlobal_CharInfoBasic_All._ui.txt_AirRegist:SetText(cc3)
end
function FromClient_CharInfoBasic_All_ItemDropRateUpdate()
  if PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) == false then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local itemDropTotalPercent = 0
  if selfPlayer:isUseDropItemGroupList() == true then
    for groupIndex = 0, __eEfficiencyOfDropItemGroup_Count - 1 do
      local itemDropGroupPercent = selfPlayer:getEfficiencyOfDropItemPercent(groupIndex)
      local maxDropGroupPercent = selfPlayer:getEfficiencyOfDropItemPercentMax(groupIndex)
      if itemDropGroupPercent > maxDropGroupPercent then
        itemDropGroupPercent = maxDropGroupPercent
      end
      itemDropTotalPercent = itemDropTotalPercent + itemDropGroupPercent
    end
  end
  PaGlobal_CharInfoBasic_All._ui.txt_ItemDropRate:SetText(itemDropTotalPercent .. "%")
end
function FromClient_CharInfoBasic_All_LifeUpdate()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) and false == PaGlobal_CharInfoBasic_All._ui.stc_LifeBg:GetShow() then
    return
  end
  if nil == PaGlobal_CharInfoBasic_All._ui.stc_LifeTable then
    UI.ASSERT_NAME(nil ~= PaGlobal_CharInfoBasic_All._ui.stc_LifeTable, " Panel_CharacterInfoBasic_All_3.lua / PaGlobal_CharInfoBasic_All._ui.stc_LifeTable is nil", "-")
    return
  end
  for idx = 1, PaGlobal_CharInfoBasic_All._LIFEINFOCOUNT do
    local lifeType = idx - 1
    if 10 == lifeType then
      lifeType = lifeType + 1
    end
    local currentExp64 = PaGlobal_CharInfoBasic_All._selfPlayer:get():getCurrLifeExperiencePoint(lifeType)
    local needExp64 = PaGlobal_CharInfoBasic_All._selfPlayer:get():getDemandLifeExperiencePoint(lifeType)
    local currentExpRate64 = currentExp64 * toInt64(0, 10000) / needExp64
    local currentExpRate = Int64toInt32(currentExpRate64)
    currentExpRate = currentExpRate / 100
    local currentExpRateString = string.format("%.2f", currentExpRate)
    local lvString = PaGlobalFunc_Util_CraftLevelColorReplace(PaGlobal_CharInfoBasic_All._selfPlayer:get():getLifeExperienceLevel(lifeType))
    local isShow = currentExpRate > 0
    PaGlobal_CharInfoBasic_All._ui.stc_LifeTable[idx].lv:SetText(lvString)
    PaGlobal_CharInfoBasic_All._ui.stc_LifeTable[idx].prog2:SetShow(isShow)
    PaGlobal_CharInfoBasic_All._ui.stc_LifeTable[idx].prog2:SetProgressRate(currentExpRate)
    PaGlobal_CharInfoBasic_All._ui.stc_LifeTable[idx].rate:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TRADEMARKET_ALL_SELLRATES", "Percent", currentExpRateString))
    PaGlobal_CharInfoBasic_All._ui.stc_LifeTable[idx].expVal = currentExpRate
  end
end
function FromClient_CharInfoBasic_All_PotentialUpdate()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) or false == PaGlobal_CharInfoBasic_All._ui.stc_BattleInfoBg:GetShow() then
    return
  end
  if nil == PaGlobal_CharInfoBasic_All._potentialData then
    UI.ASSERT_NAME(nil ~= PaGlobal_CharInfoBasic_All._ui.stc_LifeTable, " Panel_CharacterInfoBasic_All_3.lua / PaGlobal_CharInfoBasic_All._potentialData is nil", "-")
    return
  end
  local self = PaGlobal_CharInfoBasic_All
  local levelText = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_POTENLEVEL")
  local classType = self._selfPlayer:getClassType()
  local localFlag = isGameTypeKorea() or isGameTypeTaiwan()
  local function potentialDataSet(potenType)
    local castData = {move = 0, attack = 1}
    local lvData = 1
    if self._ENUM_POTEN.ATKSPD == potenType then
      lvData = self._selfPlayer:characterStatPointSpeed(castData.attack + NewClassData.newClass_CategoryType[classType]._battleSpeed)
      limitSpeed = self._selfPlayer:characterStatPointLimitedSpeed(castData.attack + NewClassData.newClass_CategoryType[classType]._battleSpeed)
      if lvData > limitSpeed then
        lvData = limitSpeed
      end
      return lvData - 5
    elseif self._ENUM_POTEN.MOVESPD == potenType then
      lvData = self._selfPlayer:characterStatPointSpeed(castData.move)
      limitSpeed = self._selfPlayer:characterStatPointLimitedSpeed(castData.move)
      if lvData > limitSpeed then
        lvData = limitSpeed
      end
      return lvData - 5
    elseif self._ENUM_POTEN.CRITICAL == potenType then
      lvData = self._selfPlayer:characterStatPointCritical()
      limitSpeed = self._selfPlayer:characterStatPointLimitedCritical()
      if lvData > limitSpeed then
        lvData = limitSpeed
      end
      return lvData
    elseif self._ENUM_POTEN.FISH == potenType then
      lvData = self._selfPlayer:getCharacterStatPointFishing()
      limitSpeed = self._selfPlayer:getCharacterStatPointLimitedFishing()
      if lvData > limitSpeed then
        lvData = limitSpeed
      end
      return lvData
    elseif self._ENUM_POTEN.COLLECT == potenType then
      lvData = self._selfPlayer:getCharacterStatPointCollection()
      limitSpeed = self._selfPlayer:getCharacterStatPointLimitedCollection()
      if lvData > limitSpeed then
        lvData = limitSpeed
      end
      return lvData
    elseif self._ENUM_POTEN.LUCK == potenType then
      lvData = self._selfPlayer:getCharacterStatPointDropItem()
      limitSpeed = self._selfPlayer:getCharacterStatPointLimitedDropItem()
      if lvData > limitSpeed then
        lvData = limitSpeed
      end
      return lvData
    end
  end
  for potenIdx = 0, self._MAX_POTENCIALSLOT + 1 do
    if nil ~= self._potentialData[potenIdx] or nil ~= self._potentialData[potenIdx].slot then
      for idx = 0, self._MAX_POTENCIALSLOT do
        self._potentialData[potenIdx].slot[idx]:SetShow(false)
      end
      local lvCount = potentialDataSet(potenIdx)
      self._potentialData[potenIdx].val:SetShow(localFlag)
      if true == localFlag then
        self._potentialData[potenIdx].val:SetText(lvCount .. levelText)
      end
      for idx = 0, lvCount - 1 do
        self._potentialData[potenIdx].slot[idx]:SetShow(true)
      end
    end
  end
end
function FromClient_CharInfoBasic_All_FitnesspUpdate(addSp, addWeight, addHp, addMp)
  local self = PaGlobal_CharInfoBasic_All
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) and false == self._ui.stc_BattleInfoBg:GetShow() then
    return
  end
  local playerWrapper = getSelfPlayer()
  local classType = playerWrapper:getClassType()
  local mainStr = ""
  local subStr = ""
  if addSp > 0 then
    mainStr = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_DEX")
    subStr = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_LEVELUP_REWARD_LvupStatus1", "AddSp", addSp, "GetMaxSp", getSelfPlayer():get():getStamina():getMaxSp())
    ToClient_RequestNakMessageRenewelWithString(__eNakMessage_FitnessLevelUpEndurance, mainStr, subStr)
  elseif addWeight > 0 then
    mainStr = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_STR")
    subStr = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_LEVELUP_REWARD_LvupStatus2", "AddWeight", addWeight / 10000, "UserWeight", Int64toInt32(getSelfPlayer():get():getPossessableWeight_s64()) / 10000)
    Inventory_updateSlotData()
    FromClient_CharInfoBasic_All_WeightUpdate()
    ToClient_RequestNakMessageRenewelWithString(__eNakMessage_FitnessLevelUpStrength, mainStr, subStr)
  elseif addHp > 0 and addMp > 0 then
    mainStr = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_CON")
    subStr = PAGetString(Defines.StringSheet_GAME, "LUA_LEVELUP_REWARD_MAXHPUP") .. "<PAColor0xFFFFBD2E>+" .. addHp .. "<PAOldColor>, "
    local mpType = NewClassData.newClass_CategoryType[classType]._mpType
    if mpType == nil then
      mpType = CppEnums.MpBarColor.MP
    end
    if mpType == CppEnums.MpBarColor.EP or mpType == CppEnums.MpBarColor.MP then
      subStr = subStr .. PAGetString(Defines.StringSheet_GAME, "LUA_LEVELUP_REWARD_MAXMPUP") .. "<PAColor0xFFFFBD2E>+" .. addMp .. "<PAOldColor>"
    elseif mpType == CppEnums.MpBarColor.DARKELF then
      subStr = subStr .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LEVELUP_REWARD_MAXEPUP", "ep", addMp)
    elseif mpType == CppEnums.MpBarColor.FP then
      subStr = subStr .. PAGetString(Defines.StringSheet_GAME, "LUA_LEVELUP_REWARD_MAXFPUP") .. "<PAColor0xFFFFBD2E>+" .. addMp .. "<PAOldColor>"
    elseif mpType == CppEnums.MpBarColor.BP then
      subStr = subStr .. PAGetString(Defines.StringSheet_GAME, "LUA_LEVELUP_REWARD_MAXBPUP") .. "<PAColor0xFFFFBD2E>+" .. addMp .. "<PAOldColor>"
    end
    ToClient_RequestNakMessageRenewelWithString(__eNakMessage_FitnessLevelUpHealth, mainStr, subStr)
  end
  local _mentalType = self._selfPlayer:getCombatResourceType()
  local _mpName = {
    [CppEnums.CombatResourceType.CombatType_MP] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_MP"),
    [CppEnums.CombatResourceType.CombatType_FP] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_FP_NEW"),
    [CppEnums.CombatResourceType.CombatType_EP] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_EP"),
    [CppEnums.CombatResourceType.CombatType_BP] = PAGetString(Defines.StringSheet_GAME, "LUA_SELFCHARACTERINFO_BP")
  }
  local mpTypeTitle = _mpName[_mentalType]
  local titleString = {
    [0] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_FITNESS_STAMINA_TITLE"),
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_FITNESS_STRENGTH_TITLE"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_FITNESS_HEALTH_TITLE")
  }
  if false == self._asianFlag then
    titleString[0] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_FITNESS_STAMINA_TITLE_ONE")
    titleString[1] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_FITNESS_STRENGTH_TITLE_ONE")
    titleString[2] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_FITNESS_HEALTH_TITLE_ONE")
  end
  for index = 0, 2 do
    local current = Int64toInt32(self._selfPlayer:get():getCurrFitnessExperiencePoint(index))
    local max = Int64toInt32(self._selfPlayer:get():getDemandFItnessExperiencePoint(index))
    local rate = current / max * 100
    local level = self._selfPlayer:get():getFitnessLevel(index)
    local _hpIncrease = tostring(ToClient_GetFitnessLevelStatus(index, 0))
    local _mpIncrease = tostring(ToClient_GetFitnessLevelStatus(index, 1))
    local _heathInfo
    if nil == rate then
      rate = 0
    end
    self._fitnessData[index]._prog2:SetProgressRate(rate)
    self._fitnessData[index]._level:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_CRAFTLEVEL") .. tostring(level))
    if true == PaGlobal_CharInfoBasic_All._asianFlag then
      if index == 0 then
        titleString[index] = titleString[index] .. tostring(ToClient_GetFitnessLevelStatus(index, 0))
      elseif index == 1 then
        titleString[index] = titleString[index] .. tostring(ToClient_GetFitnessLevelStatus(index, 0) / 10000)
      else
        titleString[index] = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_FITNESS_HEALTHINFO_NEW", "hpIncrease", _hpIncrease, "mpTypeName", mpTypeTitle, "mpIncrease", _mpIncrease)
      end
    end
    self._fitnessData[index]._titleUI:SetText(titleString[index])
    self._fitnessData[index]._titleUI:SetEnableArea(0, 0, self._fitnessData[index]._titleUI:GetTextSizeX(), self._fitnessData[index]._titleUI:GetTextSizeY())
  end
end
function FromClient_CharInfoBasic_All_EnchantStackUpdate()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  local defaultCount = PaGlobal_CharInfoBasic_All._selfPlayer:get():getEnchantFailCount()
  local valksCount = PaGlobal_CharInfoBasic_All._selfPlayer:get():getEnchantValuePackCount()
  local familyCount = getEnchantInformation():ToClient_getBonusStackCount()
  if ToClient_IsReceivedEnchantFailCount() then
    PaGlobal_CharInfoBasic_All._ui.txt_EnchantCount:SetText(defaultCount + valksCount + familyCount)
    PaGlobal_CharInfoBasic_All._ui.txt_EnchantStackIcon_Value:SetText(defaultCount + valksCount + familyCount)
  else
    PaGlobal_CharInfoBasic_All._ui.txt_EnchantCount:SetText("-")
  end
  PaGlobal_CharInfoBasic_All._ui.txt_EnchantCount:SetEnableArea(0, 0, PaGlobal_CharInfoBasic_All._ui.txt_EnchantCount:GetTextSizeX(), PaGlobal_CharInfoBasic_All._ui.txt_EnchantCount:GetTextSizeY())
end
function FromClient_CharInfoBasic_All_IncreaseMusicExp()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  if true == _ContentsGroup_InstrumentPerformance then
    PaGlobal_CharInfoBasic_All._ui.txt_MusicGradeValue:SetText(ToClient_GetMusicRank())
    PaGlobal_CharInfoBasic_All._ui.txt_MusicGradeValue:SetEnableArea(0, 0, PaGlobal_CharInfoBasic_All._ui.txt_MusicGradeValue:GetTextSizeX(), PaGlobal_CharInfoBasic_All._ui.txt_MusicGradeValue:GetTextSizeY())
  end
end
function FromClient_CharInfoBasic_All_IntroduceUpdate()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  local inputString = PaGlobal_CharInfoBasic_All._ui.edit_multiEdit:GetEditText()
  local selfMsg = ToClient_GetUserIntroduction()
  if "" ~= selfMsg then
    PaGlobal_CharInfoBasic_All._ui.edit_multiEdit:SetEditText(selfMsg)
  else
    PaGlobal_CharInfoBasic_All._ui.edit_multiEdit:SetEditText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERINFO_MYINTRODUCE_INPUT"))
  end
  if inputString == selfMsg then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SELFCHARACTERINFO_MYINTRODUCE_REGIST"))
  elseif _ContentsOption_CH_GameType == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoInvalidWordForChina"))
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoInappropriateWord"))
  end
end
function FromClient_CharInfoBasic_All_CompleteCharacterSwap()
  local self = PaGlobal_CharInfoBasic_All
  if self == nil then
    return
  end
  self:setUnChangedData()
end
function PaGlobal_CharInfoBasic_All_BattleStatUpdate()
  if PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) == false then
    return
  end
  FromClient_CharInfoBasic_All_AtkDefUpdate()
  FromClient_CharInfoBasic_All_ResistUpdate()
end
