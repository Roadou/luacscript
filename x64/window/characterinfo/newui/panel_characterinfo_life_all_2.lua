function PaGlobalFunc_CharInfoLife_All_Update()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._life) then
    return
  end
  PaGlobal_CharInfoLife_All:update()
end
function HandleEventOnOut_CharInfoLife_All_LifeType_Area(isOn, lifeType)
  if PaGlobal_CharInfoLife_All._isConsole == false then
    return
  end
  if isOn == true then
    if lifeType == CppEnums.LifeExperienceType.gather and PaGlobal_CharInfoLife_All._ui.btn_collectMiniGameOnOff:GetShow() == true then
      PaGlobal_CharInfoLife_All._ui.stc_KeyGuide_A:SetShow(true)
    else
      PaGlobal_CharInfoLife_All._ui.stc_KeyGuide_A:SetShow(false)
    end
  else
    PaGlobal_CharInfoLife_All._ui.stc_KeyGuide_A:SetShow(false)
  end
  PaGlobal_CharInfoLife_All:updateKeyguides()
end
function HandleEventOnOut_CharInfoLife_All_LifeType_Tooltip(isShow, lifeType, subType, isOnlyConsole)
  if isShow == false and PaGlobal_CharInfoLife_All._isConsole == true then
    HandleEventOnOut_CharInfoLife_All_LifeType_Area(false, lifeType)
  end
  if nil == isOnlyConsole and isShow == false then
    TooltipSimple_Hide()
    return
  end
  if false == isOnlyConsole and (false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._life) or false == isShow or nil == lifeType) then
    TooltipSimple_Hide()
    return
  end
  local eLIFE = CppEnums.LifeExperienceType
  local name, desc, control
  if true == isShow then
    if lifeType == eLIFE.gather then
      if nil ~= subType and -1 ~= subType then
        if nil ~= PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._subLifeType then
          local characterCollectRate = ToClient_getSelfPlayerCollectRate(subType)
          local count = ToClient_LoadCollectingStatData(subType)
          local tempString = {}
          for ii = 0, count - 2 do
            local dropRate = ToClient_getCollectingStatAddDropRate(ii)
            local dropCountRate = ToClient_getCollectingStatAddDropCountRate(ii)
            local dropRateStr = PaGlobalFunc_GlobalUtil_RoundRateToSecondPoint(dropRate)
            local dropCountRateStr = PaGlobalFunc_GlobalUtil_RoundRateToSecondPoint(dropCountRate)
            local stringFormatKey = string.format("LUA_COLLECTING_POWER_DESC_%d", ii + 1)
            tempString[ii] = PAGetStringParam2(Defines.StringSheet_GAME, stringFormatKey, "rate1", tostring(dropRateStr), "rate2", tostring(dropCountRateStr))
          end
          local characterCollectRateStr = PaGlobalFunc_GlobalUtil_RoundRateToSecondPoint(characterCollectRate)
          local subStringName = string.format("LUA_COLLECTING_POWER_DESC_SUB_%d", subType)
          desc = string.format([[
%s
%s%s%s
%s

%s]], PAGetString(Defines.StringSheet_GAME, "LUA_COLLECTING_POWER_DESC_MAIN"), tempString[0], tempString[1], tempString[2], PAGetStringParam1(Defines.StringSheet_GAME, "LUA_COLLECTING_POWER_DESC_4", "charRate", tostring(characterCollectRateStr)), PAGetString(Defines.StringSheet_GAME, tostring(subStringName)))
          local subTypeUI = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._subLifeType[subType]
          name = subTypeUI._subtitle:GetText()
          control = subTypeUI._subtitle
        end
      else
        local addDesc = ""
        if _ContentsGroup_MorningLand == true then
          if ToClient_IsLearnedKnowledge(PaGlobal_CharInfoLife_All._miniGameMentalCardKey) == true then
            local flagStr = PAGetString(Defines.StringSheet_GAME, "LUA_CHARINFO_LIFETAB_MINIGAME_TOOLTIP_CHECKON")
            if PaGlobal_CharInfoLife_All._ui.btn_collectMiniGameOnOff:IsCheck() == false then
              flagStr = PAGetString(Defines.StringSheet_GAME, "LUA_CHARINFO_LIFETAB_MINIGAME_TOOLTIP_CHECKOFF")
            end
            addDesc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHARINFO_LIFETAB_MINIGAME_TOOLTIP_2", "flag", flagStr)
          else
            addDesc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARINFO_LIFETAB_MINIGAME_TOOLTIP_1")
          end
        end
        name = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._title:GetText()
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFT_DESC_1") .. PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFT_SUBDESC") .. [[


]] .. addDesc
        control = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._parent
      end
    elseif lifeType == eLIFE.fishing then
      local fishingStatStaticStatus = ToClient_getFishingStatStaticStatus()
      local addRate = 0
      if nil ~= fishingStatStaticStatus then
        addRate = PaGlobalFunc_GlobalUtil_RoundRateToSecondPoint(fishingStatStaticStatus._rate)
      end
      desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE_FISHINGSTAT_DESC", "rate", tostring(addRate))
      name = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._title:GetText()
      control = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._parent
    elseif lifeType == eLIFE.hunting then
      local dropRate = ToClient_getHuntingRate()
      local dropRateStr = PaGlobalFunc_GlobalUtil_RoundRateToSecondPoint(dropRate)
      desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE_HUNTING_DESC", "rate", tostring(dropRateStr))
      name = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._title:GetText()
      control = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._parent
    elseif lifeType == eLIFE.cooking then
      local cookingStatStaticStatus = ToClient_getCookingStatStaticStatus()
      local speedCookRate = 0
      local basicMaxDropRate = 0
      local addCriticalDropRate = 0
      local addCriticalMaxDropRate = 0
      local addRoyalTradeBonus = 0
      if nil ~= cookingStatStaticStatus then
        speedCookRate = PaGlobalFunc_GlobalUtil_RoundRateToSecondPoint(cookingStatStaticStatus._speedCookRate)
        basicMaxDropRate = PaGlobalFunc_GlobalUtil_RoundRateToSecondPoint(cookingStatStaticStatus._basicMaxDropRate)
        addCriticalDropRate = PaGlobalFunc_GlobalUtil_RoundRateToSecondPoint(cookingStatStaticStatus._addCriticalDropRate)
        addCriticalMaxDropRate = PaGlobalFunc_GlobalUtil_RoundRateToSecondPoint(cookingStatStaticStatus._addCriticalMaxDropRate)
        addRoyalTradeBonus = PaGlobalFunc_GlobalUtil_RoundRateToSecondPoint(cookingStatStaticStatus._addRoyalTradeBonus)
      end
      desc = string.format("%s%s", PAGetStringParam4(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE_COOK_DESC_1", "rate1", tostring(speedCookRate), "rate2", tostring(basicMaxDropRate), "rate3", tostring(addCriticalDropRate), "rate4", tostring(addCriticalMaxDropRate)), PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE_COOK_DESC_2", "rate1", tostring(addRoyalTradeBonus)))
      name = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._title:GetText()
      control = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._parent
    elseif lifeType == eLIFE.alchemy then
      local alchemySSW = ToClient_getAlchemyStatStaticStatus()
      if nil == alchemySSW then
        local tempdesc1 = PAGetStringParam4(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE_ALCHEMY_DESC_1", "rate1", 0, "rate2", 0, "rate3", 0, "rate4", 0)
        local tempdesc2 = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE_ALCHEMY_DESC_2", "rate1", 0)
        desc = string.format([[
%s
%s]], tempdesc1, tempdesc2)
      else
        local rate1 = PaGlobalFunc_GlobalUtil_RoundRateToSecondPoint(alchemySSW._basicMaxDropRate)
        local eventDropRate = alchemySSW._eventDropRate / 1000000
        local dropRate1 = alchemySSW:getEventDropRateForTooltip(0) / 1000000
        local dropRate2 = alchemySSW:getEventDropRateForTooltip(1) / 1000000
        local dropRate3 = alchemySSW:getEventDropRateForTooltip(2) / 1000000
        local basicRate = eventDropRate * (1 - dropRate3) * (1 - dropRate2)
        local specialRate = eventDropRate * (1 - dropRate3) * dropRate2
        local uniqueRate = eventDropRate * dropRate3
        local tempdesc1 = PAGetStringParam4(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE_ALCHEMY_DESC_1", "rate1", rate1, "rate2", PaGlobalFunc_GlobalUtil_RoundRateToThridPoint(basicRate * 1000000), "rate3", PaGlobalFunc_GlobalUtil_RoundRateToThridPoint(specialRate * 1000000), "rate4", PaGlobalFunc_GlobalUtil_RoundRateToThridPoint(uniqueRate * 1000000))
        local royalBonus = PaGlobalFunc_GlobalUtil_RoundRateToSecondPoint(alchemySSW._addRoyalTradeBonus)
        local tempdesc2 = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE_ALCHEMY_DESC_2", "rate1", royalBonus)
        desc = string.format([[
%s
%s]], tempdesc1, tempdesc2)
      end
      name = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._title:GetText()
      control = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._parent
    elseif lifeType == eLIFE.manufacture then
      if nil ~= subType and -1 ~= subType then
        if nil ~= PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._subLifeType then
          local countRate = ToClient_getManufacturingStatCountRate(subType)
          desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MANUFACTURING_POWER_TOOLTIP_DESC", "data2", tostring(countRate))
          local subTypeUI = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._subLifeType[subType]
          name = subTypeUI._subtitle:GetText()
          control = subTypeUI._subtitle
        end
      else
        name = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._title:GetText()
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFT_DESC_2") .. PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFT_SUBDESC")
        control = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._parent
      end
    elseif lifeType == eLIFE.training then
      local trainingStatStaticStatus = ToClient_getTrainingStatStaticStatus()
      local captureRate = 0
      local expRate = 0
      local matingRate = 0
      if nil ~= trainingStatStaticStatus then
        captureRate = PaGlobalFunc_GlobalUtil_RoundRateToSecondPoint(trainingStatStaticStatus._addHorseCaptureRate)
        expRate = PaGlobalFunc_GlobalUtil_RoundRateToSecondPoint(trainingStatStaticStatus._addVehicleExperienceRate)
        matingRate = PaGlobalFunc_GlobalUtil_RoundRateToSecondPoint(trainingStatStaticStatus._addMatingRate)
      end
      desc = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE_TRAINING_DESC_1", "rate1", tostring(captureRate), "rate2", tostring(expRate), "rate3", tostring(matingRate))
      name = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._title:GetText()
      control = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._parent
    elseif lifeType == eLIFE.trade then
      name = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._title:GetText()
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFT_DESC_4")
      control = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._parent
    elseif lifeType == eLIFE.growth then
      name = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._title:GetText()
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFT_DESC_7")
      control = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._parent
    elseif lifeType == eLIFE.sail then
      local sailStatStaticStatus = ToClient_getSailStatStaticStatus()
      local acc = 0
      local spd = 0
      local cor = 0
      local brk = 0
      if nil ~= sailStatStaticStatus then
        acc = PaGlobalFunc_GlobalUtil_RoundRateToSecondPoint(sailStatStaticStatus:getVariedStatByIndex(0))
        spd = PaGlobalFunc_GlobalUtil_RoundRateToSecondPoint(sailStatStaticStatus:getVariedStatByIndex(1))
        cor = PaGlobalFunc_GlobalUtil_RoundRateToSecondPoint(sailStatStaticStatus:getVariedStatByIndex(2))
        brk = PaGlobalFunc_GlobalUtil_RoundRateToSecondPoint(sailStatStaticStatus:getVariedStatByIndex(3))
      end
      local desc1 = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE_SAILSTAT_DESC_1", "rate2", tostring(acc))
      local desc2 = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE_SAILSTAT_DESC_2", "rate1", tostring(spd), "rate2", tostring(cor), "rate3", tostring(brk))
      desc = string.format([[
%s
%s]], desc1, desc2)
      name = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._title:GetText()
      control = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._parent
    elseif lifeType == eLIFE.barter then
      if false == _ContentsGroup_Barter then
        return
      end
      local value = ToClient_discountPointByBarterLevel()
      local valueStr = PaGlobalFunc_GlobalUtil_RoundRateToSecondPoint(value)
      name = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._title:GetText()
      desc = PAGetStringParam1(Defines.StringSheet_GAME, CppEnums.LifeExperienceTooltip[lifeType], "value", valueStr)
      control = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._parent
    end
    if nil == control then
      UI.ASSERT_NAME(nil ~= control, " Panel_CharacterInfo_Life_ALL_2.lua / HandleEventOnOut_CharInfoLife_All_LifeType_Tooltip() /  control is nil", "-")
      return
    end
    if nil == isOnlyConsole or false == isOnlyConsole then
      TooltipSimple_Show(control, name, desc)
    else
      PaGlobal_CharInfo_All_SetConsoleSimpleTooltip(name, desc)
      PaGlobal_CharInfo_All_SetConsoleDescShow(true)
    end
  end
end
function HandleEventLUp_CharInfoLife_All_UpdateCollectMiniGameUseable()
  if Panel_CharacterInfoLife_All == nil then
    return
  end
  if _ContentsGroup_MorningLand == false then
    return
  end
  if ToClient_IsLearnedKnowledge(PaGlobal_CharInfoLife_All._miniGameMentalCardKey) == false then
    return
  end
  local isCheck = not PaGlobal_CharInfoLife_All._ui.btn_collectMiniGameOnOff:IsCheck()
  PaGlobal_CharInfoLife_All._ui.btn_collectMiniGameOnOff:SetCheck(isCheck)
  local isNotUseable = not isCheck
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eCollectMiniGameNotUseable, isNotUseable, CppEnums.VariableStorageType.eVariableStorageType_User)
  PaGlobal_CharInfoLife_All._ui.stc_collectMiniGameIcon:SetMonoTone(isNotUseable)
  local flagStr = ""
  if isCheck == false then
    flagStr = PAGetString(Defines.StringSheet_GAME, "LUA_CHARINFO_LIFETAB_MINIGAME_TOOLTIP_CHECKOFF")
  else
    flagStr = PAGetString(Defines.StringSheet_GAME, "LUA_CHARINFO_LIFETAB_MINIGAME_TOOLTIP_CHECKON")
  end
  local name = CppEnums.LifeExperienceString[0]
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFT_DESC_1") .. PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFT_SUBDESC") .. [[


]] .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHARINFO_LIFETAB_MINIGAME_TOOLTIP_2", "flag", flagStr)
  TooltipSimple_CommonShow(name, desc)
end
