function PaGlobal_MorningLand_Boss_All_Close()
  if nil == Panel_Window_MorningLand_Boss_All then
    return
  end
  PaGlobal_MorningLand_Boss_All:prepareClose()
end
function PaGlobal_MorningLand_Boss_All_Open()
  if nil == PaGlobal_MorningLand_Boss_All then
    return
  end
  if Panel_Widget_EscapeBar_All ~= nil and Panel_Widget_EscapeBar_All:GetShow() == true then
    ToClient_StopPreCoolTime()
  end
  PaGlobal_MorningLand_Boss_All._isWorldMapOpen = false
  PaGlobal_MorningLand_Boss_All:prepareOpen()
end
function PaGlobal_MorningLand_Boss_All_ToggleGuilde()
  if nil == PaGlobal_MorningLand_Boss_All then
    return
  end
  local self = PaGlobal_MorningLand_Boss_All
  if self._isConsole == false then
    return
  end
  if Panel_MorningLand_BossRanking:GetShow() == true then
    self._ui.stc_keyGuide:SetShow(false)
  else
    self._ui.stc_keyGuide:SetShow(true)
  end
end
function PaGlobalFunc_MorningMyReward_MajorRewardTooltip()
  local self = PaGlobal_MorningLand_Boss_All
  if self._tooltipInfo_Pad._index == nil or self._tooltipInfo_Pad._monsterKeyRaw == nil then
    return
  end
  if _ContentsGroup_RenewUI == true then
    if PaGlobalFunc_TooltipInfo_GetShow() == true then
      PaGlobalFunc_TooltipInfo_Close()
      return
    end
    local itemEnchantKeyRaw = ToClient_getElementalMonsterShowRewardItemKey(self._tooltipInfo_Pad._monsterKeyRaw, self._tooltipInfo_Pad._index - 1)
    if itemEnchantKeyRaw == nil then
      return
    end
    local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKeyRaw))
    if itemSSW == nil then
      return
    end
    local slot = PaGlobal_MorningLand_Boss_All._listShowRewardSlots[self._tooltipInfo_Pad._index]
    if slot == nil then
      return
    end
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  else
    if Panel_Tooltip_Item == nil then
      return
    end
    HandleEventLUp_MorningLand_Boss_Reward_Tooltip(self._tooltipInfo_Pad._index, self._tooltipInfo_Pad._monsterKeyRaw, Panel_Tooltip_Item:GetShow())
  end
end
function FromClient_loadElementalStatPoint()
  if nil == PaGlobal_MorningLand_Boss_All then
    return
  end
  if PaGlobal_MorningLand_Boss_All._ui.stc_statManageArea:GetShow() == true then
    PaGlobal_MorningLand_Boss_All:selectedElementalType(PaGlobal_MorningLand_Boss_All._selectedType)
  end
  if PaGlobal_MorningLand_Boss_All._ui.stc_statView:GetShow() == true then
    PaGlobal_MorningLand_Boss_All:updateStatView()
  end
end
function FromClient_setElementalMonsterKey()
  if nil == PaGlobal_MorningLand_Boss_All then
    return
  end
  local morningBossSSW = ToClient_getElementalMonsterInfoByCharacterKey(ToClient_GetSeletedElementalMonsterKey())
  if nil ~= morningBossSSW then
    PaGlobal_MorningLand_Boss_All._selectedBoss = morningBossSSW:getCharacterKeyRaw()
    ToClient_DeleteNaviGuideByGroup(0)
    PaGlobal_MorningLand_Boss_All:setWayPoint()
    PaGlobal_MorningLand_Boss_All_Close()
  else
    local morningBossSSW = ToClient_getElementalMonsterInfoByCharacterKey(PaGlobal_MorningLand_Boss_All._selectedBoss)
    if nil ~= morningBossSSW then
      local groupIndex = morningBossSSW:getGroup()
      local selectedLevel = morningBossSSW:getLevel()
      if groupIndex < PaGlobal_MorningLand_Boss_All._MORNINGLAND_PART1_BOSSCOUNT then
        PaGlobal_MorningLand_Boss_All:difficultySelect(selectedLevel + 1, PaGlobal_MorningLand_Boss_All._selectedBoss)
      else
        PaGlobal_MorningLand_Boss_All:difficultySelectMorning2(selectedLevel, PaGlobal_MorningLand_Boss_All._selectedBoss)
      end
    end
  end
end
function FromClient_setElementalMonsterRewardInfo()
  if nil == PaGlobal_MorningLand_Boss_All then
    return
  end
  PaGlobal_MorningLand_Boss_All_UpdateRewardAble()
end
function FromClient_MorningLand_Boss_All_List2Update(content, key)
  local self = PaGlobal_MorningLand_Boss_All
  local index = Int64toInt32(key)
  local bossInfoTbl = self._bossList[index]
  local originalRadioButton = UI.getChildControl(content, "RadioButton_Boss_Template")
  local bossName = UI.getChildControl(originalRadioButton, "StaticText_BossList_Name")
  local newUpdateTag = UI.getChildControl(originalRadioButton, "Static_NEW")
  local bossWeakness = UI.getChildControl(originalRadioButton, "Static_BossList_Weakness")
  local bossListVisual = UI.getChildControl(originalRadioButton, "Static_BossList_Visual")
  local bossLockBg = UI.getChildControl(originalRadioButton, "Static_BossList_LockBG")
  local bossListOffBg = UI.getChildControl(bossLockBg, "Static_BossList_ListOffBG")
  local txtbossLock = UI.getChildControl(bossLockBg, "StaticText_BossList_Lock")
  if ToClient_isElementalMonsterUnlockKnowledgeCondition(bossInfoTbl._group) == true then
    bossLockBg:SetShow(false)
    bossName:SetShow(true)
    bossWeakness:SetShow(true)
    bossListVisual:SetShow(true)
    bossListOffBg:SetIgnore(true)
    bossListOffBg:removeInputEvent("Mouse_LUp")
    newUpdateTag:SetShow(false)
    self._isUnlockOne = true
  else
    bossLockBg:ChangeTextureInfoAndSizeByTextureIDKey("Combine_Etc_MorningLand_Boss_01_List_Profile_10_Normal")
    bossLockBg:setRenderTexture(bossLockBg:getBaseTexture())
    bossLockBg:SetShow(true)
    if bossInfoTbl._mentalCardKey ~= nil then
      local mentalCardSSW = ToClinet_getMentalCardStaticStatus(bossInfoTbl._mentalCardKey)
      if mentalCardSSW ~= nil then
        local mentalCardName = mentalCardSSW:getName()
        local mentalCardDesc = mentalCardSSW:getDesc()
        txtbossLock:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_LOCK", "knowledge", mentalCardName))
        bossName:SetShow(false)
        bossWeakness:SetShow(false)
        bossListVisual:SetShow(false)
        bossListOffBg:SetIgnore(false)
        bossListOffBg:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_Boss_All:lockMonsterSelect(" .. bossInfoTbl._group .. ")")
      end
    end
  end
  originalRadioButton:SetCheck(bossInfoTbl._group == self._selectedBossGroupIndex)
  originalRadioButton:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_Boss_All:selectBoss(" .. tostring(bossInfoTbl._group) .. ", 0)")
  if self._isConsole == true then
    originalRadioButton:addInputEvent("Mouse_On", "PaGlobal_MorningLand_Boss_All:addInputEventForConsole( false )")
  end
  bossName:SetTextMode(__eTextMode_AutoWrap)
  bossName:SetText(bossInfoTbl._name)
  bossName:ComputePos()
  local bossWeeknessIconString = self._bossWeeknessUV[bossInfoTbl._stat]
  bossWeakness:ChangeTextureInfoAndSizeByTextureIDKey(bossWeeknessIconString)
  bossWeakness:setRenderTexture(bossWeakness:getBaseTexture())
  local bossListVisualIconString = self._bossListUV[bossInfoTbl._group]
  bossListVisual:ChangeTextureInfoAndSizeByTextureIDKey(bossListVisualIconString)
  bossListVisual:setRenderTexture(bossListVisual:getBaseTexture())
end
function FromClient_MorningLand_Boss_Part2_All_List2Update(content, key)
  local self = PaGlobal_MorningLand_Boss_All
  local index = Int64toInt32(key)
  local bossInfoTbl = self._bossListMorning2[index]
  if bossInfoTbl == nil then
    return
  end
  local originalRadioButton = UI.getChildControl(content, "RadioButton_Boss_Template2")
  local bossName = UI.getChildControl(originalRadioButton, "StaticText_BossList_Name")
  local newUpdateTag = UI.getChildControl(originalRadioButton, "Static_NEW")
  local bossListVisual = UI.getChildControl(originalRadioButton, "Static_BossList_Visual")
  local bossLockBg = UI.getChildControl(originalRadioButton, "Static_BossList_LockBG")
  local bossListOffBg = UI.getChildControl(bossLockBg, "Static_BossList_ListOffBG")
  local txtbossLock = UI.getChildControl(bossLockBg, "MultilineText_BossList_Lock")
  if ToClient_isElementalMonsterUnlockKnowledgeCondition(bossInfoTbl._group) == true then
    bossLockBg:SetShow(false)
    bossName:SetShow(true)
    bossListVisual:SetShow(true)
    bossListOffBg:SetIgnore(true)
    bossListOffBg:removeInputEvent("Mouse_LUp")
    newUpdateTag:SetShow(false)
    self._isUnlockOne = true
  else
    bossLockBg:ChangeTextureInfoAndSizeByTextureIDKey("Combine_Etc_MorningLand_Boss_01_List_Profile_10_Normal")
    bossLockBg:setRenderTexture(bossLockBg:getBaseTexture())
    bossLockBg:SetShow(true)
    if bossInfoTbl._mentalCardKey ~= nil then
      local mentalCardSSW = ToClinet_getMentalCardStaticStatus(bossInfoTbl._mentalCardKey)
      if mentalCardSSW ~= nil then
        local mentalCardName = mentalCardSSW:getName()
        local mentalCardDesc = mentalCardSSW:getDesc()
        txtbossLock:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_LOCK", "knowledge", mentalCardName))
        bossName:SetShow(false)
        bossListVisual:SetShow(false)
        bossListOffBg:SetIgnore(false)
        bossListOffBg:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_Boss_All:lockMonsterSelect(" .. bossInfoTbl._group .. ")")
      end
    end
  end
  originalRadioButton:SetCheck(bossInfoTbl._group == self._selectedBossGroupIndex)
  originalRadioButton:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_Boss_All:selectBossMorning2(" .. tostring(bossInfoTbl._group) .. ", 0)")
  if self._isConsole == true then
    originalRadioButton:addInputEvent("Mouse_On", "PaGlobal_MorningLand_Boss_All:addInputEventForConsole( false )")
  end
  bossName:SetTextMode(__eTextMode_AutoWrap)
  bossName:SetText(bossInfoTbl._name)
  bossName:ComputePos()
  local bossListVisualIconString = self._bossListUV[bossInfoTbl._group]
  bossListVisual:ChangeTextureInfoAndSizeByTextureIDKey(bossListVisualIconString)
  bossListVisual:setRenderTexture(bossListVisual:getBaseTexture())
end
function PaGlobal_MorningLand_Boss_All_UpdateRewardAble()
  if nil == Panel_Window_MorningLand_Boss_All then
    return
  end
  local self = PaGlobal_MorningLand_Boss_All
  local size = ToClient_ElementalBossRewardInfoCount()
  self._ui.stc_getAble:SetShow(size > 0)
end
function HandleEventLUp_MorningLand_Boss_Reward_Tooltip(index, monsterKeyRaw, isHide)
  if isHide == true then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local itemEnchantKeyRaw = ToClient_getElementalMonsterShowRewardItemKey(monsterKeyRaw, index - 1)
  if itemEnchantKeyRaw == nil then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKeyRaw))
  if itemSSW == nil then
    return
  end
  local slot = PaGlobal_MorningLand_Boss_All._listShowRewardSlots[index]
  if slot == nil then
    return
  end
  Panel_Tooltip_Item_Show(itemSSW, slot.icon, true, false)
end
function FromClient_ElementalMonsterPersonalInfoLoaded()
  if nil == Panel_Window_MorningLand_Boss_All then
    return
  end
  if ToClient_isPlayingSequence() == true and ToClient_isUsePadSnapping() == true then
    return
  end
  PaGlobal_MorningLand_Boss_All:open()
end
function FromClient_Worldmap_MorningLandBossIcon_LClick(control, groupNo)
  if Panel_Window_MorningLand_Boss_All == nil then
    return
  end
  if control == nil or groupNo == nil then
    return
  end
  local morningBossSSW = ToClient_getElementalMonsterInfo(groupNo, 0)
  if nil ~= morningBossSSW then
    local monsterKeyRaw = morningBossSSW:getCharacterKeyRaw()
    PaGlobal_MorningLand_Boss_All._isWorldMapOpen = true
    PaGlobal_MorningLand_Boss_All._selectedBoss = monsterKeyRaw
    PaGlobal_MorningLand_Boss_All:prepareOpen()
  end
end
function FromClient_Worldmap_MorningLandBossIcon_MouseOn(worldMapIcon)
  local self = Panel_Window_MorningLand_Boss_All
  if self == nil or worldMapIcon == nil then
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_MORNINGBOSS_WORLDMAP")
  local desc
  TooltipSimple_Show(worldMapIcon, name, desc)
end
function FromClient_Worldmap_MorningLandBossIcon_MouseOut(worldMapIcon)
  local self = Panel_Window_MorningLand_Boss_All
  if self == nil or worldMapIcon == nil then
    return
  end
  TooltipSimple_Hide()
end
function PaGlobalFunc_MorningLand_Boss_Available()
  if PaGlobal_MorningLand_Boss_All == nil then
    return false
  end
  if _ContentsGroup_MorningLandTierParty == true then
    if ToClient_RequestElementalPersonalInfoSize(__eMorningLandMosterPart1) >= __eElementalMonsterWeekLimit and ToClient_RequestElementalPersonalInfoSize(__eMorningLandMosterPart2) >= __eElementalMonsterPart2WeekLimit then
      return false
    end
  elseif ToClient_RequestElementalPersonalInfoSize(__eMorningLandMosterPart1) >= __eElementalMonsterWeekLimit then
    return false
  end
  for index = 0, PaGlobal_MorningLand_Boss_All._MORNINGLAND_PART1_BOSSCOUNT - 1 do
    if ToClient_isElementalMonsterUnlockKnowledgeCondition(index) == true then
      return true
    end
  end
  return false
end
function FromClient_FinishMorningLandBossTeleportProgressBar()
  if _ContentsGroup_MorningLandTierGo == false then
    return
  end
  local self = PaGlobal_MorningLand_Boss_All
  if self == nil then
    return
  end
  ToClient_RequestSetElementalMonster(self._selectedBoss)
end
function PaGlobalFunc_MorningLand_Boss_TeleportToMorningLandBoss()
  if _ContentsGroup_MorningLandTierGo == false then
    return
  end
  local self = PaGlobal_MorningLand_Boss_All
  if self == nil then
    return
  end
  PaGlobal_MorningLand_Boss_All_Close()
  ToClient_createMorningLandBossTeleportNpc(__eMorningLandBossTeleportNpcCharacterKey)
  ToClient_CallPreCoolTimeProgressBar(__ePreCoolTimeType_MorningLandBossTeleport, 0)
end
function PaGlobalFunc_MorningLand_Boss_CheckTeleportToMorningLandBoss()
  if _ContentsGroup_MorningLandTierGo == false then
    return
  end
  local self = PaGlobal_MorningLand_Boss_All
  if self == nil then
    return
  end
  local selfPlayer = getSelfPlayer():get()
  if selfPlayer == nil then
    return
  end
  if _ContentsGroup_MorningLandTierParty == false and selfPlayer:hasParty() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantWithParty"))
    return
  end
  if ToClient_IsInstanceField() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoRestrictContentsByRegion"))
    return
  end
  if ToClient_IsEnterMirrorField(__eMirrorFieldContentsKey_PersonalField) == true or ToClient_IsEnterMirrorField(__eMirrorFieldContentsKey_PersonalRelayField) == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantDoBehaviorInPersonalField"))
    return
  end
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  if regionInfo == nil then
    return
  end
  local isPVEArenaZone = regionInfo:get():isPVEArenaZone()
  if isPVEArenaZone == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantUseFromCurrentRegion"))
    return
  end
  local isPremiumCharacter = getTemporaryInformationWrapper():isPremiumCharacter()
  if isPremiumCharacter == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantEnterPremiumCharacter"))
    return
  end
  if self._ui.rdo_MorningLandPart1:IsCheck() == true then
    local personalInfoSize = ToClient_RequestElementalPersonalInfoSize(__eMorningLandMosterPart1)
    if personalInfoSize >= __eElementalMonsterWeekLimit then
      local playerClassType = getSelfPlayer():getClassType()
      local alreadyRecordMonster = false
      for i = 0, personalInfoSize do
        local personalInfo = ToClient_getElementalMonsterPersonalInfoAt(i)
        if personalInfo ~= nil and personalInfo:getMorningLandMonsterPart() == __eMorningLandMosterPart1 then
          local monsterKey = personalInfo:getChracterKeyRaw()
          local classType = personalInfo:getClassType()
          if monsterKey == self._selectedBoss and classType == playerClassType then
            alreadyRecordMonster = true
          end
        end
      end
    end
  elseif self._ui.rdo_MorningLandPart2:IsCheck() == true then
    local personalInfoSize = ToClient_RequestElementalPersonalInfoSize(__eMorningLandMosterPart2)
    if personalInfoSize >= __eElementalMonsterPart2WeekLimit then
      local playerClassType = getSelfPlayer():getClassType()
      local alreadyRecordMonster = false
      for i = 0, personalInfoSize do
        local personalInfo = ToClient_getElementalMonsterPersonalInfoAt(i)
        if personalInfo ~= nil and personalInfo:getMorningLandMonsterPart() == __eMorningLandMosterPart2 then
          local monsterKey = personalInfo:getChracterKeyRaw()
          local classType = personalInfo:getClassType()
          if monsterKey == self._selectedBoss and classType == playerClassType then
            alreadyRecordMonster = true
          end
        end
      end
    end
  end
  if alreadyRecordMonster == false then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoMorningLandBossEnterCount"))
    return
  end
  local morningBossSSW = ToClient_getElementalMonsterInfoByCharacterKey(self._selectedBoss)
  if nil ~= morningBossSSW then
    local selfPos = float3(selfPlayer:getPositionX(), selfPlayer:getPositionY(), selfPlayer:getPositionZ())
    local monsterPos = morningBossSSW:getPosition()
    local distance = Util.Math.calculateDistance(selfPos, monsterPos)
    if distance > __eMorningLandBossTeleportDistance then
      PaGlobalFunc_MorningLand_Boss_TeleportToMorningLandBoss()
    else
      ToClient_RequestSetElementalMonster(self._selectedBoss)
    end
  end
end
function FromClient_BlackTempleFieldExplosionReady()
  local self = PaGlobal_MorningLand_Boss_All
  if self == nil then
    return
  end
  if _ContentsGroup_MorningLandTierParty == false then
    return
  end
  local delayTime = ToClient_BlackTempleFieldExplosionDelayTime()
  local string = PAGetStringParam1(Defines.StringSheet_GAME, "MORNINGLAND_ESC_LEADER_OUT", "time", delayTime)
  Proc_ShowMessage_Ack(string)
end
