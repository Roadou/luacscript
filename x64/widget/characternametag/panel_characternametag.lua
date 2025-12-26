local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_AV = CppEnums.PA_UI_ALIGNVERTICAL
local UI_TT = CppEnums.PAUI_TEXTURE_TYPE
local UI_color = Defines.Color
local questFrameUV = {
  [0] = "renewal/PcRemaster/Remaster_InGameQuest_00.dds",
  [1] = {
    {
      303,
      0,
      405,
      102
    },
    {
      303,
      101,
      405,
      203
    },
    {
      303,
      303,
      405,
      405
    },
    {
      303,
      202,
      405,
      304
    }
  },
  [2] = {
    {
      202,
      0,
      304,
      102
    },
    {
      202,
      101,
      304,
      203
    },
    {
      202,
      303,
      304,
      405
    },
    {
      202,
      202,
      304,
      304
    }
  },
  [3] = {
    {
      101,
      0,
      203,
      102
    },
    {
      101,
      101,
      203,
      203
    },
    {
      101,
      303,
      203,
      405
    },
    {
      101,
      202,
      203,
      304
    }
  },
  [4] = {
    {
      0,
      0,
      102,
      102
    },
    {
      0,
      101,
      102,
      203
    },
    {
      0,
      303,
      102,
      405
    },
    {
      0,
      202,
      102,
      304
    }
  }
}
local isPlayMusic = false
local initReplayActorList = Array.new()
local basePanel = {
  [__eActorProxyTypeForNameTag_isSelfPlayer] = Panel_Copy_SelfPlayer,
  [__eActorProxyTypeForNameTag_isOtherPlayer] = Panel_Copy_OtherPlayer,
  [__eActorProxyTypeForNameTag_isMonster] = Panel_Copy_Monster,
  [__eActorProxyTypeForNameTag_isNpc] = Panel_Copy_Npc,
  [__eActorProxyTypeForNameTag_isVehicle] = Panel_Copy_Vehicle,
  [__eActorProxyTypeForNameTag_isHouseHold] = Panel_Copy_HouseHold,
  [__eActorProxyTypeForNameTag_isInstallationActor] = Panel_Copy_Installation,
  [__eActorProxyTypeForNameTag_isInstanceObject] = Panel_Copy_Installation,
  [__eActorProxyTypeForNameTag_isReplayActor] = Panel_Copy_SelfPlayer,
  [__eActorProxyTypeForNameTag_isMaidActor] = Panel_Copy_MaidActor
}
local replayGuilNamePosY = 0
local replayTitlePosY = 0
local lifeContentCount = 16
if ToClient_IsConferenceMode() or ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence) or ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare) then
  lifeContentCount = 0
else
  lifeContentCount = 16
end
local lifeContent = {
  gathering = 0,
  fishing = 1,
  hunting = 2,
  cook = 3,
  alchemy = 4,
  manufacture = 5,
  horse = 6,
  trade = 7,
  growth = 8,
  sail = 9,
  combat = 10,
  money = 11,
  battleField = 12,
  match = 13,
  barter = 14,
  music = 15
}
local convertLifeIndex = {
  [lifeContent.gathering] = 0,
  [lifeContent.fishing] = 1,
  [lifeContent.hunting] = 2,
  [lifeContent.cook] = 3,
  [lifeContent.alchemy] = 4,
  [lifeContent.manufacture] = 5,
  [lifeContent.horse] = 6,
  [lifeContent.trade] = 7,
  [lifeContent.growth] = 8,
  [lifeContent.sail] = 9,
  [lifeContent.barter] = 11
}
local convertBattleIndex = {
  [lifeContent.combat] = 0,
  [lifeContent.money] = 1,
  [lifeContent.battleField] = 2,
  [lifeContent.music] = 4
}
local lifeRankSetTexture = {}
for i = 0, lifeContentCount - 1 do
  lifeRankSetTexture[i] = {}
end
if lifeContentCount > 0 then
  for index = 0, lifeContentCount - 1 do
    for rankIndex = 1, 5 do
      lifeRankSetTexture[index][rankIndex] = {
        x1,
        y1,
        x2,
        y2
      }
      lifeRankSetTexture[index][rankIndex].x1 = 2 + index * 38
      lifeRankSetTexture[index][rankIndex].y1 = 2 + (rankIndex - 1) * 34
      lifeRankSetTexture[index][rankIndex].x2 = 39 + index * 38
      lifeRankSetTexture[index][rankIndex].y2 = 35 + (rankIndex - 1) * 34
    end
  end
end
PaGlobal_CharacterNameTag_All = {
  _questLoadingDataList = nil,
  _isOffNameTagInBattleField = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eBattleFieldNameShow),
  _isInLocalWar = false,
  _initialize = false
}
local ActionChartCCStartAction = {
  [__eActionChartCCStartAction_DAMAGE_AIRFLOAT] = "Combine_Etc_Skill_CC_Airborn",
  [__eActionChartCCStartAction_DAMAGE_STUN] = "Combine_Etc_Skill_CC_Stun",
  [__eActionChartCCStartAction_DAMAGE_BOUND] = "Combine_Etc_Skill_CC_Bound",
  [__eActionChartCCStartAction_DAMAGE_RIGID] = "Combine_Etc_Skill_CC_Rigid",
  [__eActionChartCCStartAction_DAMAGE_FREEZE] = "Combine_Etc_Skill_CC_Freezing",
  [__eActionChartCCStartAction_KNOCKBACK] = "Combine_Etc_Skill_CC_KnockBack",
  [__eActionChartCCStartAction_KNOCKDOWN] = "Combine_Etc_Skill_CC_KnockDown",
  [__eActionChartCCStartAction_DAMAGE_CAPTURE] = "Combine_Etc_Skill_CC_Grogg",
  [__eActionChartCCStartAction_DAMAGE_DOWNSMASH] = "Combine_Etc_Skill_CC_DownSmash",
  [__eActionChartCCStartAction_DAMAGE_AIRSMASH] = "Combine_Etc_Skill_CC_AirSmash"
}
function PaGlobal_CharacterNameTag_All:clearQuestLoadingTable()
  if _ContentsGroup_QuestBackEndLoading == false then
    return
  end
  self._questLoadingDataList = Array.new()
end
function PaGlobal_CharacterNameTag_All:pushQuestLoadingData(questSSW, actorKeyRaw, targetPanel, actorProxyWrapper, insertedArray)
  if _ContentsGroup_QuestBackEndLoading == false or questSSW == nil then
    return
  end
  if self._questLoadingDataList == nil then
    self:clearQuestLoadingTable()
  end
  local newLoadingData = {
    _questNoRaw = questSSW:getQuestNo()._raw,
    _param_0 = actorKeyRaw,
    _param_1 = targetPanel,
    _param_2 = actorProxyWrapper,
    _param_3 = insertedArray
  }
  if self:isExistLoadingDataAnyOne() == true then
    for index = #self._questLoadingDataList, 1, -1 do
      local value = self._questLoadingDataList[index]
      if value ~= nil then
        if value._questNoRaw == newLoadingData._questNoRaw then
          table.remove(self._questLoadingDataList, index)
        elseif value._param_0 == newLoadingData._param_0 then
          table.remove(self._questLoadingDataList, index)
        end
      end
    end
  end
  self._questLoadingDataList:push_back(newLoadingData)
  questSSW:requestLoadBackEndData()
end
function PaGlobal_CharacterNameTag_All:isExistLoadingDataAnyOne()
  if _ContentsGroup_QuestBackEndLoading == false then
    return false
  end
  if self._questLoadingDataList == nil then
    return false
  end
  local isExistAnyOne = self._questLoadingDataList:length() ~= 0
  return isExistAnyOne
end
local function init()
  _PA_SVC_LOG("LoadUI::Load NameTagPools")
  for value = 0, __eActorProxyTypeForNameTag_isMaidActor do
    if basePanel[value] ~= nil then
      ToClient_SetBasePanelAndInitializeNameTagPool(value, basePanel[value])
    end
  end
  PaGlobal_CharacterNameTag_All._isInLocalWar = 0 ~= ToClient_GetMyTeamNoRedBattleField()
end
init()
local _stackHpBarColor = {
  [-1] = Defines.Color.C_FF000000,
  [0] = 4291035148,
  [1] = 4294934576,
  [2] = 4294953029,
  [3] = 4287220554,
  [4] = 4281445845,
  [5] = 4278220233,
  [6] = 4289076667
}
if true == _ContentsOption_CH_HPMP_Bar_Color then
  _stackHpBarColor[0] = 4289074763
  _stackHpBarColor[1] = 4294967295
end
local _normalHpBarColor = {
  defaultColor = Defines.Color.C_FFD20000,
  blindMode_Red = Defines.Color.C_FFFFCE22,
  blindMode_Blue = Defines.Color.C_FFFFCE22,
  partyMemeberColor = Defines.Color.C_FF008AFF
}
if true == _ContentsOption_CH_HPMP_Bar_Color then
  _normalHpBarColor.defaultColor = 4289074763
end
local _defaultUsePotionPosY
local _characterHpBarContainer = {}
local _maxHpCount = 1000
local _maxHpBarColorCount = 7
local _isStackOvered = false
local function CharacterNameTag_FreeHpBarContainer(actorKeyRaw)
  _characterHpBarContainer[actorKeyRaw] = nil
end
local function CharacterNameTag_SetHpBarContainer(actorKeyRaw, actorProxy, targetPanel)
  local hpRate = actorProxy:getHp() % _maxHpCount / _maxHpCount * 100
  local modifiedHpIdx = math.floor(actorProxy:getHp() / _maxHpCount)
  local hpRatePerMaxHP = actorProxy:getHp() * 100 / actorProxy:getMaxHp()
  local progressGroup = UI.getChildControl(targetPanel, "Static_Progress_Group")
  if nil == progressGroup then
    return
  end
  local stackHpBack = UI.getChildControl(progressGroup, "ProgressBack")
  local stackHpBackColor = UI.getChildControl(progressGroup, "Progress2_StackHpBackColor")
  local stackHpbar = UI.getChildControl(progressGroup, "CharacterHPGageProgress")
  local hpPointer = UI.getChildControl(progressGroup, "StaticText_HP")
  local gage_Count = UI.getChildControl(progressGroup, "CharacterHPGage_Counting")
  local isColorBlindMode = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eColorBlindMode)
  if nil == _characterHpBarContainer[actorKeyRaw] then
    local hpBarData = {}
    hpBarData.stackHpBar = stackHpbar
    hpBarData.stackHpBarBackColor = stackHpBackColor
    hpBarData.hpPointer = hpPointer
    hpBarData.stackHpBar:SetAniSpeed(0)
    hpBarData.stackHpBar:SetProgressRate(hpRate)
    hpBarData.stackHpBarBackColor:SetAniSpeed(0)
    hpBarData.stackHpBarBackColor:SetProgressRate(100)
    hpBarData.targetHpIdx = modifiedHpIdx
    hpBarData.currentHpIdx = modifiedHpIdx
    hpBarData.currentHpRate = hpRate
    hpBarData.hpBack = stackHpBack
    if true == _ContentsGroup_StackHpBaranimation then
      hpBarData.startCount = modifiedHpIdx
      hpBarData.endCount = modifiedHpIdx
      hpBarData.calcFlag = true
      hpBarData.uiPanel = targetPanel
      hpBarData.gage_Count = gage_Count
      if nil ~= hpBarData.gage_Count then
        hpBarData.gage_Count:SetText("")
        if modifiedHpIdx <= 0 then
          hpBarData.gage_Count:SetShow(false)
        else
          hpBarData.gage_Count:SetShow(true)
        end
      end
    end
    _characterHpBarContainer[actorKeyRaw] = hpBarData
  else
    if _characterHpBarContainer[actorKeyRaw].targetPanel ~= targetPanel then
      CharacterNameTag_FreeHpBarContainer(actorKeyRaw)
      CharacterNameTag_SetHpBarContainer(actorKeyRaw, actorProxy, targetPanel)
      return
    end
    _characterHpBarContainer[actorKeyRaw].stackHpBar = stackHpbar
    _characterHpBarContainer[actorKeyRaw].stackHpBarBackColor = stackHpBackColor
    _characterHpBarContainer[actorKeyRaw].targetHpIdx = modifiedHpIdx
    _characterHpBarContainer[actorKeyRaw].currentHpRate = hpRate
    _characterHpBarContainer[actorKeyRaw].hpPointer = hpPointer
    if true == _ContentsGroup_StackHpBaranimation then
      _characterHpBarContainer[actorKeyRaw].endCount = modifiedHpIdx
      _characterHpBarContainer[actorKeyRaw].gage_Count:SetShow(true)
      if false == _characterHpBarContainer[actorKeyRaw].calcFlag then
        _characterHpBarContainer[actorKeyRaw].startCount = modifiedHpIdx
      end
      _characterHpBarContainer[actorKeyRaw].calcFlag = true
    end
  end
  local colorValue = modifiedHpIdx % _maxHpBarColorCount
  local backColorValue = colorValue - 1
  if modifiedHpIdx <= 0 then
    backColorValue = -1
  elseif backColorValue < 0 then
    backColorValue = _maxHpBarColorCount - 1
  end
  if modifiedHpIdx > _maxHpBarColorCount * 2 then
    _characterHpBarContainer[actorKeyRaw].stackHpBarBackColor:SetColor(_stackHpBarColor[_maxHpBarColorCount - 1])
    _characterHpBarContainer[actorKeyRaw].stackHpBar:SetColor(_stackHpBarColor[_maxHpBarColorCount - 1])
  else
    _characterHpBarContainer[actorKeyRaw].stackHpBarBackColor:SetColor(_stackHpBarColor[backColorValue])
    _characterHpBarContainer[actorKeyRaw].stackHpBar:SetColor(_stackHpBarColor[colorValue])
  end
  if modifiedHpIdx == _characterHpBarContainer[actorKeyRaw].currentHpIdx then
    _characterHpBarContainer[actorKeyRaw].stackHpBar:SetProgressRate(hpRate)
  end
end
function stackHpBarAnimation(deltaTime)
  if false == _ContentsGroup_StackHpBaranimation then
    return
  end
  for key, value in pairs(_characterHpBarContainer) do
    if nil ~= key and nil ~= _characterHpBarContainer[key] and true == value.calcFlag then
      if nil == value.uiPanel then
        UI.ASSERT_NAME(nil ~= value.uiPanel, "stackHpBarAnimation()  panel nil", "\235\176\149\234\180\145\236\154\180")
      end
      if value.startCount > value.endCount then
        local divVal = 1
        value.startCount = value.startCount - divVal
      end
      value.gage_Count:SetText("x" .. tostring(value.startCount))
      if nil ~= value.gage_Count then
        if value.targetHpIdx <= 0 then
          value.gage_Count:SetShow(false)
        else
          value.gage_Count:SetShow(true)
        end
      end
      if value.startCount <= value.endCount then
        value.gage_Count:SetText("x" .. tostring(value.endCount))
        value.calcFlag = false
      end
    end
  end
end
local getControlProperty = function(panel, index)
  local nameTagGroup = UI.getChildControl(panel, "Static_NameTag_Group")
  if nil == nameTagGroup then
    return nil
  end
  if index == CppEnums.SpawnType.eSpawnType_SkillTrainer then
    return UI.getChildControl(nameTagGroup, "Static_Skill")
  elseif index == CppEnums.SpawnType.eSpawnType_ShopMerchant then
    return UI.getChildControl(nameTagGroup, "Static_Store")
  elseif index == CppEnums.SpawnType.eSpawnType_Potion then
    return UI.getChildControl(nameTagGroup, "Static_Store")
  elseif index == CppEnums.SpawnType.eSpawnType_Weapon then
    return UI.getChildControl(nameTagGroup, "Static_Store")
  elseif index == CppEnums.SpawnType.eSpawnType_Jewel then
    return UI.getChildControl(nameTagGroup, "Static_Store")
  elseif index == CppEnums.SpawnType.eSpawnType_Furniture then
    return UI.getChildControl(nameTagGroup, "Static_Store")
  elseif index == CppEnums.SpawnType.eSpawnType_Collect then
    return UI.getChildControl(nameTagGroup, "Static_Store")
  elseif index == CppEnums.SpawnType.eSpawnType_Fish then
    return UI.getChildControl(nameTagGroup, "Static_Store")
  elseif index == CppEnums.SpawnType.eSpawnType_Worker then
    return UI.getChildControl(nameTagGroup, "Static_Store")
  elseif index == CppEnums.SpawnType.eSpawnType_Alchemy then
    return UI.getChildControl(nameTagGroup, "Static_Store")
  elseif index == CppEnums.SpawnType.eSpawnType_Stable then
    return UI.getChildControl(nameTagGroup, "Static_Stable")
  elseif index == CppEnums.SpawnType.eSpawnType_WareHouse then
    return UI.getChildControl(nameTagGroup, "Static_WareHouse")
  elseif index == CppEnums.SpawnType.eSpawnType_auction then
    return UI.getChildControl(nameTagGroup, "Static_Auction")
  elseif index == CppEnums.SpawnType.eSpawnType_inn then
    return UI.getChildControl(nameTagGroup, "Static_Inn")
  elseif index == CppEnums.SpawnType.eSpawnType_guild then
    return UI.getChildControl(nameTagGroup, "Static_Guild")
  elseif index == CppEnums.SpawnType.eSpawnType_intimacy then
    return UI.getChildControl(nameTagGroup, "Static_Intimacy")
  elseif index == CppEnums.SpawnType.eSpawnType_Instrument then
    return UI.getChildControl(nameTagGroup, "Static_Store")
  else
    return nil
  end
end
local sortCenterX = function(insertedArray)
  if _ContentsGroup_NameTag_Optimization == true then
    return
  end
  local size = {}
  local fullSize = 0
  local scaleBuffer
  for key, value in pairs(insertedArray) do
    if value:GetShow() then
      scaleBuffer = value:GetScale()
      value:SetScale(1, 1)
      local aSize = value:GetSizeX()
      size[key] = aSize
      fullSize = fullSize + aSize
    end
  end
  local leftSize = -fullSize / 2
  for key, value in pairs(insertedArray) do
    if value:GetShow() then
      leftSize = leftSize + size[key] / 2
      value:SetSpanSize(leftSize, value:GetSpanSize().y)
      value:SetScale(scaleBuffer.x, scaleBuffer.y)
      leftSize = leftSize + size[key] / 2
    end
  end
end
local guildMarkInit = function(guildMark)
  guildMark:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Default/Default_Buttons.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(guildMark, 183, 1, 188, 6)
  guildMark:getBaseTexture():setUV(x1, y1, x2, y2)
  guildMark:setRenderTexture(guildMark:getBaseTexture())
end
local monsterLevelNameColor = {
  4287993237,
  4285643008,
  4287816466,
  4290966896,
  4292540333,
  4294967295,
  4294954702,
  4294943137,
  4294927717,
  4294901760,
  4287579626
}
local monsterLevelNameColorText = {
  "FF959595",
  "FF71B900",
  "FF92E312",
  "FFC2F570",
  "FFDAF7AD",
  "FFFFFFFF",
  "FFFFCECE",
  "FFFFA1A1",
  "FFFF6565",
  "FFFF0000",
  "FF8F45EA"
}
if true == _ContentsGroup_ChinaFontColor then
  monsterLevelNameColor = {
    4287993237,
    4285643008,
    4287816466,
    4290966896,
    4292540333,
    4294967295,
    4294962894,
    4294959521,
    4293054053,
    4294946304,
    4287579626
  }
  monsterLevelNameColorText = {
    "FF959595",
    "FF71B900",
    "FF92E312",
    "FFC2F570",
    "FFDAF7AD",
    "FFFFFFFF",
    "FFFFEECE",
    "FFFFE1A1",
    "FFE2CE65",
    "FFFFAE00",
    "FF8F45EA"
  }
end
local playerlevelColor = {
  "FFC8FFC8",
  "FFC8FFC8",
  "FFFFFFFF",
  "FFFFE8BB",
  "FFFFC960",
  "FFFFAD10",
  "FFFF8A00",
  "FFFF6C00",
  "FFFF4E00",
  "FFE10000"
}
local function getColorBySelfPlayerLevel(level)
  if level < 0 then
    return playerlevelColor[1]
  elseif level >= 100 then
    return playerlevelColor[10]
  else
    return playerlevelColor[math.floor(level / 10) + 1]
  end
end
local function getColorByMonsterLevel(playerLevel, monsterLevel)
  local levelDiff = monsterLevel - playerLevel + 6
  levelDiff = math.max(levelDiff, 1)
  levelDiff = math.min(levelDiff, 11)
  return monsterLevelNameColorText[levelDiff]
end
local function setMonsterNameColor_Level(playerLevel, monsterLevel, nameStatic, isDarkSpiritMonster)
  if isDarkSpiritMonster then
    nameStatic:SetFontColor(Defines.Color.C_FF6A0000)
    return
  end
  local levelDiff = monsterLevel - playerLevel + 6
  levelDiff = math.max(levelDiff, 1)
  levelDiff = math.min(levelDiff, 11)
  nameStatic:SetFontColor(monsterLevelNameColor[levelDiff])
end
local hideTimeType = {
  overHeadUI = 0,
  preemptiveStrike = 1,
  bubbleBox = 2,
  murdererEnd = 3
}
local myMilitiaTeamNo = function()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return -1
  end
  local selfProxy = selfPlayer:get()
  local myTeamNo = selfProxy:getVolunteerTeamNoForLua()
  if myTeamNo >= 1000 then
    return 1
  elseif myTeamNo >= 100 then
    return 0
  else
    return -1
  end
end
local function settingName(actorKeyRaw, targetPanel, actorProxyWrapper)
  if _ContentsGroup_NameTag_Optimization == true then
    return
  end
  local nameTag
  local actorProxy = actorProxyWrapper:get()
  if nil == actorProxy then
    return
  end
  local nameTagGroup = UI.getChildControl(targetPanel, "Static_NameTag_Group")
  if nil == nameTagGroup then
    return
  end
  if actorProxy:isKingOrLordTent() then
    nameTag = UI.getChildControl(nameTagGroup, "KingsCharacterName")
  elseif actorProxy:isLargeHpBarCharacter() then
    return
  else
    nameTag = UI.getChildControl(nameTagGroup, "CharacterName")
  end
  if nil == nameTag then
    return
  end
  local characterActorProxyWrapper = getCharacterActor(actorKeyRaw)
  local playerActorProxyWrapper = getPlayerActor(actorKeyRaw)
  local instanceMapKey = ToClient_GetCurrentInstanceFieldMapKey()
  if true == actorProxy:isSelfPlayer() then
    if true == PaGlobal_CharacterNameTag_All._isOffNameTagInBattleField and true == PaGlobal_CharacterNameTag_All._isInLocalWar then
      nameTag:SetShow(false)
      return
    end
    if ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare) == true or __eInstanceRedBattleField_PapuCrio == instanceMapKey then
      nameTag:SetShow(false)
      return
    end
  end
  local isShowForAlli = false
  if false == _ContentsGroup_camouflageueShowName and actorProxy:isPlayer() and true == playerActorProxyWrapper:get():isHideCharacterName() and true == playerActorProxyWrapper:get():isShowNameWhenCamouflage() and getSelfPlayer():getActorKey() ~= playerActorProxyWrapper:getActorKey() then
    isShowForAlli = true
  end
  if actorProxy:isPlayer() and characterActorProxyWrapper:get():isClientAI() or actorProxy:isHiddenName() and false == actorProxy:isVehicle() and false == actorProxy:isFlashBanged() or true == isShowForAlli then
    nameTag:SetShow(false)
    return
  end
  if actorProxy:isPlayer() == true and actorProxy:isNeedHideNameForEdaniaInstanceField() == true then
    nameTag:SetShow(false)
    return
  end
  if actorProxy:isPlayer() then
    local militiaIcon = UI.getChildControl(nameTagGroup, "Static_MilitiaIcon")
    local militiaTeamNo = actorProxy:getVolunteerTeamNoForLua()
    if militiaTeamNo >= 1000 then
      if nil ~= playerActorProxyWrapper then
        local isMilitia = playerActorProxyWrapper:get():isVolunteer()
        if isMilitia then
          militiaIcon:SetShow(true)
          militiaIcon:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Window/PvP/Militia_01.dds")
          if 0 == myMilitiaTeamNo() then
            local x1, y1, x2, y2 = setTextureUV_Func(militiaIcon, 160, 193, 195, 235)
            militiaIcon:getBaseTexture():setUV(x1, y1, x2, y2)
          else
            local x1, y1, x2, y2 = setTextureUV_Func(militiaIcon, 88, 193, 123, 235)
            militiaIcon:getBaseTexture():setUV(x1, y1, x2, y2)
          end
          militiaIcon:setRenderTexture(militiaIcon:getBaseTexture())
          nameTag:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERNAMETAG_MILITIADEFFENCE"))
          nameTag:SetShow(true)
          return
        end
      end
    elseif militiaTeamNo >= 100 then
      if nil ~= playerActorProxyWrapper then
        local isMilitia = playerActorProxyWrapper:get():isVolunteer()
        if isMilitia then
          militiaIcon:SetShow(true)
          militiaIcon:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Window/PvP/Militia_01.dds")
          if 0 == myMilitiaTeamNo() then
            local x1, y1, x2, y2 = setTextureUV_Func(militiaIcon, 196, 193, 231, 235)
            militiaIcon:getBaseTexture():setUV(x1, y1, x2, y2)
          else
            local x1, y1, x2, y2 = setTextureUV_Func(militiaIcon, 124, 193, 159, 235)
            militiaIcon:getBaseTexture():setUV(x1, y1, x2, y2)
          end
          militiaIcon:setRenderTexture(militiaIcon:getBaseTexture())
          nameTag:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERNAMETAG_MILITIAATTACK"))
          nameTag:SetShow(true)
          return
        end
      end
    else
      militiaIcon:SetShow(false)
    end
  end
  if actorProxy:isHouseHold() then
    local houseActorWarpper = getHouseHoldActor(actorKeyRaw)
    local isMine = houseActorWarpper:get():isOwnedBySelfPlayer()
    local isMyGuild = houseActorWarpper:get():isOwnedBySelfPlayerGuild()
    local isPersonalTent = houseActorWarpper:get():isPersonalTent()
    local isSiegeTent = houseActorWarpper:get():isKingOrLordTent()
    if isMine and isPersonalTent then
      local tentWrapper = getTemporaryInformationWrapper():getSelfTentWrapperByActorKeyRaw(actorKeyRaw)
      if nil ~= tentWrapper then
        local expireTime = tentWrapper:getSelfTentExpiredTime_s64()
        local lefttimeText = convertStringFromDatetime(getLeftSecond_TTime64(expireTime))
        textName = getHouseHoldName(actorProxy)
        targetPanel:Set3DRotationY(actorProxy:getRotation())
      end
    elseif isMyGuild and isSiegeTent then
      local expireTime = houseActorWarpper:get():getExpiredTime()
      local lefttimeText = convertStringFromDatetime(getLeftSecond_TTime64(expireTime))
      textName = getHouseHoldName(actorProxy)
      if _ContentsGroup_EditGuildColor == true then
        textName = getHouseholdNameAndGuildColor(actorProxy)
      end
      targetPanel:Set3DRotationY(actorProxy:getRotation())
    elseif isSiegeTent == true then
      textName = getHouseHoldName(actorProxy)
      if _ContentsGroup_EditGuildColor == true then
        textName = getHouseholdNameAndGuildColor(actorProxy)
      end
      targetPanel:Set3DRotationY(actorProxy:getRotation())
    else
      textName = getHouseHoldName(actorProxy)
      targetPanel:Set3DRotationY(actorProxy:getRotation())
    end
  elseif actorProxy:isInstallationActor() then
    textName = actorProxy:getStaticStatusName()
    local installationActorWrapper = getInstallationActor(actorKeyRaw)
    if nil ~= installationActorWrapper and toInt64(0, 0) ~= installationActorWrapper:getOwnerHouseholdNo_s64() then
      if installationActorWrapper:isHavestInstallation() then
        local rate = installationActorWrapper:getHarvestTotalGrowRate() * 100
        if rate < 0 then
          rate = 0
        end
        textName = installationActorWrapper:get():getStaticStatusName() .. " - (<PAColor0xFFffd429>" .. tostring(math.floor(rate)) .. "%<PAOldColor>)"
      else
        local installationSS = installationActorWrapper:getStaticStatusWrapper()
        if nil ~= installationSS then
          local installationObjectSS = installationSS:getObjectStaticStatus()
          if nil ~= installationObjectSS then
            local installationType = installationObjectSS:getInstallationType()
            if CppEnums.InstallationType.eType_Scarecrow ~= installationType and CppEnums.InstallationType.eType_Waterway ~= installationType then
              local isHideDurability = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eHideHousingDurability)
              if true == isHideDurability then
                nameTag:SetShow(false)
                return
              end
            end
          end
        end
        local curEndurance = installationActorWrapper:getEndurance()
        local maxEndurance = installationActorWrapper:getMaxEndurance()
        textName = textName .. " (" .. tostring(curEndurance) .. "/" .. tostring(maxEndurance) .. ")"
      end
    end
  elseif isNpcWorker(actorProxy) then
    textName = getNpcWorkerOwnerName(actorProxy)
  elseif actorProxy:isSelfPlayer() == true then
    local selfplayerActorProxyWrapper = getPlayerActor(actorKeyRaw)
    if selfplayerActorProxyWrapper == nil then
      return
    end
    local guildNoOrAllianceNo = selfplayerActorProxyWrapper:getGuildNo_s64()
    if selfplayerActorProxyWrapper:isGuildAllianceMember() == true then
      guildNoOrAllianceNo = selfplayerActorProxyWrapper:getGuildAllianceNo_s64()
    end
    local isFindNewColor = false
    local guildColorCount = ToClient_getGuildColorCount()
    if guildColorCount > 1 then
      local editGuildColor = ToClient_getEditGuildColorByGuildNo(guildNoOrAllianceNo)
      if editGuildColor ~= 0 and editGuildColor ~= 4294967295 then
        nameTag:SetFontColor(editGuildColor)
        nameTag:useGlowFont(false)
        nameTag:useGlowFont(true, "BaseFont_10_Glow", UI_color.C_FF000000)
        nameTag:SetMonoTone(false)
        isFindNewColor = true
      end
    else
      local fontColor = ToClient_GetGuildColorStringByGuildNo(guildNoOrAllianceNo)
      if fontColor ~= nil and fontColor ~= "" then
        nameTag:SetFontColor(fontColor)
        nameTag:useGlowFont(false)
        nameTag:useGlowFont(true, "BaseFont_10_Glow", UI_color.C_FF000000)
        nameTag:SetMonoTone(false)
        isFindNewColor = true
      end
    end
    if isFindNewColor == false then
      nameTag:SetFontColor(4294967295)
      nameTag:useGlowFont(false)
      if selfplayerActorProxyWrapper:get():isFlashBanged() == true then
        nameTag:SetMonoTone(false)
      elseif selfplayerActorProxyWrapper:get():isHideCharacterName() == false and selfplayerActorProxyWrapper:get():isEquipCamouflage() == true then
        nameTag:SetMonoTone(true)
      elseif selfplayerActorProxyWrapper:get():isConcealCharacter() == true then
        nameTag:SetMonoTone(true)
      else
        nameTag:SetMonoTone(false)
      end
    end
    textName = selfplayerActorProxyWrapper:getName()
    if actorProxy:isParticipateInRoseWar() == true then
      local isSameRoseWarTeamNoWithSelfPlayer = actorProxy:isSameRoseWarTeamWithSelfPlayer()
      local colorCode
      if isSameRoseWarTeamNoWithSelfPlayer == true then
        colorCode = UI_color.C_FFABE8FF
      else
        colorCode = UI_color.C_FFFFB3AB
      end
      nameTag:useGlowFont(false)
      nameTag:SetFontColor(UI_color.C_FFFFFFFF)
      nameTag:useGlowFont(true, "BaseFont_10_Glow", colorCode)
      nameTag:SetMonoTone(false)
      textName = selfplayerActorProxyWrapper:getUserNickname()
    end
    if ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_GuildMatch) == true then
      nameTag:useGlowFont(false)
      nameTag:SetFontColor(UI_color.C_FFABE8FF)
      nameTag:useGlowFont(true, "BaseFont_10_Glow", UI_color.C_FF0051C0)
      nameTag:SetMonoTone(false)
    end
  elseif actorProxy:isPlayer() then
    local playerActorProxyWrapper = getPlayerActor(actorKeyRaw)
    if playerActorProxyWrapper == nil then
      return
    end
    if nil == getSelfPlayer() then
      return
    end
    local isShowForAlli = false
    if true == _ContentsGroup_camouflageueShowName then
      if true == playerActorProxyWrapper:get():isHideCharacterName() and true == playerActorProxyWrapper:get():isShowNameWhenCamouflage() and getSelfPlayer():getActorKey() ~= playerActorProxyWrapper:getActorKey() then
        isShowForAlli = true
      end
      if playerActorProxyWrapper:get():isHideCharacterName() and false == playerActorProxyWrapper:get():isFlashBanged() or true == isShowForAlli then
        nameTag:SetShow(false)
        return
      end
      if ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare) == true or __eInstanceRedBattleField_PapuCrio == instanceMapKey then
        nameTag:SetShow(false)
        return
      end
      nameTag:SetShow(true)
    end
    local guildNoOrAllianceNo = playerActorProxyWrapper:getGuildNo_s64()
    local isAllianceMember = playerActorProxyWrapper:isGuildAllianceMember()
    if isAllianceMember == true then
      guildNoOrAllianceNo = playerActorProxyWrapper:getGuildAllianceNo_s64()
    end
    local isFindNewColor = false
    local guildColorCount = ToClient_getGuildColorCount()
    if guildColorCount > 1 then
      local editGuildColor = ToClient_getEditGuildColorByGuildNo(guildNoOrAllianceNo)
      if editGuildColor ~= 0 and editGuildColor ~= 4294967295 then
        nameTag:SetFontColor(editGuildColor)
        nameTag:useGlowFont(false)
        nameTag:useGlowFont(true, "BaseFont_10_Glow", UI_color.C_FF000000)
        nameTag:SetMonoTone(false)
        isFindNewColor = true
      end
    else
      local fontColor = ToClient_GetGuildColorStringByGuildNo(guildNoOrAllianceNo)
      if fontColor ~= nil and fontColor ~= "" then
        nameTag:SetFontColor(fontColor)
        nameTag:useGlowFont(false)
        nameTag:useGlowFont(true, "BaseFont_10_Glow", UI_color.C_FF000000)
        nameTag:SetMonoTone(false)
        isFindNewColor = true
      end
    end
    if isFindNewColor == false then
      nameTag:SetFontColor(4294967295)
      nameTag:useGlowFont(false)
      if false == playerActorProxyWrapper:get():isFlashBanged() and false == playerActorProxyWrapper:get():isHideCharacterName() and true == playerActorProxyWrapper:get():isEquipCamouflage() and playerActorProxyWrapper:getGuildNo_s64() == getSelfPlayer():getGuildNo_s64() then
        nameTag:SetMonoTone(true)
      elseif false == playerActorProxyWrapper:get():isFlashBanged() and true == playerActorProxyWrapper:get():isConcealCharacter() then
        nameTag:SetMonoTone(true)
      else
        nameTag:SetMonoTone(false)
      end
    end
    textName = actorProxyWrapper:getName()
    if actorProxy:isParticipateInRoseWar() == true then
      local isSameRoseWarTeamNoWithSelfPlayer = actorProxy:isSameRoseWarTeamWithSelfPlayer()
      local colorCode
      if isSameRoseWarTeamNoWithSelfPlayer == true then
        colorCode = UI_color.C_FFABE8FF
      else
        colorCode = UI_color.C_FFFFB3AB
      end
      nameTag:useGlowFont(false)
      nameTag:SetFontColor(UI_color.C_FFFFFFFF)
      nameTag:useGlowFont(true, "BaseFont_10_Glow", colorCode)
      nameTag:SetMonoTone(false)
      textName = playerActorProxyWrapper:getUserNickname()
    end
    if ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_GuildMatch) == true then
      local fontColor, glowColor
      if ToClient_IsGuildMatchSameTeamAsMe(actorKeyRaw) == true then
        fontColor = UI_color.C_FFABE8FF
        glowColor = UI_color.C_FF0051C0
      else
        fontColor = UI_color.C_FFFFB3AB
        glowColor = UI_color.C_FFC00000
      end
      nameTag:useGlowFont(false)
      nameTag:SetFontColor(fontColor)
      nameTag:useGlowFont(true, "BaseFont_10_Glow", glowColor)
      nameTag:SetMonoTone(false)
    end
  elseif actorProxy:isInstanceObject() then
    if actorProxyWrapper:getCharacterStaticStatusWrapper():getObjectStaticStatus():isTrap() then
      nameTag:SetShow(false)
      return
    end
    textName = actorProxyWrapper:getName()
  elseif actorProxy:isNpc() then
    textName = actorProxyWrapper:getName()
    local isFusionCore = actorProxy:getCharacterSimplyStaticStatus():isFusionCore()
    if true == isFusionCore then
      local npcActorProxyWrapper = getNpcActor(actorKeyRaw)
      if npcActorProxyWrapper:getTeamNo_s64() == getSelfPlayer():getTeamNo_s64() then
        textName = textName
      else
        textName = ""
      end
    end
  elseif actorProxy:isVehicle() then
    textName = actorProxyWrapper:getName()
    if actorProxy:hasVehicleOwner() == true and ToClient_namelessPVPServer() == true then
      textName = " "
    end
  else
    textName = actorProxyWrapper:getName()
  end
  nameTag:SetText(textName)
  nameTag:SetShow(true)
end
local function settingGuildInfoForSiegeVehicle(actorKeyRaw, targetPanel, actorProxyWrapper)
  if ToClient_IsSelfParticipateInSiege2024() == false then
    return
  end
  local actorProxy = actorProxyWrapper:get()
  if actorProxy == nil then
    return
  end
  if actorProxy:isVehicle() == false then
    return
  end
  local vehicleActorWrapper = getVehicleActorByProxy(actorProxy)
  if vehicleActorWrapper == nil then
    return
  end
  local nameTagGroup = UI.getChildControl(targetPanel, "Static_NameTag_Group")
  if nameTagGroup == nil then
    return
  end
  local guildName = UI.getChildControl(nameTagGroup, "CharacterGuild")
  if guildName == nil then
    return
  end
  if actorProxy:IsNeedHideNameForPVPServer() == true then
    guildName:SetShow(false)
    return
  end
  local guildNameText, guildNameTextFontColor, guildNameTextGlowColor, cannonOwnerGuildNo
  if vehicleActorWrapper:isGuildAllianceMember() == true then
    cannonOwnerGuildNo = vehicleActorWrapper:getGuildAllianceNo_s64()
  else
    cannonOwnerGuildNo = vehicleActorWrapper:getGuildNo_s64()
  end
  local appliedGuildName
  local appliedGuildCount = ToClient_GetAppliedGuildCountSiege2024()
  for index = 0, appliedGuildCount - 1 do
    local appliedGuildNoRaw = ToClient_GetAppliedGuildNoRawSiege2024(index)
    if cannonOwnerGuildNo == appliedGuildNoRaw then
      appliedGuildName = ToClient_GetAppliedGuildNameSiege2024(index)
      break
    end
  end
  if appliedGuildName ~= nil then
    local selfPlayerGuildNo
    if getSelfPlayer():isGuildAllianceMember() == true then
      selfPlayerGuildNo = getSelfPlayer():getGuildAllianceNo_s64()
    else
      selfPlayerGuildNo = getSelfPlayer():getGuildNo_s64()
    end
    if cannonOwnerGuildNo == selfPlayerGuildNo then
      guildNameTextFontColor = UI_color.C_FFABE8FF
      guildNameTextGlowColor = UI_color.C_FF0051C0
    else
      guildNameTextFontColor = UI_color.C_FFFFB3AB
      guildNameTextGlowColor = UI_color.C_FFC00000
    end
    guildNameText = appliedGuildName
  end
  if guildNameText ~= nil and guildNameText ~= "" and guildNameTextFontColor ~= nil and guildNameTextGlowColor ~= nil then
    guildName:SetFontColor(guildNameTextFontColor)
    guildName:useGlowFont(false)
    guildName:useGlowFont(true, "BaseFont_10_Glow", guildNameTextGlowColor)
    guildName:SetText("<" .. guildNameText .. ">")
    guildName:SetShow(true)
  else
    guildName:SetShow(false)
  end
end
local function settingGuildInfoForSiegeInstanceObject(actorKeyRaw, targetPanel, actorProxyWrapper)
  if ToClient_IsSelfParticipateInSiege2024() == false then
    return
  end
  local actorProxy = actorProxyWrapper:get()
  if actorProxy == nil then
    return
  end
  if actorProxy:isInstanceObject() == false then
    return
  end
  local instanceActorWrapper = getInstanceActorByProxy(actorProxy)
  if instanceActorWrapper == nil then
    return
  end
  local nameTagGroup = UI.getChildControl(targetPanel, "Static_NameTag_Group")
  if nameTagGroup == nil then
    return
  end
  local guildName = UI.getChildControl(nameTagGroup, "CharacterGuild")
  if guildName == nil then
    return
  end
  if actorProxy:IsNeedHideNameForPVPServer() == true then
    guildName:SetShow(false)
    return
  end
  local guildNameText, guildNameTextFontColor, guildNameTextGlowColor, instanceOwnerGuild
  if instanceActorWrapper:isGuildAllianceMember() == true then
    instanceOwnerGuild = instanceActorWrapper:getGuildAllianceNo_s64()
  else
    instanceOwnerGuild = instanceActorWrapper:getGuildNo_s64()
  end
  local appliedGuildName
  local appliedGuildCount = ToClient_GetAppliedGuildCountSiege2024()
  for index = 0, appliedGuildCount - 1 do
    local appliedGuildNoRaw = ToClient_GetAppliedGuildNoRawSiege2024(index)
    if instanceOwnerGuild == appliedGuildNoRaw then
      appliedGuildName = ToClient_GetAppliedGuildNameSiege2024(index)
      break
    end
  end
  if appliedGuildName ~= nil then
    local selfPlayerGuildNo
    if getSelfPlayer():isGuildAllianceMember() == true then
      selfPlayerGuildNo = getSelfPlayer():getGuildAllianceNo_s64()
    else
      selfPlayerGuildNo = getSelfPlayer():getGuildNo_s64()
    end
    if instanceOwnerGuild == selfPlayerGuildNo then
      guildNameTextFontColor = UI_color.C_FFABE8FF
      guildNameTextGlowColor = UI_color.C_FF0051C0
    else
      guildNameTextFontColor = UI_color.C_FFFFB3AB
      guildNameTextGlowColor = UI_color.C_FFC00000
    end
    guildNameText = appliedGuildName
  end
  if guildNameText ~= nil and guildNameText ~= "" and guildNameTextFontColor ~= nil and guildNameTextGlowColor ~= nil then
    guildName:SetFontColor(guildNameTextFontColor)
    guildName:useGlowFont(false)
    guildName:useGlowFont(true, "BaseFont_10_Glow", guildNameTextGlowColor)
    guildName:SetText("<" .. guildNameText .. ">")
    guildName:SetShow(true)
  else
    guildName:SetShow(false)
  end
end
local settingAlias = function(actorKeyRaw, targetPanel, actorProxyWrapper)
  if _ContentsGroup_NameTag_Optimization == true then
    return
  end
  local playerActorProxyWrapper = getPlayerActor(actorKeyRaw)
  if nil == playerActorProxyWrapper then
    return
  end
  local nameTagGroup = UI.getChildControl(targetPanel, "Static_NameTag_Group")
  if nil == nameTagGroup then
    return
  end
  local aliasInfo = UI.getChildControl(nameTagGroup, "CharacterAlias")
  if nil == aliasInfo then
    return
  end
  local actorProxy = playerActorProxyWrapper:get()
  if nil == actorProxy then
    return
  end
  if actorProxy:IsNeedHideNameForPVPServer() == true then
    aliasInfo:SetShow(false)
    return
  end
  if actorProxy:isParticipateInRoseWar() == true then
    aliasInfo:SetShow(false)
    return
  end
  if ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_GuildMatch) == true then
    aliasInfo:SetShow(false)
    return
  end
  if actorProxy:isNeedHideNameForEdaniaInstanceField() == true then
    aliasInfo:SetShow(false)
    return
  end
  if true == actorProxy:isSelfPlayer() and true == PaGlobal_CharacterNameTag_All._isOffNameTagInBattleField and true == PaGlobal_CharacterNameTag_All._isInLocalWar then
    aliasInfo:SetShow(false)
    return
  end
  if actorProxy:isPlayer() then
    local militiaTeamNo = actorProxy:getVolunteerTeamNoForLua()
    local isMilitia = actorProxy:isVolunteer()
    if militiaTeamNo > 0 and true == isMilitia then
      aliasInfo:SetShow(false)
      return
    end
  end
  local instanceMapKey = ToClient_GetCurrentInstanceFieldMapKey()
  if actorProxy:isPlayer() then
    local characterActorProxyWrapper = getCharacterActor(actorKeyRaw)
    local isRemoveAliasForGM = false
    if nil ~= characterActorProxyWrapper then
      local guildNoOrAllianceNo = characterActorProxyWrapper:getGuildNo_s64()
      local isAllianceMember = characterActorProxyWrapper:isGuildAllianceMember()
      if true == isAllianceMember then
        guildNoOrAllianceNo = characterActorProxyWrapper:getGuildAllianceNo_s64()
      end
      local fontColor = ToClient_GetGuildColorStringByGuildNo(guildNoOrAllianceNo)
      if nil ~= fontColor then
        isRemoveAliasForGM = true
      end
    end
    if playerActorProxyWrapper:checkToTitleKey() and false == isRemoveAliasForGM and playerActorProxyWrapper:isParticipateInRoseWar() == false then
      aliasInfo:SetText(playerActorProxyWrapper:getTitleName())
      if false == playerActorProxyWrapper:get():isFlashBanged() and false == playerActorProxyWrapper:get():isHideCharacterName() and true == playerActorProxyWrapper:get():isEquipCamouflage() and playerActorProxyWrapper:getGuildNo_s64() == getSelfPlayer():getGuildNo_s64() then
        aliasInfo:SetMonoTone(true)
      elseif false == playerActorProxyWrapper:get():isFlashBanged() and true == playerActorProxyWrapper:get():isConcealCharacter() then
        aliasInfo:SetMonoTone(true)
      else
        aliasInfo:SetMonoTone(false)
      end
      local isShowForAlli = false
      if true == actorProxy:isHideCharacterName() and true == actorProxy:isShowNameWhenCamouflage() and getSelfPlayer():getActorKey() ~= playerActorProxyWrapper:getActorKey() then
        isShowForAlli = true
      end
      if actorProxy:isHideCharacterName() and false == actorProxy:isFlashBanged() or true == isShowForAlli or __eInstanceRedBattleField_PapuCrio == instanceMapKey then
        aliasInfo:SetShow(false)
      else
        local titleColor = 4282695908
        if playerActorProxyWrapper:isExistTitleColor() then
          titleColor = playerActorProxyWrapper:getTitleColorValue()
        end
        aliasInfo:SetShow(true)
        aliasInfo:SetFontColor(titleColor)
        aliasInfo:useGlowFont(true, "BaseFont_10_Glow", 4278456421)
      end
    else
      aliasInfo:SetShow(false)
    end
  else
    aliasInfo:SetShow(false)
  end
end
local function settingTitle(actorKeyRaw, targetPanel, actorProxyWrapper)
  if _ContentsGroup_NameTag_Optimization == true then
    return
  end
  local actorProxy = actorProxyWrapper:get()
  if false == actorProxy:isPlayer() and false == actorProxy:isMonster() and false == actorProxy:isNpc() then
    return
  end
  local nameTagGroup = UI.getChildControl(targetPanel, "Static_NameTag_Group")
  if nil == nameTagGroup then
    return
  end
  local nickName = UI.getChildControl(nameTagGroup, "CharacterTitle")
  local instanceFieldMapKey = ToClient_GetCurrentInstanceFieldMapKey()
  if nil == nickName then
    return
  end
  if actorProxy:IsNeedHideNameForPVPServer() == true then
    nickName:SetShow(false)
    return
  end
  local isPapuCrio = instanceFieldMapKey == __eInstanceRedBattleField_PapuCrio
  if true == actorProxy:isSelfPlayer() and true == PaGlobal_CharacterNameTag_All._isOffNameTagInBattleField and PaGlobal_CharacterNameTag_All._isInLocalWar then
    nickName:SetShow(false)
    return
  end
  nickName:SetShow(false)
  if actorProxy:isPlayer() then
    local playerActorProxyWrapper = getPlayerActor(actorKeyRaw)
    if nil == playerActorProxyWrapper then
      return
    end
    local militiaTeamNo = actorProxy:getVolunteerTeamNoForLua()
    local isMilitia = playerActorProxyWrapper:get():isVolunteer()
    if militiaTeamNo > 0 and true == isMilitia then
      nickName:SetShow(false)
      return
    end
    nickName:SetSpanSize(nickName:GetSpanSize().x, 20)
    local isShowForAlli = false
    local isAlterNameShow = false
    if false == _ContentsGroup_camouflageueShowName then
      if true == playerActorProxyWrapper:get():isHideCharacterName() and true == playerActorProxyWrapper:get():isShowNameWhenCamouflage() and getSelfPlayer():getActorKey() ~= playerActorProxyWrapper:getActorKey() then
        isShowForAlli = true
      end
      if playerActorProxyWrapper:get():isHideCharacterName() and false == playerActorProxyWrapper:get():isFlashBanged() or true == isShowForAlli then
        return
      end
    elseif true == actorProxy:isSelfPlayer() then
      if true == playerActorProxyWrapper:get():isHideCharacterName() and true == playerActorProxyWrapper:get():isShowNameWhenCamouflage() and getSelfPlayer():getActorKey() ~= playerActorProxyWrapper:getActorKey() then
        isShowForAlli = true
      end
      if playerActorProxyWrapper:get():isHideCharacterName() and false == playerActorProxyWrapper:get():isFlashBanged() or true == isShowForAlli then
        return
      end
    else
      if true == playerActorProxyWrapper:get():isHideCharacterName() and true == playerActorProxyWrapper:get():isShowNameWhenCamouflage() and getSelfPlayer():getActorKey() ~= playerActorProxyWrapper:getActorKey() then
        isShowForAlli = true
      end
      if playerActorProxyWrapper:get():isHideCharacterName() and false == playerActorProxyWrapper:get():isFlashBanged() or true == isShowForAlli then
        isAlterNameShow = true
      end
    end
    local vectorC = {
      x,
      y,
      z,
      w
    }
    vectorC = playerActorProxyWrapper:getAllyPlayerColor()
    local allyColor = 4278190080 + math.floor(255 * vectorC.x) * 256 * 256 + math.floor(255 * vectorC.y) * 256 + math.floor(255 * vectorC.z)
    if 0 < string.len(playerActorProxyWrapper:getUserNickname()) then
      if 0 < vectorC.w then
        nickName:SetFontColor(4293914607)
        nickName:useGlowFont(false)
        nickName:useGlowFont(true, "BaseFont_10_Glow", allyColor)
      else
        nickName:SetFontColor(4293914607)
        nickName:useGlowFont(false)
        nickName:useGlowFont(true, "BaseFont_10_Glow", 4278190080)
      end
      local characterActorProxyWrapper = getCharacterActor(actorKeyRaw)
      local finalString = playerActorProxyWrapper:getUserNickname()
      if nil ~= characterActorProxyWrapper then
        local guildNoOrAllianceNo = characterActorProxyWrapper:getGuildNo_s64()
        local isAllianceMember = characterActorProxyWrapper:isGuildAllianceMember()
        if true == isAllianceMember then
          guildNoOrAllianceNo = characterActorProxyWrapper:getGuildAllianceNo_s64()
        end
        local isFindNewColor = false
        local guildColorCount = ToClient_getGuildColorCount()
        if guildColorCount > 1 then
          local editGuildColor = ToClient_getEditGuildColorByGuildNo(guildNoOrAllianceNo)
          if editGuildColor ~= 0 and editGuildColor ~= 4294967295 then
            nickName:SetFontColor(editGuildColor)
            nickName:useGlowFont(false)
            nickName:useGlowFont(true, "BaseFont_10_Glow", UI_color.C_FF000000)
            nickName:SetMonoTone(false)
            isFindNewColor = true
          end
        else
          local fontColor = ToClient_GetGuildColorStringByGuildNo(guildNoOrAllianceNo)
          if fontColor ~= nil and fontColor ~= "" then
            nickName:SetFontColor(fontColor)
            nickName:useGlowFont(false)
            nickName:useGlowFont(true, "BaseFont_10_Glow", UI_color.C_FF000000)
            nickName:SetMonoTone(false)
            isFindNewColor = true
          end
        end
        if isFindNewColor == false then
          if true == isAlterNameShow and true == _ContentsGroup_camouflageueShowName then
            finalString = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERNAME_CAMO")
            nickName:SetSpanSize(nickName:GetSpanSize().x, 0)
          end
          if false == playerActorProxyWrapper:get():isFlashBanged() and false == playerActorProxyWrapper:get():isHideCharacterName() and true == playerActorProxyWrapper:get():isEquipCamouflage() and playerActorProxyWrapper:getGuildNo_s64() == getSelfPlayer():getGuildNo_s64() then
            nickName:SetMonoTone(true)
          elseif false == playerActorProxyWrapper:get():isFlashBanged() and true == playerActorProxyWrapper:get():isConcealCharacter() then
            nickName:SetMonoTone(true)
          else
            nickName:SetMonoTone(false)
          end
        end
      end
      nickName:SetText(finalString)
      nickName:SetShow(true)
    end
  elseif 0 < string.len(actorProxyWrapper:getCharacterTitle()) then
    nickName:SetText(actorProxyWrapper:getCharacterTitle())
    nickName:SetSpanSize(0, 20)
    nickName:SetShow(true)
    nickName:useGlowFont(false)
  end
  if isPapuCrio == true then
    nickName:SetSpanSize(0, 0)
  end
  if actorProxy:isParticipateInRoseWar() == true and actorProxy:isPlayer() then
    local colorCode
    local gradeType = actorProxy:getRoseWarGradeTypeByMemberDataList()
    if gradeType == __eRoseWarPlayerGradeType_Commander or gradeType == __eRoseWarPlayerGradeType_EnemyCommander then
      nickName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_CHARTITLE_RANK_1"))
      colorCode = UI_color.C_FFFFAA77
    elseif gradeType == __eRoseWarPlayerGradeType_SubCommander or gradeType == __eRoseWarPlayerGradeType_EnemySubCommander then
      nickName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_CHARTITLE_RANK_2"))
      colorCode = UI_color.C_FFFFAA77
    else
      local name = actorProxy:getRoseWarNameTagByKillScore()
      colorCode = actorProxy:getRoseWarNameTagColorCodeByKillScore()
      nickName:SetText(name)
    end
    nickName:useGlowFont(false)
    nickName:SetFontColor(colorCode)
    nickName:useGlowFont(true, "BaseFont_10_Glow", UI_color.C_FF000000)
    nickName:SetMonoTone(false)
    return
  end
  if actorProxy:isPlayer() == true and ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_GuildMatch) == true then
    local fontColor, glowColor
    if ToClient_IsGuildMatchSameTeamAsMe(actorKeyRaw) == true then
      fontColor = UI_color.C_FFABE8FF
      glowColor = UI_color.C_FF0051C0
    else
      fontColor = UI_color.C_FFFFB3AB
      glowColor = UI_color.C_FFC00000
    end
    nickName:useGlowFont(false)
    nickName:SetFontColor(fontColor)
    nickName:useGlowFont(true, "BaseFont_10_Glow", glowColor)
    nickName:SetMonoTone(false)
    return
  end
  if _ContentsGroup_HardCoreChannel == true and actorProxy:isPlayer() and ToClient_isHardCoreChannel() == true then
    nickName:SetShow(false)
    return
  end
  if actorProxy:isPlayer() == true and actorProxy:isNeedHideNameForEdaniaInstanceField() == true then
    nickName:useGlowFont(false)
    nickName:SetFontColor(UI_color.C_FFFFB3AB)
    nickName:useGlowFont(true, "BaseFont_10_Glow", colorCode)
    nickName:SetMonoTone(false)
    nickName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EDANIA_SYSTEM_PVP_CHALLENGER"))
  end
end
local settingFirstTalk = function(actorKeyRaw, targetPanel, actorProxyWrapper, insertedArray)
  if _ContentsGroup_NameTag_Optimization == true then
    return
  end
  local nameTagGroup = UI.getChildControl(targetPanel, "Static_NameTag_Group")
  if nil == nameTagGroup then
    return
  end
  local firstTalk = UI.getChildControl(nameTagGroup, "Static_FirstTalk")
  if nil == firstTalk then
    return
  end
  local npcActorProxyWrapper = getNpcActor(actorKeyRaw)
  if nil == npcActorProxyWrapper then
    return
  end
  firstTalk:SetShow(npcActorProxyWrapper:get():getFirstTalkable())
  insertedArray:push_back(firstTalk)
end
local settingImportantTalk = function(actorKeyRaw, targetPanel, actorProxyWrapper, insertedArray)
  if _ContentsGroup_NameTag_Optimization == true then
    return
  end
  local nameTagGroup = UI.getChildControl(targetPanel, "Static_NameTag_Group")
  if nil == nameTagGroup then
    return
  end
  local importantTalk = UI.getChildControl(nameTagGroup, "Static_ImportantTalk")
  if nil == importantTalk then
    return
  end
  local npcActorProxyWrapper = getNpcActor(actorKeyRaw)
  if nil == npcActorProxyWrapper then
    return
  end
  local isShow = npcActorProxyWrapper:get():getImportantTalk()
  importantTalk:SetShow(isShow)
  if isShow then
    insertedArray:push_back(importantTalk)
  end
end
local function settingOtherHeadIcon(actorKeyRaw, targetPanel, actorProxyWrapper, insertedArray)
  if _ContentsGroup_NameTag_Optimization == true then
    return
  end
  local characterKeyRaw = actorProxyWrapper:getCharacterKeyRaw()
  local npcActorProxyWrapper = getNpcActor(actorKeyRaw)
  if nil == npcActorProxyWrapper then
    return
  end
  local npcData = getNpcInfoByCharacterKeyRaw(characterKeyRaw, npcActorProxyWrapper:get():getDialogIndex())
  if nil ~= npcData then
    for index = 0, CppEnums.SpawnType.eSpawnType_Count - 1 do
      local aControl = getControlProperty(targetPanel, index)
      local isOn = npcData:hasSpawnType(index)
      if nil ~= aControl then
        aControl:SetShow(false)
        if isOn then
          aControl:SetShow(true)
          insertedArray:push_back(aControl)
        end
      end
    end
    if _ContentsGroup_MasterlessHorse == true and ToClient_IsCanSummonMasterlessHorseNPC(actorKeyRaw) == true then
      local nameTagGroup = UI.getChildControl(targetPanel, "Static_NameTag_Group")
      if nameTagGroup ~= nil then
        local rentHorseControl = UI.getChildControl(nameTagGroup, "Static_RentHorse")
        if rentHorseControl ~= nil then
          rentHorseControl:SetShow(true)
          insertedArray:push_back(rentHorseControl)
        end
      end
    end
  end
end
local guildTendencyColor = function(tendency)
  local r, g, b = 0, 0, 0
  local upValue = __eMaxTendency
  local downValue = __eMinTendency
  if tendency > 0 then
    local percents = tendency / upValue
    r = math.floor(255 - 255 * percents)
    g = math.floor(255 - 171 * percents)
    b = 255
  else
    local percents = tendency / downValue
    r = 255
    g = math.floor(255 - 255 * percents)
    b = math.floor(255 - 255 * percents)
  end
  local sumColorValue = 4278190080 + 65536 * r + 256 * g + b
  return sumColorValue
end
local nameTendencyColor = function(tendency)
  local r, g, b = 0, 0, 0
  local upValue = __eMaxTendency
  local downValue = -1000000
  if tendency > 0 then
    local percents = tendency / upValue
    r = math.floor(203 - 203 * percents)
    g = math.floor(203 - 203 * percents)
    b = math.floor(203 + 52 * percents)
  else
    local percents = tendency / downValue
    if percents >= 1 then
      percents = 1
    end
    if _ContentsOption_CH_HPMP_Bar_Color == false then
      r = math.floor(203 + 52 * percents)
      g = math.floor(203 - 203 * percents)
      b = math.floor(203 - 203 * percents)
    else
      r = math.floor(203 - 11 * percents)
      g = math.floor(203 - 166 * percents)
      b = math.floor(203 - 119 * percents)
    end
  end
  local sumColorValue = 4278190080 + 65536 * r + 256 * g + b
  return sumColorValue
end
local hardCoreRankLastTextureID = {}
local function settingHardCoreCharacterNameTag(actorKeyRaw, targetPanel, actorProxyWrapper)
  if _ContentsGroup_HardCoreChannel == false then
    return
  end
  if nil == actorProxyWrapper then
    return
  end
  local actorProxy = actorProxyWrapper:get()
  if nil == actorProxy then
    return
  end
  if false == actorProxy:isPlayer() then
    return
  end
  local playerActorProxyWrapper = getPlayerActor(actorKeyRaw)
  if nil == playerActorProxyWrapper then
    return
  end
  local playerActorProxy = playerActorProxyWrapper:get()
  if nil == playerActorProxy then
    return
  end
  local nameTagGroup = UI.getChildControl(targetPanel, "Static_NameTag_Group")
  if nil == nameTagGroup then
    return
  end
  local characterName = UI.getChildControl(nameTagGroup, "CharacterName")
  if nil == characterName then
    return
  end
  local txt_HardCorePoint = UI.getChildControl(nameTagGroup, "CharacterHardCorePoint")
  local txt_HardCorePointIcon = UI.getChildControl(nameTagGroup, "CharacterHardCorePointIcon")
  local isHardCoreChannel = ToClient_isHardCoreChannel()
  if isHardCoreChannel == false then
    txt_HardCorePoint:SetShow(false)
    txt_HardCorePointIcon:SetShow(false)
    return
  end
  local isHardCoreCharacter = ToClient_isHardCoreCharacter()
  if isHardCoreCharacter == false then
    txt_HardCorePoint:SetShow(false)
    txt_HardCorePointIcon:SetShow(false)
    return
  end
  local rankPoint = playerActorProxyWrapper:getHardCoreRankPoint()
  local nameColor = UI_color.C_00FFFFFF
  local scaleBuffer = txt_HardCorePoint:GetScale()
  txt_HardCorePoint:SetScale(1, 1)
  txt_HardCorePoint:SetText(rankPoint)
  txt_HardCorePoint:SetShow(true)
  txt_HardCorePointIcon:SetScale(1, 1)
  txt_HardCorePointIcon:SetShow(true)
  local aliasInfo = UI.getChildControl(nameTagGroup, "CharacterAlias")
  local hasTitle = playerActorProxyWrapper:getHardCoreTitleExist()
  local isSelfPlayer = actorProxy:isSelfPlayer()
  if hasTitle == true and aliasInfo ~= nil then
    aliasInfo:SetSpanSize(aliasInfo:GetSpanSize().x, 20)
    characterName:SetShow(true)
    local titleColor = playerActorProxyWrapper:getHardCoreTitleColor()
    aliasInfo:SetFontColor(titleColor)
    aliasInfo:SetText(playerActorProxyWrapper:getHardCoreTitleName())
    aliasInfo:SetShow(true)
  end
  local survivalPointPos = 0
  if true == hasTitle then
    survivalPointPos = 40
  else
    survivalPointPos = 20
  end
  local icon_Rank = UI.getChildControl(nameTagGroup, "Static_Hardcore_RankIcon")
  if icon_Rank ~= nil then
    local ranking = playerActorProxyWrapper:getHardCoreIngameRank()
    if ranking == 0 or ranking > 10 then
      icon_Rank:SetShow(false)
    else
      local panelId = targetPanel:GetID()
      local textureID = "Combine_Etc_HardcoreServer_Map_Icon_Ranking" .. ranking
      if hardCoreRankLastTextureID[panelId] == nil then
        hardCoreRankLastTextureID[panelId] = textureID
        icon_Rank:ChangeTextureInfoTextureIDAsync(textureID)
        icon_Rank:setRenderTexture(icon_Rank:getBaseTexture())
        icon_Rank:SetShow(true)
      elseif hardCoreRankLastTextureID[panelId] ~= textureID then
        hardCoreRankLastTextureID[panelId] = textureID
        icon_Rank:ChangeTextureInfoTextureIDAsync(textureID)
        icon_Rank:setRenderTexture(icon_Rank:getBaseTexture())
        icon_Rank:SetShow(true)
      end
    end
  end
  local textureSize = txt_HardCorePointIcon:GetSizeX()
  local textSizeHalf = txt_HardCorePoint:GetTextSizeX() / 2
  txt_HardCorePoint:useGlowFont(true, "BaseFont_10_Glow", UI_color.C_FF000000)
  txt_HardCorePoint:SetFontColor(nameColor)
  txt_HardCorePoint:SetFontAlpha(1)
  txt_HardCorePoint:SetAlpha(1)
  txt_HardCorePoint:SetSpanSize(txt_HardCorePoint:GetSpanSize().x, survivalPointPos)
  txt_HardCorePointIcon:SetSpanSize(txt_HardCorePointIcon:GetSpanSize().x, survivalPointPos)
  txt_HardCorePoint:SetScale(scaleBuffer.x, scaleBuffer.y)
  txt_HardCorePointIcon:SetScale(scaleBuffer.x, scaleBuffer.y)
  txt_HardCorePoint:ComputePos()
  txt_HardCorePointIcon:SetPosX(50 - textureSize - textSizeHalf)
end
local function settingReplayName(actorKeyRaw, targetPanel, actorProxyWrapper)
  if _ContentsGroup_NameTag_Optimization == true then
    return
  end
  local nameTag
  local actorProxy = actorProxyWrapper:get()
  if nil == actorProxy then
    return
  end
  local characterActorProxyWrapper = getCharacterActor(actorKeyRaw)
  local playerActorProxyWrapper = getPlayerActor(actorKeyRaw)
  local instanceMapKey = ToClient_GetCurrentInstanceFieldMapKey()
  local characterActorProxyWrapper = getCharacterActor(actorKeyRaw)
  local playerActorProxyWrapper = getPlayerActor(actorKeyRaw)
  local instanceMapKey = ToClient_GetCurrentInstanceFieldMapKey()
  if actorProxy:isReplayActor() == true and ToClient_IsSolareReplayActor(playerActorProxyWrapper:getUserNo()) == true then
    local nameTagGroup = UI.getChildControl(targetPanel, "Static_NameTag_Group")
    if nameTagGroup == nil then
      return
    end
    local nameTag = UI.getChildControl(nameTagGroup, "CharacterName")
    if nameTag == nil then
      return
    end
    local title = UI.getChildControl(nameTagGroup, "CharacterTitle")
    if title == nil then
      return
    end
    local textName
    local solareIngameInfoWrapper = ToClient_GetInstanceContentsReplaySolareIngameInfo(playerActorProxyWrapper:getUserNo())
    if solareIngameInfoWrapper == nil then
      textName = actorProxyWrapper:getName()
    else
      textName = actorProxyWrapper:getName() .. " " .. PaGloabalFunc_MakeReplayPlayerRankingString(solareIngameInfoWrapper:getClassRanking(), solareIngameInfoWrapper:getRankRating(), false)
    end
    title:SetText(textName)
    nameTag:SetText(textName)
    nameTag:SetShow(true)
  else
    settingName(actorKeyRaw, targetPanel, actorProxyWrapper)
  end
end
local function settingGuildInfo(actorKeyRaw, targetPanel, actorProxyWrapper)
  if _ContentsGroup_NameTag_Optimization == true then
    return
  end
  if nil == targetPanel then
    return
  end
  local actorProxy = actorProxyWrapper:get()
  if nil == actorProxy then
    return
  end
  if false == actorProxy:isPlayer() then
    return
  end
  local nameTagGroup = UI.getChildControl(targetPanel, "Static_NameTag_Group")
  if nil == nameTagGroup then
    return
  end
  local guildName = UI.getChildControl(nameTagGroup, "CharacterGuild")
  local guildMark = UI.getChildControl(nameTagGroup, "Static_GuildMark")
  local guildOccupyIcon = UI.getChildControl(nameTagGroup, "Static_Icon_GuildMaster")
  local guildBack = UI.getChildControl(nameTagGroup, "Static_GuildBackGround")
  local guildMarkXBOXBg = UI.getChildControl(nameTagGroup, "Static_XBOXGuildMarkBg")
  local guildMarkXBOXIcon = UI.getChildControl(nameTagGroup, "Static_XBOXGuildMarkIcon")
  if nil == guildName or nil == guildMark or nil == guildOccupyIcon or nil == guildBack or nil == guildMarkXBOXBg or nil == guildMarkXBOXIcon then
    return
  end
  if actorProxy:IsNeedHideNameForPVPServer() == true or _ContentsGroup_HardCoreChannel == true and ToClient_isHardCoreChannel() == true or actorProxy:isNeedHideNameForEdaniaInstanceField() == true then
    guildName:SetShow(false)
    guildMark:SetShow(false)
    guildBack:SetShow(false)
    guildOccupyIcon:SetShow(false)
    guildMarkXBOXBg:SetShow(false)
    guildMarkXBOXIcon:SetShow(false)
    return
  end
  if actorProxy:isParticipateInRoseWar() == true then
    local roseWarTeamNo = actorProxyWrapper:getRoseWarTeamNo()
    local isSameRoseWarTeamNoWithSelfPlayer = actorProxy:isSameRoseWarTeamWithSelfPlayer()
    local colorCode, fontColorCode
    local teamString = ""
    if isSameRoseWarTeamNoWithSelfPlayer == true then
      colorCode = UI_color.C_FF0051C0
      fontColorCode = UI_color.C_FFABE8FF
    elseif ToClient_IsRoseWarObserveMode() == true then
      local observerTeamNo = ToClient_GetRoseObserveTeamNo()
      if observerTeamNo == roseWarTeamNo then
        colorCode = UI_color.C_FF0051C0
        fontColorCode = UI_color.C_FFABE8FF
      else
        colorCode = UI_color.C_FFC00000
        fontColorCode = UI_color.C_FFFFB3AB
      end
    else
      colorCode = UI_color.C_FFC00000
      fontColorCode = UI_color.C_FFFFB3AB
    end
    if roseWarTeamNo == __eRoseWarTeam_Kamasylvia then
      teamString = "<" .. PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_CHARTITLE_KAMA") .. ">"
    elseif roseWarTeamNo == __eRoseWarTeam_Odyllita then
      teamString = "<" .. PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_CHARTITLE_ODYL") .. ">"
    end
    guildName:useGlowFont(false)
    guildName:SetFontColor(fontColorCode)
    guildName:useGlowFont(true, "BaseFont_10_Glow", colorCode)
    guildName:SetText(teamString)
    guildName:SetMonoTone(false)
    guildName:SetShow(true)
    guildMark:SetShow(false)
    guildBack:SetShow(false)
    guildOccupyIcon:SetShow(false)
    guildMarkXBOXBg:SetShow(false)
    guildMarkXBOXIcon:SetShow(false)
    return
  end
  local instanceFieldMapKey = ToClient_GetCurrentInstanceFieldMapKey()
  local isPapuCrio = __eInstanceRedBattleField_PapuCrio == instanceFieldMapKey
  if (true == actorProxy:isSelfPlayer() or true == isPapuCrio) and (true == PaGlobal_CharacterNameTag_All._isOffNameTagInBattleField and PaGlobal_CharacterNameTag_All._isInLocalWar or true == isPapuCrio) then
    guildName:SetShow(false)
    guildMark:SetShow(false)
    guildBack:SetShow(false)
    guildOccupyIcon:SetShow(false)
    guildMarkXBOXBg:SetShow(false)
    guildMarkXBOXIcon:SetShow(false)
    return
  end
  guildOccupyIcon:SetIgnore(true)
  guildOccupyIcon:SetShow(false)
  local guildSpan = guildMark:GetSpanSize()
  guildOccupyIcon:SetSpanSize(guildSpan.x, 40)
  local playerActorProxyWrapper = getPlayerActor(actorKeyRaw)
  if nil == playerActorProxyWrapper then
    return
  end
  local playerActorProxy = playerActorProxyWrapper:get()
  if nil == playerActorProxy then
    return
  end
  if actorProxy:isPlayer() then
    local militiaTeamNo = actorProxy:getVolunteerTeamNoForLua()
    local isMilitia = playerActorProxy:isVolunteer()
    if militiaTeamNo > 0 and true == isMilitia then
      guildName:SetShow(false)
      guildMark:SetShow(false)
      guildBack:SetShow(false)
      guildMarkXBOXBg:SetShow(false)
      guildMarkXBOXIcon:SetShow(false)
      return
    end
  end
  local hasGuild = playerActorProxy:isGuildMember() and (false == playerActorProxy:isHideGuildName() or playerActorProxy:isFlashBanged())
  if false == playerActorProxy:isFlashBanged() and false == playerActorProxy:isHideCharacterName() and true == playerActorProxy:isEquipCamouflage() and playerActorProxyWrapper:getGuildNo_s64() == getSelfPlayer():getGuildNo_s64() then
    guildName:SetMonoTone(true)
    guildMark:SetMonoTone(true)
    guildBack:SetMonoTone(true)
    guildMarkXBOXBg:SetMonoTone(true)
    guildMarkXBOXIcon:SetMonoTone(true)
  elseif false == playerActorProxy:isFlashBanged() and true == playerActorProxy:isConcealCharacter() then
    guildName:SetMonoTone(true)
    guildMark:SetMonoTone(true)
    guildBack:SetMonoTone(true)
    guildMarkXBOXBg:SetMonoTone(true)
    guildMarkXBOXIcon:SetMonoTone(true)
  else
    guildName:SetMonoTone(false)
    guildMark:SetMonoTone(false)
    guildBack:SetMonoTone(false)
    guildMarkXBOXBg:SetMonoTone(false)
    guildMarkXBOXIcon:SetMonoTone(false)
  end
  local isShowForAlli = false
  if true == playerActorProxyWrapper:get():isHideCharacterName() and true == playerActorProxyWrapper:get():isShowNameWhenCamouflage() and getSelfPlayer():getActorKey() ~= playerActorProxyWrapper:getActorKey() then
    isShowForAlli = true
  end
  if false == hasGuild or true == isShowForAlli then
    guildName:SetShow(false)
    guildMark:SetShow(false)
    guildBack:SetShow(false)
    guildMarkXBOXBg:SetShow(false)
    guildMarkXBOXIcon:SetShow(false)
    return
  else
    guildName:SetShow(hasGuild)
    guildMark:SetShow(hasGuild)
    guildBack:SetShow(hasGuild)
    guildMarkXBOXBg:SetShow(hasGuild)
    guildMarkXBOXIcon:SetShow(hasGuild)
    if isGameServiceTypeConsole() or _ContentsOption_CH_HPMP_Bar_Color == true then
      guildMarkXBOXBg:ComputePos()
      guildMarkXBOXIcon:ComputePos()
      local nameTag = UI.getChildControl(nameTagGroup, "CharacterName")
      local titleTag = UI.getChildControl(nameTagGroup, "CharacterTitle")
      local guildPosEndX = guildMarkXBOXBg:GetPosX()
      if nameTag:GetSizeX() - guildMarkXBOXIcon:GetSizeX() <= nameTag:GetTextSizeX() or titleTag:GetSizeX() - guildMarkXBOXIcon:GetSizeX() <= titleTag:GetTextSizeX() then
        local extraPosX = math.max(nameTag:GetTextSizeX(), titleTag:GetTextSizeX()) * -0.5
        local padding = guildMarkXBOXIcon:GetSizeX() * 0.5
        guildMarkXBOXBg:SetSpanSize(extraPosX - padding, guildMarkXBOXBg:GetSpanSize().y)
        guildMarkXBOXIcon:SetSpanSize(extraPosX - padding, guildMarkXBOXIcon:GetSpanSize().y)
      end
    end
  end
  if hasGuild then
    local isAllianceMember = playerActorProxy:isGuildAllianceMember()
    local isSiegeBeingChannel = ToClient_IsAnySiegeBeingOfMyChannel()
    local guildNameText = ""
    if true == isAllianceMember and true == isSiegeBeingChannel then
      guildNameText = playerActorProxyWrapper:getGuildAllianceName()
      if "" == guildNameText then
        guildNameText = playerActorProxyWrapper:getGuildName()
      end
    else
      guildNameText = playerActorProxyWrapper:getGuildName()
    end
    guildName:useGlowFont(false)
    guildName:SetFontColor(4293914607)
    guildName:useGlowFont(true, "BaseFont_10_Glow", 4279004349)
    local guildNo = 0
    if true == isAllianceMember and true == isSiegeBeingChannel then
      guildNo = playerActorProxyWrapper:getGuildAllianceNo_s64()
    else
      guildNo = playerActorProxyWrapper:getGuildNo_s64()
    end
    local guildGrade = ToClient_getGuildGrade(guildNo)
    local isbadGuildName = playerActorProxyWrapper:isBadNameFlag(guildNo)
    if CppEnums.GuildGrade.GuildGrade_Clan == guildGrade then
      guildMark:SetShow(false)
      guildBack:SetShow(false)
      guildMarkXBOXBg:SetShow(false)
      guildMarkXBOXIcon:SetShow(false)
    else
    end
    local characterActorProxyWrapper = getCharacterActor(actorKeyRaw)
    if nil ~= characterActorProxyWrapper then
      local guildNoOrAllianceNo = characterActorProxyWrapper:getGuildNo_s64()
      local isAllianceMember = characterActorProxyWrapper:isGuildAllianceMember()
      if true == isAllianceMember then
        guildNoOrAllianceNo = characterActorProxyWrapper:getGuildAllianceNo_s64()
      end
      local guildColorCount = ToClient_getGuildColorCount()
      if guildColorCount > 1 then
        local editGuildColor = ToClient_getEditGuildColorByGuildNo(guildNoOrAllianceNo)
        if editGuildColor ~= 0 and editGuildColor ~= 4294967295 then
          guildName:SetFontColor(editGuildColor)
          guildName:useGlowFont(false)
          guildName:useGlowFont(true, "BaseFont_10_Glow", UI_color.C_FF000000)
          guildName:SetMonoTone(false)
          guildMark:SetMonoTone(false)
          guildBack:SetMonoTone(false)
          guildMarkXBOXBg:SetMonoTone(false)
          guildMarkXBOXIcon:SetMonoTone(false)
        end
      else
        local fontColor = ToClient_GetGuildColorStringByGuildNo(guildNoOrAllianceNo)
        if fontColor ~= nil and fontColor ~= "" then
          guildName:SetFontColor(fontColor)
          guildName:useGlowFont(false)
          guildName:useGlowFont(true, "BaseFont_10_Glow", UI_color.C_FF000000)
          guildName:SetMonoTone(false)
          guildMark:SetMonoTone(false)
          guildBack:SetMonoTone(false)
          guildMarkXBOXBg:SetMonoTone(false)
          guildMarkXBOXIcon:SetMonoTone(false)
        end
      end
    end
    if false == isbadGuildName then
      guildName:SetText("<" .. guildNameText .. ">")
    else
      guildName:SetText("<" .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_IMPROPERGUILDNAME") .. ">")
    end
    local hasOccupyTerritory = playerActorProxy:isOccupyTerritory()
    if hasOccupyTerritory then
      guildOccupyIcon:SetShow(true)
      guildOccupyIcon:SetMonoTone(false)
    else
      local allianceCache = 0
      if true == isAllianceMember then
        allianceCache = playerActorProxyWrapper:getGuildAllianceNo_s64()
      else
        allianceCache = playerActorProxyWrapper:getGuildNo_s64()
      end
      local hasSiege = ToClient_hasOccupyingMajorSiege(allianceCache)
      if true == hasSiege then
        guildOccupyIcon:SetShow(true)
        guildOccupyIcon:SetMonoTone(true)
      else
        guildOccupyIcon:SetShow(false)
        guildOccupyIcon:SetMonoTone(false)
      end
    end
    if ToClient_isConsole() == true and true == isGameServiceTypeConsole() or _ContentsOption_CH_HPMP_Bar_Color == true then
      if nil ~= PaGlobalFunc_GuildMark_SetGuildMarkControl then
        PaGlobalFunc_GuildMark_SetGuildMarkControl(guildMarkXBOXBg, guildMarkXBOXIcon, actorKeyRaw)
        guildBack:SetShow(false)
        guildMark:SetShow(false)
      end
    else
      local isSet = setGuildTexture(actorKeyRaw, guildMark)
      if false == isSet then
        guildMarkInit(guildMark)
      else
        guildMark:getBaseTexture():setUV(0, 0, 1, 1)
        guildMark:setRenderTexture(guildMark:getBaseTexture())
      end
      if playerActorProxy:isGuildAllianceChair() then
        guildBack:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Default/Default_Etc_00.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(guildBack, 1, 1, 43, 43)
        guildBack:getBaseTexture():setUV(x1, y1, x2, y2)
        guildBack:setRenderTexture(guildBack:getBaseTexture())
      elseif playerActorProxy:isGuildMaster() then
        guildBack:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Default/Default_Etc_00.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(guildBack, 87, 1, 129, 43)
        guildBack:getBaseTexture():setUV(x1, y1, x2, y2)
        guildBack:setRenderTexture(guildBack:getBaseTexture())
      elseif playerActorProxy:isGuildAdviser() then
        guildBack:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Guild_00.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(guildBack, 271, 1, 313, 43)
        guildBack:getBaseTexture():setUV(x1, y1, x2, y2)
        guildBack:setRenderTexture(guildBack:getBaseTexture())
      elseif playerActorProxy:isGuildSubMaster() then
        guildBack:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Default/Default_Etc_00.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(guildBack, 44, 1, 86, 43)
        guildBack:getBaseTexture():setUV(x1, y1, x2, y2)
        guildBack:setRenderTexture(guildBack:getBaseTexture())
      elseif __eGuildMemberGradeVolunteer == playerActorProxyWrapper:getGuildMemberGrade() then
        guildBack:ChangeTextureInfoNameAsync("renewal/PcRemaster/Remaster_ETC_Guild.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(guildBack, 184, 1, 226, 43)
        guildBack:getBaseTexture():setUV(x1, y1, x2, y2)
        guildBack:setRenderTexture(guildBack:getBaseTexture())
      elseif __eGuildMemberGradeScribe == playerActorProxyWrapper:getGuildMemberGrade() then
        guildBack:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Guild_00.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(guildBack, 500, 71, 542, 113)
        guildBack:getBaseTexture():setUV(x1, y1, x2, y2)
        guildBack:setRenderTexture(guildBack:getBaseTexture())
      elseif __eGuildMemberGradeChiefOfStaff == playerActorProxyWrapper:getGuildMemberGrade() then
        guildBack:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Guild_00.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(guildBack, 543, 71, 585, 113)
        guildBack:getBaseTexture():setUV(x1, y1, x2, y2)
        guildBack:setRenderTexture(guildBack:getBaseTexture())
      else
        guildBack:ChangeTextureInfoNameAsync("")
      end
      guildMarkXBOXBg:SetShow(false)
      guildMarkXBOXIcon:SetShow(false)
    end
  else
    guildOccupyIcon:SetShow(false)
    guildMarkInit(guildMark)
  end
  if actorProxy:isPlayer() == true and ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_GuildMatch) == true then
    local fontColor, glowColor
    if ToClient_IsGuildMatchSameTeamAsMe(actorKeyRaw) == true then
      fontColor = UI_color.C_FFABE8FF
      glowColor = UI_color.C_FF0051C0
    else
      fontColor = UI_color.C_FFFFB3AB
      glowColor = UI_color.C_FFC00000
    end
    guildName:useGlowFont(false)
    guildName:SetFontColor(fontColor)
    guildName:useGlowFont(true, "BaseFont_10_Glow", glowColor)
    guildName:SetMonoTone(false)
    return
  end
end
local function settingGuildMarkInfoForReplay(actorKeyRaw, targetPanel, actorProxyWrapper)
  if nil == targetPanel then
    return
  end
  local actorProxy = actorProxyWrapper:get()
  if nil == actorProxy then
    return
  end
  if false == actorProxy:isReplayActor() then
    return
  end
  local nameTagGroup = UI.getChildControl(targetPanel, "Static_NameTag_Group")
  if nil == nameTagGroup then
    return
  end
  local guildMark = UI.getChildControl(nameTagGroup, "Static_GuildMark")
  local guildBack = UI.getChildControl(nameTagGroup, "Static_GuildBackGround")
  local guildName = UI.getChildControl(nameTagGroup, "CharacterGuild")
  if nil == guildMark or nil == guildBack or nil == guildName then
    return
  end
  local playerActorProxyWrapper = getPlayerActor(actorKeyRaw)
  if nil == playerActorProxyWrapper then
    return
  end
  local playerActorProxy = playerActorProxyWrapper:get()
  if nil == playerActorProxy then
    return
  end
  local hasGuild = playerActorProxy:isGuildMember() and (false == playerActorProxy:isHideGuildName() or playerActorProxy:isFlashBanged())
  if false == hasGuild or true == isShowForAlli then
    guildMark:SetShow(false)
    return
  else
    guildMark:SetShow(hasGuild)
    guildBack:SetShow(hasGuild)
  end
  if true == hasGuild then
    guildName:SetText("<" .. playerActorProxyWrapper:getGuildName() .. ">")
    local isAllianceMember = playerActorProxy:isGuildAllianceMember()
    local isSiegeBeingChannel = ToClient_IsAnySiegeBeingOfMyChannel()
    local guildNo = 0
    if true == isAllianceMember and true == isSiegeBeingChannel then
      guildNo = playerActorProxyWrapper:getGuildAllianceNo_s64()
    else
      guildNo = playerActorProxyWrapper:getGuildNo_s64()
    end
    local isSet = setGuildTexture(actorKeyRaw, guildMark)
    if false == isSet then
      guildMarkInit(guildMark)
    else
      guildMark:getBaseTexture():setUV(0, 0, 1, 1)
      guildMark:setRenderTexture(guildMark:getBaseTexture())
    end
    if playerActorProxy:isGuildAllianceChair() then
      guildBack:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Default/Default_Etc_00.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(guildBack, 1, 1, 43, 43)
      guildBack:getBaseTexture():setUV(x1, y1, x2, y2)
      guildBack:setRenderTexture(guildBack:getBaseTexture())
    elseif playerActorProxy:isGuildMaster() then
      guildBack:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Default/Default_Etc_00.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(guildBack, 87, 1, 129, 43)
      guildBack:getBaseTexture():setUV(x1, y1, x2, y2)
      guildBack:setRenderTexture(guildBack:getBaseTexture())
    elseif playerActorProxy:isGuildAdviser() then
      guildBack:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Guild_00.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(guildBack, 271, 1, 313, 43)
      guildBack:getBaseTexture():setUV(x1, y1, x2, y2)
      guildBack:setRenderTexture(guildBack:getBaseTexture())
    elseif playerActorProxy:isGuildSubMaster() then
      guildBack:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Default/Default_Etc_00.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(guildBack, 44, 1, 86, 43)
      guildBack:getBaseTexture():setUV(x1, y1, x2, y2)
      guildBack:setRenderTexture(guildBack:getBaseTexture())
    elseif __eGuildMemberGradeVolunteer == playerActorProxyWrapper:getGuildMemberGrade() then
      guildBack:ChangeTextureInfoNameAsync("renewal/PcRemaster/Remaster_ETC_Guild.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(guildBack, 184, 1, 226, 43)
      guildBack:getBaseTexture():setUV(x1, y1, x2, y2)
      guildBack:setRenderTexture(guildBack:getBaseTexture())
    elseif __eGuildMemberGradeScribe == playerActorProxyWrapper:getGuildMemberGrade() then
      guildBack:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Guild_00.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(guildBack, 271, 1, 313, 43)
      guildBack:getBaseTexture():setUV(x1, y1, x2, y2)
      guildBack:setRenderTexture(guildBack:getBaseTexture())
    elseif __eGuildMemberGradeChiefOfStaff == playerActorProxyWrapper:getGuildMemberGrade() then
      guildBack:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Guild_00.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(guildBack, 543, 71, 585, 113)
      guildBack:getBaseTexture():setUV(x1, y1, x2, y2)
      guildBack:setRenderTexture(guildBack:getBaseTexture())
    else
      guildBack:ChangeTextureInfoNameAsync("")
    end
  else
    guildMarkInit(guildMark)
  end
end
local settingEdanaInfo = function(actorKeyRaw, targetPanel, actorProxyWrapper)
  if _ContentsGroup_NameTag_Optimization == true then
    return
  end
  if targetPanel == nil then
    return
  end
  local actorProxy = actorProxyWrapper:get()
  if actorProxy == nil then
    return
  end
  if actorProxy:isPlayer() == false then
    return
  end
  local nameTagGroup = UI.getChildControl(targetPanel, "Static_NameTag_Group")
  if nameTagGroup == nil then
    return
  end
  local edanaIcon = UI.getChildControl(nameTagGroup, "Static_Icon_Edana")
  if edanaIcon == nil then
    return
  end
  edanaIcon:SetShow(false)
  local playerActorProxyWrapper = getPlayerActor(actorKeyRaw)
  if playerActorProxyWrapper == nil then
    return
  end
  local playerActorProxy = playerActorProxyWrapper:get()
  if playerActorProxy == nil then
    return
  end
  if actorProxy:isSelfPlayer() == true and true == PaGlobal_CharacterNameTag_All._isOffNameTagInBattleField and PaGlobal_CharacterNameTag_All._isInLocalWar then
    return
  end
  if actorProxy:IsNeedHideNameForPVPServer() == true then
    return
  end
  if playerActorProxyWrapper:isParticipateInRoseWar() == true then
    return
  end
  local isShowForAlli = false
  if true == playerActorProxy:isHideCharacterName() and true == playerActorProxy:isShowNameWhenCamouflage() and getSelfPlayer():getActorKey() ~= playerActorProxyWrapper:getActorKey() then
    isShowForAlli = true
  end
  if playerActorProxy:isHideCharacterName() and false == playerActorProxy:isFlashBanged() or true == isShowForAlli then
    return
  end
  if ToClient_IsEdana(playerActorProxyWrapper:getUserNo()) == false then
    return
  end
  local edaniaRegion = ToClient_GetEdaniaRegion(playerActorProxyWrapper:getUserNo())
  local textureID = ""
  if edaniaRegion == __eEdaniaRegion_Aetherion then
    textureID = "Combine_Etc_EdaniaIcon_Jordain_Normal"
  elseif edaniaRegion == __eEdaniaRegion_Nymphamare then
    textureID = "Combine_Etc_EdaniaIcon_Rusalka_Normal"
  elseif edaniaRegion == __eEdaniaRegion_Orbita then
    textureID = "Combine_Etc_EdaniaIcon_Ensla_Normal"
  elseif edaniaRegion == __eEdaniaRegion_Tenebraum then
    textureID = "Combine_Etc_EdaniaIcon_Kartian_Normal"
  elseif edaniaRegion == __eEdaniaRegion_Zephyros then
    textureID = "Combine_Etc_EdaniaIcon_Caphras_Normal"
  end
  edanaIcon:ChangeTextureInfoTextureIDAsync(textureID)
  edanaIcon:setRenderTexture(edanaIcon:getBaseTexture())
  edanaIcon:SetMonoTone(playerActorProxyWrapper:isInEdaniaRegion() == false)
  edanaIcon:SetShow(true)
end
local function settingMonsterName(actorKeyRaw, targetPanel, actorProxyWrapper)
  local nameTagGroup = UI.getChildControl(targetPanel, "Static_NameTag_Group")
  if nil == nameTagGroup then
    return
  end
  local nameTag = UI.getChildControl(nameTagGroup, "CharacterName")
  if nil == nameTag then
    return
  end
  local monsterActorProxyWrapper = getMonsterActor(actorKeyRaw)
  if nil == monsterActorProxyWrapper then
    return
  end
  local selfPlayerActorProxyWrapper = getSelfPlayer()
  if nil == selfPlayerActorProxyWrapper then
    return
  end
  local monsterLevel = monsterActorProxyWrapper:get():getCharacterSimplyStaticStatus().level
  local selfPlayerLevel = selfPlayerActorProxyWrapper:get():getLevel()
  setMonsterNameColor_Level(selfPlayerLevel, monsterLevel, nameTag, monsterActorProxyWrapper:get():isDarkSpiritMonster())
end
local function settingLifeRankIcon(actorKeyRaw, targetPanel, actorProxyWrapper, insertedArray)
  if _ContentsGroup_NameTag_Optimization == true then
    return
  end
  local actorProxy = actorProxyWrapper:get()
  if nil == actorProxy then
    return
  end
  if false == actorProxy:isPlayer() and false == actorProxy:isSubPlayer() then
    return
  end
  if lifeContentCount <= 0 then
    return
  end
  if ToClient_namelessPVPServer() == true then
    return
  end
  if true == actorProxy:isSelfPlayer() and true == isPlayMusic then
    return
  end
  local mylocalTeamNo = ToClient_GetMyTeamNoRedBattleField()
  if true == actorProxy:isSelfPlayer() and true == PaGlobal_CharacterNameTag_All._isOffNameTagInBattleField and PaGlobal_CharacterNameTag_All._isInLocalWar then
    return
  end
  if mylocalTeamNo > 0 or true == ToClient_IsMyselfInEntryUser() then
    return
  end
  local isRankShow = ToClient_getLifeRankNameTag()
  local nameTagGroup = UI.getChildControl(targetPanel, "Static_NameTag_Group")
  if nil == nameTagGroup then
    return
  end
  local lifeRankIcon = {}
  for i = 0, lifeContentCount - 1 do
    lifeRankIcon[i] = nil
    lifeRankIcon[i] = UI.getChildControl(nameTagGroup, "Static_LifeRankIcon_" .. i)
    if nil == lifeRankIcon[i] then
      return
    end
    lifeRankIcon[i]:SetShow(false)
  end
  if actorProxy:isParticipateInRoseWar() == true then
    return
  end
  if actorProxy:isPlayer() == true and ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_GuildMatch) == true then
    return
  end
  local iconSizeX = lifeRankIcon[0]:GetSizeX()
  local iconGap = 5
  local playerActorProxyWrapper = getPlayerActor(actorKeyRaw)
  if nil == playerActorProxyWrapper then
    return
  end
  local playerActorProxy = playerActorProxyWrapper:get()
  if nil == playerActorProxy then
    return
  end
  if actorProxy:isPlayer() then
    local militiaTeamNo = actorProxy:getVolunteerTeamNoForLua()
    local isMilitia = playerActorProxy:isVolunteer()
    if militiaTeamNo > 0 and true == isMilitia then
      return
    end
  end
  if ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Edania) == true or ToClient_IsEdana(playerActorProxyWrapper:getUserNo()) then
    return
  end
  for lifeContentIndex = 0, lifeContent.match do
    lifeContent[lifeContentIndex] = {}
  end
  local hasContentRank = 0
  for lifeContentIndex = 0, lifeContent.barter do
    if nil ~= convertLifeIndex[lifeContentIndex] then
      local hasRank = FromClient_GetTopRankListForNameTag():hasRank(convertLifeIndex[lifeContentIndex], actorKeyRaw)
      local rankNumer = 0
      if nil ~= FGlobal_LifeRanking_CheckEnAble and FGlobal_LifeRanking_CheckEnAble(lifeContentIndex) and true == hasRank then
        local rankNumer = FromClient_GetTopRankListForNameTag():getRank(convertLifeIndex[lifeContentIndex], actorKeyRaw) + 1
        lifeContent[lifeContentIndex][rankNumer] = rankNumer
        lifeRankIcon[lifeContentIndex]:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/RankingIcon_00.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(lifeRankIcon[lifeContentIndex], lifeRankSetTexture[lifeContentIndex][rankNumer].x1, lifeRankSetTexture[lifeContentIndex][rankNumer].y1, lifeRankSetTexture[lifeContentIndex][rankNumer].x2, lifeRankSetTexture[lifeContentIndex][rankNumer].y2)
        lifeRankIcon[lifeContentIndex]:getBaseTexture():setUV(x1, y1, x2, y2)
        lifeRankIcon[lifeContentIndex]:setRenderTexture(lifeRankIcon[lifeContentIndex]:getBaseTexture())
        if false == playerActorProxy:isFlashBanged() and false == playerActorProxy:isHideCharacterName() and true == playerActorProxy:isEquipCamouflage() and playerActorProxyWrapper:getGuildNo_s64() == getSelfPlayer():getGuildNo_s64() then
          lifeRankIcon[lifeContentIndex]:SetMonoTone(true)
        elseif false == playerActorProxy:isFlashBanged() and true == playerActorProxy:isConcealCharacter() then
          lifeRankIcon[lifeContentIndex]:SetMonoTone(true)
        else
          lifeRankIcon[lifeContentIndex]:SetMonoTone(false)
        end
        local isShowForAlli = false
        if true == playerActorProxy:isHideCharacterName() and true == playerActorProxy:isShowNameWhenCamouflage() and getSelfPlayer():getActorKey() ~= playerActorProxyWrapper:getActorKey() then
          isShowForAlli = true
        end
        if playerActorProxy:isPlayer() and playerActorProxy:isHideCharacterName() and false == playerActorProxy:isFlashBanged() or true == isShowForAlli then
          lifeRankIcon[lifeContentIndex]:SetShow(false)
        else
          lifeRankIcon[lifeContentIndex]:SetShow(isRankShow)
        end
        insertedArray:push_back(lifeRankIcon[lifeContentIndex])
      end
    end
  end
  for lifeContentIndex = lifeContent.combat, lifeContent.battleField do
    if nil ~= convertBattleIndex[lifeContentIndex] then
      hasContentRank = FromClient_GetTopRankListForNameTag():hasContentsRank(convertBattleIndex[lifeContentIndex], actorKeyRaw)
      if nil ~= FGlobal_LifeRanking_CheckEnAble and FGlobal_LifeRanking_CheckEnAble(lifeContentIndex) and true == hasContentRank then
        local rankNumer = FromClient_GetTopRankListForNameTag():getContentsRank(convertBattleIndex[lifeContentIndex], actorKeyRaw) + 1
        lifeContent[lifeContentIndex][rankNumer] = rankNumer
        lifeRankIcon[lifeContentIndex]:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/RankingIcon_00.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(lifeRankIcon[lifeContentIndex], lifeRankSetTexture[lifeContentIndex][rankNumer].x1, lifeRankSetTexture[lifeContentIndex][rankNumer].y1, lifeRankSetTexture[lifeContentIndex][rankNumer].x2, lifeRankSetTexture[lifeContentIndex][rankNumer].y2)
        lifeRankIcon[lifeContentIndex]:getBaseTexture():setUV(x1, y1, x2, y2)
        lifeRankIcon[lifeContentIndex]:setRenderTexture(lifeRankIcon[lifeContentIndex]:getBaseTexture())
        if false == playerActorProxy:isFlashBanged() and false == playerActorProxy:isHideCharacterName() and true == playerActorProxy:isEquipCamouflage() and playerActorProxyWrapper:getGuildNo_s64() == getSelfPlayer():getGuildNo_s64() then
          lifeRankIcon[lifeContentIndex]:SetMonoTone(true)
        elseif false == playerActorProxy:isFlashBanged() and true == playerActorProxy:isConcealCharacter() then
          lifeRankIcon[lifeContentIndex]:SetMonoTone(true)
        else
          lifeRankIcon[lifeContentIndex]:SetMonoTone(false)
        end
        local isShowForAlli = false
        if true == playerActorProxy:isHideCharacterName() and true == playerActorProxy:isShowNameWhenCamouflage() and getSelfPlayer():getActorKey() ~= playerActorProxyWrapper:getActorKey() then
          isShowForAlli = true
        end
        if playerActorProxy:isPlayer() and playerActorProxy:isHideCharacterName() and false == playerActorProxy:isFlashBanged() or true == isShowForAlli then
          lifeRankIcon[lifeContentIndex]:SetShow(false)
        else
          lifeRankIcon[lifeContentIndex]:SetShow(isRankShow)
        end
        insertedArray:push_back(lifeRankIcon[lifeContentIndex])
      end
    end
  end
  local matchType = 0
  local hasMatchRank = 0
  local isEnableContentsPvP = ToClient_IsContentsGroupOpen("38")
  hasMatchRank = FromClient_GetTopRankListForNameTag():hasMatchRank(matchType, actorKeyRaw)
  if true == hasMatchRank and isEnableContentsPvP then
    local rankNumer = FromClient_GetTopRankListForNameTag():getMatchRank(matchType, actorKeyRaw) + 1
    lifeContent[lifeContent.match][rankNumer] = rankNumer
    lifeRankIcon[lifeContent.match]:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/RankingIcon_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(lifeRankIcon[lifeContent.match], lifeRankSetTexture[lifeContent.match][rankNumer].x1, lifeRankSetTexture[lifeContent.match][rankNumer].y1, lifeRankSetTexture[lifeContent.match][rankNumer].x2, lifeRankSetTexture[lifeContent.match][rankNumer].y2)
    lifeRankIcon[lifeContent.match]:getBaseTexture():setUV(x1, y1, x2, y2)
    lifeRankIcon[lifeContent.match]:setRenderTexture(lifeRankIcon[lifeContent.match]:getBaseTexture())
    if false == playerActorProxy:isFlashBanged() and false == playerActorProxy:isHideCharacterName() and true == playerActorProxy:isEquipCamouflage() and playerActorProxyWrapper:getGuildNo_s64() == getSelfPlayer():getGuildNo_s64() then
      lifeRankIcon[lifeContent.match]:SetMonoTone(true)
    elseif false == playerActorProxy:isFlashBanged() and true == playerActorProxy:isConcealCharacter() then
      lifeRankIcon[lifeContent.match]:SetMonoTone(true)
    else
      lifeRankIcon[lifeContent.match]:SetMonoTone(false)
    end
    local isShowForAlli = false
    if true == playerActorProxy:isHideCharacterName() and true == playerActorProxy:isShowNameWhenCamouflage() and getSelfPlayer():getActorKey() ~= playerActorProxyWrapper:getActorKey() then
      isShowForAlli = true
    end
    if playerActorProxy:isPlayer() and playerActorProxy:isHideCharacterName() and false == playerActorProxy:isFlashBanged() or true == isShowForAlli then
      lifeRankIcon[lifeContent.match]:SetShow(false)
    else
      lifeRankIcon[lifeContent.match]:SetShow(isRankShow)
    end
    insertedArray:push_back(lifeRankIcon[lifeContent.match])
  end
  local spanSizeY = 40
  local hasGuild = playerActorProxy:isGuildMember() and (false == playerActorProxy:isHideGuildName() or playerActorProxy:isFlashBanged())
  if hasGuild then
    spanSizeY = spanSizeY + 20
  end
  if playerActorProxy:isPlayer() and playerActorProxyWrapper:checkToTitleKey() and playerActorProxyWrapper:isParticipateInRoseWar() == false then
    spanSizeY = spanSizeY + 20
  end
  sortCenterX(insertedArray)
end
local function settingPlayerName(actorKeyRaw, targetPanel, actorProxyWrapper)
  if _ContentsGroup_NameTag_Optimization == true then
    return
  end
  local nameTagGroup = UI.getChildControl(targetPanel, "Static_NameTag_Group")
  if nil == nameTagGroup then
    return
  end
  local nameTag = UI.getChildControl(nameTagGroup, "CharacterName")
  if nil == nameTag then
    return
  end
  local actorProxy = actorProxyWrapper:get()
  if nil == actorProxy then
    return
  end
  if true == actorProxy:isSelfPlayer() and true == PaGlobal_CharacterNameTag_All._isOffNameTagInBattleField and PaGlobal_CharacterNameTag_All._isInLocalWar then
    return
  end
  if ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare) == true then
    return
  end
  if ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_GuildMatch) == true then
    return
  end
  if actorProxy:isNeedHideNameForEdaniaInstanceField() == true then
    return
  end
  if _ContentsGroup_HardCoreChannel == true and ToClient_isHardCoreChannel() == true and actorProxy:isPlayer() == true then
    local playerActorProxyWrapper = getPlayerActor(actorKeyRaw)
    local vectorC = {
      x,
      y,
      z,
      w
    }
    vectorC = playerActorProxyWrapper:getAllyPlayerColor()
    local allyColor = 4278190080 + math.floor(255 * vectorC.x) * 256 * 256 + math.floor(255 * vectorC.y) * 256 + math.floor(255 * vectorC.z)
    if vectorC.w > 0 then
      nameTag:SetFontColor(4293914607)
      nameTag:useGlowFont(false)
      nameTag:useGlowFont(true, "BaseFont_10_Glow", allyColor)
      nameTag:SetMonoTone(false, false)
    else
      nameTag:SetFontColor(4293914607)
      nameTag:useGlowFont(false)
      nameTag:useGlowFont(true, "BaseFont_10_Glow", allyColor)
      nameTag:SetMonoTone(false, false)
    end
    settingHardCoreCharacterNameTag(actorKeyRaw, targetPanel, actorProxyWrapper)
    return
  end
  if actorProxy:IsNeedHideNameForPVPServer() == true then
    nameTag:useGlowFont(false)
    nameTag:SetFontColor(UI_color.C_FFFFFFFF)
    nameTag:useGlowFont(true, "BaseFont_10_Glow", UI_color.C_FFFF0000)
    nameTag:SetMonoTone(false, false)
    return
  end
  local playerActorProxyWrapper = getPlayerActor(actorKeyRaw)
  if nil == playerActorProxyWrapper then
    return
  end
  local playerActorProxy = playerActorProxyWrapper:get()
  local playerTendency = playerActorProxy:getTendency()
  local guildNoOrAllianceNo = playerActorProxyWrapper:getGuildNo_s64()
  local isAllianceMember = playerActorProxyWrapper:isGuildAllianceMember()
  if true == isAllianceMember then
    guildNoOrAllianceNo = playerActorProxyWrapper:getGuildAllianceNo_s64()
  end
  local fontColor
  local isUseEditGuildColor = false
  local guildColorCount = ToClient_getGuildColorCount()
  if guildColorCount > 1 then
    local editGuildColor = ToClient_getEditGuildColorByGuildNo(guildNoOrAllianceNo)
    isUseEditGuildColor = editGuildColor ~= 0 and editGuildColor ~= 4294967295
  end
  if isUseEditGuildColor == false then
    fontColor = ToClient_GetGuildColorStringByGuildNo(guildNoOrAllianceNo)
    if fontColor ~= nil and playerActorProxyWrapper:checkAppliableGuildColor() == false then
      fontColor = nil
    end
  end
  nameTag:useGlowFont(false)
  if playerActorProxy:isPvpEnable() == true then
    if isUseEditGuildColor == true then
      nameTag:useGlowFont(true, "BaseFont_10_Glow", UI_color.C_FF000000)
    elseif fontColor ~= nil then
      nameTag:useGlowFont(true, "BaseFont_10_Glow", UI_color.C_FF000000)
    else
      nameTag:SetFontColor(4293914607)
      nameTag:useGlowFont(true, "BaseFont_10_Glow", nameTendencyColor(playerTendency))
    end
  elseif isUseEditGuildColor == true then
    nameTag:useGlowFont(true, "BaseFont_10_Glow", UI_color.C_FF000000)
  elseif fontColor ~= nil then
    nameTag:useGlowFont(true, "BaseFont_10_Glow", UI_color.C_FF000000)
  else
    nameTag:SetFontColor(4294574047)
    nameTag:useGlowFont(true, "BaseFont_10_Glow", 4283917312)
  end
  if actorProxy:isParticipateInRoseWar() == true then
    local isSameRoseWarTeamNoWithSelfPlayer = actorProxy:isSameRoseWarTeamWithSelfPlayer()
    local colorCode
    if isSameRoseWarTeamNoWithSelfPlayer == true then
      colorCode = UI_color.C_FFABE8FF
    else
      colorCode = UI_color.C_FFFFB3AB
    end
    nameTag:useGlowFont(false)
    nameTag:SetFontColor(UI_color.C_FFFFFFFF)
    nameTag:useGlowFont(true, "BaseFont_10_Glow", UI_color.C_FF000000)
    nameTag:SetMonoTone(false)
  end
end
function isShowInstallationEnduranceType(installationType)
  if installationType == CppEnums.InstallationType.eType_Mortar or installationType == CppEnums.InstallationType.eType_Anvil or installationType == CppEnums.InstallationType.eType_Stump or installationType == CppEnums.InstallationType.eType_FireBowl or installationType == CppEnums.InstallationType.eType_Buff or installationType == CppEnums.InstallationType.eType_Alchemy or installationType == CppEnums.InstallationType.eType_Havest or installationType == CppEnums.InstallationType.eType_Bookcase or installationType == CppEnums.InstallationType.eType_Cooking or installationType == CppEnums.InstallationType.eType_Bed or installationType == CppEnums.InstallationType.eType_LivestockHarvest then
    return true
  else
    return false
  end
end
local isFourty = false
local isTwenty = false
local furnitureCheck = false
function ShowUseTab_Func()
  if nil == getSelfPlayer() then
    return
  end
  local myLevel = getSelfPlayer():get():getLevel()
  if myLevel > 30 then
    return
  end
  local targetPanel = getSelfPlayer():get():getUIPanel()
  if nil == targetPanel then
    return
  end
  PaGlobalFunc_UseTab_Show(0, IsChecked_WeaponOut, PAGetString(Defines.StringSheet_RESOURCE, "UI_ACTOR_NAMETAG_USETAB"))
  if true == isGameServiceTypeConsole() then
    PaGlobalFunc_UseTab_Show(0, false)
  end
end
function HideUseTab_Func()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local targetPanel = selfPlayer:get():getUIPanel()
  if nil == targetPanel then
    return
  end
  PaGlobalFunc_UseTab_Show(0, false)
end
function FGlobal_ShowUseLantern(param)
  if nil == getSelfPlayer() then
    return
  end
  local isReplayMode = ToClient_IsPlayingReplay()
  if true == isReplayMode then
    return
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare) then
    return
  end
  local targetPanel = getSelfPlayer():get():getUIPanel()
  local isLevel = getSelfPlayer():get():getLevel()
  if nil == targetPanel then
    return
  end
  local lanternIdx = 1
  if true == isGameServiceTypeConsole() then
    lanternIdx = 2
  end
  if isLevel < 16 then
    return
  end
  PaGlobalFunc_UseTab_Show(lanternIdx, param)
end
local function settingHpBarInitState(actorKeyRaw, targetPanel, actorProxyWrapper, isSubPlayer)
  local actorProxy = actorProxyWrapper:get()
  if nil == actorProxy then
    return
  end
  local hpBack, hpLater, hpMain
  local progressGroup = UI.getChildControl(targetPanel, "Static_Progress_Group")
  if nil == progressGroup then
    return
  end
  if actorProxy:isKingOrLordTent() then
    hpBack = UI.getChildControl(progressGroup, "KingOrLordTentProgressBack")
    hpLater = UI.getChildControl(progressGroup, "KingOrLordTentProgress2_HpLater")
    hpMain = UI.getChildControl(progressGroup, "KingOrLordTentHPGageProgress")
  elseif actorProxy:isLargeHpBarCharacter() then
    hpBack = UI.getChildControl(progressGroup, "KingOrLordTentProgressBack")
    hpLater = UI.getChildControl(progressGroup, "KingOrLordTentProgress2_HpLater")
    hpMain = UI.getChildControl(progressGroup, "KingOrLordTentHPGageProgress")
  else
    hpBack = UI.getChildControl(progressGroup, "ProgressBack")
    hpLater = UI.getChildControl(progressGroup, "Progress2_HpLater")
    hpMain = UI.getChildControl(progressGroup, "CharacterHPGageProgress")
  end
  local characterStaticStatus = actorProxy:getCharacterSimplyStaticStatus()
  if nil == hpBack or nil == hpLater or nil == hpMain or nil == characterStaticStatus then
    return
  end
  hpMain:ResetVertexAni(true)
  hpLater:ResetVertexAni(true)
  hpMain:SetAlpha(1)
  hpLater:SetAlpha(1)
  if actorProxy:isSelfPlayer() == true and (isSubPlayer == nil or isSubPlayer == false) then
    local usePotion = UI.getChildControl(progressGroup, "StaticText_UsePotion")
    usePotion:SetShow(false)
  elseif true == actorProxy:isReplayActor() then
  elseif true == actorProxy:isPlayer() then
    CharacterNameTag_SetHpBarContainer(actorKeyRaw, actorProxy, targetPanel)
  end
end
local beforeMaxHp = {}
local rulerControl = {}
function checkAndCreateRular(rularCount, targetPanel, actorKeyRaw)
  if nil == rulerControl[actorKeyRaw] then
    rulerControl[actorKeyRaw] = {}
    rulerControl[actorKeyRaw].createRulerCount = 0
    if nil ~= targetPanel then
      rulerControl[actorKeyRaw].panel = targetPanel:GetID()
    end
  end
  if rularCount == rulerControl[actorKeyRaw].createRulerCount then
    return false
  end
  local progressGroup = UI.getChildControl(targetPanel, "Static_Progress_Group")
  if nil == progressGroup then
    return
  end
  rulerControl[actorKeyRaw].rularParent = UI.getChildControl(progressGroup, "Static_Rular")
  for index = 0, rularCount - 1 do
    if index >= rulerControl[actorKeyRaw].createRulerCount then
      if 9 == index % 10 then
        rulerControl[actorKeyRaw][index] = UI.createAndCopyBasePropertyControl(progressGroup, "Static_1000Stick", rulerControl[actorKeyRaw].rularParent, "RulerControl_" .. index)
      else
        rulerControl[actorKeyRaw][index] = UI.createAndCopyBasePropertyControl(progressGroup, "Static_100Stick", rulerControl[actorKeyRaw].rularParent, "RulerControl_" .. index)
      end
    end
  end
  for index = 0, rulerControl[actorKeyRaw].createRulerCount - 1 do
    rulerControl[actorKeyRaw][index]:SetShow(false)
  end
  rulerControl[actorKeyRaw].createRulerCount = rularCount
  return true
end
function checkAvailableRular(index, rularCount)
  if rularCount > 1000 then
    return false
  elseif rularCount >= 100 then
    if 9 == index % 10 then
      return true
    end
  elseif rularCount >= 40 then
    if 1 == index % 2 then
      return true
    end
  else
    return true
  end
  return false
end
function checkChagnedNameTagPanel(actorKeyRaw, targetPanel, hpMain, rularParent)
  if nil == beforeMaxHp[actorKeyRaw] then
    return false
  end
  if nil == rulerControl[actorKeyRaw] then
    return false
  end
  if nil == rulerControl[actorKeyRaw].panel or nil == targetPanel then
    return false
  end
  if rulerControl[actorKeyRaw].panel ~= targetPanel:GetID() then
    rularParent:MoveChilds(rularParent:GetID(), rulerControl[actorKeyRaw].rularParent)
    rularParent:SetPosX(hpMain:GetPosX())
    rularParent:SetPosY(hpMain:GetPosY())
    rularParent:SetShow(hpMain:GetShow())
    rulerControl[actorKeyRaw].panel = targetPanel:GetID()
    rulerControl[actorKeyRaw].rularParent = rularParent
    rulerControl[actorKeyRaw].hpMain = hpMain
    return false
  end
  return false
end
function GameOptionApply_CharacterNameTag_Ruler(isShow)
  if nil == rulerControl then
    return
  end
  for _, control in pairs(rulerControl) do
    if false == isShow then
      if nil ~= control.rularParent then
        control.rularParent:SetShow(isShow)
      end
    elseif nil ~= control.hpMain and nil ~= control.rularParent then
      control.rularParent:SetShow(control.hpMain:GetShow())
    end
  end
end
function GameOptionApply_CharacterNameTag_StackHpBar(isShow)
  if nil == _characterHpBarContainer then
    return isShow
  end
  for _, hpBarData in pairs(_characterHpBarContainer) do
    if nil ~= hpBarData.stackHpBar then
      hpBarData.stackHpBar:SetShow(false)
      hpBarData.stackHpBarBackColor:SetShow(false)
      hpBarData.hpBack:SetShow(false)
      hpBarData.hpPointer:SetShow(false)
      if true == _ContentsGroup_StackHpBaranimation and nil ~= hpBarData.gage_Count then
        hpBarData.gage_Count:SetShow(false)
      end
    end
  end
  _characterHpBarContainer = {}
  return isShow
end
local CharacterNameTag_SetRuler = function(maxHp, targetPanel, actorKeyRaw)
end
local function settingHpBar(actorKeyRaw, targetPanel, actorProxyWrapper, isSubPlayer)
  local actorProxy = actorProxyWrapper:get()
  if nil == actorProxy then
    return
  end
  if true == actorProxy:isSelfPlayer() and true == isPlayMusic then
    return
  end
  if false == (actorProxy:isInstallationActor() or actorProxy:isMonster() or actorProxy:isSelfPlayer() or actorProxy:isPlayer() or actorProxy:isNpc() or actorProxy:isHouseHold() or actorProxy:isVehicle() or actorProxy:isInstanceObject() or actorProxy:isReplayActor()) then
    return
  end
  local isVisibleHpBarForNpc = false
  local charWrapper = actorProxyWrapper:getCharacterStaticStatusWrapper()
  if nil ~= charWrapper and true == charWrapper:isAttrSet(__eIsVisibleHpBarForNpc) then
    isVisibleHpBarForNpc = true
  end
  local isColorBlindMode = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eColorBlindMode)
  local hpBack, hpLater, hpMain, hpName
  local progressGroup = UI.getChildControl(targetPanel, "Static_Progress_Group")
  if nil == progressGroup then
    return
  end
  local nameTagGroup = UI.getChildControl(targetPanel, "Static_NameTag_Group")
  if nil == nameTagGroup then
    return
  end
  local instanceMapKey = ToClient_GetCurrentInstanceFieldMapKey()
  if actorProxy:isKingOrLordTent() then
    hpBack = UI.getChildControl(progressGroup, "KingOrLordTentProgressBack")
    hpLater = UI.getChildControl(progressGroup, "KingOrLordTentProgress2_HpLater")
    hpMain = UI.getChildControl(progressGroup, "KingOrLordTentHPGageProgress")
  elseif actorProxy:isLargeHpBarCharacter() or true == isVisibleHpBarForNpc then
    hpBack = UI.getChildControl(progressGroup, "KingOrLordTentProgressBack")
    hpLater = UI.getChildControl(progressGroup, "KingOrLordTentProgress2_HpLater")
    hpMain = UI.getChildControl(progressGroup, "KingOrLordTentHPGageProgress")
  else
    hpBack = UI.getChildControl(progressGroup, "ProgressBack")
    hpLater = UI.getChildControl(progressGroup, "Progress2_HpLater")
    hpMain = UI.getChildControl(progressGroup, "CharacterHPGageProgress")
  end
  local characterStaticStatus = actorProxy:getCharacterSimplyStaticStatus()
  if nil == hpBack or nil == hpLater or nil == hpMain or nil == characterStaticStatus then
    return
  end
  if characterStaticStatus._isHiddenHp and not actorProxy:isInstallationActor() then
    hpBack:SetShow(false)
    hpLater:SetShow(false)
    hpMain:SetShow(false)
    return
  end
  if actorProxy:isInstallationActor() then
    local installationActorWrapper = getInstallationActor(actorKeyRaw)
    hpBack:SetShow(false)
    hpLater:SetShow(false)
    hpMain:SetShow(false)
    if Panel_Housing:IsShow() then
      return
    end
    local installationType = installationActorWrapper:getStaticStatusWrapper():getObjectStaticStatus():getInstallationType()
    if false == isShowInstallationEnduranceType(installationType) then
      return
    end
    if toInt64(0, 0) ~= installationActorWrapper:getOwnerHouseholdNo_s64() then
      if installationActorWrapper:isHavestInstallation() then
        local prevRate = hpMain:GetProgressRate()
        local rate = installationActorWrapper:getHarvestTotalGrowRate()
        if rate > 1 then
          rate = 1
        elseif rate < 0 then
          rate = 0
        end
        rate = rate * 100
        local progressingInfo = installationActorWrapper:get():getInstallationProgressingInfo()
        local isWarning = false
        if nil ~= progressingInfo then
          isWarning = progressingInfo:getNeedLop() or progressingInfo:getNeedPestControl()
        end
        hpMain:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/default_gauges.dds")
        local x1, y1, x2, y2
        if isWarning then
          x1, y1, x2, y2 = setTextureUV_Func(hpMain, 206, 112, 255, 115)
        else
          x1, y1, x2, y2 = setTextureUV_Func(hpMain, 206, 96, 255, 99)
        end
        hpMain:getBaseTexture():setUV(x1, y1, x2, y2)
        hpMain:setRenderTexture(hpMain:getBaseTexture())
        hpMain:SetProgressRate(rate)
        hpLater:SetProgressRate(rate)
        hpMain:SetCurrentProgressRate(rate)
        hpLater:SetCurrentProgressRate(rate)
        hpBack:SetShow(true)
        hpLater:SetShow(true)
        hpMain:SetShow(true)
      else
        local curEndurance = installationActorWrapper:getEndurance()
        local maxEndurance = installationActorWrapper:getMaxEndurance()
        local prevRate = hpMain:GetProgressRate()
        local rate = curEndurance / maxEndurance * 100
        if prevRate > rate then
          hpMain:SetVertexAniRun("Ani_Color_Damage_0", true)
          hpLater:SetVertexAniRun("Ani_Color_Damage_White", true)
        elseif prevRate < rate then
          hpMain:ResetVertexAni(true)
          hpLater:ResetVertexAni(true)
          hpMain:SetAlpha(1)
          hpLater:SetAlpha(1)
        end
        hpMain:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/default_gauges.dds")
        if rate < 5 then
          x1, y1, x2, y2 = setTextureUV_Func(hpMain, 206, 112, 255, 115)
        else
          x1, y1, x2, y2 = setTextureUV_Func(hpMain, 206, 96, 255, 99)
        end
        hpMain:SetProgressRate(rate)
        hpLater:SetProgressRate(rate)
        if true == housing_isInstallMode() then
          local hpName = UI.getChildControl(nameTagGroup, "CharacterName")
          hpName:SetText(actorProxy:getStaticStatusName() .. " (" .. tostring(curEndurance) .. "/" .. tostring(maxEndurance) .. ")")
          local isHideDurability = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eHideHousingDurability)
          hpBack:SetShow(not isHideDurability)
          hpLater:SetShow(not isHideDurability)
          hpMain:SetShow(not isHideDurability)
          if installationType == CppEnums.InstallationType.eType_Alchemy or installationType == CppEnums.InstallationType.eType_Cooking then
            hpName:SetShow(not isHideDurability)
          end
        elseif true == furnitureCheck then
          local hpName = UI.getChildControl(nameTagGroup, "CharacterName")
          hpName:SetText(actorProxy:getStaticStatusName() .. " (" .. tostring(curEndurance) .. "/" .. tostring(maxEndurance) .. ")")
          local isHideDurability = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eHideHousingDurability)
          local interactionActor = interaction_getInteractable()
          local isShowDurability = false
          if false == isHideDurability and nil ~= interactionActor and interactionActor:getActorKey() == actorKeyRaw then
            isShowDurability = true
          end
          hpBack:SetShow(isShowDurability)
          hpLater:SetShow(isShowDurability)
          hpMain:SetShow(isShowDurability)
          if installationType == CppEnums.InstallationType.eType_Alchemy or installationType == CppEnums.InstallationType.eType_Cooking then
            hpName:SetShow(not isHideDurability)
          end
        else
          hpBack:SetShow(false)
          hpLater:SetShow(false)
          hpMain:SetShow(false)
        end
      end
    end
  elseif actorProxy:isLargeHpBarCharacter() then
    local prevRate = hpMain:GetProgressRate()
    local hpRate = actorProxy:getHp() * 100 / actorProxy:getMaxHp()
    if hpLater:GetCurrentProgressRate() < hpMain:GetCurrentProgressRate() then
      hpLater:SetCurrentProgressRate(hpMain:GetCurrentProgressRate())
      hpMain:SetCurrentProgressRate(hpMain:GetCurrentProgressRate())
    end
    if prevRate > hpRate then
      hpMain:SetVertexAniRun("Ani_Color_Damage_0", true)
      hpLater:SetVertexAniRun("Ani_Color_Damage_White", true)
    elseif prevRate < hpRate then
      hpMain:ResetVertexAni(true)
      hpLater:ResetVertexAni(true)
      hpMain:SetAlpha(1)
      hpLater:SetAlpha(1)
    end
    hpMain:SetProgressRate(hpRate)
    hpLater:SetProgressRate(hpRate)
    hpBack:SetShow(true)
    hpLater:SetShow(true)
    hpMain:SetShow(true)
  elseif actorProxy:isMonster() then
    local prevRate = hpMain:GetProgressRate()
    local hpRate = actorProxy:getHp() * 100 / actorProxy:getMaxHp()
    local characterActorProxyWrapper = getCharacterActor(actorKeyRaw)
    hpBack:SetShow(true)
    hpLater:SetShow(true)
    hpMain:SetShow(true)
    if checkActiveCondition(characterActorProxyWrapper:getCharacterKey()) == true then
      hpMain:SetProgressRate(hpRate)
      hpLater:SetProgressRate(hpRate)
      if prevRate > hpRate then
        hpMain:SetVertexAniRun("Ani_Color_Damage_0", true)
        hpLater:SetVertexAniRun("Ani_Color_Damage_White", true)
      elseif prevRate < hpRate then
        if hpLater:GetCurrentProgressRate() < hpMain:GetCurrentProgressRate() then
          hpLater:SetCurrentProgressRate(hpMain:GetCurrentProgressRate())
        end
        hpMain:ResetVertexAni(true)
        hpLater:ResetVertexAni(true)
        hpMain:SetAlpha(1)
        hpLater:SetAlpha(1)
      end
      hpMain:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/default_gauges.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(hpMain, 206, 96, 255, 99)
      hpMain:getBaseTexture():setUV(x1, y1, x2, y2)
      hpMain:setRenderTexture(hpMain:getBaseTexture())
    else
      local x1, y1, x2, y2
      hpMain:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/default_gauges.dds")
      if hpRate > 75 then
        x1, y1, x2, y2 = setTextureUV_Func(hpMain, 206, 96, 255, 99)
      elseif hpRate > 50 then
        x1, y1, x2, y2 = setTextureUV_Func(hpMain, 206, 100, 255, 103)
      elseif hpRate > 25 then
        x1, y1, x2, y2 = setTextureUV_Func(hpMain, 206, 104, 255, 107)
      elseif hpRate > 10 then
        x1, y1, x2, y2 = setTextureUV_Func(hpMain, 206, 108, 255, 111)
      elseif hpRate > 5 then
        x1, y1, x2, y2 = setTextureUV_Func(hpMain, 206, 112, 255, 115)
      else
        x1, y1, x2, y2 = setTextureUV_Func(hpMain, 206, 112, 255, 115)
      end
      hpMain:getBaseTexture():setUV(x1, y1, x2, y2)
      hpMain:setRenderTexture(hpMain:getBaseTexture())
      hpMain:SetProgressRate(100)
      hpLater:SetProgressRate(100)
      hpMain:SetCurrentProgressRate(100)
      hpLater:SetCurrentProgressRate(100)
    end
  elseif (actorProxy:isSelfPlayer() == true or actorProxy:isReplayActor() == true) and (isSubPlayer == nil or isSubPlayer == false) then
    local hpAlert = UI.getChildControl(nameTagGroup, "Static_nameTagGaugeAlert")
    local usePotion = UI.getChildControl(progressGroup, "StaticText_UsePotion")
    local isSolare = ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare)
    if nil == _defaultUsePotionPosY then
      _defaultUsePotionPosY = usePotion:GetPosY()
    end
    hpBack:SetShow(true)
    hpLater:SetShow(true)
    hpMain:SetShow(true)
    local x1, y1, x2, y2
    if 0 < RequestParty_getPartyMemberCount() or true == isSolare then
      hpMain:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Default/Default_Gauges.dds")
      x1, y1, x2, y2 = setTextureUV_Func(hpMain, 1, 63, 233, 69)
    elseif 0 == isColorBlindMode then
      hpMain:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Default/Default_Gauges.dds")
      x1, y1, x2, y2 = setTextureUV_Func(hpMain, 206, 96, 255, 99)
    elseif 1 == isColorBlindMode then
      hpMain:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/Default_Gauges_01.dds")
      x1, y1, x2, y2 = setTextureUV_Func(hpMain, 1, 247, 255, 250)
    elseif 2 == isColorBlindMode then
      hpMain:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/Default_Gauges_01.dds")
      x1, y1, x2, y2 = setTextureUV_Func(hpMain, 1, 247, 255, 250)
    end
    hpMain:getBaseTexture():setUV(x1, y1, x2, y2)
    local injuryHpBar = UI.getChildControl(progressGroup, "CharacterInjuryHPGageProgress")
    local injuryHp = math.floor(actorProxy:getInjuryHp())
    if injuryHp > 0 then
      if false == injuryHpBar:GetShow() then
        injuryHpBar:SetShow(true)
      end
    else
      injuryHpBar:SetShow(false)
    end
    if true == _ContentsGroup_InjuryPercent then
      local maxHp = math.floor(actorProxy:getMaxHp())
      injuryHpBar:SetProgressRate(injuryHp / maxHp * 100)
    end
    local selfPlayerLevel = getSelfPlayer():get():getLevel()
    local prevRate = hpMain:GetProgressRate()
    local hpRate = actorProxy:getHp() * 100 / actorProxy:getMaxHp()
    if prevRate > hpRate then
      hpMain:SetVertexAniRun("Ani_Color_Damage_0", true)
      hpLater:SetVertexAniRun("Ani_Color_Damage_White", true)
    elseif prevRate < hpRate then
      hpMain:ResetVertexAni(true)
      hpLater:ResetVertexAni(true)
      hpMain:SetAlpha(1)
      hpLater:SetAlpha(1)
    end
    hpMain:SetProgressRate(hpRate)
    hpLater:SetProgressRate(hpRate)
    hpAlert:ResetVertexAni(true)
    local nameTag = UI.getChildControl(nameTagGroup, "CharacterName")
    local titleTag = UI.getChildControl(nameTagGroup, "CharacterTitle")
    local x1, y1, x2, y2
    if actorProxy:isReplayActor() then
      local guildName = UI.getChildControl(nameTagGroup, "CharacterGuild")
      local guildMark = UI.getChildControl(nameTagGroup, "Static_GuildMark")
      local guildBack = UI.getChildControl(nameTagGroup, "Static_GuildBackGround")
      local aliasInfo = UI.getChildControl(nameTagGroup, "CharacterAlias")
      aliasInfo:SetShow(false)
      if ToClient_IsArshaReplay() == true or ToClient_IsInstanceContentsReplay() == true or ToClient_IsMirrorFieldContentsReplay() == true then
        local playerActorProxyWrapper = getPlayerActor(actorProxy:getActorKeyRaw())
        local characterActorProxyWrapper = getCharacterActor(actorProxy:getActorKeyRaw())
        local characterActorProxy = characterActorProxyWrapper:get()
        local hasGuild = characterActorProxy:isGuildMember()
        local isSolareReplayActor = ToClient_IsSolareReplayActor(playerActorProxyWrapper:getUserNo())
        if 0 == hpRate then
          hpMain:SetShow(false)
          nameTag:SetShow(false)
          hpBack:SetShow(false)
          hpLater:SetShow(false)
          titleTag:SetShow(false)
          guildName:SetShow(false)
          guildMark:SetShow(false)
          guildBack:SetShow(false)
        elseif ToClient_CheckInstanceContentsReplayServiceType() == false and isSolareReplayActor == true then
          hpMain:SetShow(true)
          nameTag:SetShow(true)
          hpBack:SetShow(true)
          hpLater:SetShow(true)
          titleTag:SetShow(true)
          guildName:SetShow(false)
          guildMark:SetShow(false)
          guildBack:SetShow(false)
        else
          hpMain:SetShow(true)
          nameTag:SetShow(true)
          hpBack:SetShow(true)
          hpLater:SetShow(true)
          titleTag:SetShow(true)
          guildName:SetShow(hasGuild)
          guildMark:SetShow(hasGuild)
          guildBack:SetShow(hasGuild)
        end
        nameTag:SetShow(false)
        titleTag:SetPosY(replayTitlePosY)
        guildName:SetPosY(replayGuilNamePosY)
        hpMain:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/default_gauges.dds")
        if nil ~= PaGlobalFunc_Arsha_Party_All_Get_Hp_Color_Index then
          local hpIndex = 0
          if ToClient_IsArshaReplay() == true then
            hpIndex = Int64toInt32(playerActorProxyWrapper:getTeamNo_s64())
            if 0 == hpIndex or hpIndex > 5 then
              hpIndex = 5
            end
          elseif ToClient_IsInstanceContentsReplay() == true then
            if isSolareReplayActor == true then
              local teamNo = ToClient_GetSolareReplayActorTeamNoByUserNo(playerActorProxyWrapper:getUserNo())
              if teamNo == __eSolareTeamNo_Red then
                hpIndex = 6
              elseif teamNo == __eSolareTeamNo_Blue then
                hpIndex = 7
              else
                hpIndex = 5
              end
            else
              hpIndex = 5
            end
          else
            local guildNoForColor = 0
            if true == playerActorProxyWrapper:isGuildAllianceMember() then
              guildNoForColor = playerActorProxyWrapper:getGuildAllianceNo_s64()
            else
              guildNoForColor = playerActorProxyWrapper:getGuildNo_s64()
            end
            hpIndex = PaGlobalFunc_Arsha_Party_All_Get_Hp_Color_Index(Int64toInt32(guildNoForColor))
          end
          nameTag:useGlowFont(false)
          titleTag:useGlowFont(false)
          guildName:useGlowFont(false)
          if 1 == hpIndex then
            nameTag:SetFontColor(UI_color.C_FFB82929)
            nameTag:useGlowFont(true, "BaseFont_10_Glow", UI_color.C_FFB82929)
            titleTag:SetFontColor(UI_color.C_FFB82929)
            titleTag:useGlowFont(true, "BaseFont_10_Glow", UI_color.C_FFB82929)
            guildName:SetFontColor(UI_color.C_FFB82929)
            guildName:useGlowFont(true, "BaseFont_10_Glow", UI_color.C_FFB82929)
            x1, y1, x2, y2 = setTextureUV_Func(hpMain, 206, 112, 255, 115)
          elseif 2 == hpIndex then
            nameTag:SetFontColor(UI_color.C_FF2F77AB)
            nameTag:useGlowFont(true, "BaseFont_10_Glow", UI_color.C_FF2F77AB)
            titleTag:SetFontColor(UI_color.C_FF2F77AB)
            titleTag:useGlowFont(true, "BaseFont_10_Glow", UI_color.C_FF2F77AB)
            guildName:SetFontColor(UI_color.C_FF2F77AB)
            guildName:useGlowFont(true, "BaseFont_10_Glow", UI_color.C_FF2F77AB)
            x1, y1, x2, y2 = setTextureUV_Func(hpMain, 1, 63, 233, 69)
          elseif 3 == hpIndex then
            nameTag:SetFontColor(UI_color.C_FF39A07D)
            nameTag:useGlowFont(true, "BaseFont_10_Glow", UI_color.C_FF39A07D)
            titleTag:SetFontColor(UI_color.C_FF39A07D)
            titleTag:useGlowFont(true, "BaseFont_10_Glow", UI_color.C_FF39A07D)
            guildName:SetFontColor(UI_color.C_FF39A07D)
            guildName:useGlowFont(true, "BaseFont_10_Glow", UI_color.C_FF39A07D)
            x1, y1, x2, y2 = setTextureUV_Func(hpMain, 2, 71, 232, 76)
          elseif 4 == hpIndex then
            nameTag:SetFontColor(UI_color.C_FFD4AF4B)
            nameTag:useGlowFont(true, "BaseFont_10_Glow", UI_color.C_FFD4AF4B)
            titleTag:SetFontColor(UI_color.C_FFD4AF4B)
            titleTag:useGlowFont(true, "BaseFont_10_Glow", UI_color.C_FFD4AF4B)
            guildName:SetFontColor(UI_color.C_FFD4AF4B)
            guildName:useGlowFont(true, "BaseFont_10_Glow", UI_color.C_FFD4AF4B)
            x1, y1, x2, y2 = setTextureUV_Func(hpMain, 206, 96, 255, 99)
          elseif 5 == hpIndex then
            x1, y1, x2, y2 = setTextureUV_Func(hpMain, 2, 250, 232, 255)
          elseif hpIndex == 6 then
            nameTag:SetFontColor(UI_color.C_FFB82929)
            nameTag:useGlowFont(true, "BaseFont_10_Glow", UI_color.C_FFB82929)
            titleTag:SetFontColor(UI_color.C_FFB82929)
            titleTag:useGlowFont(true, "BaseFont_10_Glow", UI_color.C_FFB82929)
            guildName:SetFontColor(UI_color.C_FFB82929)
            guildName:useGlowFont(true, "BaseFont_10_Glow", UI_color.C_FFB82929)
            x1, y1, x2, y2 = setTextureUV_Func(hpMain, 206, 112, 255, 115)
          elseif hpIndex == 7 then
            nameTag:SetFontColor(UI_color.C_FF2F77AB)
            nameTag:useGlowFont(true, "BaseFont_10_Glow", UI_color.C_FF2F77AB)
            titleTag:SetFontColor(UI_color.C_FF2F77AB)
            titleTag:useGlowFont(true, "BaseFont_10_Glow", UI_color.C_FF2F77AB)
            guildName:SetFontColor(UI_color.C_FF2F77AB)
            guildName:useGlowFont(true, "BaseFont_10_Glow", UI_color.C_FF2F77AB)
            x1, y1, x2, y2 = setTextureUV_Func(hpMain, 1, 63, 233, 69)
          end
          if nil ~= hpMain:getBaseTexture() then
            hpMain:getBaseTexture():setUV(x1, y1, x2, y2)
          end
        else
          nameTag:SetFontColor(UI_color.C_FF2F77AB)
          x1, y1, x2, y2 = setTextureUV_Func(hpMain, 1, 63, 233, 69)
        end
        usePotion:SetShow(false)
        hpMain:ResetVertexAni(true)
        hpMain:SetAlpha(1)
        hpAlert:SetShow(false)
      else
        nameTag:SetFontColor(UI_color.C_FFEDEDEE)
        nameTag:useGlowFont(false)
        titleTag:SetFontColor(UI_color.C_FFEDEDEE)
        titleTag:useGlowFont(false)
        hpMain:SetShow(false)
        hpBack:SetShow(false)
        hpLater:SetShow(false)
        hpAlert:SetShow(false)
      end
    elseif hpRate > 40 then
      if 0 == isColorBlindMode then
        hpMain:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/default_gauges.dds")
        x1, y1, x2, y2 = setTextureUV_Func(hpMain, 206, 112, 255, 115)
      elseif 1 == isColorBlindMode then
        hpMain:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/Default_Gauges_01.dds")
        x1, y1, x2, y2 = setTextureUV_Func(hpMain, 1, 247, 255, 250)
      elseif 2 == isColorBlindMode then
        hpMain:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/Default_Gauges_01.dds")
        x1, y1, x2, y2 = setTextureUV_Func(hpMain, 1, 247, 255, 250)
      end
      hpMain:getBaseTexture():setUV(x1, y1, x2, y2)
      usePotion:SetShow(false)
      hpMain:ResetVertexAni(true)
      hpMain:SetAlpha(1)
      hpAlert:SetShow(false)
    elseif hpRate >= 40 then
      if 0 == isColorBlindMode then
        hpMain:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/default_gauges.dds")
        x1, y1, x2, y2 = setTextureUV_Func(hpMain, 206, 112, 255, 115)
      elseif 1 == isColorBlindMode then
        hpMain:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/Default_Gauges_01.dds")
        x1, y1, x2, y2 = setTextureUV_Func(hpMain, 1, 247, 255, 250)
      elseif 2 == isColorBlindMode then
        hpMain:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/Default_Gauges_01.dds")
        x1, y1, x2, y2 = setTextureUV_Func(hpMain, 1, 247, 255, 250)
      end
      hpMain:getBaseTexture():setUV(x1, y1, x2, y2)
      if selfPlayerLevel <= 30 then
        usePotion:SetShow(true)
      end
      hpMain:ResetVertexAni(true)
      hpMain:SetAlpha(1)
      hpAlert:SetShow(false)
    elseif hpRate >= 20 then
      if 0 == isColorBlindMode then
        hpMain:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/default_gauges.dds")
        x1, y1, x2, y2 = setTextureUV_Func(hpMain, 206, 112, 255, 115)
      elseif 1 == isColorBlindMode then
        hpMain:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/Default_Gauges_01.dds")
        x1, y1, x2, y2 = setTextureUV_Func(hpMain, 1, 247, 255, 250)
      elseif 2 == isColorBlindMode then
        hpMain:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/Default_Gauges_01.dds")
        x1, y1, x2, y2 = setTextureUV_Func(hpMain, 1, 247, 255, 250)
      end
      hpMain:getBaseTexture():setUV(x1, y1, x2, y2)
      if selfPlayerLevel <= 30 then
        usePotion:SetShow(true)
      end
      hpMain:SetVertexAniRun("Ani_Color_Damage_40", true)
      hpAlert:SetShow(true)
      hpAlert:SetVertexAniRun("Ani_Color_nameTagAlertGauge0", true)
    else
      if 0 == isColorBlindMode then
        hpMain:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/default_gauges.dds")
        x1, y1, x2, y2 = setTextureUV_Func(hpMain, 206, 112, 255, 115)
      elseif 1 == isColorBlindMode then
        hpMain:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/Default_Gauges_01.dds")
        x1, y1, x2, y2 = setTextureUV_Func(hpMain, 1, 247, 255, 250)
      elseif 2 == isColorBlindMode then
        hpMain:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/Default_Gauges_01.dds")
        x1, y1, x2, y2 = setTextureUV_Func(hpMain, 1, 247, 255, 250)
      end
      hpMain:getBaseTexture():setUV(x1, y1, x2, y2)
      if selfPlayerLevel <= 30 then
        usePotion:SetShow(true)
      end
      hpMain:SetVertexAniRun("Ani_Color_Damage_20", true)
      hpAlert:SetShow(true)
      hpAlert:SetVertexAniRun("Ani_Color_nameTagAlertGauge1", true)
    end
    if __eClassType_ShyWaman == getSelfPlayer():getClassType() then
      usePotion:SetPosY(_defaultUsePotionPosY - 50)
    end
    hpMain:setRenderTexture(hpMain:getBaseTexture())
  elseif actorProxy:isPlayer() then
    if false == _ContentsGroup_StackingHpBar then
      local prevRate = hpMain:GetProgressRate()
      local isParty = Requestparty_isPartyPlayer(actorKeyRaw)
      local playerActorProxyWrapper = getPlayerActor(actorKeyRaw)
      local isArenaAreaOrZone = playerActorProxyWrapper:get():isArenaAreaRegion() or playerActorProxyWrapper:get():isArenaZoneRegion() or playerActorProxyWrapper:get():isCompetitionDefined() or true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare)
      local isSameRoseWarTeam = actorProxy:isParticipateInRoseWar() == true and getSelfPlayer():getRoseWarTeamNo() == actorProxyWrapper:getRoseWarTeamNo()
      local isInInstanceFieldEdania = ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Edania) == true
      local hpRate = actorProxy:getHp() * 100 / actorProxy:getMaxHp()
      if prevRate > hpRate then
        hpMain:SetVertexAniRun("Ani_Color_Damage_0", true)
        hpLater:SetVertexAniRun("Ani_Color_Damage_White", true)
      elseif prevRate < hpRate then
        hpMain:ResetVertexAni(true)
        hpLater:ResetVertexAni(true)
        hpMain:SetAlpha(1)
        hpLater:SetAlpha(1)
      end
      hpMain:SetProgressRate(hpRate)
      hpLater:SetProgressRate(hpRate)
      local isShow = false == actorProxy:isHideTimeOver(hideTimeType.overHeadUI) or isParty or isArenaAreaOrZone or isSameRoseWarTeam == true or isInInstanceFieldEdania == true
      hpMain:SetShow(true)
      hpBack:SetShow(isShow)
      hpLater:SetShow(isShow)
      hpMain:SetShow(isShow)
      local x1, y1, x2, y2
      if isParty == true and (isSubPlayer == nil or isSubPlayer == false or isSameRoseWarTeam == true) then
        hpMain:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/default_gauges.dds")
        x1, y1, x2, y2 = setTextureUV_Func(hpMain, 1, 63, 233, 69)
      else
        if 0 == isColorBlindMode then
          hpMain:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/default_gauges.dds")
          x1, y1, x2, y2 = setTextureUV_Func(hpMain, 206, 112, 255, 115)
        elseif 1 == isColorBlindMode then
          hpMain:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/Default_Gauges_01.dds")
          x1, y1, x2, y2 = setTextureUV_Func(hpMain, 1, 247, 255, 250)
        elseif 2 == isColorBlindMode then
          hpMain:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/Default_Gauges_01.dds")
          x1, y1, x2, y2 = setTextureUV_Func(hpMain, 1, 247, 255, 250)
        end
        hpMain:getBaseTexture():setUV(x1, y1, x2, y2)
      end
      hpMain:getBaseTexture():setUV(x1, y1, x2, y2)
      hpMain:setRenderTexture(hpMain:getBaseTexture())
      CharacterNameTag_SetRuler(actorProxy:getMaxHp(), targetPanel, actorKeyRaw)
    else
      local isParty = Requestparty_isPartyPlayer(actorKeyRaw)
      local playerActorProxyWrapper = getPlayerActor(actorKeyRaw)
      local isArenaAreaOrZone = playerActorProxyWrapper:get():isArenaAreaRegion() or playerActorProxyWrapper:get():isArenaZoneRegion() or playerActorProxyWrapper:get():isCompetitionDefined()
      local isSolare = true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare)
      local isShow = false == actorProxy:isHideTimeOver(hideTimeType.overHeadUI) or isParty == true or isArenaAreaOrZone == true or isSolare == true or actorProxy:isParticipateInRoseWar() == true or ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Edania) == true
      local hpPointer = UI.getChildControl(progressGroup, "StaticText_HP")
      local hpRate = actorProxy:getHp() * 100 / actorProxy:getMaxHp()
      local solareMyTeamNo = ToClient_GetSolareMyTeamType()
      local solarePlayerTeamNo = playerActorProxyWrapper:getInstanceTeamNo()
      local isSameRoseWarTeam = actorProxy:isParticipateInRoseWar() == true and getSelfPlayer():getRoseWarTeamNo() == actorProxyWrapper:getRoseWarTeamNo()
      if GameOption_GetShowStackHp ~= nil and GameOption_GetShowStackHp() == true and true == _ContentsGroup_StackingHpBar then
        hpBack = UI.getChildControl(progressGroup, "ProgressBack")
        hpMain = UI.getChildControl(progressGroup, "Progress2_StackHpBackColor")
        hpLater = UI.getChildControl(progressGroup, "CharacterHPGageProgress")
        local gage_Count = UI.getChildControl(progressGroup, "CharacterHPGage_Counting")
        hpBack:SetShow(isShow)
        hpLater:SetShow(isShow)
        hpMain:SetShow(isShow)
        hpPointer:SetShow(isShow)
        gage_Count:SetShow(isShow)
        local pointerHalfSize = hpPointer:GetSizeX() * 0.5
        hpPointer:SetPosX(hpBack:GetPosX() + 0.01 * hpRate * hpBack:GetSizeX() - pointerHalfSize)
        if true == isShow then
          CharacterNameTag_SetHpBarContainer(actorKeyRaw, actorProxy, targetPanel)
          targetPanel:RegisterUpdateFunc("PaGlobal_WaitUntilHpBarChange_UpdateFunc")
        else
          CharacterNameTag_FreeHpBarContainer(actorKeyRaw)
        end
      else
        local isSelfSubPlayer = false
        if isSubPlayer ~= nil and isSubPlayer == true and actorProxy:isSelfPlayer() == true then
          isSelfSubPlayer = true
        end
        local prevRate = hpMain:GetProgressRate()
        hpBack:SetShow(isShow)
        hpLater:SetShow(isShow)
        hpMain:SetShow(isShow)
        hpPointer:SetShow(false)
        if (true == isParty or true == isSolare and solareMyTeamNo == solarePlayerTeamNo or isSameRoseWarTeam == true) and isSelfSubPlayer == false then
          hpMain:SetColor(_normalHpBarColor.partyMemeberColor)
        elseif 0 == isColorBlindMode then
          hpMain:SetColor(_normalHpBarColor.defaultColor)
        elseif 1 == isColorBlindMode then
          hpMain:SetColor(_normalHpBarColor.blindMode_Red)
        elseif 2 == isColorBlindMode then
          hpMain:SetColor(_normalHpBarColor.blindMode_Blue)
        end
        hpMain:SetAniSpeed(0)
        hpMain:SetProgressRate(hpRate)
        if true == _ContentsGroup_StackingHpBar then
          local data = {}
          data.stackHpBar = hpMain
          data.stackHpBarBackColor = hpLater
          data.hpBack = hpBack
          data.hpPointer = hpPointer
          _characterHpBarContainer[actorKeyRaw] = data
        end
      end
    end
  elseif actorProxy:isNpc() then
    local isShow = false
    local isFusionCore = actorProxy:getCharacterSimplyStaticStatus():isFusionCore()
    if true == isFusionCore then
      local npcActorProxyWrapper = getNpcActor(actorKeyRaw)
      if npcActorProxyWrapper:getTeamNo_s64() == getSelfPlayer():getTeamNo_s64() then
        isShow = true
      end
    end
    if true == isVisibleHpBarForNpc then
      isShow = true
    end
    if true == isShow then
      local hpRate = actorProxy:getHp() * 100 / actorProxy:getMaxHp()
      local prevRate = hpMain:GetProgressRate()
      if hpRate < prevRate then
        hpMain:SetVertexAniRun("Ani_Color_Damage_0", true)
        hpLater:SetVertexAniRun("Ani_Color_Damage_White", true)
      elseif hpRate > prevRate then
        hpMain:ResetVertexAni(true)
        hpLater:ResetVertexAni(true)
        hpMain:SetAlpha(1)
        hpLater:SetAlpha(1)
      end
      hpMain:SetProgressRate(hpRate)
      hpLater:SetProgressRate(hpRate)
    end
    hpBack:SetShow(isShow)
    hpLater:SetShow(isShow)
    hpMain:SetShow(isShow)
  elseif actorProxy:isHouseHold() then
    houseHoldActorWrapper = getHouseHoldActor(actorKeyRaw)
    if nil == houseHoldActorWrapper then
      return
    end
    if false == (houseHoldActorWrapper:getStaticStatusWrapper():getObjectStaticStatus():isBarricade() or houseHoldActorWrapper:getStaticStatusWrapper():getObjectStaticStatus():isKingOrLordTent() or houseHoldActorWrapper:getStaticStatusWrapper():getObjectStaticStatus():isAdvancedBase()) then
      return
    end
    local prevRate = hpMain:GetProgressRate()
    local hpRate = actorProxy:getHp() * 100 / actorProxy:getMaxHp()
    if hpLater:GetCurrentProgressRate() < hpMain:GetCurrentProgressRate() then
      hpLater:SetCurrentProgressRate(hpMain:GetCurrentProgressRate())
      hpMain:SetCurrentProgressRate(hpMain:GetCurrentProgressRate())
    end
    if prevRate > hpRate then
      hpMain:SetVertexAniRun("Ani_Color_Damage_0", true)
      hpLater:SetVertexAniRun("Ani_Color_Damage_White", true)
    elseif prevRate < hpRate then
      hpMain:ResetVertexAni(true)
      hpLater:ResetVertexAni(true)
      hpMain:SetAlpha(1)
      hpLater:SetAlpha(1)
    end
    hpMain:SetProgressRate(hpRate)
    hpLater:SetProgressRate(hpRate)
    hpBack:SetShow(true)
    hpLater:SetShow(true)
    hpMain:SetShow(true)
  elseif actorProxy:isInstanceObject() then
    if actorProxyWrapper:getCharacterStaticStatusWrapper():getObjectStaticStatus():isBarricade() or actorProxyWrapper:getCharacterStaticStatusWrapper():getObjectStaticStatus():isHealingTower() or actorProxyWrapper:getCharacterStaticStatusWrapper():getObjectStaticStatus():isObservatory() or actorProxyWrapper:getCharacterStaticStatusWrapper():getObjectStaticStatus():isElephantBarn() or actorProxyWrapper:getCharacterStaticStatusWrapper():getObjectStaticStatus():isRepairingTower() or actorProxyWrapper:getCharacterStaticStatusWrapper():getObjectStaticStatus():isMineFactory() or actorProxyWrapper:getCharacterStaticStatusWrapper():getObjectStaticStatus():isBombFactory() or actorProxyWrapper:getCharacterStaticStatusWrapper():getObjectStaticStatus():isDistributor() or actorProxyWrapper:getCharacterStaticStatusWrapper():getObjectStaticStatus():isSiegeTower() or actorProxyWrapper:getCharacterStaticStatusWrapper():getObjectStaticStatus():isLargeSiegeTower() or actorProxyWrapper:getCharacterStaticStatusWrapper():getObjectStaticStatus():isDefenceTower() or actorProxyWrapper:getCharacterStaticStatusWrapper():getObjectStaticStatus():isSiegeTower() or actorProxyWrapper:getCharacterStaticStatusWrapper():getObjectStaticStatus():isLargeSiegeTower() or actorProxyWrapper:getCharacterStaticStatusWrapper():getObjectStaticStatus():isAdvancedBaseTower() or actorProxyWrapper:getCharacterStaticStatusWrapper():getObjectStaticStatus():isTankFactory() or actorProxyWrapper:getCharacterStaticStatusWrapper():getObjectStaticStatus():isSavageDefenceObject() or actorProxyWrapper:getCharacterStaticStatusWrapper():getObjectStaticStatus():isBallistaFactory() then
      local prevRate = hpMain:GetProgressRate()
      local hpRate = actorProxy:getHp() * 100 / actorProxy:getMaxHp()
      hpMain:SetProgressRate(hpRate)
      hpLater:SetProgressRate(hpRate)
      if prevRate > hpRate then
        hpMain:SetVertexAniRun("Ani_Color_Damage_0", true)
        hpLater:SetVertexAniRun("Ani_Color_Damage_White", true)
      elseif prevRate < hpRate then
        if hpLater:GetCurrentProgressRate() < hpMain:GetCurrentProgressRate() then
          hpLater:SetCurrentProgressRate(hpMain:GetCurrentProgressRate())
        end
        hpMain:ResetVertexAni(true)
        hpLater:ResetVertexAni(true)
        hpMain:SetAlpha(1)
        hpLater:SetAlpha(1)
      end
      hpBack:SetShow(true)
      hpLater:SetShow(true)
      hpMain:SetShow(true)
    elseif actorProxyWrapper:getCharacterStaticStatusWrapper():getObjectStaticStatus():isTrap() then
      hpBack:SetShow(false)
      hpLater:SetShow(false)
      hpMain:SetShow(false)
    end
  else
    if actorProxy:isVehicle() then
      local vehicleActorWrapper = getVehicleActorByProxy(actorProxy)
      if nil ~= vehicleActorWrapper and (CppEnums.VehicleType.Type_ThrowStone == vehicleActorWrapper:get():getVehicleType() or CppEnums.VehicleType.Type_ThrowFire == vehicleActorWrapper:get():getVehicleType() or CppEnums.VehicleType.Type_WoodenFence == vehicleActorWrapper:get():getVehicleType() or __eInstanceRedBattleField_PapuCrio == instanceMapKey) then
        local prevRate = hpMain:GetProgressRate()
        local hpRate = actorProxy:getHp() * 100 / actorProxy:getMaxHp()
        hpMain:SetProgressRate(hpRate)
        hpLater:SetProgressRate(hpRate)
        if prevRate > hpRate then
          hpMain:SetVertexAniRun("Ani_Color_Damage_0", true)
          hpLater:SetVertexAniRun("Ani_Color_Damage_White", true)
        elseif prevRate < hpRate then
          if hpLater:GetCurrentProgressRate() < hpMain:GetCurrentProgressRate() then
            hpLater:SetCurrentProgressRate(hpMain:GetCurrentProgressRate())
          end
          hpMain:ResetVertexAni(true)
          hpLater:ResetVertexAni(true)
          hpMain:SetAlpha(1)
          hpLater:SetAlpha(1)
        end
        hpBack:SetShow(true)
        hpLater:SetShow(true)
        hpMain:SetShow(true)
      else
        hpBack:SetShow(false)
        hpLater:SetShow(false)
        hpMain:SetShow(false)
      end
    else
    end
  end
end
local function CharacterNameTag_HpBarUpdateCheck()
  for _, hpBarData in pairs(_characterHpBarContainer) do
    if nil ~= hpBarData then
      if hpBarData.currentHpIdx ~= hpBarData.targetHpIdx then
        hpBarData.stackHpBar:SetAniSpeed(1 / (math.abs(hpBarData.currentHpIdx - hpBarData.targetHpIdx) + 1))
        if hpBarData.currentHpIdx < hpBarData.targetHpIdx then
          hpBarData.stackHpBar:SetProgressRate(100)
        elseif hpBarData.targetHpIdx < hpBarData.currentHpIdx then
          hpBarData.stackHpBar:SetProgressRate(0)
        end
      end
      if hpBarData.currentHpIdx == hpBarData.targetHpIdx then
        hpBarData.stackHpBar:SetProgressRate(hpBarData.currentHpRate)
      elseif 100 <= hpBarData.stackHpBar:GetCurrentProgressRate() then
        hpBarData.currentHpIdx = hpBarData.currentHpIdx + 1
        if hpBarData.currentHpIdx >= _maxHpBarColorCount * 2 then
          hpBarData.stackHpBarBackColor:SetColor(_stackHpBarColor[_maxHpBarColorCount - 1])
          hpBarData.stackHpBar:SetColor(_stackHpBarColor[_maxHpBarColorCount - 1])
        else
          local colorValue = hpBarData.currentHpIdx % _maxHpBarColorCount
          local backColorValue = colorValue - 1
          if hpBarData.currentHpIdx <= 0 then
            backColorValue = -1
          elseif backColorValue < 0 then
            backColorValue = _maxHpBarColorCount - 1
          end
          hpBarData.stackHpBarBackColor:SetColor(_stackHpBarColor[backColorValue])
          hpBarData.stackHpBar:SetColor(_stackHpBarColor[colorValue])
        end
        hpBarData.stackHpBar:SetProgressRate(0)
      elseif 0 >= hpBarData.stackHpBar:GetCurrentProgressRate() then
        hpBarData.currentHpIdx = hpBarData.currentHpIdx - 1
        hpBarData.stackHpBar:SetProgressRate(100)
        if hpBarData.currentHpIdx >= _maxHpBarColorCount * 2 then
          hpBarData.stackHpBarBackColor:SetColor(_stackHpBarColor[_maxHpBarColorCount - 1])
          hpBarData.stackHpBar:SetColor(_stackHpBarColor[_maxHpBarColorCount - 1])
        else
          local colorValue = hpBarData.currentHpIdx % _maxHpBarColorCount
          local backColorValue = colorValue - 1
          if hpBarData.currentHpIdx <= 0 then
            backColorValue = -1
          elseif backColorValue < 0 then
            backColorValue = _maxHpBarColorCount - 1
          end
          hpBarData.stackHpBarBackColor:SetColor(_stackHpBarColor[backColorValue])
          hpBarData.stackHpBar:SetColor(_stackHpBarColor[colorValue])
        end
      end
    end
  end
end
function PaGlobal_WaitUntilHpBarChange_UpdateFunc()
  if true == GameOption_GetShowStackHp() and true == _ContentsGroup_StackingHpBar then
    CharacterNameTag_HpBarUpdateCheck()
  end
end
local function settingMpBar(actorKeyRaw, targetPanel, actorProxyWrapper)
  if _ContentsGroup_NameTag_Optimization == true then
    return
  end
  local actorProxy = actorProxyWrapper:get()
  if nil == actorProxy then
    return
  end
  local progressGroup = UI.getChildControl(targetPanel, "Static_Progress_Group")
  if nil == progressGroup then
    return
  end
  local mpBack = UI.getChildControl(progressGroup, "ProgressBack_ManaResource")
  local mpMain = UI.getChildControl(progressGroup, "Character_ManaResource")
  if nil == mpBack or nil == mpMain then
    return
  end
  if actorProxy:isSelfPlayer() then
    local mpMainBarHead = UI.getChildControl(mpMain, "CharacterManaRes_Bar_Head")
    if nil == mpMainBarHead then
      return
    end
    mpMainBarHead:SetShow(false)
    if true == isPlayMusic then
      return
    end
    local playerWrapper = getSelfPlayer()
    local mp = playerWrapper:get():getMp()
    local maxMp = playerWrapper:get():getMaxMp()
    local mpRate = mp * 100 / maxMp
    mpMain:SetProgressRate(mpRate)
    mpMain:SetCurrentProgressRate(mpRate)
    local classType = playerWrapper:getClassType()
    local mpBarColor = CppEnums.MpBarColor.MP
    if NewClassData.newClass_CategoryType[classType]._mpType ~= nil then
      mpBarColor = NewClassData.newClass_CategoryType[classType]._mpType
    end
    local isColorBlindMode = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eColorBlindMode)
    if 0 ~= isColorBlindMode then
      mpMain:SetColor(Defines.Color.C_FFEE9900)
    else
      mpMain:SetColor(mpBarColor)
    end
    mpBack:SetShow(true)
    mpMain:SetShow(true)
  elseif actorProxy:isInstanceObject() then
    local instanceObject = actorProxyWrapper:getCharacterStaticStatusWrapper():getObjectStaticStatus()
    if instanceObject:isBarricade() or instanceObject:isHealingTower() or instanceObject:isObservatory() or instanceObject:isElephantBarn() or instanceObject:isRepairingTower() or instanceObject:isMineFactory() or instanceObject:isBombFactory() or instanceObject:isDistributor() or instanceObject:isSiegeTower() or instanceObject:isLargeSiegeTower() or instanceObject:isDefenceTower() or instanceObject:isAdvancedBaseTower() or instanceObject:isTankFactory() or instanceObject:isSavageDefenceObject() or instanceObject:isBallistaFactory() then
      local isShowMp = false
      if instanceObject:isElephantBarn() or instanceObject:isObservatory() or instanceObject:isSiegeTower() or instanceObject:isLargeSiegeTower() or instanceObject:isAdvancedBaseTower() or instanceObject:isTankFactory() or instanceObject:isBallistaFactory() then
        isShowMp = true
      else
        local instanceObjectActorWrapper = getInstanceObjectActor(actorKeyRaw)
        if nil ~= instanceObjectActorWrapper and instanceObjectActorWrapper:isActionType_BuildingStart() then
          isShowMp = true
        end
        if instanceObjectActorWrapper:isActionType_BuildingStart() then
          isShowMp = true
        end
      end
      if true == isShowMp then
        local mp = actorProxyWrapper:get():getMp()
        local maxMp = actorProxyWrapper:get():getMaxMp()
        local mpRate = mp * 100 / maxMp
        mpMain:SetProgressRate(mpRate)
        mpMain:SetCurrentProgressRate(mpRate)
        mpMain:SetColor(Defines.Color.C_FFA3EF00)
        mpBack:SetShow(true)
        mpMain:SetShow(true)
      else
        mpBack:SetShow(false)
        mpMain:SetShow(false)
      end
    else
      mpBack:SetShow(false)
      mpMain:SetShow(false)
    end
  elseif actorProxy:isVehicle() then
    if actorProxy:getCharacterSimplyStaticStatus():isSiegeBastille() or actorProxy:getCharacterSimplyStaticStatus():isSiegeFrameTower() or actorProxy:getCharacterSimplyStaticStatus():isWoodenFence() then
      local isShowMp = true
      local vehicleActorWrapper = getVehicleActorByProxy(actorProxy)
      if nil ~= vehicleActorWrapper then
        if vehicleActorWrapper:isActionType_BuildingStart() then
          isShowMp = true
        else
          isShowMp = false
        end
      end
      if true == isShowMp then
        local mp = getMpToActor(vehicleActorWrapper)
        local maxMp = getMaxMpToActor(vehicleActorWrapper)
        local mpRate = mp * 100 / maxMp
        mpMain:SetProgressRate(mpRate)
        mpMain:SetCurrentProgressRate(mpRate)
        mpMain:SetColor(Defines.Color.C_FFA3EF00)
        mpBack:SetShow(true)
        mpMain:SetShow(true)
      else
        mpBack:SetShow(false)
        mpMain:SetShow(false)
      end
    else
      mpBack:SetShow(false)
      mpMain:SetShow(false)
    end
  else
    mpBack:SetShow(false)
    mpMain:SetShow(false)
  end
end
local function settingLocalWarCombatPoint(actorKeyRaw, targetPanel, actorProxyWrapper)
  if _ContentsGroup_NameTag_Optimization == true then
    return
  end
  if nil == actorProxyWrapper then
    return
  end
  local actorProxy = actorProxyWrapper:get()
  if nil == actorProxy then
    return
  end
  if false == actorProxy:isPlayer() then
    return
  end
  local playerActorProxyWrapper = getPlayerActor(actorKeyRaw)
  if nil == playerActorProxyWrapper then
    return
  end
  local playerActorProxy = playerActorProxyWrapper:get()
  if nil == playerActorProxy then
    return
  end
  local nameTagGroup = UI.getChildControl(targetPanel, "Static_NameTag_Group")
  if nil == nameTagGroup then
    return
  end
  local txt_WarPoint = UI.getChildControl(nameTagGroup, "CharacterWarPoint")
  local instanceMapKey = ToClient_GetCurrentInstanceFieldMapKey()
  local isPapuCrio = __eInstanceRedBattleField_PapuCrio == instanceMapKey
  local lifeIcon = {
    [0] = UI.getChildControl(nameTagGroup, "Static_LifeRankIcon_0"),
    [1] = UI.getChildControl(nameTagGroup, "Static_LifeRankIcon_1"),
    [2] = UI.getChildControl(nameTagGroup, "Static_LifeRankIcon_2"),
    [3] = UI.getChildControl(nameTagGroup, "Static_LifeRankIcon_3"),
    [4] = UI.getChildControl(nameTagGroup, "Static_LifeRankIcon_4"),
    [5] = UI.getChildControl(nameTagGroup, "Static_LifeRankIcon_5"),
    [6] = UI.getChildControl(nameTagGroup, "Static_LifeRankIcon_6"),
    [7] = UI.getChildControl(nameTagGroup, "Static_LifeRankIcon_7"),
    [8] = UI.getChildControl(nameTagGroup, "Static_LifeRankIcon_8"),
    [9] = UI.getChildControl(nameTagGroup, "Static_LifeRankIcon_9"),
    [10] = UI.getChildControl(nameTagGroup, "Static_LifeRankIcon_10"),
    [11] = UI.getChildControl(nameTagGroup, "Static_LifeRankIcon_11"),
    [12] = UI.getChildControl(nameTagGroup, "Static_LifeRankIcon_12"),
    [13] = UI.getChildControl(nameTagGroup, "Static_LifeRankIcon_13")
  }
  if actorProxy:isParticipateInRoseWar() == true then
    txt_WarPoint:SetShow(false)
    return
  end
  if ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_GuildMatch) == true then
    txt_WarPoint:SetShow(false)
    return
  end
  local competitionTeamNo = playerActorProxyWrapper:getCompetitionTeamNo()
  local warCombatPoint = playerActorProxyWrapper:getRedBattleFieldCombatPoint()
  if warCombatPoint > 0 then
    local hasTitle = false
    if playerActorProxyWrapper:checkToTitleKey() and playerActorProxyWrapper:isParticipateInRoseWar() == false then
      if playerActorProxy:isHideCharacterName() and false == playerActorProxy:isFlashBanged() then
        hasTitle = false
      else
        hasTitle = true
      end
    else
      hasTitle = false
    end
    local hasGuild = playerActorProxy:isGuildMember() and (false == playerActorProxy:isHideGuildName() or playerActorProxy:isFlashBanged())
    local warPointPos = 0
    if true == hasTitle and true == hasGuild then
      warPointPos = 80
    elseif hasTitle ~= hasGuild then
      warPointPos = 60
    else
      warPointPos = 40
    end
    if isPapuCrio == true then
      warPointPos = 20
    end
    if true == actorProxy:isSelfPlayer() and true == PaGlobal_CharacterNameTag_All._isOffNameTagInBattleField and true == PaGlobal_CharacterNameTag_All._isInLocalWar then
      warPointPos = 5
    end
    local nameColor
    if warCombatPoint < 50 then
      nameColor = UI_color.C_FFA1A1A1
    elseif warCombatPoint < 100 then
      nameColor = UI_color.C_FFFFFFFF
    elseif warCombatPoint < 150 then
      nameColor = UI_color.C_FFFFE050
    elseif warCombatPoint < 200 then
      nameColor = UI_color.C_FF75FF50
    elseif warCombatPoint < 250 then
      nameColor = UI_color.C_FF00FFD8
    elseif warCombatPoint < 300 then
      nameColor = UI_color.C_FFFF00D8
    elseif warCombatPoint < 350 then
      nameColor = UI_color.C_FFFF7200
    else
      nameColor = UI_color.C_FFFF0000
    end
    local isOccupationMode = ToClient_IsOccupationModeInRedBattleField()
    local scaleBuffer = txt_WarPoint:GetScale()
    txt_WarPoint:SetScale(1, 1)
    txt_WarPoint:SetFontColor(nameColor)
    if true == isOccupationMode then
      txt_WarPoint:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LocalWarOccupationMode_KillCount", "killCount", warCombatPoint))
    else
      txt_WarPoint:SetText("+" .. warCombatPoint)
    end
    txt_WarPoint:SetShow(true)
    txt_WarPoint:SetSpanSize(txt_WarPoint:GetSpanSize().x, warPointPos)
    txt_WarPoint:SetScale(scaleBuffer.x, scaleBuffer.y)
    txt_WarPoint:ComputePos()
    for idx = 0, 13 do
      lifeIcon[idx]:SetShow(false)
    end
  elseif competitionTeamNo >= 0 then
    local hasTitle = false
    if playerActorProxyWrapper:checkToTitleKey() and playerActorProxyWrapper:isParticipateInRoseWar() == false then
      if playerActorProxy:isHideCharacterName() and false == playerActorProxy:isFlashBanged() then
        hasTitle = false
      else
        hasTitle = true
      end
    else
      hasTitle = false
    end
    local hasGuild = playerActorProxy:isGuildMember() and (false == playerActorProxy:isHideGuildName() or playerActorProxy:isFlashBanged())
    local warPointPos = 0
    if true == hasTitle and true == hasGuild then
      warPointPos = 80
    elseif hasTitle ~= hasGuild then
      warPointPos = 60
    else
      warPointPos = 40
    end
    if isPapuCrio == true then
      warPointPos = 20
    end
    if true == actorProxy:isSelfPlayer() and true == PaGlobal_CharacterNameTag_All._isOffNameTagInBattleField and true == PaGlobal_CharacterNameTag_All._isInLocalWar then
      warPointPos = 5
    end
    local nameColor = FGlobal_TeamColorList(competitionTeamNo - 1)
    local scaleBuffer = txt_WarPoint:GetScale()
    txt_WarPoint:SetScale(1, 1)
    txt_WarPoint:SetFontColor(nameColor)
    txt_WarPoint:SetShow(true)
    txt_WarPoint:SetSpanSize(txt_WarPoint:GetSpanSize().x, warPointPos)
    txt_WarPoint:SetScale(scaleBuffer.x, scaleBuffer.y)
    txt_WarPoint:ComputePos()
    txt_WarPoint:SetText("")
    local needOverHeadNameTag = 0 == ToClient_CompetitionMatchType() or 2 == ToClient_CompetitionMatchType()
    if true == needOverHeadNameTag and 0 ~= competitionTeamNo then
      local teamA_Info, teamB_Info
      if 0 == ToClient_CompetitionMatchType() then
        teamA_Info = ToClient_GetTeamListAt(0)
        teamB_Info = ToClient_GetTeamListAt(1)
      elseif 2 == ToClient_CompetitionMatchType() then
        teamA_Info = ToClient_GetArshaTeamInfo(1)
        teamB_Info = ToClient_GetArshaTeamInfo(2)
      end
      local teamA_Name = ""
      local teamB_Name = ""
      if nil ~= teamA_Info and nil ~= teamB_Info then
        teamA_Name = teamA_Info:getTeamName()
        teamB_Name = teamB_Info:getTeamName()
      end
      if "" ~= teamA_Name and "" ~= teamB_Name then
        if 1 == competitionTeamNo then
          txt_WarPoint:SetText("[ " .. teamA_Name .. " ]")
        elseif 2 == competitionTeamNo then
          txt_WarPoint:SetText("[ " .. teamB_Name .. " ]")
        end
      elseif 1 == competitionTeamNo then
        txt_WarPoint:SetText("[ " .. PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_TEAM_A") .. " ]")
      elseif 2 == competitionTeamNo then
        txt_WarPoint:SetText("[ " .. PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_TEAM_B") .. " ]")
      end
    elseif 1 == ToClient_CompetitionMatchType() and 0 ~= competitionTeamNo then
      local leaderInfo = ToClient_GetTeamLeaderInfo(competitionTeamNo)
      if nil ~= leaderInfo then
        txt_WarPoint:SetText("[ " .. leaderInfo:getCharacterName() .. " ]")
      end
    end
    for idx = 0, 13 do
      lifeIcon[idx]:SetShow(false)
    end
  else
    txt_WarPoint:SetText(0)
    txt_WarPoint:SetShow(false)
    local insertedArray = Array.new()
    settingLifeRankIcon(actorKeyRaw, targetPanel, actorProxyWrapper, insertedArray)
  end
end
function FGlobal_SettingMpBarTemp()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if nil == selfPlayer:get():getUIPanel() then
    return
  end
  settingMpBar(selfPlayer:get():getActorKeyRaw(), selfPlayer:get():getUIPanel(), selfPlayer)
end
local settingGuildMarkAndPreemptiveStrike = function(actorKeyRaw, targetPanel, actorProxyWrapper)
  if _ContentsGroup_NameTag_Optimization == true then
    return
  end
  if nil == targetPanel then
    return
  end
  if false == actorProxyWrapper:get():isPlayer() then
    return
  end
  if actorProxyWrapper:get():isPetProxy() or actorProxyWrapper:get():isHouseHold() then
    return
  end
  local nameTagGroup = UI.getChildControl(targetPanel, "Static_NameTag_Group")
  if nil == nameTagGroup then
    return
  end
  local preemptiveStrikeBeing = UI.getChildControl(nameTagGroup, "Static_PreemptiveStrikeBeing")
  local murdererMark = UI.getChildControl(nameTagGroup, "Static_MurdererMark")
  local guildBack = UI.getChildControl(nameTagGroup, "Static_GuildBackGround")
  local guildMark = UI.getChildControl(nameTagGroup, "Static_GuildMark")
  local guildMaster = UI.getChildControl(nameTagGroup, "Static_Icon_GuildMaster")
  local guildName = UI.getChildControl(nameTagGroup, "CharacterGuild")
  local nameTag = UI.getChildControl(nameTagGroup, "CharacterName")
  local title = UI.getChildControl(nameTagGroup, "CharacterTitle")
  local alias = UI.getChildControl(nameTagGroup, "CharacterAlias")
  if nil == guildName or nil == guildBack or nil == guildMark or nil == nameTag or nil == title or nil == preemptiveStrikeBeing or nil == murdererMark or nil == actorProxyWrapper or nil == alias then
    return
  end
  if actorProxyWrapper:isParticipateInRoseWar() == true then
    return
  end
  if _ContentsGroup_HardCoreChannel == true and ToClient_isHardCoreChannel() == true then
    return
  end
  if ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Edania) == true and ToClient_GetEdanaInstanceFieldMode() == __eEdaniaInstanceContentsMode_Challenger then
    preemptiveStrikeBeing:SetShow(false)
  end
  if ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_GuildMatch) == true then
    preemptiveStrikeBeing:SetShow(false)
  end
  local scaleBuffer = guildMark:GetScale()
  preemptiveStrikeBeing:SetScale(1, 1)
  murdererMark:SetScale(1, 1)
  guildMark:SetScale(1, 1)
  guildBack:SetScale(1, 1)
  guildMaster:SetScale(1, 1)
  guildName:SetScale(1, 1)
  nameTag:SetScale(1, 1)
  title:SetScale(1, 1)
  alias:SetScale(1, 1)
  local widthMax = guildName:GetTextSizeX()
  widthMax = math.max(widthMax, nameTag:GetTextSizeX())
  widthMax = math.max(widthMax, title:GetTextSizeX())
  if alias:GetShow() then
    widthMax = math.max(widthMax, alias:GetTextSizeX())
  end
  local sizeMax = math.max(guildMark:GetSizeX(), guildBack:GetSizeX())
  sizeMax = sizeMax * 0.5
  guildMark:SetSpanSize(-widthMax / 2 - sizeMax, guildMark:GetSpanSize().y)
  guildBack:SetSpanSize(-widthMax / 2 - sizeMax, guildBack:GetSpanSize().y)
  guildMaster:SetSpanSize(-widthMax / 2 - sizeMax, guildMaster:GetSpanSize().y)
  preemptiveStrikeBeing:SetSpanSize(widthMax / 2 + preemptiveStrikeBeing:GetSizeX() / 2 + 5, preemptiveStrikeBeing:GetSpanSize().y)
  local actorProxyWrapper = getActor(actorKeyRaw)
  local name = actorProxyWrapper:getName()
  if true == _ContentsGroup_camouflageueShowName and "" == name then
    name = nameTag:GetText()
  end
  if preemptiveStrikeBeing:GetShow() then
    if "" ~= name then
      murdererMark:SetSpanSize(widthMax / 2 + murdererMark:GetSizeX() + preemptiveStrikeBeing:GetSizeX() / 2 - 10, murdererMark:GetSpanSize().y)
    else
      murdererMark:SetSpanSize(widthMax / 2 - murdererMark:GetSizeX() / 2, murdererMark:GetSpanSize().y)
    end
  elseif "" ~= name then
    murdererMark:SetSpanSize(widthMax / 2 + murdererMark:GetSizeX() / 2 + 5, murdererMark:GetSpanSize().y)
  else
    murdererMark:SetSpanSize(widthMax / 2 - murdererMark:GetSizeX(), murdererMark:GetSpanSize().y)
  end
  preemptiveStrikeBeing:SetScale(scaleBuffer.x, scaleBuffer.y)
  murdererMark:SetScale(scaleBuffer.x, scaleBuffer.y)
  guildMark:SetScale(scaleBuffer.x, scaleBuffer.y)
  guildBack:SetScale(scaleBuffer.x, scaleBuffer.y)
  guildMaster:SetScale(scaleBuffer.x, scaleBuffer.y)
  guildName:SetScale(scaleBuffer.x, scaleBuffer.y)
  nameTag:SetScale(scaleBuffer.x, scaleBuffer.y)
  title:SetScale(scaleBuffer.x, scaleBuffer.y)
  alias:SetScale(scaleBuffer.x, scaleBuffer.y)
end
local function settingSubPlayerAlliNameTag(actorKeyRaw, targetPanel, actorProxyWrapper)
  if actorProxyWrapper:get():isSelfPlayer() == true then
    return
  end
  local selfPlayerActorProxyWrapper = getSelfPlayer()
  if selfPlayerActorProxyWrapper == nil then
    return
  end
  if selfPlayerActorProxyWrapper:get():getIsAllyPlayer(actorProxyWrapper:get()) == false then
    return
  end
  local nameTagGroup = UI.getChildControl(targetPanel, "Static_NameTag_Group")
  if nameTagGroup == nil then
    return
  end
  local preemptiveStrikeBeing = UI.getChildControl(nameTagGroup, "Static_PreemptiveStrikeBeing")
  local murdererMark = UI.getChildControl(nameTagGroup, "Static_MurdererMark")
  local guildBack = UI.getChildControl(nameTagGroup, "Static_GuildBackGround")
  local guildMark = UI.getChildControl(nameTagGroup, "Static_GuildMark")
  local guildMaster = UI.getChildControl(nameTagGroup, "Static_Icon_GuildMaster")
  local guildName = UI.getChildControl(nameTagGroup, "CharacterGuild")
  local nameTag = UI.getChildControl(nameTagGroup, "CharacterName")
  local title = UI.getChildControl(nameTagGroup, "CharacterTitle")
  local alias = UI.getChildControl(nameTagGroup, "CharacterAlias")
  if guildName == nil or guildBack == nil or guildMark == nil or nameTag == nil or title == nil or preemptiveStrikeBeing == nil or murdererMark == nil or actorProxyWrapper == nil or alias == nil then
    return
  end
  local lifeRankIcon = {}
  for i = 0, lifeContentCount - 1 do
    lifeRankIcon[i] = nil
    lifeRankIcon[i] = UI.getChildControl(nameTagGroup, "Static_LifeRankIcon_" .. i)
    if nil == lifeRankIcon[i] then
      return
    end
    lifeRankIcon[i]:SetMonoTone(true)
  end
  guildName:SetMonoTone(true)
  nameTag:SetMonoTone(true)
  title:SetMonoTone(true)
  alias:SetMonoTone(true)
  preemptiveStrikeBeing:SetMonoTone(true)
  murdererMark:SetMonoTone(true)
  guildBack:SetMonoTone(true)
  guildMark:SetMonoTone(true)
  guildMaster:SetMonoTone(true)
end
local pvpIconTexture = {
  [0] = {
    x1 = 4,
    y1 = 426,
    x2 = 36,
    y2 = 458
  },
  [1] = {
    x1 = 37,
    y1 = 426,
    x2 = 69,
    y2 = 458
  },
  [2] = {
    x1 = 70,
    y1 = 426,
    x2 = 102,
    y2 = 458
  },
  [3] = {
    x1 = 103,
    y1 = 426,
    x2 = 135,
    y2 = 458
  }
}
local preemptiveIconTexture = {
  [0] = {
    x1 = 4,
    y1 = 391,
    x2 = 36,
    y2 = 423
  },
  [1] = {
    x1 = 37,
    y1 = 391,
    x2 = 69,
    y2 = 423
  },
  [2] = {
    x1 = 70,
    y1 = 391,
    x2 = 102,
    y2 = 423
  },
  [3] = {
    x1 = 103,
    y1 = 391,
    x2 = 135,
    y2 = 423
  }
}
if isGameServiceTypeConsole() then
  pvpIconTexture = {
    [0] = {
      x1 = 34,
      y1 = 141,
      x2 = 66,
      y2 = 185
    },
    [1] = {
      x1 = 34,
      y1 = 96,
      x2 = 66,
      y2 = 140
    },
    [2] = {
      x1 = 1,
      y1 = 141,
      x2 = 33,
      y2 = 185
    },
    [3] = {
      x1 = 1,
      y1 = 96,
      x2 = 33,
      y2 = 140
    }
  }
  preemptiveIconTexture = {
    [0] = {
      x1 = 67,
      y1 = 101,
      x2 = 105,
      y2 = 136
    },
    [1] = {
      x1 = 106,
      y1 = 101,
      x2 = 144,
      y2 = 136
    },
    [2] = {
      x1 = 67,
      y1 = 137,
      x2 = 105,
      y2 = 172
    },
    [3] = {
      x1 = 106,
      y1 = 137,
      x2 = 144,
      y2 = 172
    }
  }
end
local function settingPreemptiveStrike(actorKeyRaw, targetPanel, actorProxyWrapper)
  if _ContentsGroup_NameTag_Optimization == true then
    return
  end
  local preemptiveStrikeBeing
  local nameTagGroup = UI.getChildControl(targetPanel, "Static_NameTag_Group")
  if nil == nameTagGroup then
    return
  end
  if false == isGameServiceTypeConsole() then
    preemptiveStrikeBeing = UI.getChildControl(nameTagGroup, "Static_PreemptiveStrikeBeing")
  else
    preemptiveStrikeBeing = UI.getChildControl(nameTagGroup, "Static_PreemptiveStrikeBeingXbox")
  end
  if nil == preemptiveStrikeBeing then
    return
  end
  local playerActorProxyWrapper = getPlayerActor(actorKeyRaw)
  if nil == playerActorProxyWrapper then
    return
  end
  if playerActorProxyWrapper:isParticipateInRoseWar() == true then
    preemptiveStrikeBeing:SetShow(false)
    return
  end
  local playerActorProxy = playerActorProxyWrapper:get()
  local isPvpModeOn = playerActorProxy:isPvPMode()
  local isShowPvpIcon = playerActorProxy:isPreemptiveStrikeBeing() and false == playerActorProxy:isHideTimeOver(hideTimeType.preemptiveStrike) or isPvpModeOn
  preemptiveStrikeBeing:SetShow(isShowPvpIcon)
  local tendencyColor = PvpIconColorByTendency(actorKeyRaw)
  if playerActorProxy:isPreemptiveStrikeBeing() and false == playerActorProxy:isHideTimeOver(hideTimeType.preemptiveStrike) then
    preemptiveStrikeBeing:ChangeTextureInfoNameAsync("New_UI_Common_ForLua/Default/Default_Buttons_02.dds")
    if isGameServiceTypeConsole() then
      preemptiveStrikeBeing:ChangeTextureInfoNameAsync("renewal/Button/Console_Toggle_00.dds")
    end
    local x1, y1, x2, y2 = setTextureUV_Func(preemptiveStrikeBeing, preemptiveIconTexture[tendencyColor].x1, preemptiveIconTexture[tendencyColor].y1, preemptiveIconTexture[tendencyColor].x2, preemptiveIconTexture[tendencyColor].y2)
    preemptiveStrikeBeing:getBaseTexture():setUV(x1, y1, x2, y2)
    preemptiveStrikeBeing:setRenderTexture(preemptiveStrikeBeing:getBaseTexture())
  else
    preemptiveStrikeBeing:ChangeTextureInfoNameAsync("New_UI_Common_ForLua/Default/Default_Buttons_02.dds")
    if isGameServiceTypeConsole() then
      preemptiveStrikeBeing:ChangeTextureInfoNameAsync("renewal/Button/Console_Toggle_00.dds")
    end
    local x1, y1, x2, y2 = setTextureUV_Func(preemptiveStrikeBeing, pvpIconTexture[tendencyColor].x1, pvpIconTexture[tendencyColor].y1, pvpIconTexture[tendencyColor].x2, pvpIconTexture[tendencyColor].y2)
    preemptiveStrikeBeing:getBaseTexture():setUV(x1, y1, x2, y2)
    preemptiveStrikeBeing:setRenderTexture(preemptiveStrikeBeing:getBaseTexture())
  end
  settingGuildMarkAndPreemptiveStrike(actorKeyRaw, targetPanel, actorProxyWrapper)
end
function PvpIconColorByTendency(actorKeyRaw)
  local playerActorProxyWrapper = getPlayerActor(actorKeyRaw)
  if nil == playerActorProxyWrapper then
    return
  end
  local playerActorProxy = playerActorProxyWrapper:get()
  local tendency = playerActorProxy:getTendency()
  if tendency >= 150000 then
    tendencyColor = 0
  elseif tendency >= 0 and tendency < 150000 then
    tendencyColor = 1
  elseif tendency >= -5000 and tendency < 0 then
    tendencyColor = 2
  else
    tendencyColor = 3
  end
  return tendencyColor
end
local function settingMurderer(actorKeyRaw, targetPanel, actorProxyWrapper)
  if _ContentsGroup_NameTag_Optimization == true then
    return
  end
  local nameTagGroup = UI.getChildControl(targetPanel, "Static_NameTag_Group")
  if nil == nameTagGroup then
    return
  end
  local murdererMark = UI.getChildControl(nameTagGroup, "Static_MurdererMark")
  if nil == murdererMark then
    return
  end
  local playerActorProxyWrapper = getPlayerActor(actorKeyRaw)
  if nil == playerActorProxyWrapper then
    return
  end
  local actorProxy = actorProxyWrapper:get()
  if nil == actorProxy then
    return
  end
  if actorProxy:IsNeedHideNameForPVPServer() == true then
    return
  end
  if actorProxy:isNeedHideNameForEdaniaInstanceField() == true then
    murdererMark:SetShow(false)
    return
  end
  if playerActorProxyWrapper:isParticipateInRoseWar() == true then
    murdererMark:SetShow(false)
    return
  end
  if ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_GuildMatch) == true then
    murdererMark:SetShow(false)
    return
  end
  local playerActorProxy = playerActorProxyWrapper:get()
  murdererMark:SetShow(playerActorProxy:isMurdererStateBeing() and false == playerActorProxy:isHideTimeOver(hideTimeType.murdererEnd))
  settingGuildMarkAndPreemptiveStrike(actorKeyRaw, targetPanel, actorProxyWrapper)
end
local function settingGuildTextForAlias(actorKeyRaw, targetPanel, actorProxyWrapper)
  if _ContentsGroup_NameTag_Optimization == true then
    return
  end
  if nil == targetPanel then
    return
  end
  if 3 ~= targetPanel:getActorProxyTypeForNameTag() and 4 ~= targetPanel:getActorProxyTypeForNameTag() then
    return
  end
  local playerActorProxyWrapper = getPlayerActor(actorKeyRaw)
  local nameTagGroup = UI.getChildControl(targetPanel, "Static_NameTag_Group")
  if nil == nameTagGroup then
    return
  end
  local guildName = UI.getChildControl(nameTagGroup, "CharacterGuild")
  local alias = UI.getChildControl(nameTagGroup, "CharacterAlias")
  local lifeRankIcon = {}
  local edanaIcon = UI.getChildControl(nameTagGroup, "Static_Icon_Edana")
  local actorProxy = actorProxyWrapper:get()
  if actorProxy:isPlayer() then
    for i = 0, lifeContentCount - 1 do
      lifeRankIcon[i] = UI.getChildControl(nameTagGroup, "Static_LifeRankIcon_" .. i)
      if nil == lifeRankIcon[i] then
        return
      end
    end
  end
  if nil == guildName or nil == alias or nil == edanaIcon or nil == playerActorProxyWrapper then
    return
  end
  for i = 0, lifeContentCount - 1 do
    if nil == lifeRankIcon[i] then
      return
    end
  end
  local scaleBuffer = alias:GetScale()
  guildName:SetScale(1, 1)
  alias:SetScale(1, 1)
  for i = 0, lifeContentCount - 1 do
    lifeRankIcon[i]:SetScale(1, 1)
  end
  edanaIcon:SetScale(1, 1)
  local characterActorProxyWrapper = getCharacterActor(actorKeyRaw)
  local isRemoveAliasForGM = false
  if nil ~= characterActorProxyWrapper then
    local guildNoOrAllianceNo = characterActorProxyWrapper:getGuildNo_s64()
    local isAllianceMember = characterActorProxyWrapper:isGuildAllianceMember()
    if true == isAllianceMember then
      guildNoOrAllianceNo = characterActorProxyWrapper:getGuildAllianceNo_s64()
    end
    local fontColor = ToClient_GetGuildColorStringByGuildNo(guildNoOrAllianceNo)
    if nil ~= fontColor then
      isRemoveAliasForGM = true
    end
  end
  local isInGuildMatchField = ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_GuildMatch)
  local spanY = alias:GetSpanSize().y
  if playerActorProxyWrapper:checkToTitleKey() == true and isRemoveAliasForGM == false and playerActorProxyWrapper:isParticipateInRoseWar() == false and isInGuildMatchField == false then
    spanY = spanY + alias:GetSizeY()
  end
  guildName:SetSpanSize(guildName:GetSpanSize().x, spanY)
  if playerActorProxyWrapper:get():isGuildMember() and (false == playerActorProxyWrapper:get():isHideGuildName() or playerActorProxyWrapper:get():isFlashBanged()) then
    spanY = spanY + guildName:GetSizeY()
  end
  for i = 0, lifeContentCount - 1 do
    lifeRankIcon[i]:SetSpanSize(lifeRankIcon[i]:GetSpanSize().x, spanY)
  end
  edanaIcon:SetSpanSize(edanaIcon:GetSpanSize().x, spanY)
  guildName:SetScale(scaleBuffer.x, scaleBuffer.y)
  alias:SetScale(scaleBuffer.x, scaleBuffer.y)
  for i = 0, lifeContentCount - 1 do
    lifeRankIcon[i]:SetScale(scaleBuffer.x, scaleBuffer.y)
  end
  edanaIcon:SetScale(scaleBuffer.x, scaleBuffer.y)
end
local settingQuestMark = function(actorKeyRaw, targetPanel, actorProxyWrapper)
  if _ContentsGroup_NameTag_Optimization == true then
    return
  end
  local nameTagGroup = UI.getChildControl(targetPanel, "Static_NameTag_Group")
  if nil == nameTagGroup then
    return
  end
  local questMark = UI.getChildControl(nameTagGroup, "Static_Quest_Mark")
  if nil == questMark then
    return
  end
  if isQuestMonsterByKey(actorKeyRaw) then
    questMark:SetShow(true)
  else
    questMark:SetShow(false)
  end
end
local settingQuestMarkForce = function(isShow, targetPanel, actorProxyWrapper)
  local nameTagGroup = UI.getChildControl(targetPanel, "Static_NameTag_Group")
  if nil == nameTagGroup then
    return
  end
  local questMark = UI.getChildControl(nameTagGroup, "Static_Quest_Mark")
  if nil == questMark then
    return
  end
  questMark:SetShow(isShow)
end
function questIconOverTooltip(show, actorKeyRaw)
  local actorProxyWrapper = getActor(actorKeyRaw)
  local npcActorProxyWrapper = getNpcActor(actorKeyRaw)
  local panel = actorProxyWrapper:get():getUIPanel()
  local questStaticStatusWrapper = npcActorProxyWrapper:getQuestStatisStatusWrapper()
  if nil == questStaticStatusWrapper then
    return
  end
  local questTitle = questStaticStatusWrapper:getTitle()
  local nameTagGroup = UI.getChildControl(panel, "Static_NameTag_Group")
  if nil == nameTagGroup then
    return
  end
  local questTitleTooltip = UI.getChildControl(nameTagGroup, "StaticText_QuestTooltip")
  local questIcon = UI.getChildControl(nameTagGroup, "Static_QuestIcon")
  if true == show then
    local prevScale = questIcon:GetScale()
    questTitleTooltip:SetScale(1, 1)
    questTitleTooltip:SetShow(true)
    questTitleTooltip:SetText(questTitle)
    questTitleTooltip:SetSize(questTitleTooltip:GetTextSizeX() + 20, questTitleTooltip:GetSizeY())
    questTitleTooltip:SetSpanSize(questIcon:GetSpanSize().x, questTitleTooltip:GetSpanSize().y - 20)
    questTitleTooltip:SetAlpha(1)
    questTitleTooltip:SetFontAlpha(1)
  else
    questTitleTooltip:SetShow(false)
  end
end
local currentTypeChangeCheck = {}
local function settingQuestUI(actorKeyRaw, targetPanel, actorProxyWrapper, insertedArray)
  if _ContentsGroup_NameTag_Optimization == true then
    return
  end
  local nameTagGroup = UI.getChildControl(targetPanel, "Static_NameTag_Group")
  if nil == nameTagGroup then
    return
  end
  local questIconBase = UI.getChildControl(nameTagGroup, "Static_QuestIconBase")
  if questIconBase == nil then
    return
  end
  local questIcon = UI.getChildControl(questIconBase, "Static_QuestIcon")
  local questBorder = UI.getChildControl(questIconBase, "Static_QuestIconBorder")
  local questClear = UI.getChildControl(questIconBase, "Static_QuestClear")
  local lookAtMe = UI.getChildControl(questIconBase, "Static_LookAtMe")
  local lookAtMe2 = UI.getChildControl(questIconBase, "Static_LookAtMe2")
  local questType = UI.getChildControl(questIconBase, "Static_QuestType")
  local npcActorProxyWrapper = getNpcActor(actorKeyRaw)
  if nil == questIcon or nil == questBorder or nil == questClear or nil == lookAtMe or nil == lookAtMe2 or nil == npcActorProxyWrapper then
    return
  end
  local questStaticStatusWrapper = npcActorProxyWrapper:getQuestStatisStatusWrapper()
  if nil == questStaticStatusWrapper then
    questIcon:SetShow(false)
    questBorder:SetShow(false)
    questClear:SetShow(false)
    lookAtMe:SetShow(false)
    lookAtMe2:SetShow(false)
    questType:SetShow(false)
    return
  end
  if questStaticStatusWrapper:isHaveBackEndData() == false then
    PaGlobal_CharacterNameTag_All:pushQuestLoadingData(questStaticStatusWrapper, actorKeyRaw, targetPanel, actorProxyWrapper, insertedArray)
  end
  local currentType = npcActorProxyWrapper:get():getOverHeadQuestInfoType()
  local isShow = 0 ~= currentType
  questIcon:addInputEvent("Mouse_On", "questIconOverTooltip( true,\t" .. actorKeyRaw .. " )")
  questIcon:addInputEvent("Mouse_Out", "questIconOverTooltip( false,\t" .. actorKeyRaw .. " )")
  ToClient_ChangeQuestIconFromIconPath(questIcon, questStaticStatusWrapper:getIconPath(), questStaticStatusWrapper:getQuestType())
  questIcon:SetAlpha(1)
  questBorder:SetAlpha(1)
  questClear:SetAlpha(1)
  lookAtMe:SetAlpha(1)
  lookAtMe2:SetAlpha(1)
  questType:SetAlpha(1)
  questIcon:SetAlphaIgnore(true)
  questBorder:SetAlphaIgnore(true)
  questClear:SetAlphaIgnore(true)
  lookAtMe:SetAlphaIgnore(true)
  lookAtMe2:SetAlphaIgnore(true)
  questType:SetAlphaIgnore(true)
  questIcon:SetScaleMinimum(0.5)
  questBorder:SetScaleMinimum(0.5)
  questClear:SetScaleMinimum(0.5)
  lookAtMe:SetScaleMinimum(0.5)
  lookAtMe2:SetScaleMinimum(0.5)
  questType:SetScaleMinimum(0.5)
  questIconBase:SetScaleMinimum(0.5)
  questIcon:SetShow(isShow)
  questBorder:SetShow(isShow)
  questClear:SetShow(3 == currentType)
  lookAtMe:SetShow(isShow)
  lookAtMe2:SetShow(isShow)
  questType:SetShow(isShow)
  if isShow then
    local prevAlpha = questBorder:GetAlpha()
    questType:SetShow(false)
    if 3 == currentType then
      lookAtMe:SetColor(Defines.Color.C_FFF26A6A)
      lookAtMe2:SetColor(Defines.Color.C_FFF26A6A)
      if true == PaGlobal_Interaction_GetShow() and true ~= currentTypeChangeCheck[actorKeyRaw] then
        Interaction_Close()
      end
      currentTypeChangeCheck[actorKeyRaw] = true
    elseif 2 == currentType then
      lookAtMe:SetShow(true)
      lookAtMe:SetColor(Defines.Color.C_FF6DC6FF)
      lookAtMe2:SetShow(true)
      lookAtMe2:SetColor(Defines.Color.C_FF6DC6FF)
      currentTypeChangeCheck[actorKeyRaw] = false
    elseif 1 == currentType then
      lookAtMe:SetShow(true)
      lookAtMe:SetColor(Defines.Color.C_FFFFEEA0)
      lookAtMe2:SetShow(true)
      lookAtMe2:SetColor(Defines.Color.C_FFFFEEA0)
      currentTypeChangeCheck[actorKeyRaw] = false
    end
    questBorder:SetAlpha(prevAlpha)
    local aControl = {
      questIcon = questIcon,
      questBorder = questBorder,
      questClear = questClear,
      lookAtMe = lookAtMe,
      lookAtMe2 = lookAtMe2,
      questType = questType,
      GetSizeX = function()
        return questBorder:GetSizeX()
      end,
      SetScale = function(self, x, y)
        questBorder:SetScale(x, y)
        questIcon:SetScale(x, y)
        questClear:SetScale(x, y)
        lookAtMe:SetScale(x, y)
        lookAtMe2:SetScale(x, y)
        questType:SetScale(x, y)
      end,
      SetSpanSize = function(self, x, y)
        questBorder:SetSpanSize(x + 8, y)
        questIcon:SetSpanSize(x + 8, y + 18)
        questClear:SetSpanSize(x + 8, y + 16)
        lookAtMe:SetSpanSize(x + 8, y + 14)
        lookAtMe2:SetSpanSize(x + 8, y + 10)
        questType:SetSpanSize(x + 8, y + 46)
      end,
      GetSpanSize = function()
        return questBorder:GetSpanSize()
      end,
      GetScale = function()
        return questBorder:GetScale()
      end,
      GetShow = function()
        return questBorder:GetShow()
      end
    }
    questBorder:SetColor(Defines.Color.C_FFFFFFFF)
    questClear:SetShow(false)
    questBorder:ChangeTextureInfoNameAsync(questFrameUV[0])
    local x1, y1, x2, y2 = 0, nil, nil, nil
    local questTypeNo = questStaticStatusWrapper:getQuestType()
    local questCurrentStatus = npcActorProxyWrapper:get():getOverHeadQuestInfoType()
    local questTypeIdx = 3
    local questSelectTypeNo = questStaticStatusWrapper:getSelectType()
    if (5 == questTypeNo or 6 == questTypeNo or 7 == questTypeNo) and 1 == questCurrentStatus then
      questCurrentStatus = 4
      lookAtMe:SetColor(Defines.Color.C_FF88DF00)
      lookAtMe2:SetColor(Defines.Color.C_FF88DF00)
    end
    if questTypeNo == __eQuestType_BlackSpirit then
      questTypeIdx = 2
    elseif questTypeNo == __eQuestType_Main then
      questTypeIdx = 1
    elseif questTypeNo == __eQuestType_Repeat then
      questTypeIdx = 4
    else
      questTypeIdx = 3
    end
    x1, y1, x2, y2 = setTextureUV_Func(questBorder, questFrameUV[questTypeIdx][questCurrentStatus][1], questFrameUV[questTypeIdx][questCurrentStatus][2], questFrameUV[questTypeIdx][questCurrentStatus][3], questFrameUV[questTypeIdx][questCurrentStatus][4])
    questBorder:getBaseTexture():setUV(x1, y1, x2, y2)
    questBorder:setRenderTexture(questBorder:getBaseTexture())
    insertedArray:push_back(questIconBase)
  end
end
local settingBillBoardMode = function(actorKeyRaw, targetPanel, actorProxyWrapper)
  houseHoldActorWrapper = getHouseHoldActor(actorKeyRaw)
  if nil ~= houseHoldActorWrapper and false == houseHoldActorWrapper:get():isTent() and false == houseHoldActorWrapper:getStaticStatusWrapper():getObjectStaticStatus():isBarricade() then
    targetPanel:Set3DRenderType(2)
    targetPanel:Set3DOffsetZ(40)
  end
end
local function settingReplayPlayerNameTagPos(actorProxyWrapper, targetPanel)
  if ToClient_IsArshaReplay() == false and ToClient_IsInstanceContentsReplay() == false and ToClient_IsMirrorFieldContentsReplay() == false then
    return
  end
  local nameTagGroup = UI.getChildControl(targetPanel, "Static_NameTag_Group")
  if nil == nameTagGroup then
    return
  end
  local guildName = UI.getChildControl(nameTagGroup, "CharacterGuild")
  local titleTag = UI.getChildControl(nameTagGroup, "CharacterTitle")
  titleTag:SetPosY(replayTitlePosY)
  guildName:SetPosY(replayGuilNamePosY)
end
local settingWaitCommentLaunch = function(isShow)
  local selfPlayerWrapper = getSelfPlayer()
  local selfPlayer = selfPlayerWrapper:get()
  local panel = selfPlayer:getWaitCommentPanel()
  if nil == panel then
    return
  end
  local targetBoard = UI.getChildControl(panel, "Static_Board")
  local targetPaper = UI.getChildControl(panel, "Static_Paper")
  local targetEditComment = UI.getChildControl(panel, "Edit_Txt")
  local targetPin_1 = UI.getChildControl(panel, "Static_Pin_1")
  local targetPin_2 = UI.getChildControl(panel, "Static_Pin_2")
  local targetPin_3 = UI.getChildControl(panel, "Static_Pin_3")
  local targetPin_4 = UI.getChildControl(panel, "Static_Pin_4")
  local targetRoll_L = UI.getChildControl(panel, "Static_Roll_L")
  local targetRoll_R = UI.getChildControl(panel, "Static_Roll_R")
  local targetPlayerID = UI.getChildControl(panel, "StaticText_ID")
  if isShow then
    local scaleBuffer = targetBoard:GetScale()
    targetBoard:SetScale(1, 1)
    targetEditComment:SetScale(1, 1)
    targetPaper:SetScale(1, 1)
    targetBoard:SetSize(100, 110)
    targetEditComment:SetSize(45, 56)
    targetPaper:SetSize(75, 56)
    targetBoard:SetScale(scaleBuffer.x, scaleBuffer.y)
    targetEditComment:SetScale(scaleBuffer.x, scaleBuffer.y)
    targetPaper:SetScale(scaleBuffer.x, scaleBuffer.y)
    local paperSizeX = targetPaper:GetSizeX()
    local paperPosX = targetPaper:GetPosX()
    targetEditComment:SetEditText("", false)
    targetEditComment:SetMaxInput(20)
    targetRoll_L:SetShow(true)
    targetRoll_R:SetShow(true)
    targetPaper:SetShow(true)
    targetEditComment:SetShow(true)
    targetPaper:SetIgnore(false)
    targetRoll_L:SetSpanSize(-paperSizeX / 2, targetRoll_L:GetSpanSize().y)
    targetRoll_R:SetSpanSize(paperSizeX / 2, targetRoll_R:GetSpanSize().y)
    targetPaper:addInputEvent("Mouse_LUp", "settingWaitCommentReady()")
  else
    targetRoll_L:SetShow(false)
    targetRoll_R:SetShow(false)
    targetPaper:SetShow(false)
    targetEditComment:SetShow(false)
  end
  targetBoard:SetShow(false)
  targetPlayerID:SetShow(false)
  targetPin_1:SetShow(false)
  targetPin_2:SetShow(false)
  targetPin_3:SetShow(false)
  targetPin_4:SetShow(false)
  targetEditComment:SetIgnore(true)
end
function settingWaitCommentReady()
  local selfPlayerWrapper = getSelfPlayer()
  local selfPlayer = selfPlayerWrapper:get()
  local panel = selfPlayer:getWaitCommentPanel()
  if nil == panel then
    return
  end
  local targetBoard = UI.getChildControl(panel, "Static_Board")
  local targetPaper = UI.getChildControl(panel, "Static_Paper")
  local targetEditComment = UI.getChildControl(panel, "Edit_Txt")
  local targetPin_1 = UI.getChildControl(panel, "Static_Pin_1")
  local targetPin_2 = UI.getChildControl(panel, "Static_Pin_2")
  local targetPin_3 = UI.getChildControl(panel, "Static_Pin_3")
  local targetPin_4 = UI.getChildControl(panel, "Static_Pin_4")
  local targetRoll_L = UI.getChildControl(panel, "Static_Roll_L")
  local targetRoll_R = UI.getChildControl(panel, "Static_Roll_R")
  local targetPlayerID = UI.getChildControl(panel, "StaticText_ID")
  local scaleBuffer = targetEditComment:GetScale()
  targetEditComment:SetScale(1, 1)
  targetPaper:SetScale(1, 1)
  targetEditComment:SetSize(256, 56)
  targetPaper:SetSize(281, 56)
  targetEditComment:SetScale(scaleBuffer.x, scaleBuffer.y)
  targetPaper:SetScale(scaleBuffer.x, scaleBuffer.y)
  targetEditComment:ComputePos()
  targetPaper:ComputePos()
  local paperSizeX = targetPaper:GetSizeX()
  local paperPosX = targetPaper:GetPosX()
  targetRoll_L:SetSpanSize(-paperSizeX / 2, targetRoll_L:GetSpanSize().y)
  targetRoll_R:SetSpanSize(paperSizeX / 2, targetRoll_R:GetSpanSize().y)
  SetFocusEdit(targetEditComment)
  targetBoard:SetShow(false)
  targetPaper:SetShow(true)
  targetEditComment:SetShow(true)
  targetRoll_L:SetShow(true)
  targetRoll_R:SetShow(true)
  targetPlayerID:SetShow(false)
  targetPin_1:SetShow(false)
  targetPin_2:SetShow(false)
  targetPin_3:SetShow(false)
  targetPin_4:SetShow(false)
end
function settingWaitCommentConfirmReload()
  local selfPlayerWrapper = getSelfPlayer()
  local selfPlayer = selfPlayerWrapper:get()
  if false == selfPlayer:isShowWaitComment() then
    return
  end
  local panel = selfPlayer:getWaitCommentPanel()
  if nil == panel then
    return
  end
  local targetEditComment = UI.getChildControl(panel, "Edit_Txt")
  targetEditComment:SetEditText(selfPlayer:getWaitComment(), true)
  settingWaitCommentConfirm()
end
function settingWaitCommentConfirm()
  ClearFocusEdit()
  local selfPlayerWrapper = getSelfPlayer()
  local selfPlayer = selfPlayerWrapper:get()
  local panel = selfPlayer:getWaitCommentPanel()
  if nil == panel then
    return
  end
  if selfPlayer:isParticipateInRoseWar() == true then
    return
  end
  if ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_GuildMatch) == true then
    return
  end
  local targetBoard = UI.getChildControl(panel, "Static_Board")
  local targetPaper = UI.getChildControl(panel, "Static_Paper")
  local targetEditComment = UI.getChildControl(panel, "Edit_Txt")
  local targetPin_1 = UI.getChildControl(panel, "Static_Pin_1")
  local targetPin_2 = UI.getChildControl(panel, "Static_Pin_2")
  local targetPin_3 = UI.getChildControl(panel, "Static_Pin_3")
  local targetPin_4 = UI.getChildControl(panel, "Static_Pin_4")
  local targetRoll_L = UI.getChildControl(panel, "Static_Roll_L")
  local targetRoll_R = UI.getChildControl(panel, "Static_Roll_R")
  local targetPlayerID = UI.getChildControl(panel, "StaticText_ID")
  targetPlayerID:SetText("[" .. selfPlayerWrapper:getName() .. "]")
  targetBoard:SetShow(true)
  targetPlayerID:SetShow(true)
  targetPin_1:SetShow(true)
  targetPin_2:SetShow(true)
  targetPin_3:SetShow(true)
  targetPin_4:SetShow(true)
  targetEditComment:SetShow(true)
  targetPin_1:AddEffect("fUI_Repair01", false, 0, 0)
  targetPin_2:AddEffect("fUI_Repair01", false, 0, 0)
  targetPin_3:AddEffect("fUI_Repair01", false, 0, 0)
  targetPin_4:AddEffect("fUI_Repair01", false, 0, 0)
  targetRoll_L:SetShow(false)
  targetRoll_R:SetShow(false)
  targetEditComment:SetIgnore(true)
  targetPaper:SetIgnore(false)
  updateWaitComment(targetEditComment:GetEditText())
  targetEditComment:SetEditText(chatting_filteredText(targetEditComment:GetEditText()), true)
  local sizeY = targetEditComment:GetSizeY()
  local scaleBuffer = targetEditComment:GetScale()
  targetEditComment:SetScale(1, 1)
  targetPaper:SetScale(1, 1)
  targetBoard:SetScale(1, 1)
  targetPlayerID:SetScale(1, 1)
  if 256 < targetEditComment:GetTextSizeX() then
    targetBoard:SetSize(targetEditComment:GetSizeX() + 50, sizeY + 65)
    targetPaper:SetSize(targetEditComment:GetSizeX() + 25, sizeY + 10)
  else
    targetEditComment:SetSize(targetEditComment:GetTextSizeX(), targetEditComment:GetSizeY())
    targetPaper:SetSize(targetEditComment:GetTextSizeX() + 25, targetPaper:GetSizeY())
    targetBoard:SetSize(targetEditComment:GetTextSizeX() + 60, targetBoard:GetSizeY())
  end
  targetPlayerID:SetSize(targetPaper:GetSizeX(), targetPlayerID:GetSizeY())
  targetBoard:SetScale(scaleBuffer.x, scaleBuffer.y)
  targetPaper:SetScale(scaleBuffer.x, scaleBuffer.y)
  targetEditComment:SetScale(scaleBuffer.x, scaleBuffer.y)
  targetPlayerID:SetScale(scaleBuffer.x, scaleBuffer.y)
  targetBoard:ComputePos()
  targetPaper:ComputePos()
  targetEditComment:ComputePos()
  targetPlayerID:ComputePos()
  targetPin_1:SetSpanSize(targetPaper:GetPosX() + 5, targetPin_1:GetSpanSize().y)
  targetPin_2:SetSpanSize(targetPaper:GetPosX() + targetPaper:GetSizeX() - 15, targetPin_2:GetSpanSize().y)
  targetPin_3:SetSpanSize(targetPaper:GetPosX() + 5, targetPin_3:GetSpanSize().y)
  targetPin_4:SetSpanSize(targetPaper:GetPosX() + targetPaper:GetSizeX() - 15, targetPin_4:GetSpanSize().y)
end
function WaitComment_CheckCurrentUiEdit(targetUI)
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return false
  end
  local selfPlayer = selfPlayerWrapper:get()
  local panel = selfPlayer:getWaitCommentPanel()
  if nil == panel then
    return false
  end
  local targetEditComment = UI.getChildControl(panel, "Edit_Txt")
  return nil ~= targetUI and targetUI:GetKey() == targetEditComment:GetKey()
end
local settingWaitComment = function(actorKeyRaw, panel, actorProxyWrapper, isShow, isforce)
  if _ContentsGroup_NameTag_Optimization == true then
    return
  end
  local selfPlayer = getSelfPlayer()
  local selfActorKeyRaw = selfPlayer:getActorKey()
  if actorKeyRaw == selfActorKeyRaw and true ~= isforce then
    return
  end
  local targetPanel = panel
  if actorProxyWrapper:get():isSelfPlayer() then
    targetPanel = getSelfPlayer():get():getWaitCommentPanel()
  end
  if targetPanel == nil then
    return
  end
  local playerActorProxy = getPlayerActor(actorKeyRaw)
  if nil == playerActorProxy then
    return
  end
  local message = playerActorProxy:get():getWaitComment()
  local targetBoard, targetPaper, targetEditComment, targetPin_1, targetPin_2, targetPin_3, targetPin_4, targetPlayerID
  if actorProxyWrapper:get():isSelfPlayer() then
    targetBoard = UI.getChildControl(targetPanel, "Static_Board")
    targetPaper = UI.getChildControl(targetPanel, "Static_Paper")
    targetEditComment = UI.getChildControl(targetPanel, "Edit_Txt")
    targetPin_1 = UI.getChildControl(targetPanel, "Static_Pin_1")
    targetPin_2 = UI.getChildControl(targetPanel, "Static_Pin_2")
    targetPin_3 = UI.getChildControl(targetPanel, "Static_Pin_3")
    targetPin_4 = UI.getChildControl(targetPanel, "Static_Pin_4")
    targetPlayerID = UI.getChildControl(targetPanel, "StaticText_ID")
  else
    local nameTagGroup = UI.getChildControl(targetPanel, "Static_NameTag_Group")
    targetBoard = UI.getChildControl(nameTagGroup, "Static_Board")
    targetPaper = UI.getChildControl(nameTagGroup, "Static_Paper")
    targetEditComment = UI.getChildControl(nameTagGroup, "Edit_Txt")
    targetPin_1 = UI.getChildControl(nameTagGroup, "Static_Pin_1")
    targetPin_2 = UI.getChildControl(nameTagGroup, "Static_Pin_2")
    targetPin_3 = UI.getChildControl(nameTagGroup, "Static_Pin_3")
    targetPin_4 = UI.getChildControl(nameTagGroup, "Static_Pin_4")
    targetPlayerID = UI.getChildControl(nameTagGroup, "StaticText_ID")
  end
  if isShow and nil ~= message and "" ~= message then
    targetBoard:SetShow(true)
    targetPaper:SetShow(true)
    targetEditComment:SetShow(true)
    targetPin_1:SetShow(true)
    targetPin_2:SetShow(true)
    targetPin_3:SetShow(true)
    targetPin_4:SetShow(true)
    targetPlayerID:SetShow(true)
    local scaleBuffer = targetEditComment:GetScale()
    targetEditComment:SetScale(1, 1)
    targetBoard:SetScale(1, 1)
    targetPaper:SetScale(1, 1)
    targetPlayerID:SetScale(1, 1)
    targetEditComment:SetSize(256, 56)
    targetPlayerID:SetText("[" .. playerActorProxy:getName() .. "]")
    targetEditComment:SetText(message)
    local sizeY = targetEditComment:GetSizeY()
    targetEditComment:SetSize(targetEditComment:GetTextSizeX(), targetEditComment:GetSizeY())
    targetBoard:SetSize(targetEditComment:GetTextSizeX() + 60, targetBoard:GetSizeY())
    targetPaper:SetSize(targetEditComment:GetTextSizeX() + 25, targetPaper:GetSizeY())
    targetPlayerID:SetSize(targetPaper:GetSizeX(), targetPlayerID:GetSizeY())
    targetEditComment:SetScale(scaleBuffer.x, scaleBuffer.y)
    targetBoard:SetScale(scaleBuffer.x, scaleBuffer.y)
    targetPaper:SetScale(scaleBuffer.x, scaleBuffer.y)
    targetPlayerID:SetScale(scaleBuffer.x, scaleBuffer.y)
    targetBoard:ComputePos()
    targetPaper:ComputePos()
    targetEditComment:ComputePos()
    targetPlayerID:ComputePos()
    targetPin_1:SetSpanSize(-targetEditComment:GetTextSizeX() / 2, 40)
    targetPin_2:SetSpanSize(targetEditComment:GetTextSizeX() / 2, 40)
    targetPin_3:SetSpanSize(targetEditComment:GetTextSizeX() / 2, 5)
    targetPin_4:SetSpanSize(-targetEditComment:GetTextSizeX() / 2, 5)
  else
    targetBoard:SetShow(false)
    targetPaper:SetShow(false)
    targetEditComment:SetShow(false)
    targetPin_1:SetShow(false)
    targetPin_2:SetShow(false)
    targetPin_3:SetShow(false)
    targetPin_4:SetShow(false)
    targetPlayerID:SetShow(false)
  end
end
local furnitureActorKeyRaw
function Furniture_Check(actorKeyRaw)
  local actorProxyWrapper = getActor(actorKeyRaw)
  if nil == actorProxyWrapper then
    return
  end
  local actorProxy = actorProxyWrapper:get()
  local characterStaticStatus = actorProxy:getCharacterSimplyStaticStatus()
  furnitureActorKeyRaw = actorKeyRaw
  if nil == actorProxy or nil == characterStaticStatus or nil == actorKeyRaw then
    return
  end
  if actorProxy:isInstallationActor() then
    local installationActorWrapper = getInstallationActor(furnitureActorKeyRaw)
    if Panel_Housing:IsShow() then
      return
    end
    local installationType = installationActorWrapper:getStaticStatusWrapper():getObjectStaticStatus():getInstallationType()
    if false == isShowInstallationEnduranceType(installationType) then
      return
    end
    if toInt64(0, 0) == installationActorWrapper:getOwnerHouseholdNo_s64() or installationActorWrapper:isHavestInstallation() then
    else
      furnitureCheck = true
    end
  end
  local panel = actorProxyWrapper:get():getUIPanel()
  if nil == panel then
    return
  end
  ToClient_UpdateActorHpBar(actorKeyRaw)
  ToClient_UpdateActorCharacterName(actorKeyRaw)
end
function Funiture_Endurance_Hide()
  if true == furnitureCheck and nil ~= furnitureActorKeyRaw then
    local actorProxyWrapper = getActor(furnitureActorKeyRaw)
    if nil ~= actorProxyWrapper then
      local actorProxy = actorProxyWrapper:get()
      if actorProxy ~= nil then
        local panel = actorProxy:getUIPanel()
        if nil == panel then
          return
        end
        furnitureCheck = false
        ToClient_UpdateActorHpBar(furnitureActorKeyRaw)
        ToClient_UpdateActorCharacterName(furnitureActorKeyRaw)
      else
        return
      end
    else
      return
    end
  end
  furnitureActorKeyRaw = nil
end
function setNameBasicPos(Panel)
  local nameTagGroupnameTagGroup = UI.getChildControl(Panel, "Static_NameTag_Group")
  local titleTag = UI.getChildControl(nameTagGroupnameTagGroup, "CharacterTitle")
  local nameTag = UI.getChildControl(nameTagGroupnameTagGroup, "CharacterName")
  if 0 == replayGuilNamePosY then
    replayGuilNamePosY = titleTag:GetPosY()
    replayTitlePosY = nameTag:GetPosY()
  end
end
local TypeByLoadData = {
  [__eActorProxyTypeForNameTag_isActorProxy] = function(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingName(actorKeyRaw, targetPanel, actorProxyWrapper)
  end,
  [__eActorProxyTypeForNameTag_isCharacter] = function(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingName(actorKeyRaw, targetPanel, actorProxyWrapper)
  end,
  [__eActorProxyTypeForNameTag_isPlayer] = function(actorKeyRaw, targetPanel, actorProxyWrapper)
    local insertedArray = Array.new()
    settingName(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingPlayerName(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingTitle(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingGuildInfo(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingEdanaInfo(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingLifeRankIcon(actorKeyRaw, targetPanel, actorProxyWrapper, insertedArray)
    settingPreemptiveStrike(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingGuildTextForAlias(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingLocalWarCombatPoint(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingMurderer(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingGuildMarkAndPreemptiveStrike(actorKeyRaw, targetPanel, actorProxyWrapper)
  end,
  [__eActorProxyTypeForNameTag_isSelfPlayer] = function(actorKeyRaw, targetPanel, actorProxyWrapper)
    if true == isPlayMusic then
      return
    end
    local insertedArray = Array.new()
    settingName(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingPlayerName(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingAlias(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingTitle(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingGuildInfo(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingEdanaInfo(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingLifeRankIcon(actorKeyRaw, targetPanel, actorProxyWrapper, insertedArray)
    settingPreemptiveStrike(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingWaitCommentConfirmReload()
    settingGuildTextForAlias(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingLocalWarCombatPoint(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingMurderer(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingGuildMarkAndPreemptiveStrike(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingMpBar(actorKeyRaw, targetPanel, actorProxyWrapper)
  end,
  [__eActorProxyTypeForNameTag_isOtherPlayer] = function(actorKeyRaw, targetPanel, actorProxyWrapper, isSubPlayer)
    local insertedArray = Array.new()
    settingName(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingPlayerName(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingAlias(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingTitle(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingGuildInfo(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingEdanaInfo(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingLifeRankIcon(actorKeyRaw, targetPanel, actorProxyWrapper, insertedArray)
    settingPreemptiveStrike(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingWaitComment(actorKeyRaw, targetPanel, actorProxyWrapper, true)
    settingGuildTextForAlias(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingLocalWarCombatPoint(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingMurderer(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingGuildMarkAndPreemptiveStrike(actorKeyRaw, targetPanel, actorProxyWrapper)
    if isSubPlayer == true then
      settingSubPlayerAlliNameTag(actorKeyRaw, targetPanel, actorProxyWrapper)
    end
  end,
  [__eActorProxyTypeForNameTag_isAlterego] = function(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingName(actorKeyRaw, targetPanel, actorProxyWrapper)
  end,
  [__eActorProxyTypeForNameTag_isMonster] = function(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingName(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingMonsterName(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingTitle(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingQuestMark(actorKeyRaw, targetPanel, actorProxyWrapper)
  end,
  [__eActorProxyTypeForNameTag_isNpc] = function(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingName(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingTitle(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingQuestMark(actorKeyRaw, targetPanel, actorProxyWrapper)
    local insertedArray = Array.new()
    settingQuestUI(actorKeyRaw, targetPanel, actorProxyWrapper, insertedArray)
    settingFirstTalk(actorKeyRaw, targetPanel, actorProxyWrapper, insertedArray)
    settingImportantTalk(actorKeyRaw, targetPanel, actorProxyWrapper, insertedArray)
    settingOtherHeadIcon(actorKeyRaw, targetPanel, actorProxyWrapper, insertedArray)
    sortCenterX(insertedArray)
  end,
  [__eActorProxyTypeForNameTag_isDeadBody] = function(actorKeyRaw, targetPanel, actorProxyWrapper)
  end,
  [__eActorProxyTypeForNameTag_isVehicle] = function(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingName(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingGuildInfoForSiegeVehicle(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingQuestMark(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingMpBar(actorKeyRaw, targetPanel, actorProxyWrapper)
  end,
  [__eActorProxyTypeForNameTag_isHouseHold] = function(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingName(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingBillBoardMode(actorKeyRaw, targetPanel, actorProxyWrapper)
  end,
  [__eActorProxyTypeForNameTag_isInstallationActor] = function(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingName(actorKeyRaw, targetPanel, actorProxyWrapper)
  end,
  [__eActorProxyTypeForNameTag_isInstanceObject] = function(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingName(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingGuildInfoForSiegeInstanceObject(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingMpBar(actorKeyRaw, targetPanel, actorProxyWrapper)
  end,
  [__eActorProxyTypeForNameTag_isReplayActor] = function(actorKeyRaw, targetPanel, actorProxyWrapper)
    setNameBasicPos(targetPanel)
    settingPlayerName(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingTitle(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingGuildInfo(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingReplayName(actorKeyRaw, targetPanel, actorProxyWrapper)
  end,
  [__eActorProxyTypeForNameTag_isMaidActor] = function(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingName(actorKeyRaw, targetPanel, actorProxyWrapper)
  end
}
function EventActorCreated_NameTag(actorKeyRaw, targetPanel, actorProxyType, actorProxyWrapper)
  local isSubPlayer = false
  if nil ~= TypeByLoadData[actorProxyType] then
    if actorProxyWrapper:get():isSubPlayer() == true then
      local subPlayerActorType = actorProxyWrapper:get():getSubActorType()
      if subPlayerActorType == nil then
        targetPanel:SetShow(false)
        return
      end
      if subPlayerActorType ~= __eSubPlayerActorType_Clone then
        targetPanel:SetShow(false)
        return
      end
      actorKeyRaw = actorProxyWrapper:get():getOwnerActorKeyRaw()
      isSubPlayer = true
      actorProxyWrapper = getActor(actorKeyRaw)
    end
    TypeByLoadData[actorProxyType](actorKeyRaw, targetPanel, actorProxyWrapper, isSubPlayer)
  end
end
function FromClient_ChangeTopRankUser(actorKeyRaw)
  local actorProxyWrapper = getActor(actorKeyRaw)
  if nil == actorProxyWrapper then
    return
  end
  local panel = actorProxyWrapper:get():getUIPanel()
  if nil == panel then
    return
  end
  local insertedArray = Array.new()
  settingLifeRankIcon(actorKeyRaw, panel, actorProxyWrapper, insertedArray)
  settingGuildTextForAlias(actorKeyRaw, panel, actorProxyWrapper)
end
function FromClient_NameTag_TendencyChanged(actorKeyRaw, tendencyValue)
  local actorProxyWrapper = getActor(actorKeyRaw)
  if nil == actorProxyWrapper then
    return
  end
  local panel = actorProxyWrapper:get():getUIPanel()
  if nil == panel then
    return
  end
  settingPlayerName(actorKeyRaw, panel, actorProxyWrapper)
  settingGuildMarkAndPreemptiveStrike(actorKeyRaw, panel, actorProxyWrapper)
  settingPreemptiveStrike(actorKeyRaw, panel, actorProxyWrapper)
end
function EventActorFirsttalk(actorKeyRaw, isFirsttalkOn)
  local actorProxyWrapper = getActor(actorKeyRaw)
  if nil == actorProxyWrapper then
    return
  end
  local panel = actorProxyWrapper:get():getUIPanel()
  if nil == panel then
    return
  end
  local insertedArray = Array.new()
  settingQuestUI(actorKeyRaw, panel, actorProxyWrapper, insertedArray)
  settingFirstTalk(actorKeyRaw, panel, actorProxyWrapper, insertedArray)
  settingImportantTalk(actorKeyRaw, panel, actorProxyWrapper, insertedArray)
  settingOtherHeadIcon(actorKeyRaw, panel, actorProxyWrapper, insertedArray)
  sortCenterX(insertedArray)
end
function EventActorImportantTalk(actorKeyRaw, isImportantTalk)
  local actorProxyWrapper = getActor(actorKeyRaw)
  if nil == actorProxyWrapper then
    return
  end
  local panel = actorProxyWrapper:get():getUIPanel()
  if nil == panel then
    return
  end
  local insertedArray = Array.new()
  settingQuestUI(actorKeyRaw, panel, actorProxyWrapper, insertedArray)
  settingFirstTalk(actorKeyRaw, panel, actorProxyWrapper, insertedArray)
  settingImportantTalk(actorKeyRaw, panel, actorProxyWrapper, insertedArray)
  settingOtherHeadIcon(actorKeyRaw, panel, actorProxyWrapper, insertedArray)
  sortCenterX(insertedArray)
end
function EventActorChangeGuildInfo(actorKeyRaw, guildName)
  local actorProxyWrapper = getActor(actorKeyRaw)
  if nil == actorProxyWrapper then
    return
  end
  local panel = actorProxyWrapper:get():getUIPanel()
  if nil == panel then
    return
  end
  if true == actorProxyWrapper:get():isReplayActor() then
    for ii = 0, #initReplayActorList - 1 do
      if initReplayActorList[ii] == actorKeyRaw then
        settingGuildMarkInfoForReplay(actorKeyRaw, panel, actorProxyWrapper)
        return
      end
    end
  end
  local insertedArray = Array.new()
  settingGuildInfo(actorKeyRaw, panel, actorProxyWrapper)
  settingEdanaInfo(actorKeyRaw, panel, actorProxyWrapper)
  settingGuildMarkAndPreemptiveStrike(actorKeyRaw, panel, actorProxyWrapper)
  settingLifeRankIcon(actorKeyRaw, panel, actorProxyWrapper, insertedArray)
  settingGuildTextForAlias(actorKeyRaw, panel, actorProxyWrapper)
  settingLocalWarCombatPoint(actorKeyRaw, panel, actorProxyWrapper)
  if true == actorProxyWrapper:get():isReplayActor() then
    initReplayActorList:push_back(actorKeyRaw)
  end
end
function FromClient_EventActorUpdateTitleKey(actorKeyRaw)
  local actorProxyWrapper = getActor(actorKeyRaw)
  if nil == actorProxyWrapper then
    return
  end
  local panel = actorProxyWrapper:get():getUIPanel()
  if nil == panel then
    return
  end
  local insertedArray = Array.new()
  settingAlias(actorKeyRaw, panel, actorProxyWrapper)
  settingGuildMarkAndPreemptiveStrike(actorKeyRaw, panel, actorProxyWrapper)
  settingLifeRankIcon(actorKeyRaw, panel, actorProxyWrapper, insertedArray)
  settingGuildTextForAlias(actorKeyRaw, panel, actorProxyWrapper)
  settingLocalWarCombatPoint(actorKeyRaw, panel, actorProxyWrapper)
  settingHardCoreCharacterNameTag(actorKeyRaw, panel, actorProxyWrapper)
end
function FromClient_EventActorChangeGuildInfo_HaveLand(actorProxyWrapper, Panel, isoccupyTerritory)
  local targetPanel = Panel
  if nil == actorProxyWrapper or nil == isoccupyTerritory then
    return
  end
  local actorKeyRaw = actorProxyWrapper:get():getActorKeyRaw()
  settingGuildInfo(actorKeyRaw, targetPanel, actorProxyWrapper)
  settingEdanaInfo(actorKeyRaw, targetPanel, actorProxyWrapper)
  settingGuildMarkAndPreemptiveStrike(actorKeyRaw, targetPanel, actorProxyWrapper)
end
function EventActorPvpModeChange(actorKeyRaw)
  local actorProxyWrapper = getActor(actorKeyRaw)
  if nil == actorProxyWrapper then
    return
  end
  local panel = actorProxyWrapper:get():getUIPanel()
  if nil == panel then
    return
  end
  if actorProxyWrapper:get():isPlayer() then
    settingPreemptiveStrike(actorKeyRaw, panel, actorProxyWrapper)
  end
end
function EventActorChangeLevel(actorKeyRaw)
  local actorProxyWrapper = getActor(actorKeyRaw)
  if nil == actorProxyWrapper then
    return
  end
  local panel = actorProxyWrapper:get():getUIPanel()
  if nil == panel then
    return
  end
  if actorProxyWrapper:get():isMonster() then
    settingMonsterName(actorKeyRaw, panel, actorProxyWrapper)
  elseif actorProxyWrapper:get():isPlayer() then
    settingPlayerName(actorKeyRaw, panel, actorProxyWrapper)
  end
end
function EventChangeCharacterName(actorKeyRaw, characterName)
  local actorProxyWrapper = getActor(actorKeyRaw)
  if nil == actorProxyWrapper then
    return
  end
  local panel = actorProxyWrapper:get():getUIPanel()
  if nil == panel then
    return
  end
  if actorProxyWrapper:get():isReplayActor() then
    return
  end
  local insertedArray = Array.new()
  settingName(actorKeyRaw, panel, actorProxyWrapper)
  settingAlias(actorKeyRaw, panel, actorProxyWrapper)
  settingGuildMarkAndPreemptiveStrike(actorKeyRaw, panel, actorProxyWrapper)
  settingLifeRankIcon(actorKeyRaw, panel, actorProxyWrapper, insertedArray)
  if actorProxyWrapper:get():isPlayer() then
    settingPlayerName(actorKeyRaw, panel, actorProxyWrapper)
    settingLocalWarCombatPoint(actorKeyRaw, panel, actorProxyWrapper)
  end
end
function insertPartyMemberGage(actorKeyRaw)
  local actorProxyWrapper = getActor(actorKeyRaw)
  if nil == actorProxyWrapper then
    return
  end
  local panel = actorProxyWrapper:get():getUIPanel()
  if nil == panel then
    return
  end
  local function getInsertPartyMemberName()
    local name = ""
    local nameType = ToClient_getChatNameType()
    local playerActorProxyWrapper
    playerActorProxyWrapper = getPlayerActor(actorKeyRaw)
    if __eChatNameType_NickName == nameType and nil ~= playerActorProxyWrapper then
      name = playerActorProxyWrapper:getUserNickname()
    else
      name = actorProxyWrapper:getName()
    end
    return name
  end
  if getSelfPlayer():getActorKey() ~= actorKeyRaw then
    local textName = getInsertPartyMemberName()
    if 0 == ToClient_GetPartyType() then
      Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHARACTERNAMETAG_PARTY_ACK", "textName", textName))
    else
      Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHARACTERNAMETAG_LARGEPARTY_ACK", "textName", textName))
    end
  end
end
function removePartyMemberGage(actorKeyRaw)
  local actorProxyWrapper = getActor(actorKeyRaw)
  if nil == actorProxyWrapper then
    return
  end
  local panel = actorProxyWrapper:get():getUIPanel()
  if nil == panel then
    return
  end
  if actorProxyWrapper:IsNeedHideNameForPVPServer() == true then
    settingAlias(actorKeyRaw, panel, actorProxyWrapper)
    settingTitle(actorKeyRaw, panel, actorProxyWrapper)
    settingGuildInfo(actorKeyRaw, panel, actorProxyWrapper)
    settingEdanaInfo(actorKeyRaw, panel, actorProxyWrapper)
    settingPlayerName(actorKeyRaw, panel, actorProxyWrapper)
  end
end
function EventShowProgressBar(actorKeyRaw, aHideTimeType)
  local actorProxyWrapper = getActor(actorKeyRaw)
  if nil == actorProxyWrapper then
    return
  end
  if hideTimeType.preemptiveStrike == aHideTimeType then
    local panel = actorProxyWrapper:get():getUIPanel()
    if nil == panel then
      return
    end
    settingPreemptiveStrike(actorKeyRaw, panel, actorProxyWrapper)
  elseif hideTimeType.murdererEnd == aHideTimeType then
    local panel = actorProxyWrapper:get():getUIPanel()
    if nil == panel then
      return
    end
    settingMurderer(actorKeyRaw, panel, actorProxyWrapper, true)
  end
end
function EventHideProgressBar(actorKeyRaw, aHideTimeType, panel)
  if panel == nil then
    return
  end
  local actorProxyWrapper = getActor(actorKeyRaw)
  if nil == actorProxyWrapper then
    return
  end
  if hideTimeType.preemptiveStrike == aHideTimeType then
    settingPreemptiveStrike(actorKeyRaw, panel, actorProxyWrapper)
  elseif hideTimeType.murdererEnd == aHideTimeType then
    settingMurderer(actorKeyRaw, panel, actorProxyWrapper, true)
  end
end
function update_Changed_StunGage(actorKeyRaw, curStun, maxStun)
  local actorProxyWrapper = getActor(actorKeyRaw)
  if nil == actorProxyWrapper then
    return
  end
  local actorProxy = actorProxyWrapper:get()
  if false == (actorProxy:isMonster() or actorProxy:isPlayer()) then
    return
  end
  local panel = actorProxyWrapper:get():getUIPanel()
  if nil == panel then
    return
  end
  settingStun(actorKeyRaw, panel, actorProxyWrapper)
end
function EventActor_QuestUpdateInserted(actorKeyRaw)
  local actorProxyWrapper = getActor(actorKeyRaw)
  if nil == actorProxyWrapper then
    return
  end
  local panel = actorProxyWrapper:get():getUIPanel()
  if nil == panel then
    return
  end
  settingQuestMarkForce(true, panel, actorProxyWrapper)
end
function EventActor_QuestUpdateDeleted(actorKeyRaw)
  local actorProxyWrapper = getActor(actorKeyRaw)
  if nil == actorProxyWrapper then
    return
  end
  local panel = actorProxyWrapper:get():getUIPanel()
  if nil == panel then
    return
  end
  settingQuestMarkForce(false, panel, actorProxyWrapper)
end
function FromClient_preemptiveStrikeTimeChanged(targetActorKeyRaw)
  ActorInsertShowTime(attackerActorKey, hideTimeType.preemptiveStrike, 0)
end
function EventActor_QuestUI_UpdateData(actorKeyRaw)
  local actorProxyWrapper = getActor(actorKeyRaw)
  if nil == actorProxyWrapper then
    return
  end
  local panel = actorProxyWrapper:get():getUIPanel()
  if nil == panel then
    return
  end
  local insertedArray = Array.new()
  settingQuestUI(actorKeyRaw, panel, actorProxyWrapper, insertedArray)
  settingFirstTalk(actorKeyRaw, panel, actorProxyWrapper, insertedArray)
  settingImportantTalk(actorKeyRaw, panel, actorProxyWrapper, insertedArray)
  settingOtherHeadIcon(actorKeyRaw, panel, actorProxyWrapper, insertedArray)
  sortCenterX(insertedArray)
end
function EventActor_EnduranceUpdate(actorKeyRaw)
  local actorProxyWrapper = getActor(actorKeyRaw)
  if nil == actorProxyWrapper then
    return
  end
  local panel = actorProxyWrapper:get():getUIPanel()
  if nil == panel then
    return
  end
  if true == _ContentsGroup_MassLeftToNormalManufacture then
    Furniture_Check(actorKeyRaw)
  end
end
function EventSelfPlayerWaitCommentLaunch()
  if nil == getSelfPlayer():get():getWaitCommentPanel() then
    return
  end
  settingWaitCommentLaunch(true)
  getSelfPlayer():get():showWaitComment()
end
function EventSelfPlayerWaitCommentClose()
  if nil == getSelfPlayer():get():getWaitCommentPanel() then
    return
  end
  ClearFocusEdit()
  settingWaitCommentLaunch(false)
  getSelfPlayer():get():hideWaitComment()
end
function EventOtherPlayerWaitCommentUpdate(actorKeyRaw)
  local actorProxyWrapper = getActor(actorKeyRaw)
  if nil == actorProxyWrapper then
    return
  end
  local panel = actorProxyWrapper:get():getUIPanel()
  if nil == panel then
    return
  end
  settingWaitComment(actorKeyRaw, panel, actorProxyWrapper, true)
end
function EventOtherPlayerWaitCommentClose(actorKeyRaw)
  local actorProxyWrapper = getActor(actorKeyRaw)
  if nil == actorProxyWrapper then
    return
  end
  local panel = actorProxyWrapper:get():getUIPanel()
  if nil == panel then
    return
  end
  settingWaitComment(actorKeyRaw, panel, actorProxyWrapper, false)
end
function FromClient_UpdateGuildColor(actorKeyRaw)
  local actorProxyWrapper = getActor(actorKeyRaw)
  if actorProxyWrapper == nil then
    return
  end
  local panel = actorProxyWrapper:get():getUIPanel()
  if panel == nil then
    return
  end
  settingName(actorKeyRaw, panel, actorProxyWrapper)
  settingAlias(actorKeyRaw, panel, actorProxyWrapper)
  settingTitle(actorKeyRaw, panel, actorProxyWrapper)
  settingGuildInfo(actorKeyRaw, panel, actorProxyWrapper)
  settingEdanaInfo(actorKeyRaw, panel, actorProxyWrapper)
  settingPlayerName(actorKeyRaw, panel, actorProxyWrapper)
  settingGuildTextForAlias(actorKeyRaw, panel, actorProxyWrapper)
end
function FromClient_OverHeadUIShowChanged(actorKeyRaw, panel, actorProxyWrapper, isShow)
end
function FromClient_GuildMemberGradeChanged(actorKeyRaw, panel, actorProxyWrapper, guildGrade)
  settingGuildInfo(actorKeyRaw, panel, actorProxyWrapper)
  settingEdanaInfo(actorKeyRaw, panel, actorProxyWrapper)
  settingGuildMarkAndPreemptiveStrike(actorKeyRaw, panel, actorProxyWrapper)
end
function EventPlayerNicknameUpdate(actorKeyRaw)
  local actorProxyWrapper = getActor(actorKeyRaw)
  if nil == actorProxyWrapper then
    return
  end
  local panel = actorProxyWrapper:get():getUIPanel()
  if nil == panel then
    return
  end
  if true == actorProxyWrapper:get():isReplayActor() then
    return
  end
  settingTitle(actorKeyRaw, panel, actorProxyWrapper)
end
function FromClient_ActorInformationChanged(actorKeyRaw, panel, actorProxyWrapper)
  if nil == panel then
    return
  end
  if nil == actorProxyWrapper then
    return
  end
  settingName(actorKeyRaw, panel, actorProxyWrapper)
end
function FromClient_NotifyChangeGuildTendency(actorKeyRaw, panel, actorProxyWrapper)
  if nil == panel then
    return
  end
  if nil == actorProxyWrapper then
    return
  end
  settingGuildInfo(actorKeyRaw, panel, actorProxyWrapper)
  settingEdanaInfo(actorKeyRaw, panel, actorProxyWrapper)
  settingGuildMarkAndPreemptiveStrike(actorKeyRaw, panel, actorProxyWrapper)
end
function FromClient_RedBattleFieldCombatPoint(actorkeyRaw)
  if nil == actorkeyRaw then
    return
  end
  local playerActorWrapper = getPlayerActor(actorkeyRaw)
  if nil == playerActorWrapper then
    return
  end
  local panel = playerActorWrapper:get():getUIPanel()
  if nil == panel then
    return
  end
  settingLocalWarCombatPoint(actorkeyRaw, panel, playerActorWrapper)
end
function FromClient_EntryTeamChanged(actorkeyRaw)
  if nil == actorkeyRaw then
    return
  end
  local playerActorWrapper = getPlayerActor(actorkeyRaw)
  if nil == playerActorWrapper then
    return
  end
  local panel = playerActorWrapper:get():getUIPanel()
  if nil == panel then
    return
  end
  settingLocalWarCombatPoint(actorkeyRaw, panel, playerActorWrapper)
end
function FromClient_ObjectInstanceMpChanged(isMpShow, targetPanel, mpRate)
  if nil == targetPanel then
    return
  end
  local progressGroup = UI.getChildControl(targetPanel, "Static_Progress_Group")
  if nil == progressGroup then
    return
  end
  local mpBack = UI.getChildControl(progressGroup, "ProgressBack_ManaResource")
  local mpMain = UI.getChildControl(progressGroup, "Character_ManaResource")
  if nil == mpBack or nil == mpMain then
    return
  end
  mpBack:SetShow(isMpShow)
  mpMain:SetShow(isMpShow)
  if true == isMpShow then
    mpMain:SetProgressRate(mpRate)
    mpMain:SetCurrentProgressRate(mpRate)
    mpMain:SetColor(Defines.Color.C_FFA3EF00)
  end
end
function FromClient_FlashBangStateChanged(actorKeyRaw, isFlashBangOn)
  if nil == actorKeyRaw then
    return
  end
  local actorProxyWrapper = getActor(actorKeyRaw)
  if nil == actorProxyWrapper then
    return
  end
  local panel = actorProxyWrapper:get():getUIPanel()
  if nil == panel then
    return
  end
  local insertedArray = Array.new()
  settingName(actorKeyRaw, panel, actorProxyWrapper)
  settingAlias(actorKeyRaw, panel, actorProxyWrapper)
  settingGuildInfo(actorKeyRaw, panel, actorProxyWrapper)
  settingEdanaInfo(actorKeyRaw, panel, actorProxyWrapper)
  settingGuildMarkAndPreemptiveStrike(actorKeyRaw, panel, actorProxyWrapper)
  settingLifeRankIcon(actorKeyRaw, panel, actorProxyWrapper, insertedArray)
  if actorProxyWrapper:get():isPlayer() then
    settingPlayerName(actorKeyRaw, panel, actorProxyWrapper)
    settingLocalWarCombatPoint(actorKeyRaw, panel, actorProxyWrapper)
  end
  settingTitle(actorKeyRaw, panel, actorProxyWrapper)
end
function FromClient_ShowOverheadRank(actorKeyRaw)
  if nil == actorKeyRaw then
    return
  end
  local actorProxyWrapper = getActor(actorKeyRaw)
  if nil == actorProxyWrapper then
    return
  end
  local panel = actorProxyWrapper:get():getUIPanel()
  if nil == panel then
    return
  end
  local insertedArray = Array.new()
  settingLifeRankIcon(actorKeyRaw, panel, actorProxyWrapper, insertedArray)
  isOptionChange = true
end
function FromClient_CharacterNameTag_PlayMusic_Start()
  local actorProxyWrapper = getSelfPlayer()
  if nil == actorProxyWrapper then
    return
  end
  local panel = actorProxyWrapper:get():getUIPanel()
  if nil == panel then
    return
  end
  local childCount = panel:getChildControlCount()
  for childIdx = 0, childCount - 1 do
    local childGroup = UI.getChildControlByIndex(panel, childIdx)
    local childGroupCount = childGroup:getChildControlCount()
    for childGroupIdx = 0, childGroupCount - 1 do
      local child = UI.getChildControlByIndex(childGroup, childGroupIdx)
      child:SetShow(false)
    end
  end
  local nameTagGroup = UI.getChildControl(panel, "Static_NameTag_Group")
  if nil == nameTagGroup then
    return
  end
  local musicIcon = UI.getChildControl(nameTagGroup, "Button_PlayState")
  musicIcon:SetShow(true)
  isPlayMusic = true
end
function FromClient_CharacterNameTag_PlayMusic_Stop()
  local selfActorProxyWrapper = getSelfPlayer()
  if nil == selfActorProxyWrapper then
    return
  end
  local panel = selfActorProxyWrapper:get():getUIPanel()
  if nil == panel then
    return
  end
  local nameTagGroup = UI.getChildControl(panel, "Static_NameTag_Group")
  if nil == nameTagGroup then
    return
  end
  local musicIcon = UI.getChildControl(nameTagGroup, "Button_PlayState")
  musicIcon:SetShow(false)
  isPlayMusic = false
  if _ContentsGroup_NameTag_Optimization == true then
    ToClient_UpdateActorOveHeadUI(selfActorProxyWrapper:get():getActorKeyRaw())
  else
    TypeByLoadData[__eActorProxyTypeForNameTag_isSelfPlayer](selfActorProxyWrapper:get():getActorKeyRaw(), panel, selfActorProxyWrapper)
  end
end
function PaGlobalFunc_CharacterNameTag_BattleFieldNameTagVisibleSet(value)
  local selfActorProxyWrapper = getSelfPlayer()
  if nil == selfActorProxyWrapper then
    return
  end
  if nil ~= value then
    PaGlobal_CharacterNameTag_All._isOffNameTagInBattleField = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eBattleFieldNameShow)
  end
  local myTeamLocalWar = ToClient_GetMyTeamNoRedBattleField()
  if 0 == myTeamLocalWar then
    return
  end
  local selfActorProxyWrapper = getSelfPlayer()
  if nil == selfActorProxyWrapper then
    return
  end
  local panel = selfActorProxyWrapper:get():getUIPanel()
  if nil == panel then
    return
  end
  if _ContentsGroup_NameTag_Optimization == true then
    ToClient_UpdateActorOveHeadUI(selfActorProxyWrapper:get():getActorKeyRaw())
  else
    TypeByLoadData[__eActorProxyTypeForNameTag_isSelfPlayer](selfActorProxyWrapper:get():getActorKeyRaw(), panel, selfActorProxyWrapper)
  end
end
function FromClient_ChracterNameTag_JoinLocalWar(teamNo)
  if nil == teamNo then
    return
  end
  if 1 ~= teamNo and 2 ~= teamNo then
    return
  end
  PaGlobal_CharacterNameTag_All._isInLocalWar = true
  local instanceMapKey = ToClient_GetCurrentInstanceFieldMapKey()
  local isPapuCrio = __eInstanceRedBattleField_PapuCrio == instanceMapKey
  if true == PaGlobal_CharacterNameTag_All._isOffNameTagInBattleField or true == isPapuCrio then
    PaGlobalFunc_CharacterNameTag_BattleFieldNameTagVisibleSet()
  end
end
function FromClient_ChracterNameTag_UnJoinLocalWar()
  PaGlobal_CharacterNameTag_All._isInLocalWar = false
end
function FromClient_ChangeNameTagScaleForReplay(actorProxyWrapper, panel)
  if nil == actorProxyWrapper or nil == panel then
    return
  end
  settingReplayPlayerNameTagPos(actorProxyWrapper, panel)
end
function FromClient_CharacterNameTag_RideOn()
  if ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_RedBattleField) == false then
    return
  end
  local instanceMapKey = ToClient_GetCurrentInstanceFieldMapKey()
  local isPapuCrio = instanceMapKey == __eInstanceRedBattleField_PapuCrio
  if isPapuCrio == false then
    return
  end
  PaGlobalFunc_CharacterNameTag_BattleFieldNameTagVisibleSet()
end
function PaGloabalFunc_MakeReplayPlayerRankingString(classRanking, rankRating, showOutOfRanking)
  local classRankingStr
  if classRanking == -1 then
    if showOutOfRanking == true then
      classRankingStr = PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_REPLAYLIST_OUTOFRANK_OTHERSERVICE")
    else
      classRankingStr = ""
    end
  else
    classRankingStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SOLARE_REPLAYLIST_RANKING_OTHERSERVICE", "rank", tostring(classRanking))
  end
  local rankRatingStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SOLARE_REPLAYLIST_RANKRATING_OTHERSERVICE", "rating", tostring(rankRating))
  local textName = classRankingStr .. "(" .. rankRatingStr .. ")"
  return textName
end
function FromClient_CharacterNAmeTag_QuestBackEndLoadComplete(s32_questNoRaw)
  if _ContentsGroup_QuestBackEndLoading == false then
    return
  end
  if PaGlobal_CharacterNameTag_All:isExistLoadingDataAnyOne() == false then
    return
  end
  local param_0, param_1, param_2, param_3
  for index = 1, #PaGlobal_CharacterNameTag_All._questLoadingDataList do
    local value = PaGlobal_CharacterNameTag_All._questLoadingDataList[index]
    if value ~= nil and value._questNoRaw == s32_questNoRaw then
      needUpdate = true
      param_0 = value._param_0
      param_1 = value._param_1
      param_2 = value._param_2
      param_3 = value._param_3
      table.remove(PaGlobal_CharacterNameTag_All._questLoadingDataList, index)
      break
    end
  end
  if needUpdate == true then
    settingQuestUI(param_0, param_1, param_2, param_3)
    return
  end
  return
end
function FromClient_RoseWarStateChanged(actorKeyRaw)
  local actorProxyWrapper = getActor(actorKeyRaw)
  if actorProxyWrapper == nil then
    return
  end
  local panel = actorProxyWrapper:get():getUIPanel()
  if panel == nil then
    return
  end
  local actorProxy = actorProxyWrapper:get()
  if actorProxy == nil then
    return
  end
  if actorProxy:isSelfPlayer() == true then
    if TypeByLoadData[__eActorProxyTypeForNameTag_isSelfPlayer] ~= nil then
      TypeByLoadData[__eActorProxyTypeForNameTag_isSelfPlayer](actorKeyRaw, panel, actorProxyWrapper)
    end
  elseif actorProxy:isPlayer() == true and TypeByLoadData[__eActorProxyTypeForNameTag_isOtherPlayer] ~= nil then
    TypeByLoadData[__eActorProxyTypeForNameTag_isOtherPlayer](actorKeyRaw, panel, actorProxyWrapper, actorProxyWrapper:get():isSubPlayer() == true)
  end
end
function FromClient_UpdateGuildMatchTeamInfo(actorKeyRaw)
  local actorProxyWrapper = getActor(actorKeyRaw)
  if actorProxyWrapper == nil then
    return
  end
  local panel = actorProxyWrapper:get():getUIPanel()
  if panel == nil then
    return
  end
  local actorProxy = actorProxyWrapper:get()
  if actorProxy == nil then
    return
  end
  if actorProxy:isSelfPlayer() == true then
    if TypeByLoadData[__eActorProxyTypeForNameTag_isSelfPlayer] ~= nil then
      TypeByLoadData[__eActorProxyTypeForNameTag_isSelfPlayer](actorKeyRaw, panel, actorProxyWrapper)
    end
  elseif actorProxy:isPlayer() == true and TypeByLoadData[__eActorProxyTypeForNameTag_isOtherPlayer] ~= nil then
    TypeByLoadData[__eActorProxyTypeForNameTag_isOtherPlayer](actorKeyRaw, panel, actorProxyWrapper, actorProxyWrapper:get():isSubPlayer() == true)
  end
end
function FromClient_NotifyPlayerCCStart(actorKeyRaw, ccType)
  local actorProxyWrapper = getActor(actorKeyRaw)
  if actorProxyWrapper == nil then
    return
  end
  local actorProxy = actorProxyWrapper:get()
  if actorProxy == nil then
    return
  end
  local panel = actorProxy:getUIPanel()
  if panel == nil then
    return
  end
  local progressGroup = UI.getChildControl(panel, "Static_Progress_Group")
  if progressGroup == nil then
    return
  end
  local stc_CC = UI.getChildControl(progressGroup, "Static_CC_Template")
  if stc_CC == nil then
    return
  end
  stc_CC:ChangeTextureInfoTextureIDAsync(ActionChartCCStartAction[ccType])
  stc_CC:setRenderTexture(stc_CC:getBaseTexture())
  stc_CC:ResetVertexAni()
  stc_CC:SetShow(true)
end
function FromClient_NotifyPlayerCCEnd(actorKeyRaw)
  local actorProxyWrapper = getActor(actorKeyRaw)
  if actorProxyWrapper == nil then
    return
  end
  local actorProxy = actorProxyWrapper:get()
  if actorProxy == nil then
    return
  end
  local panel = actorProxy:getUIPanel()
  if panel == nil then
    return
  end
  local progressGroup = UI.getChildControl(panel, "Static_Progress_Group")
  if progressGroup == nil then
    return
  end
  local stc_CC = UI.getChildControl(progressGroup, "Static_CC_Template")
  if stc_CC == nil then
    return
  end
  stc_CC:SetShow(false)
end
function FromClient_HardCoreCharacterInfoChanged(actorKeyRaw)
  local actorProxyWrapper = getActor(actorKeyRaw)
  if actorProxyWrapper == nil then
    return
  end
  local panel = actorProxyWrapper:get():getUIPanel()
  if panel == nil then
    return
  end
  local actorProxy = actorProxyWrapper:get()
  if actorProxy == nil then
    return
  end
  if actorProxy:isSelfPlayer() == true then
    if TypeByLoadData[__eActorProxyTypeForNameTag_isSelfPlayer] ~= nil then
      TypeByLoadData[__eActorProxyTypeForNameTag_isSelfPlayer](actorKeyRaw, panel, actorProxyWrapper)
    end
  elseif actorProxy:isPlayer() == true and TypeByLoadData[__eActorProxyTypeForNameTag_isOtherPlayer] ~= nil then
    TypeByLoadData[__eActorProxyTypeForNameTag_isOtherPlayer](actorKeyRaw, panel, actorProxyWrapper, actorProxyWrapper:get():isSubPlayer() == true)
  end
  settingHardCoreCharacterNameTag(actorKeyRaw, panel, actorProxyWrapper)
end
function FromClient_HardCoreCharacterAllyChanged(actorKeyRaw)
  local actorProxyWrapper = getActor(actorKeyRaw)
  if nil == actorProxyWrapper then
    return
  end
  local panel = actorProxyWrapper:get():getUIPanel()
  if nil == panel then
    return
  end
  local actorProxy = actorProxyWrapper:get()
  if false == actorProxy:isPlayer() then
    return
  end
  settingPlayerName(actorKeyRaw, panel, actorProxyWrapper)
end
function FromClient_PlayerNameTagReload(actorKeyRaw)
  local actorProxyWrapper = getActor(actorKeyRaw)
  if actorProxyWrapper == nil then
    return
  end
  local panel = actorProxyWrapper:get():getUIPanel()
  if panel == nil then
    return
  end
  local actorProxy = actorProxyWrapper:get()
  if actorProxy == nil then
    return
  end
  if actorProxy:isSelfPlayer() == true then
    if TypeByLoadData[__eActorProxyTypeForNameTag_isSelfPlayer] ~= nil then
      TypeByLoadData[__eActorProxyTypeForNameTag_isSelfPlayer](actorKeyRaw, panel, actorProxyWrapper)
    end
  elseif actorProxy:isPlayer() == true and TypeByLoadData[__eActorProxyTypeForNameTag_isOtherPlayer] ~= nil then
    TypeByLoadData[__eActorProxyTypeForNameTag_isOtherPlayer](actorKeyRaw, panel, actorProxyWrapper, actorProxyWrapper:get():isSubPlayer() == true)
  end
end
registerEvent("FromClient_PlayMusic_Stop", "FromClient_CharacterNameTag_PlayMusic_Stop")
registerEvent("FromClient_PlayMusic_Start", "FromClient_CharacterNameTag_PlayMusic_Start")
registerEvent("EventSelfPlayerRideOn", "FromClient_CharacterNameTag_RideOn")
registerEvent("EventActorCreated", "EventActorCreated_NameTag")
registerEvent("FromClient_TendencyChanged", "FromClient_NameTag_TendencyChanged")
registerEvent("EventFirstTalk", "EventActorFirsttalk")
registerEvent("EventImportantTalk", "EventActorImportantTalk")
registerEvent("EventChangeGuildInfo", "EventActorChangeGuildInfo")
registerEvent("EventMonsterLevelColorChanged", "EventActorChangeLevel")
registerEvent("EventPlayerPvPAbleChanged", "EventActorChangeLevel")
registerEvent("EventChangeCharacterName", "EventChangeCharacterName")
registerEvent("ResponseParty_insert", "insertPartyMemberGage")
registerEvent("ResponseParty_RemovePatyNameTag", "removePartyMemberGage")
registerEvent("EventShowProgressBar", "EventShowProgressBar")
registerEvent("EventHideProgressBar", "EventHideProgressBar")
registerEvent("EventQuestTargetActorInserted", "EventActor_QuestUpdateInserted")
registerEvent("EventQuestTargetActorDeleted", "EventActor_QuestUpdateDeleted")
registerEvent("FromClient_preemptiveStrikeTimeChanged", "FromClient_preemptiveStrikeTimeChanged")
registerEvent("EventQuestUpdate", "EventActor_QuestUI_UpdateData")
registerEvent("EventHousingUpdateInstallationEndurance", "EventActor_EnduranceUpdate")
registerEvent("EventSelfPlayerWaitCommentUpdate", "EventSelfPlayerWaitCommentLaunch")
registerEvent("EventSelfPlayerWaitCommentClose", "EventSelfPlayerWaitCommentClose")
registerEvent("EventOtherPlayerWaitCommentUpdate", "EventOtherPlayerWaitCommentUpdate")
registerEvent("EventOtherPlayerWaitCommentClose", "EventOtherPlayerWaitCommentClose")
registerEvent("FromClient_GuildMemberGradeChanged", "FromClient_GuildMemberGradeChanged")
registerEvent("EventPlayerNicknameUpdate", "EventPlayerNicknameUpdate")
registerEvent("FromClient_ActorInformationChanged", "FromClient_ActorInformationChanged")
registerEvent("FromClient_NotifyChangeGuildTendency", "FromClient_NotifyChangeGuildTendency")
registerEvent("FromClient_ChangeOccupyTerritoryState", "FromClient_EventActorChangeGuildInfo_HaveLand")
registerEvent("FromClient_ChangeTopRankUser", "FromClient_ChangeTopRankUser")
registerEvent("FromClient_EventActorUpdateTitleKey", "FromClient_EventActorUpdateTitleKey")
registerEvent("FromClient_RedBattleFieldCombatPoint", "FromClient_RedBattleFieldCombatPoint")
registerEvent("FromClient_EntryTeamChanged", "FromClient_EntryTeamChanged")
registerEvent("FromClient_FlashBangStateChanged", "FromClient_FlashBangStateChanged")
registerEvent("FromClient_JoinRedBattleField", "FromClient_ChracterNameTag_JoinLocalWar")
registerEvent("FromClient_UnJoinRedBattleField", "FromClient_ChracterNameTag_UnJoinLocalWar")
registerEvent("EventPvPModeChanged", "EventActorPvpModeChange")
registerEvent("FromClient_ObjectInstanceMpChanged", "FromClient_ObjectInstanceMpChanged")
registerEvent("FromClient_ShowOverheadRank", "FromClient_ShowOverheadRank")
registerEvent("FromClient_ChangeNameTagScaleForReplay", "FromClient_ChangeNameTagScaleForReplay")
registerEvent("FromClient_UpdateGuildColor", "FromClient_UpdateGuildColor")
if _ContentsGroup_QuestBackEndLoading == true then
  registerEvent("FromClient_QuestBackEndLoadComplete", "FromClient_CharacterNAmeTag_QuestBackEndLoadComplete")
end
registerEvent("FromClient_RoseWarStateChanged", "FromClient_RoseWarStateChanged")
registerEvent("FromClient_UpdateGuildMatchTeamInfo", "FromClient_UpdateGuildMatchTeamInfo")
registerEvent("FromClient_NotifyPlayerCCStart", "FromClient_NotifyPlayerCCStart")
registerEvent("FromClient_NotifyPlayerCCEnd", "FromClient_NotifyPlayerCCEnd")
registerEvent("FromClient_HardCoreCharacterInfoChanged", "FromClient_HardCoreCharacterInfoChanged")
registerEvent("FromClient_HardCoreCharacterAllyChanged", "FromClient_HardCoreCharacterAllyChanged")
registerEvent("FromClient_PlayerNameTagReload", "FromClient_PlayerNameTagReload")
