function PaGlobalFunc_CharInfoBasic_All_Update()
  PaGlobal_CharInfoBasic_All:update()
end
function HandleEventPadPress_CharInfoBasic_All_ClickOtherTab(isUp)
  if false == PaGlobal_CharInfo_All._isConsole then
    return
  end
  local curTab = PaGlobal_CharInfoBasic_All._currentTab
  if true == isUp then
    curTab = curTab + 1
    if curTab > 1 then
      curTab = 0
    end
  else
    curTab = curTab - 1
    if curTab < 0 then
      curTab = 1
    end
  end
  HandleEventLUp_CharInfoBasic_All_ClickOtherTab(curTab)
end
function HandleEventLUp_CharInfoBasic_All_ClickOtherTab(tabIdx)
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(__eCharacterInfo, tabIdx, CppEnums.VariableStorageType.eVariableStorageType_User)
  PaGlobal_CharInfoBasic_All:setMenuPosition()
  local isBattleInfoOpen = 0 == tabIdx
  PaGlobal_CharInfoBasic_All._ui.stc_BattleInfoBg:SetShow(isBattleInfoOpen)
  PaGlobal_CharInfoBasic_All._ui.rdo_BattleInfo:SetCheck(isBattleInfoOpen)
  PaGlobal_CharInfoBasic_All._ui.stc_LifeBg:SetShow(not isBattleInfoOpen)
  PaGlobal_CharInfoBasic_All._ui.rdo_LifeInfo:SetCheck(not isBattleInfoOpen)
  local selectbarX = 0
  if true == isBattleInfoOpen then
    FromClient_CharInfoBasic_All_PotentialUpdate()
    FromClient_CharInfoBasic_All_FitnesspUpdate(0, 0, 0, 0)
    FromClient_CharInfoBasic_All_AtkDefUpdate()
    FromClient_CharInfoBasic_All_ResistUpdate()
    FromClient_CharInfoBasic_All_ItemDropRateUpdate()
    PaGlobal_CharInfoBasic_All._currentTab = 0
    selectbarX = PaGlobal_CharInfoBasic_All._ui.rdo_BattleInfo:GetSpanSize().x
  else
    PaGlobal_CharInfoBasic_All._currentTab = 1
    selectbarX = PaGlobal_CharInfoBasic_All._ui.rdo_LifeInfo:GetSpanSize().x
    FromClient_CharInfoBasic_All_LifeUpdate()
  end
  PaGlobal_CharInfoBasic_All._ui.stc_TabSelectBar:SetSpanSize(selectbarX, PaGlobal_CharInfoBasic_All._ui.stc_TabSelectBar:GetSpanSize().y)
  if 1 == tabIdx then
    HandleEventLUp_ChracterInfo_All_ScaleResizeLDown()
    HandleEventLUp_ChracterInfo_All_ScaleResizeLPress()
    HandleEventLUp_ChracterInfo_All_ScaleResizeLUp()
  end
  PaGlobal_CharInfo_All:setKeyGuideAlign(0)
  PaGlobal_CharInfoBasic_All:setPositionByContentsOption()
end
function PaGlobal_CharInfoBasic_All_UpdateCharPhoto(control)
  if control == nil then
    return
  end
  local classType = control._selfPlayer:getClassType()
  local TextureName = ToClient_GetCharacterFaceTexturePath(control._selfPlayer:getCharacterNo_64())
  local isCaptureExist = control._ui.stc_CharPhoto:ChangeTextureInfoNameNotDDS(TextureName, classType, true)
  if isCaptureExist == true then
    control._ui.stc_CharPhoto:getBaseTexture():setUV(0, 0, 1, 1)
  else
    local DefaultFace = NewClassData.newClass_Texture_ID[classType]._defaultFaceTextureTID
    if DefaultFace ~= nil then
      control._ui.stc_CharPhoto:ChangeTextureInfoTextureIDAsync(DefaultFace, 0)
    end
  end
  control._ui.stc_CharPhoto:setRenderTexture(control._ui.stc_CharPhoto:getBaseTexture())
end
function HandleEventLUp_CharInfoBasic_All_TakePhoto()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  HandleEventOnOut_CharInfoBasic_All_EnchantStack(false)
  FGlobal_InGameCustomize_SetCharacterInfo(true)
  IngameCustomize_Show()
end
function HandleEventLUp_CharInfoBasic_All_ShowLifeRanking()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  if nil ~= Panel_LifeRanking_All then
    PaGlobal_LifeRanking_Open_All()
  end
end
function HandleEventLUp_CharInfoBasic_All_SetEditFocus()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  local preIntroduceText = PaGlobal_CharInfoBasic_All._ui.edit_multiEdit:GetEditText()
  local originString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERINFO_MYINTRODUCE_INPUT")
  if preIntroduceText == originString or "" == preIntroduceText then
    PaGlobal_CharInfoBasic_All._ui.edit_multiEdit:SetEditText("")
  end
  SetFocusEdit(PaGlobal_CharInfoBasic_All._ui.edit_multiEdit)
end
function HandleEventLUp_CharInfoBasic_All_SetIntroduceText()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  local preIntroduceText = PaGlobal_CharInfoBasic_All._ui.edit_multiEdit:GetEditText()
  preIntroduceText = ToClient_getFilteredIntroduceText(preIntroduceText)
  local originString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERINFO_MYINTRODUCE_INPUT")
  if true == PaGlobalFunc_CharInfoBasic_All_GetFocusEdit() and preIntroduceText ~= originString then
    PaGlobal_CharInfoBasic_All._ui.edit_multiEdit:SetEditText(preIntroduceText)
    ToClient_RequestSetUserIntroduction(preIntroduceText)
    ClearFocusEdit()
  end
end
function HandleEventLUp_CharInfoBasic_All_OpenSkillWindow()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  if _ContentsGroup_UISkillGroupTreeLayOut == true then
    if _ContentsGroup_ShowOtherClassSkill == true then
      PaGlobalFunc_SkillGroup_All_HotKeyToggle()
    else
      PaGlobalFunc_SkillGroup_HotKeyToggle()
    end
  elseif nil ~= Panel_Window_Skill then
    PaGlobal_Skill:SkillWindow_Show()
  end
end
function HandleEventLUp_CharInfoBasic_All_OpenMusicAlbum()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  if true == _ContentsGroup_InstrumentPerformance then
    PaGlobal_MusicAlbum_All_Open()
  end
end
function HandleEventLUp_CharInfoBasic_All_OpenBlackSpiritEnchant()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  if false == IsSelfPlayerWaitAction() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_SUMMON_BLACKSPIRIT"))
    return
  end
  ToClient_AddBlackSpiritFlush(0, true, CppEnums.EFlush_BlackSpirit_Ui_Type.eFlush_BlackSpirit_Ui_ItemEnchant)
end
function HandleEventOnOut_CharInfoBasic_All_FacePhoto(isShow)
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control, name, desc, icon
  name = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_FACEPHOTO_TOOLTIP_NAME")
  desc = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_FACEPHOTO_TOOLTIP_DESC")
  control = PaGlobal_CharInfoBasic_All._ui.btn_FacePhoto
  icon = UI.getChildControl(PaGlobal_CharInfoBasic_All._ui.btn_FacePhoto, "Static_CameraIcon")
  if nil == control then
    UI.ASSERT_NAME(nil ~= control, " Panel_CharacterInfoBasic_All_2.lua / HandleEventOnOut_CharInfoBasic_All_FacePhoto() /  control is nil", "-")
    return
  end
  TooltipSimple_Show(control, name, desc, icon)
end
function HandleEventOnOut_CharInfoBasic_All_EnchantStack(isShow, isEnchatIcon)
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control, name, desc, isValksItemCheck
  ToClient_RequestCharacterEnchantFailCount()
  local defaultCount = PaGlobal_CharInfoBasic_All._selfPlayer:get():getEnchantFailCount()
  local valksCount = PaGlobal_CharInfoBasic_All._selfPlayer:get():getEnchantValuePackCount()
  local familyCount = getEnchantInformation():ToClient_getBonusStackCount()
  local isValksItem = ToClient_IsContentsGroupOpen("47")
  if isValksItem == false then
    isValksItemCheck = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GAMEEXIT_ENCHANTCOUNT_TOOLTIP_ADDCOUNT_NONE", "defaultCount", tostring(defaultCount))
  else
    isValksItemCheck = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_GAMEEXIT_ENCHANTCOUNT_TOOLTIP", "defaultCount", tostring(defaultCount), "valksCount", tostring(valksCount), "familyCount", tostring(familyCount))
  end
  name = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_NORMALSTACK_TOOLTIP_NAME")
  desc = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_NORMALSTACK_TOOLTIP_DESC") .. isValksItemCheck
  if false == isEnchatIcon then
    control = PaGlobal_CharInfoBasic_All._ui.txt_EnchantCount
  else
    control = PaGlobal_CharInfoBasic_All._ui.stc_EnchantStackIcon
  end
  if nil == control then
    UI.ASSERT_NAME(nil ~= control, " Panel_CharacterInfoBasic_All_2.lua / HandleEventOnOut_CharInfoBasic_All_EnchantStack() /  control is nil", "-")
    return
  end
  TooltipSimple_Show(control, name, desc, PaGlobal_CharInfoBasic_All._ui.stc_EnchantStackIcon)
end
function HandleEventOnOut_CharInfoBasic_All_Fame(isShow, tipType)
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) or false == isShow or nil == tipType then
    TooltipSimple_Hide()
    return
  end
  local title = {
    [0] = {
      "LUA_FAMILYPOINTS_SUM_TOOLTIP_TITLE",
      "LUA_FAMILYPOINTS_SUM_TOOLTIP_DESC"
    },
    [1] = {
      "LUA_FAMILYPOINTS_COMBAT_TOOLTIP_TITLE",
      "LUA_FAMILYPOINTS_COMBAT_TOOLTIP_DESC"
    },
    [2] = {
      "LUA_FAMILYPOINTS_LIFE_TOOLTIP_TITLE",
      "LUA_FAMILYPOINTS_LIFE_TOOLTIP_DESC"
    },
    [3] = {
      "LUA_FAMILYPOINTS_ETC_TOOLTIP_TITLE",
      "LUA_FAMILYPOINTS_ETC_TOOLTIP_DESC"
    }
  }
  local fameUI = {
    [0] = PaGlobal_CharInfoBasic_All._ui.txt_BattlePoint,
    [1] = PaGlobal_CharInfoBasic_All._ui.txt_LifePoint,
    [2] = PaGlobal_CharInfoBasic_All._ui.txt_SpecialPoint,
    [3] = PaGlobal_CharInfoBasic_All._ui.txt_FamilyPoint
  }
  local name, desc
  name = PAGetString(Defines.StringSheet_GAME, title[tipType][1])
  desc = PaGlobalFunc_CharInfoBasic_All_RangePointTooltip(tipType)
  local control = fameUI[tipType]
  if nil == control or nil == name then
    UI.ASSERT_NAME(nil ~= control, " Panel_CharacterInfoBasic_All_2.lua / HandleEventOnOut_CharInfoBasic_All_FamliyPoints() /  control or name is nil", "-")
    return
  end
  TooltipSimple_Show(control, name, desc)
  if 1 == tipType then
    local tooltipPosY = Panel_Tooltip_SimpleText:GetPosY()
    local tooltipPosX = Panel_Tooltip_SimpleText:GetPosX()
    local screenX = getScreenSizeX()
    local screenY = getScreenSizeY()
    if tooltipPosY < 0 then
      Panel_Tooltip_SimpleText:SetPosY(math.abs(tooltipPosY))
    elseif tooltipPosY > screenY then
      Panel_Tooltip_SimpleText:SetPosY(tooltipPosY - (screenY - tooltipPosY))
    end
    if tooltipPosX < 0 then
      Panel_Tooltip_SimpleText:SetPosX(math.abs(tooltipPosX))
    elseif tooltipPosX > screenX then
      Panel_Tooltip_SimpleText:SetPosX(tooltipPosX - (screenX - tooltipPosX))
    end
  end
end
function HandleEventOnOut_CharInfoBasic_All_Regist(isShow, tipType)
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) or false == isShow or nil == tipType then
    TooltipSimple_Hide()
    return
  end
  local string = {
    [0] = {
      "LUA_CHARACTERINFO_TXT_REGIST_STUN_TOOLTIP_NAME",
      "LUA_CHARACTERINFO_TXT_REGIST_STUN_TOOLTIP_DESC"
    },
    [1] = {
      "LUA_CHARACTERINFO_TXT_REGIST_DOWN_TOOLTIP_NAME",
      "LUA_CHARACTERINFO_TXT_REGIST_DOWN_TOOLTIP_DESC"
    },
    [2] = {
      "LUA_CHARACTERINFO_TXT_REGIST_KNOCKBACK_TOOLTIP_NAME",
      "LUA_CHARACTERINFO_TXT_REGIST_KNOCKBACK_TOOLTIP_DESC"
    },
    [3] = {
      "LUA_CHARACTERINFO_TXT_REGIST_ATKTYPE_TOOLTIP_NAME",
      "LUA_CHARACTERINFO_TXT_REGIST_ATKTYPE_TOOLTIP_DESC"
    }
  }
  if true == _ContentsOption_CH_GameType then
    string[4] = {
      "LUA_CHARACTERINFO_TXT_REGIST_ATKTYPE_TOOLTIP_NAME",
      "LUA_ATKTYPE_TOOLTIP_DESC_CH"
    }
  end
  local RegistUI = {
    [0] = PaGlobal_CharInfoBasic_All._ui.txt_StunRegistTitle,
    [1] = PaGlobal_CharInfoBasic_All._ui.txt_DownRegistTitle,
    [2] = PaGlobal_CharInfoBasic_All._ui.txt_AirRegistTitle,
    [3] = PaGlobal_CharInfoBasic_All._ui.txt_AtkTypeTitle
  }
  local name = PAGetString(Defines.StringSheet_GAME, string[tipType][1])
  local desc = PAGetString(Defines.StringSheet_GAME, string[tipType][2])
  local control = RegistUI[tipType]
  if nil == control then
    UI.ASSERT_NAME(nil ~= control, " Panel_CharacterInfoBasic_All_2.lua / HandleEventOnOut_CharInfoBasic_All_Regist() /  control is nil", "-")
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_CharInfoBasic_All_ItemDropRate(isShow)
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERINFO_ITEMDROP_TITLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_ITEMDROP_TOOLTIP_EXTRADESC")
  local control = PaGlobal_CharInfoBasic_All._ui.txt_ItemDropRateTitle
  if control == nil then
    return
  end
  if selfPlayer:isUseDropItemGroupList() == true then
    local zeroPercentString = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMDROPEFFECT_NONE")
    local totalDropPercent = 0
    local totalDropPercentMax = 0
    local addString = ""
    for groupIndex = 0, __eEfficiencyOfDropItemGroup_Count - 1 do
      local itemDropGroupPercent = selfPlayer:getEfficiencyOfDropItemPercent(groupIndex)
      local maxDropGroupPercent = selfPlayer:getEfficiencyOfDropItemPercentMax(groupIndex)
      totalDropPercentMax = totalDropPercentMax + maxDropGroupPercent
      if itemDropGroupPercent > maxDropGroupPercent then
        itemDropGroupPercent = maxDropGroupPercent
      end
      totalDropPercent = totalDropPercent + itemDropGroupPercent
      if groupIndex == __eEfficiencyOfDropItemGroup_Normal then
        addString = addString .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ITEMDROPEFFECT_DESC1", "item", itemDropGroupPercent .. "%") .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_ITEMDROP_MAX_COUNT", "count", maxDropGroupPercent) .. "\n"
      elseif groupIndex == __eEfficiencyOfDropItemGroup_Special then
        local arshaBuffPercent = selfPlayer:getCurrentArshaServerItemDropBuffPercent()
        local majorSiegeBuffPercent = selfPlayer:getCurrentMajorSiegeItemDropBuffPercent()
        local elementalBossBuffPercent = selfPlayer:getElementalMonsterItemDropBuffPercent()
        local edaniaBuffPercent = ToClient_GetEdanaDropBuffPercentCurrentRegion()
        local arshaServerBuffString = ""
        local majorSiegeBuffString = ""
        local elementalMonsterBuffString = ""
        local edaniaBuffString = ""
        if arshaBuffPercent > 0 then
          arshaServerBuffString = tostring(arshaBuffPercent) .. "%"
        else
          arshaServerBuffString = zeroPercentString
        end
        if majorSiegeBuffPercent > 0 then
          majorSiegeBuffString = tostring(majorSiegeBuffPercent) .. "%"
        else
          majorSiegeBuffString = zeroPercentString
        end
        if elementalBossBuffPercent > 0 then
          elementalMonsterBuffString = tostring(elementalBossBuffPercent) .. "%"
        else
          elementalMonsterBuffString = zeroPercentString
        end
        if edaniaBuffPercent > 0 then
          edaniaBuffString = tostring(edaniaBuffPercent) .. "%"
        else
          edaniaBuffString = zeroPercentString
        end
        addString = addString .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ITEMDROPEFFECT_EXTRAEFFECT_NEW2", "item", itemDropGroupPercent .. "%") .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_ITEMDROP_MAX_COUNT", "count", maxDropGroupPercent) .. "\n"
        addString = addString .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ITEMDROPEFFECT_EXTRAEFFECT_NEW3", "percent", maxDropGroupPercent .. "%") .. "\n"
        addString = addString .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ITEMDROPEFFECT_EXTRAEFFECT_NEW4", "item", arshaServerBuffString) .. "\n"
        addString = addString .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ITEMDROPEFFECT_EXTRAEFFECT_NEW5", "item", majorSiegeBuffString) .. "\n"
        addString = addString .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ITEMDROPEFFECT_EXTRAEFFECT_NEW6", "item", elementalMonsterBuffString) .. "\n"
        addString = addString .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ITEMDROPEFFECT_EXTRAEFFECT_NEW7", "item", edaniaBuffString) .. "\n"
        addString = addString .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ITEMDROPEFFECT_EXTRAEFFECT_NEW10", "percent", totalDropPercentMax) .. "\n"
        addString = addString .. PAGetString(Defines.StringSheet_GAME, "LUA_ITEMDROPEFFECT_EXTRAEFFECT_NEW9") .. [[


]]
      else
        _PA_ASSERT(false, "\236\149\132\236\157\180\237\133\156 \237\154\141\235\147\157 \237\153\149\235\165\160 \234\183\184\235\163\185 enum(" .. tostring(groupIndex) .. ")\236\151\144 \237\149\180\235\139\185\237\149\152\235\138\148 string \236\160\149\236\157\152\234\176\128 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164.")
      end
    end
    desc = desc .. [[


]] .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ITEMDROPEFFECT_EXTRAEFFECT_NEW1", "item", totalDropPercent .. "%") .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_ITEMDROP_MAX_COUNT", "count", totalDropPercentMax) .. addString
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_CharInfoBasic_All_Fitness(isShow, tipType)
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) or false == isShow or nil == tipType then
    TooltipSimple_Hide()
    return
  end
  local control, name, desc
  if PaGlobal_CharInfoBasic_All._ENUM_FITNESS.BREATH == tipType then
    control = PaGlobal_CharInfoBasic_All._ui.txt_Breath
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_FITNESS_STAMINA_TITLE_ONE")
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFCHARACTERINFO_FITNESS_STAMINA_MSG", "type", tostring(ToClient_GetFitnessLevelStatus(tipType)))
  elseif PaGlobal_CharInfoBasic_All._ENUM_FITNESS.POWER == tipType then
    control = PaGlobal_CharInfoBasic_All._ui.txt_Power
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_FITNESS_STRENGTH_TITLE_ONE")
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFCHARACTERINFO_FITNESS_STRENGTH_MSG", "type", tostring(ToClient_GetFitnessLevelStatus(tipType) / 10000))
  else
    control = PaGlobal_CharInfoBasic_All._ui.txt_Health
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_FITNESS_HEALTH_TITLE_ONE")
    local _hpIncrease = tostring(ToClient_GetFitnessLevelStatus(tipType, 0))
    local _mpIncrease = tostring(ToClient_GetFitnessLevelStatus(tipType, 1))
    local _mentalType = PaGlobal_CharInfoBasic_All._selfPlayer:getCombatResourceType()
    local _mpName = {
      [CppEnums.CombatResourceType.CombatType_MP] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_MP"),
      [CppEnums.CombatResourceType.CombatType_FP] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_FP_NEW"),
      [CppEnums.CombatResourceType.CombatType_EP] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_EP"),
      [CppEnums.CombatResourceType.CombatType_BP] = PAGetString(Defines.StringSheet_GAME, "LUA_SELFCHARACTERINFO_BP")
    }
    local mpTypeTitle = _mpName[_mentalType]
    if true == PaGlobal_CharInfoBasic_All._asianFlag then
      desc = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_FITNESS_HEALTH_MSG_NEW", "hpIncrease", _hpIncrease, "mpTypeName", mpTypeTitle, "mpIncrease", _mpIncrease)
    else
      desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFCHARACTERINFO_FITNESS_HEALTH_MSG", "type", _hpIncrease)
    end
  end
  if nil == control then
    UI.ASSERT_NAME(nil ~= control, " Panel_CharacterInfoBasic_All_2.lua / HandleEventOnOut_CharInfoBasic_All_Regist() /  control is nil", "-")
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_CharInfoBasic_All_Potential(isShow, tipType)
  if false == isShow or nil == tipType or false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    TooltipSimple_Hide()
    return
  end
  if nil == PaGlobal_CharInfoBasic_All._potentialData[tipType] then
    UI.ASSERT_NAME(nil ~= PaGlobal_CharInfoBasic_All._potentialData[tipType], " Panel_CharacterInfoBasic_All_2.lua / HandleEventOnOut_CharInfoBasic_All_Potential() /  PaGlobal_CharInfoBasic_All._potentialData[" .. tostring(tipType) .. "potenIdx'] is nil", "-")
    TooltipSimple_Hide()
    return
  end
  local control, name, desc
  control = PaGlobal_CharInfoBasic_All._potentialData[tipType].title
  name = PaGlobal_CharInfoBasic_All._potentialData[tipType].title:GetText()
  desc = PaGlobal_CharInfoBasic_All._potentialData[tipType].toolTipDesc
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_CharInfoBasic_All_BasicStat(isShow, tipType)
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) or false == isShow or nil == tipType then
    TooltipSimple_Hide()
    return
  end
  local control, name
  if 0 == tipType then
    control = PaGlobal_CharInfoBasic_All._ui.txt_HpTitle
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_HPREGEN") .. " : " .. tostring(PaGlobal_CharInfoBasic_All._selfPlayer:get():getRegenHp())
  elseif 1 == tipType then
    control = PaGlobal_CharInfoBasic_All._ui.txt_MpTitle
    name = PaGlobal_CharInfo_All:setMpTooltipByClass()
  else
    control = PaGlobal_CharInfoBasic_All._ui.txt_LTTitle
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERINFO_WEIGHT_TOOLTIP")
  end
  if nil == control then
    UI.ASSERT_NAME(nil ~= control, " Panel_CharacterInfoBasic_All_2.lua / HandleEventOnOut_CharInfoBasic_All_Regist() /  control is nil", "-")
    return
  end
  TooltipSimple_Show(control, name, "")
end
function HandleEventOnOut_CharInfoBasic_All_LifeGrade(isShow, lifeType)
  if false == PaGlobal_CharInfoBasic_All._ui.stc_LifeBg:GetShow() or false == isShow or nil == lifeType then
    TooltipSimple_Hide()
    return
  end
  local control, name, desc, icon
  local exp = PaGlobal_CharInfoBasic_All._ui.stc_LifeTable[lifeType].expVal
  name = CppEnums.LifeExperienceString[lifeType - 1]
  desc = CppEnums.LifeExperienceTooltip[lifeType - 1]
  control = PaGlobal_CharInfoBasic_All._ui.stc_LifeTable[lifeType].bg
  icon = PaGlobal_CharInfoBasic_All._ui.stc_LifeTable[lifeType].title
  if 11 == lifeType then
    local value = ToClient_discountPointByBarterLevel() / 10000
    local ceil = math.ceil(value * 1000 - 0.5) / 1000
    if ceil <= 0 then
      ceil = math.abs(ceil)
    end
    name = CppEnums.LifeExperienceString[lifeType]
    desc = PAGetStringParam1(Defines.StringSheet_GAME, CppEnums.LifeExperienceTooltip[lifeType], "value", string.format("%.2f", ceil))
  elseif 7 == lifeType then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFT_DESC_3")
    if true == _ContentsGroup_EnhanceTraining then
      local trainingSKillStatStaticStatus = ToClient_getTrainingLevelSkillStatStaticStatus()
      local skillRate = 0
      local statRate = 0
      if nil == ToClient_GetServantMarketTaxPercent() then
        return
      end
      local discountRate = string.format("%.1f", ToClient_GetServantMarketTaxPercent() / 10000)
      if nil ~= trainingSKillStatStaticStatus then
        skillRate = string.format("%.1f", trainingSKillStatStaticStatus._addVehicleSkillOwnerRate / 10000)
        statRate = string.format("%.1f", trainingSKillStatStaticStatus._addServantStatRate / 10000)
      end
      desc = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE_TRAINING_DESC_2", "rate1", tostring(skillRate), "rate2", tostring(statRate), "rate3", tostring(discountRate))
    end
    name = CppEnums.LifeExperienceString[lifeType - 1]
  end
  if nil == control then
    UI.ASSERT_NAME(nil ~= control, " Panel_CharacterInfoBasic_All_2.lua / HandleEventOnOut_CharInfoBasic_All_Regist() /  control is nil", "-")
    return
  end
  TooltipSimple_Show(control, name, desc, icon)
end
function HandleEventOnOut_CharInfoBasic_All_MusicRank(isShow)
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control = PaGlobal_CharInfoBasic_All._ui.txt_MusicGradeValue
  local titleStr = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_MUSIC_TOOLTIP_NAME")
  local descStr = ""
  if _ContentsGroup_MusicUpgrade2023 == true then
    descStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE_MUSIC_DESC835", "value", ToClient_GetMusicExpRate())
  else
    descStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE_MUSIC_DESC", "value", ToClient_GetMusicExpRate())
  end
  local icon = PaGlobal_CharInfoBasic_All._ui.txt_MusicGradeTitle
  TooltipSimple_Show(control, titleStr, descStr, icon)
end
function HandleEventOnOut_CharInfoBasic_All_OceanTendency(isShow)
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control = PaGlobal_CharInfoBasic_All._ui.txt_OceanTendency
  local titleStr = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_SEASTYLE_TOOLTIP_NAME")
  local descStr = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_SEASTYLE_TOOLTIP_INFO_UP")
  local icon
  if true == PaGlobal_CharInfoBasic_All._ui.stc_OceanTendencyNavyIcon:GetShow() then
    descStr = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_SEASTYLE_TOOLTIP_INFO_UP")
    icon = PaGlobal_CharInfoBasic_All._ui.stc_OceanTendencyNavyIcon
  else
    descStr = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_SEASTYLE_TOOLTIP_INFO_DOWN")
    icon = PaGlobal_CharInfoBasic_All._ui.stc_OceanTendencyPirateIcon
  end
  TooltipSimple_Show(control, titleStr, descStr, icon)
end
function HandleEventOnOut_CharInfoBasic_All_StatusTooltip(idx)
  if nil == PaGlobal_CharInfoBasic_All._statusTable or nil == idx then
    TooltipSimple_Hide()
    return
  end
  local control, name, desc, icon
  control = PaGlobal_CharInfoBasic_All._statusTable[idx]
  if 1 == idx then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERINFO_RENEW_TENDENCY_TITLE")
    local txt_familyBase = PAGetString(Defines.StringSheet_GAME, "LUA_FAMILYACCOUNT_BASE") .. "\n"
    if true == _ContentsGroup_FamilyTendency then
      desc = txt_familyBase .. PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_STYLE_TOOLTIP_INFO")
    else
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_STYLE_TOOLTIP_INFO")
    end
    icon = PaGlobal_CharInfoBasic_All._ui.stc_Tendency
  elseif 2 == idx then
    name = PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_MENTAL")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_ENERGY_TOOLTIP_INFO")
    icon = PaGlobal_CharInfoBasic_All._ui.stc_Wp
  elseif 3 == idx then
    local _contributeBubbleText = ""
    if PaGlobal_ExplorePoint_UsingInfo == nil then
      return
    end
    PaGlobal_ExplorePoint_UsingInfo:searchHouseList()
    local houseTotal_uint32 = ToClient_getHouseTotalExplorePoint()
    PaGlobal_ExplorePoint_UsingInfo:searchNodeList()
    local nodeTotal_uint32 = ToClient_getNodeTotalExplorePoint()
    if ToClient_GetPalaceManageContentUsed() == true then
      nodeTotal_uint32 = nodeTotal_uint32 + ToClient_GetPalaceManageExplorationPoint()
    end
    PaGlobal_ExplorePoint_UsingInfo:searchItemList()
    local itemTotal_uint32 = ToClient_getItemTotalExplorePoint()
    local contributeUsePointInt = {
      houseTotal_uint32,
      nodeTotal_uint32,
      itemTotal_uint32
    }
    for i = 0, 2 do
      if contributeUsePointInt[i + 1] > 0 then
        if "" == _contributeBubbleText then
          _contributeBubbleText = PaGlobal_CharInfoBasic_All._contributeUsePoint[i] .. " " .. contributeUsePointInt[i + 1]
        else
          _contributeBubbleText = _contributeBubbleText .. " | " .. PaGlobal_CharInfoBasic_All._contributeUsePoint[i] .. " " .. contributeUsePointInt[i + 1]
        end
      end
    end
    if "" == _contributeBubbleText then
      _contributeBubbleText = PAGetString(Defines.StringSheet_GAME, "LUA_EXPGUAGE_CONTRIBUTE_VALUE_4")
    else
      _contributeBubbleText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EXPGUAGE_CONTRIBUTE_VALUE_6", "_contributeBubbleText", _contributeBubbleText)
    end
    name = PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_CONTRIBUTION")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CONTRIBUTE_POINT_DESC") .. "\n" .. _contributeBubbleText
    icon = PaGlobal_CharInfoBasic_All._ui.stc_Contribute
  elseif 4 == idx then
    name = PAGetString(Defines.StringSheet_RESOURCE, "SKILL_TEXT_POINT")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_SKILLPOINT_TOOLTIP_INFO")
    icon = PaGlobal_CharInfoBasic_All._ui.stc_SkillPoint
  elseif 5 == idx then
    name = PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_ZODIA")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_ZODIAC_TOOLTIP_INFO")
    icon = PaGlobal_CharInfoBasic_All._ui.stc_Star
  end
  TooltipSimple_Show(control, name, desc, icon)
end
function HandleEventOnOut_CharInfoBasic_All_SubTabTooltip(idx)
  if nil == idx then
    TooltipSimple_Hide()
    return
  end
  local control, name, desc
  if 0 == idx then
    control = PaGlobal_CharInfoBasic_All._ui.rdo_BattleInfo
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERINFO_BATTLETITLE")
  else
    control = PaGlobal_CharInfoBasic_All._ui.rdo_LifeInfo
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERINFO_RENEW_LIFEINFO_TITLE")
  end
  if nil == control then
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function PaGlobalFunc_CharInfoBasic_All_GetFocusEdit()
  return PaGlobal_CharInfoBasic_All._ui.edit_multiEdit:GetFocusEdit()
end
function HandleEventPadPress_CharInfoBasic_All_OpenVirtualKeyBoard()
  if true == ToClient_isPS() and false == ToClient_isUserCreateContentsAllowed() then
    ToClient_SystemMsgDialogPS4(__ePS4SystemMsgDialogType_TRC_PSN_UGC_RESTRICTION)
    return
  end
  ClearFocusEdit()
  SetFocusEdit(PaGlobal_CharInfoBasic_All._ui.edit_multiEdit)
end
function HandleEventPadPress_CharInfoBasic_All_EndVirtualKeyBoard(str)
  if true == ToClient_isPS() and false == ToClient_isUserCreateContentsAllowed() then
    ToClient_SystemMsgDialogPS4(__ePS4SystemMsgDialogType_TRC_PSN_UGC_RESTRICTION)
    return
  end
  PaGlobal_CharInfoBasic_All._ui.edit_multiEdit:SetEditText(str)
  HandleEventLUp_CharInfoBasic_All_SetIntroduceText()
end
function PaGlobalFunc_CharInfoBasic_All_CheckIntroduceEditing(targetUI)
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  return nil ~= targetUI and targetUI:GetKey() == PaGlobal_CharInfoBasic_All._ui.edit_multiEdit:GetKey()
end
function HandleEventOnOut_CharInfoBasic_All_SelfTimerTooltip(show)
  if nil == show or false == show then
    TooltipSimple_Hide()
    return
  end
  local control, name, desc
  control = PaGlobal_CharInfoBasic_All._ui.stc_SelfTimer
  name = PAGetString(Defines.StringSheet_GAME, "LUA_FAMILY_PLAYTIME_TITLE")
  local totalSecond = Int64toInt32(ToClient_GetUserPlayTime())
  local hour = math.floor(totalSecond / 60 / 60)
  if hour <= 0 then
    hour = 0
  end
  local hourString = tostring(hour) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_HOUR")
  desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHALLENGE_PCROOMACCUMULATETIME_DESCBYHOUR", "time", hourString)
  if nil == control then
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventPadPress_CharInfoBasic_All_ShowTooltip(idx, subIdx)
  if PaGlobal_CharInfoBasic_All._isConsole == false then
    return
  end
  if idx == 11 then
    if Panel_Tooltip_SimpleText:GetShow() == false then
      HandleEventOnOut_CharInfoBasic_All_Fame(true, subIdx)
    else
      TooltipSimple_Hide()
    end
    return
  end
  if PaGlobal_CharInfoBasic_All._consoleTooltip == nil or PaGlobal_CharInfoBasic_All._consoleTooltip[idx] == nil then
    return
  end
  if idx == 10 then
    PaGlobal_CharInfoBasic_All:updateConsoleTooltip_ItemDropRate()
  end
  TooltipSimple_Hide()
  local title = PaGlobal_CharInfoBasic_All._consoleTooltip[idx]._title
  local desc = PaGlobal_CharInfoBasic_All._consoleTooltip[idx]._desc
  PaGlobal_CharInfo_All_SetConsoleSimpleTooltip(title, desc)
  PaGlobal_CharInfo_All_SetConsoleDescShow(true)
end
function PaGlobalFunc_CharInfoBasic_All_RangePointTooltip(tipType)
  local self = PaGlobal_CharInfoBasic_All
  local checkPoint = 0
  local resultStr = ""
  local sectionInfo
  local sectionString = ""
  if self._ENUM_FAMILY_PIONT_TYPE.ALL == tipType then
    checkPoint = self._familySumPoint
    sectionInfo = self._allPointSection
  elseif self._ENUM_FAMILY_PIONT_TYPE.BATTLE == tipType then
    checkPoint = self._familyBattlePoint
    sectionInfo = self._battlePointSection
  elseif self._ENUM_FAMILY_PIONT_TYPE.LIFE == tipType then
    checkPoint = self._familyLifePoint
    sectionInfo = self._lifePointSection
  elseif self._ENUM_FAMILY_PIONT_TYPE.ETC == tipType then
    checkPoint = self._familyEtcPoint
    sectionInfo = self._etcPointSection
  end
  resultStr = sectionInfo.desc .. [[


]] .. sectionInfo.sectionStart .. "\n"
  if self._ENUM_FAMILY_PIONT_TYPE.ALL == tipType then
    for index = 0, sectionInfo.count - 1 do
      local _start = sectionInfo[index].start
      local _next = sectionInfo[index].next
      local _bonus = sectionInfo[index].bonus
      local _itemBonus = sectionInfo[index].itemBonus
      local isMySector = false
      sectionString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_BASIC_ALLPOINT_TOOLTIP", "start", _start, "bonus", tostring(_bonus))
      if self._ENUM_FAMILY_PIONT_TYPE.ALL == tipType and index == 2 then
        local itemBonusString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_BASIC_ALLPOINT_ITEM_TOOLTIP", "bonus", tostring(_itemBonus))
        sectionString = sectionString .. " " .. itemBonusString
      end
      if nil ~= _next then
        if checkPoint >= _start and checkPoint < _next then
          isMySector = true
        end
      elseif checkPoint >= _start then
        isMySector = true
      end
      if true == isMySector then
        sectionString = "<PAColor0xFFF5BA3A>" .. sectionString .. "<PAOldColor>"
      end
      resultStr = resultStr .. sectionString .. "\n"
    end
  else
    for index = 0, sectionInfo.count - 1 do
      local _start = sectionInfo[index].start
      local _last = sectionInfo[index].last
      local _bonus = makeDotMoney(toInt64(0, sectionInfo[index].bonus))
      local isMySector = false
      if nil ~= _last then
        sectionString = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_BASIC_FAMILYPOINT_SECTION_TOOLTIP", "start", _start, "last", _last, "bonus", _bonus)
      else
        sectionString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_BASIC_FAMILYPOINT_SECTION_END_TOOLTIP", "start", _start, "bonus", _bonus)
      end
      if nil ~= _last then
        if checkPoint >= _start and checkPoint <= _last then
          isMySector = true
        end
      elseif checkPoint >= _start then
        isMySector = true
      end
      if true == isMySector then
        sectionString = "<PAColor0xFFF5BA3A>" .. sectionString .. "<PAOldColor>"
      end
      resultStr = resultStr .. sectionString .. "\n"
    end
  end
  if 0 < string.len(sectionInfo.conditionDesc) then
    resultStr = resultStr .. sectionInfo.conditionDesc .. [[


]]
  end
  if 0 < string.len(sectionInfo.reciveDesc) then
    resultStr = resultStr .. sectionInfo.reciveDesc
  end
  return resultStr
end
function PaGlobalFunc_CharInfoBasic_All_ZodiacTooltip(isShow)
  local self = PaGlobal_CharInfoBasic_All
  if self == nil then
    return
  end
  if isShow == true then
    TooltipSimple_Show(self._ui.txt_Star, "", self._ui.txt_Star:GetText())
  else
    TooltipSimple_Hide()
  end
end
