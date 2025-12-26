function FromClient_CharInfoBasic_HardCore_All_LevelUpdate()
  local index = PaGlobal_CharacterInfo_HardCore_All._HARDCORE_CHARACTERINFO_TABINDEX._basic
  if false == PaGlobalFunc_ChracterInfo_HardCore_GetBgShow(index) then
    return
  end
  local lv = PaGlobal_CharacterInfo_HardCore_Basic._selfPlayer:get():getLevel()
  PaGlobal_CharacterInfo_HardCore_Basic._ui.txt_PlayerLv:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORKERAUCTION_WORKERLEVEL", "level", tostring(lv)))
end
function PaGlobalFunc_CharInfoBasic_HardCore_All_HpUpdate()
  local index = PaGlobal_CharacterInfo_HardCore_All._HARDCORE_CHARACTERINFO_TABINDEX._basic
  if false == PaGlobalFunc_ChracterInfo_HardCore_GetBgShow(index) then
    return
  end
  local hp = math.floor(PaGlobal_CharacterInfo_HardCore_Basic._selfPlayer:get():getHp())
  local maxHp = math.floor(PaGlobal_CharacterInfo_HardCore_Basic._selfPlayer:get():getMaxHp())
  PaGlobal_CharacterInfo_HardCore_Basic._ui.txt_HpVal:SetText(tostring(hp) .. " / " .. tostring(maxHp))
end
function FromClient_CharInfoBasic_HardCore_All_HpUpdate(hp, maxHp, minorSiegeMaxHp, percentHp, percentProgress, isArenaZone, classType, combatResourceType)
  local index = PaGlobal_CharacterInfo_HardCore_All._HARDCORE_CHARACTERINFO_TABINDEX._basic
  if false == PaGlobalFunc_ChracterInfo_HardCore_GetBgShow(index) then
    return
  end
  PaGlobal_CharacterInfo_HardCore_Basic._ui.txt_HpVal:SetText(tostring(hp) .. " / " .. tostring(maxHp))
end
function PaGlobalFunc_CharInfoBasic_HardCore_All_MpUpdate(Mp, maxMp, percent)
  local index = PaGlobal_CharacterInfo_HardCore_All._HARDCORE_CHARACTERINFO_TABINDEX._basic
  if false == PaGlobalFunc_ChracterInfo_HardCore_GetBgShow(index) then
    return
  end
  local mp = PaGlobal_CharacterInfo_HardCore_Basic._selfPlayer:get():getMp()
  local maxMp = PaGlobal_CharacterInfo_HardCore_Basic._selfPlayer:get():getMaxMp()
  PaGlobal_CharacterInfo_HardCore_Basic._ui.txt_Mp_Val:SetText(tostring(mp) .. " / " .. tostring(maxMp))
end
function FromClient_CharInfoBasic_HardCore_All_MpUpdate(Mp, maxMp, percent)
  local index = PaGlobal_CharacterInfo_HardCore_All._HARDCORE_CHARACTERINFO_TABINDEX._basic
  if false == PaGlobalFunc_ChracterInfo_HardCore_GetBgShow(index) then
    return
  end
  PaGlobal_CharacterInfo_HardCore_Basic._ui.txt_Mp_Val:SetText(tostring(Mp) .. " / " .. tostring(maxMp))
end
function FromClient_CharInfoBasic_HardCore_All_WeightUpdate()
  local index = PaGlobal_CharacterInfo_HardCore_All._HARDCORE_CHARACTERINFO_TABINDEX._basic
  if false == PaGlobalFunc_ChracterInfo_HardCore_GetBgShow(index) then
    return
  end
  local selfPlayerGet = PaGlobal_CharacterInfo_HardCore_Basic._selfPlayer:get()
  local s64_allWeight = selfPlayerGet:getCurrentWeight_s64()
  local s64_maxWeight = selfPlayerGet:getPossessableWeight_s64()
  local s64_maxWeight_div = s64_maxWeight / Defines.s64_const.s64_100
  local str_AllWeight = makeWeightString(s64_allWeight, 1)
  local str_MaxWeight = makeWeightString(s64_maxWeight, 0)
  local rate = Int64toInt32(s64_allWeight / s64_maxWeight_div)
  local isShow = rate > 0
  PaGlobal_CharacterInfo_HardCore_Basic._ui.txt_LTVal:SetText(str_AllWeight .. " / " .. str_MaxWeight .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT"))
end
function FromClient_CharInfoBasic_HardCore_All_PotentialUpdate()
  local index = PaGlobal_CharacterInfo_HardCore_All._HARDCORE_CHARACTERINFO_TABINDEX._basic
  if false == PaGlobalFunc_ChracterInfo_HardCore_GetBgShow(index) or PaGlobal_CharacterInfo_HardCore_Basic._ui.stc_PotenBg:GetShow() == false then
    return
  end
  if nil == PaGlobal_CharacterInfo_HardCore_Basic._potentialData then
    UI.ASSERT_NAME(nil ~= PaGlobal_CharacterInfo_HardCore_Basic._ui.stc_LifeTable, " Panel_CharacterInfo_HardCore_Basic_All_3.lua / PaGlobal_CharacterInfo_HardCore_Basic._potentialData is nil", "-")
    return
  end
  local self = PaGlobal_CharacterInfo_HardCore_Basic
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
    end
  end
  for potenIdx = 0, self._MAX_POTENCIALSLOT + 1 do
    if nil ~= self._potentialData[potenIdx] then
      for idx = 0, self._MAX_POTENCIALSLOT do
        self._potentialData[potenIdx].slot[idx]:SetShow(false)
      end
      local lvCount = potentialDataSet(potenIdx)
      self._potentialData[potenIdx].val:SetShow(localFlag)
      if true == localFlag then
        self._potentialData[potenIdx].val:SetText(lvCount .. levelText)
      end
      for idx = 0, lvCount - 1 do
        if idx <= self._MAX_POTENCIALSLOT then
          self._potentialData[potenIdx].slot[idx]:SetShow(true)
        end
      end
    end
  end
end
function FromClient_CharInfoBasic_HardCore_All_BattleStatUpdate()
  local index = PaGlobal_CharacterInfo_HardCore_All._HARDCORE_CHARACTERINFO_TABINDEX._basic
  if false == PaGlobalFunc_ChracterInfo_HardCore_GetBgShow(index) or PaGlobal_CharacterInfo_HardCore_Basic._ui.stc_CombatBg:GetShow() == false then
    return
  end
  ToClient_updateAttackStat()
  local self = PaGlobal_CharacterInfo_HardCore_Basic
  self._ui.txt_Atk:SetText(tostring(ToClient_getOffence()))
  self._ui.txt_Def:SetText(tostring(ToClient_getDefence()))
  local BattileInfoTitleSpanY = 5
  local gap = 35
  local isSetAwakenWeapon = ToClient_getEquipmentItem(__eEquipSlotNoAwakenWeapon)
  local isShyWomen = __eClassType_ShyWaman == self._selfPlayer:getClassType()
  local flag = nil ~= isSetAwakenWeapon and self._isAwakenWeaponContentsOpen
  self._ui.txt_AwakenTitle:SetText(flag)
  if true == flag then
    self._ui.txt_AwakenAtk:SetText(tostring(ToClient_getAwakenOffence()))
  end
  self:setBattleStatUIPos(flag)
end
