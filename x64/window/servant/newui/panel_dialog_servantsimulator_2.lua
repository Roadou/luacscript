function PaGlobal_ServantSimulator:initGrowUpControl()
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  self._ui._growUp._stc_growUpBg = UI.getChildControl(Panel_Dialog_ServantSimulator, "Static_GrowupRate")
  self._ui._growUp._stc_growUpLeft = UI.getChildControl(self._ui._growUp._stc_growUpBg, "Static_LeftBg")
  local growUpSelectImageBg = UI.getChildControl(self._ui._growUp._stc_growUpLeft, "Static_HorseImageBG")
  local growUpSelectImage = UI.getChildControl(growUpSelectImageBg, "Static_HorseImage")
  self._ui._growUp._stc_horseImage = UI.getChildControl(growUpSelectImage, "Static_RealImage")
  self._ui._growUp._stc_selectHorse = UI.getChildControl(growUpSelectImage, "Static_SelectHorse")
  self._ui._growUp._txt_selectHorseName = UI.getChildControl(growUpSelectImage, "StaticText_Name")
  self._ui._growUp._stc_horseGender = UI.getChildControl(growUpSelectImage, "Static_Gender")
  self._ui._growUp._btn_changeHorse = UI.getChildControl(growUpSelectImageBg, "Button_ChangeHorse")
  self._ui._growUp._btn_reset = UI.getChildControl(growUpSelectImageBg, "Button_Reset")
  self._ui._growUp._cbx_horseLevel = UI.getChildControl(self._ui._growUp._stc_growUpLeft, "Combobox_HorseLevel")
  self._ui._growUp._cbx_lifeLevel = UI.getChildControl(self._ui._growUp._stc_growUpLeft, "Combobox_LifeLevel")
  self._ui._growUp._chk_imprint = UI.getChildControl(self._ui._growUp._stc_growUpLeft, "CheckButton_Seal")
  self._ui._growUp._chk_equipAvatar = UI.getChildControl(self._ui._growUp._stc_growUpLeft, "CheckButton_CashEquip")
  local growUpDefaultStatBg = UI.getChildControl(self._ui._growUp._stc_growUpLeft, "Static_DefaultStat")
  self._ui._growUp._txt_hp = UI.getChildControl(growUpDefaultStatBg, "StaticText_VehicleHP_Value")
  self._ui._growUp._txt_mp = UI.getChildControl(growUpDefaultStatBg, "StaticText_VehicleStemina_Value")
  self._ui._growUp._txt_acceleration = UI.getChildControl(growUpDefaultStatBg, "StaticText_Acceleration_Value")
  self._ui._growUp._txt_speed = UI.getChildControl(growUpDefaultStatBg, "StaticText_Speed_Value")
  self._ui._growUp._txt_cornering = UI.getChildControl(growUpDefaultStatBg, "StaticText_CorneringSpeed_Value")
  self._ui._growUp._txt_brake = UI.getChildControl(growUpDefaultStatBg, "StaticText_Brake_Value")
  self._ui._growUp._txt_shape = UI.getChildControl(growUpDefaultStatBg, "StaticText_Shape_Value")
  self._ui._growUp._stc_growUpRight = UI.getChildControl(self._ui._growUp._stc_growUpBg, "Static_RightBg")
  self._ui._growUp._stc_topTitle = UI.getChildControl(self._ui._growUp._stc_growUpRight, "Static_TopTitleBG")
  self._ui._growUp._stc_emptyText = UI.getChildControl(self._ui._growUp._stc_growUpRight, "StaticText_NoData")
  self._ui._growUp._stc_vitalityHelpIcon = UI.getChildControl(self._ui._growUp._stc_growUpRight, "Static_LifeAbilityHelp")
  self._ui._growUp._stc_skillHelpIcon = UI.getChildControl(self._ui._growUp._stc_growUpRight, "Static_StudySkillHelp")
  self._ui._growUp._lst_vitality = UI.getChildControl(self._ui._growUp._stc_growUpRight, "List2_VitalityList")
  self._ui._growUp._lst_ability = UI.getChildControl(self._ui._growUp._stc_growUpRight, "List2_AbilityList")
  self._ui._growUp._lst_skill = UI.getChildControl(self._ui._growUp._stc_growUpRight, "List2_SkillList")
  self._ui._growUp._stc_descEdge = UI.getChildControl(self._ui._growUp._stc_growUpRight, "Static_DescEdge")
  self._ui._growUp._txt_maxLevelDesc = UI.getChildControl(self._ui._growUp._stc_growUpBg, "MultilineText_MaxLevel")
  local vitalityStatTitle = UI.getChildControl(self._ui._growUp._stc_growUpRight, "StaticText_DefaultStat")
  local abillityStatTitle = UI.getChildControl(self._ui._growUp._stc_growUpRight, "StaticText_AbilityStat")
  local skillTitle = UI.getChildControl(self._ui._growUp._stc_growUpRight, "StaticText_SkillStat")
  vitalityStatTitle:SetText(vitalityStatTitle:GetText())
  vitalityStatTitle:SetSize(vitalityStatTitle:GetTextSizeX(), vitalityStatTitle:GetSizeY())
  vitalityStatTitle:ComputePos()
  abillityStatTitle:SetText(abillityStatTitle:GetText())
  abillityStatTitle:SetSize(abillityStatTitle:GetTextSizeX(), abillityStatTitle:GetSizeY())
  abillityStatTitle:ComputePos()
  skillTitle:SetText(skillTitle:GetText())
  skillTitle:SetSize(skillTitle:GetTextSizeX(), skillTitle:GetSizeY())
  skillTitle:ComputePos()
  self._ui._growUp._stc_vitalityHelpIcon:SetSpanSize(vitalityStatTitle:GetSpanSize().x + vitalityStatTitle:GetSizeX() + 5, self._ui._growUp._stc_vitalityHelpIcon:GetSpanSize().y)
  self._ui._growUp._stc_skillHelpIcon:SetSpanSize(skillTitle:GetSpanSize().x + skillTitle:GetSizeX() + 5, self._ui._growUp._stc_skillHelpIcon:GetSpanSize().y)
end
function PaGlobal_ServantSimulator:registEventHandler_GrowUp()
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  self._ui._growUp._stc_selectHorse:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSimulator_ToggleSubView(nil)")
  self._ui._growUp._btn_changeHorse:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSimulator_ToggleSubView(nil)")
  self._ui._growUp._btn_changeHorse:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSimulator_ShowChangeHorseButtonTooltip(0, true)")
  self._ui._growUp._btn_changeHorse:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantSimulator_ShowChangeHorseButtonTooltip(0, false)")
  self._ui._growUp._btn_reset:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSimulator_ResetGrowUpSelectInfo()")
  self._ui._growUp._btn_reset:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSimulator_ShowSelectInfoResetButtonTooltip(0, true)")
  self._ui._growUp._btn_reset:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantSimulator_ShowSelectInfoResetButtonTooltip(0, false)")
  self._ui._growUp._cbx_horseLevel:GetListControl():AddSelectEvent("HandleEventLUp_ServantSimulator_GrowUpHorseLevelComboBoxItem()")
  self._ui._growUp._cbx_horseLevel:setListTextHorizonCenter()
  self._ui._growUp._cbx_horseLevel:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSimulator_GrowUpHorseLevelComboBox()")
  self._ui._growUp._cbx_lifeLevel:GetListControl():AddSelectEvent("HandleEventLUp_ServantSimulator_GrowUpLifeLevelComboBoxItem()")
  self._ui._growUp._cbx_lifeLevel:setListTextHorizonCenter()
  self._ui._growUp._cbx_lifeLevel:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSimulator_GrowUpLifeLevelComboBox()")
  self._ui._growUp._chk_imprint:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSimulator_ChangeGrowUpImprint()")
  self._ui._growUp._chk_imprint:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSimulator_ShowGrowUpImprintTooltip(true)")
  self._ui._growUp._chk_imprint:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantSimulator_ShowGrowUpImprintTooltip(false)")
  self._ui._growUp._chk_equipAvatar:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSimulator_ChangeGrowUpEquipAvatar()")
  self._ui._growUp._chk_equipAvatar:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSimulator_ShowGrowUpEquipAvatarTooltip(true)")
  self._ui._growUp._chk_equipAvatar:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantSimulator_ShowGrowUpEquipAvatarTooltip(false)")
  self._ui._growUp._stc_vitalityHelpIcon:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSimulator_ShowGrowUpHPMPStatDescTooltip(true)")
  self._ui._growUp._stc_vitalityHelpIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantSimulator_ShowGrowUpHPMPStatDescTooltip(false)")
  self._ui._growUp._stc_skillHelpIcon:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSimulator_ShowGrowUpSkillStatDescTooltip(true)")
  self._ui._growUp._stc_skillHelpIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantSimulator_ShowGrowUpSkillStatDescTooltip(false)")
  self._ui._growUp._lst_vitality:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_ServantSimulator_OnCreateGrowUpVitalityContent")
  self._ui._growUp._lst_vitality:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._growUp._lst_ability:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_ServantSimulator_OnCreateGrowUpAbilityContent")
  self._ui._growUp._lst_ability:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._growUp._lst_skill:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_ServantSimulator_OnCreateGrowUpSkillContent")
  self._ui._growUp._lst_skill:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_ServantSimulator:validate_GrowUp()
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  self._ui._growUp._stc_growUpBg:isValidate()
  self._ui._growUp._stc_growUpLeft:isValidate()
  self._ui._growUp._stc_horseImage:isValidate()
  self._ui._growUp._stc_selectHorse:isValidate()
  self._ui._growUp._btn_changeHorse:isValidate()
  self._ui._growUp._txt_selectHorseName:isValidate()
  self._ui._growUp._stc_horseGender:isValidate()
  self._ui._growUp._btn_reset:isValidate()
  self._ui._growUp._cbx_horseLevel:isValidate()
  self._ui._growUp._cbx_lifeLevel:isValidate()
  self._ui._growUp._chk_imprint:isValidate()
  self._ui._growUp._chk_equipAvatar:isValidate()
  self._ui._growUp._txt_hp:isValidate()
  self._ui._growUp._txt_mp:isValidate()
  self._ui._growUp._txt_acceleration:isValidate()
  self._ui._growUp._txt_speed:isValidate()
  self._ui._growUp._txt_cornering:isValidate()
  self._ui._growUp._txt_brake:isValidate()
  self._ui._growUp._txt_shape:isValidate()
  self._ui._growUp._stc_growUpRight:isValidate()
  self._ui._growUp._stc_emptyText:isValidate()
  self._ui._growUp._stc_vitalityHelpIcon:isValidate()
  self._ui._growUp._stc_skillHelpIcon:isValidate()
  self._ui._growUp._lst_vitality:isValidate()
  self._ui._growUp._lst_ability:isValidate()
  self._ui._growUp._lst_skill:isValidate()
  self._ui._growUp._txt_maxLevelDesc:isValidate()
  self._ui._growUp._stc_descEdge:isValidate()
end
function PaGlobal_ServantSimulator:clearGrowUpSelectInfo()
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  self._ui._growUp._stc_selectHorse:SetShow(true)
  self._ui._growUp._btn_changeHorse:SetShow(true)
  self._ui._growUp._stc_horseImage:SetShow(false)
  self._ui._growUp._stc_horseGender:SetShow(false)
  self._ui._growUp._stc_topTitle:SetShow(false)
  self._ui._growUp._cbx_horseLevel:DeleteAllItem(0)
  self._ui._growUp._cbx_horseLevel:AddItem(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTSIMULATOR_SELECT_HORSE_LEVEL"))
  self._ui._growUp._cbx_horseLevel:SetSelectItemIndex(0)
  self._lastGrowUpHorseLevelComboBoxToIndex = nil
  self._ui._growUp._lst_vitality:moveTopIndex()
  self._ui._growUp._lst_vitality:SetShow(false)
  self._ui._growUp._lst_ability:moveTopIndex()
  self._ui._growUp._lst_ability:SetShow(false)
  self._ui._growUp._lst_skill:moveTopIndex()
  self._ui._growUp._lst_skill:SetShow(false)
  self._ui._growUp._stc_descEdge:SetShow(false)
  self._ui._growUp._cbx_lifeLevel:DeleteAllItem(0)
  local horseTrainingStr = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE6")
  self._ui._growUp._cbx_lifeLevel:AddItem(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTSIMULATOR_SELECT_HORSE_LIFELEVEL"))
  local maxLifeLevel = ToClient_GetHorseSimulateGrowUpSelectLifeLevelMax()
  for lifeLevel = 1, maxLifeLevel do
    self._ui._growUp._cbx_lifeLevel:AddItem(PaGlobalFunc_Util_CraftLevelColorStrReplace(lifeLevel, horseTrainingStr) .. " " .. PaGlobalFunc_Util_CraftLevelColorReplace(lifeLevel))
  end
  local selfPlayer = getSelfPlayer()
  local lifeIndex = 0
  if selfPlayer ~= nil then
    local selfProxy = selfPlayer:get()
    if selfProxy ~= nil then
      lifeIndex = selfProxy:getLifeExperienceLevel(CppEnums.LifeExperienceType.training)
    end
  end
  self._ui._growUp._cbx_lifeLevel:SetSelectItemIndex(lifeIndex)
  self._lastGrowUpLifeLevelComboBoxToIndex = self._ui._growUp._cbx_lifeLevel:GetSelectIndex()
  self._ui._growUp._cbx_lifeLevel:GetListControl():SetToIndex(self._lastGrowUpLifeLevelComboBoxToIndex)
  self._ui._growUp._chk_imprint:SetCheck(false)
  self._ui._growUp._chk_equipAvatar:SetCheck(false)
  self._ui._growUp._stc_emptyText:SetShow(true)
  self._ui._growUp._stc_vitalityHelpIcon:SetShow(false)
  self._ui._growUp._stc_skillHelpIcon:SetShow(false)
  self._ui._growUp._txt_maxLevelDesc:SetShow(false)
  UI.getChildControl(self._ui._growUp._stc_growUpRight, "StaticText_DefaultStat"):SetShow(false)
  UI.getChildControl(self._ui._growUp._stc_growUpRight, "StaticText_AbilityStat"):SetShow(false)
  UI.getChildControl(self._ui._growUp._stc_growUpRight, "StaticText_SkillStat"):SetShow(false)
  UI.getChildControl(self._ui._growUp._stc_growUpRight, "Static_HorizonLine1"):SetShow(false)
  UI.getChildControl(self._ui._growUp._stc_growUpRight, "Static_HorizonLine2"):SetShow(false)
  self._ui._growUp._txt_selectHorseName:SetText("-")
  self._ui._growUp._txt_hp:SetText("-")
  self._ui._growUp._txt_mp:SetText("-")
  self._ui._growUp._txt_acceleration:SetText("-")
  self._ui._growUp._txt_speed:SetText("-")
  self._ui._growUp._txt_cornering:SetText("-")
  self._ui._growUp._txt_brake:SetText("-")
  self._ui._growUp._txt_shape:SetText("-")
  self._growUpSelectInfo._dataIndex = nil
  self._growUpSelectInfo._isMyHorse = nil
  self._growUpSelectInfo._horseMaxLevel = nil
  self._selectGrowUpSkillIndexList = nil
  if self._isConsole == true then
    ToClient_padSnapRefreshTarget(self._ui._growUp._cbx_horseLevel)
    ToClient_padSnapRefreshTarget(self._ui._growUp._cbx_lifeLevel)
  end
end
function PaGlobal_ServantSimulator:updateRightBg_GrowUpSelectInfo(index, isOnlyMyHorse, selectedLevel)
  if Panel_Dialog_ServantSimulator == nil or index == nil then
    return false
  end
  local dataWrapper
  if isOnlyMyHorse == true then
    dataWrapper = ToClient_GetHorseSimulateGrowUpMyHorseSelectInfoByIndex(index)
  else
    dataWrapper = ToClient_GetHorseSimulateGrowUpAllSelectInfoByIndex(index)
  end
  if dataWrapper == nil then
    return false
  end
  self._growUpSelectInfo._dataIndex = index
  self._growUpSelectInfo._isMyHorse = isOnlyMyHorse
  self._ui._growUp._stc_selectHorse:SetShow(false)
  self._ui._growUp._btn_changeHorse:SetShow(true)
  local horseName = "-"
  if dataWrapper:isMyHorse() == true then
    horseName = dataWrapper:getMyHorseNameForLua()
  else
    horseName = dataWrapper:getHorseTitleNameForLua()
  end
  if ToClient_IsDevelopment() == true then
    horseName = horseName .. "(" .. tostring(dataWrapper:getCharacterKeyRaw()) .. ")"
  end
  self._ui._growUp._txt_selectHorseName:SetText(horseName)
  self._ui._growUp._stc_emptyText:SetShow(false)
  self._ui._growUp._stc_vitalityHelpIcon:SetShow(false)
  self._ui._growUp._stc_skillHelpIcon:SetShow(true)
  UI.getChildControl(self._ui._growUp._stc_growUpRight, "StaticText_DefaultStat"):SetShow(true)
  UI.getChildControl(self._ui._growUp._stc_growUpRight, "StaticText_AbilityStat"):SetShow(true)
  UI.getChildControl(self._ui._growUp._stc_growUpRight, "StaticText_SkillStat"):SetShow(true)
  UI.getChildControl(self._ui._growUp._stc_growUpRight, "Static_HorizonLine1"):SetShow(true)
  UI.getChildControl(self._ui._growUp._stc_growUpRight, "Static_HorizonLine2"):SetShow(true)
  self._ui._growUp._lst_vitality:SetShow(true)
  self._ui._growUp._lst_ability:SetShow(true)
  self._ui._growUp._lst_skill:SetShow(true)
  self._ui._growUp._stc_descEdge:SetShow(true)
  self._ui._growUp._stc_topTitle:SetShow(true)
  local genderTextureId
  if dataWrapper:isMale() == true then
    genderTextureId = "Combine_Etc_Stable_Male"
  else
    genderTextureId = "Combine_Etc_Stable_Female"
  end
  self._ui._growUp._stc_horseGender:ChangeTextureInfoTextureIDAsync(genderTextureId)
  self._ui._growUp._stc_horseGender:setRenderTexture(self._ui._growUp._stc_horseGender:getBaseTexture())
  self._ui._growUp._stc_horseGender:SetShow(true)
  self._ui._growUp._cbx_horseLevel:DeleteAllItem(0)
  local maxLevel = ToClient_GetHorseSimulateGrowUpVariableStatLevelMax()
  local horseMaxLevel = 0
  for level = 1, maxLevel do
    if dataWrapper:isExistExperienceStatic(level) == true then
      horseMaxLevel = level
    end
  end
  self._growUpSelectInfo._horseMaxLevel = horseMaxLevel
  for level = 0, horseMaxLevel - 1 do
    local iterLevel = horseMaxLevel - level
    self._ui._growUp._cbx_horseLevel:AddItem(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_HORSE_LEVEL", "level", iterLevel))
  end
  if isOnlyMyHorse == true then
    local servantNo = dataWrapper:getServantNo()
    local servantWrapper = stable_getServantByServantNo(servantNo, CppEnums.ServantWhereType.ServantWhereTypeUser)
    if servantWrapper == nil then
      servantWrapper = stable_getServantByServantNo(servantNo, CppEnums.ServantWhereType.ServantWhereTypeCrogdaloStable)
    end
    if servantWrapper ~= nil then
      local levelIndex = 0
      if selectedLevel ~= nil then
        levelIndex = self._growUpSelectInfo._horseMaxLevel - math.min(selectedLevel, self._growUpSelectInfo._horseMaxLevel)
      else
        levelIndex = self._growUpSelectInfo._horseMaxLevel - math.min(servantWrapper:getLevel(), self._growUpSelectInfo._horseMaxLevel)
      end
      self._ui._growUp._cbx_horseLevel:SetSelectItemIndex(levelIndex)
    else
      self._ui._growUp._cbx_horseLevel:SetSelectItemIndex(0)
    end
    local currentServantFormIndexRaw = servantWrapper:getFormIndexRaw()
    local formManager = getServantFormManager()
    if formManager == nil then
      self._ui._growUp._stc_horseImage:ChangeTextureInfoNameAsync(dataWrapper:getIconPath1())
    else
      local currentDefaultFormIndexRaw = servantWrapper:getDefaultFormIndexRaw()
      if currentServantFormIndexRaw == 0 or currentServantFormIndexRaw == currentDefaultFormIndexRaw then
        self._ui._growUp._stc_horseImage:ChangeTextureInfoNameAsync(dataWrapper:getIconPath1())
      else
        local changableFormSSW = formManager:getFormByFormIndexRaw(currentServantFormIndexRaw)
        if changableFormSSW ~= nil then
          self._ui._growUp._stc_horseImage:ChangeTextureInfoNameAsync(changableFormSSW:getIcon1())
        end
      end
    end
  else
    self._ui._growUp._cbx_horseLevel:SetSelectItemIndex(0)
    self._ui._growUp._stc_horseImage:ChangeTextureInfoNameAsync(dataWrapper:getIconPath1())
  end
  self._ui._growUp._stc_horseImage:setRenderTexture(self._ui._growUp._stc_horseImage:getBaseTexture())
  self._ui._growUp._stc_horseImage:SetShow(true)
  self._lastGrowUpHorseLevelComboBoxToIndex = self._ui._growUp._cbx_horseLevel:GetSelectIndex()
  self._ui._growUp._cbx_horseLevel:GetListControl():SetToIndex(self._lastGrowUpHorseLevelComboBoxToIndex)
  local genderTextureId
  local horseCharacterKeyRaw = dataWrapper:getCharacterKeyRaw()
  local servantInfo = stable_getServantByCharacterKey(CharacterKey(horseCharacterKeyRaw), 1)
  if servantInfo ~= nil and servantInfo:isDisplayGender() == false then
    self._ui._growUp._stc_horseGender:SetShow(false)
  else
    if dataWrapper:isMale() == true then
      genderTextureId = "Combine_Etc_Stable_Male"
    else
      genderTextureId = "Combine_Etc_Stable_Female"
    end
    self._ui._growUp._stc_horseGender:ChangeTextureInfoTextureIDAsync(genderTextureId)
    self._ui._growUp._stc_horseGender:setRenderTexture(self._ui._growUp._stc_horseGender:getBaseTexture())
    self._ui._growUp._stc_horseGender:SetShow(true)
  end
  self._lastGrowUpHorseLevelComboBoxToIndex = nil
  if self._isConsole == true then
    ToClient_padSnapRefreshTarget(self._ui._growUp._cbx_horseLevel)
  end
  self:updateGrowUpResult()
  return true
end
function PaGlobal_ServantSimulator:updateGrowUpResult()
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  if self._growUpSelectInfo._dataIndex == nil or self._growUpSelectInfo._isMyHorse == nil or self._growUpSelectInfo._horseMaxLevel == nil then
    return
  end
  local level = self._growUpSelectInfo._horseMaxLevel - self._ui._growUp._cbx_horseLevel:GetSelectIndex()
  local dataWrapper
  if self._growUpSelectInfo._isMyHorse == true then
    dataWrapper = ToClient_GetHorseSimulateGrowUpMyHorseSelectInfoByIndex(self._growUpSelectInfo._dataIndex)
  else
    dataWrapper = ToClient_GetHorseSimulateGrowUpAllSelectInfoByIndex(self._growUpSelectInfo._dataIndex)
  end
  self:updateGrowUpResult_Vitality(dataWrapper, level)
  self:updateGrowUpResult_Ability(dataWrapper, level)
  self:updateGrowUpResult_Skill(dataWrapper, level)
  if level < 30 then
    self._ui._growUp._stc_growUpRight:SetShow(true)
    self._ui._growUp._txt_maxLevelDesc:SetShow(false)
  else
    self._ui._growUp._stc_growUpRight:SetShow(false)
    self._ui._growUp._txt_maxLevelDesc:SetShow(true)
  end
  self:updateGrowUpResult_DefaultStat(dataWrapper, level)
end
function PaGlobal_ServantSimulator:updateGrowUpResult_Vitality(dataWrapper, level)
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  if dataWrapper == nil then
    return
  end
  if dataWrapper:isExistExperienceStatic(level) == false then
    return
  end
  local listManager = self._ui._growUp._lst_vitality:getElementManager()
  if listManager == nil then
    return
  end
  listManager:clearKey()
  listManager:pushKey(toInt64(0, self._list_subject_vitality))
  local lifeLevel = self._ui._growUp._cbx_lifeLevel:GetSelectIndex()
  if lifeLevel == 0 then
    lifeLevel = 1
  end
  local hpMin = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_HP, true, level + 1, true, lifeLevel)
  local hpMax = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_HP, false, level + 1, true, lifeLevel)
  local mpMin = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_MP, true, level + 1, true, lifeLevel)
  local mpMax = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_MP, false, level + 1, true, lifeLevel)
  local vitalityMin = math.min(hpMin, mpMin)
  local vitalityMax = math.max(hpMax, mpMax)
  for vitalityValue = vitalityMin, vitalityMax do
    listManager:pushKey(toInt64(level, vitalityValue))
  end
end
function PaGlobal_ServantSimulator:updateGrowUpResult_Ability(dataWrapper, level)
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  if dataWrapper == nil then
    return
  end
  if dataWrapper:isExistExperienceStatic(level) == false then
    return
  end
  local listManager = self._ui._growUp._lst_ability:getElementManager()
  if listManager == nil then
    return
  end
  listManager:clearKey()
  listManager:pushKey(toInt64(0, self._list_subject_ability))
  local lifeLevel = self._ui._growUp._cbx_lifeLevel:GetSelectIndex()
  if lifeLevel == 0 then
    lifeLevel = 1
  end
  local accelerationMinNotBonus = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_Acceleration, true, level + 1, false, lifeLevel)
  local accelerationMin = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_Acceleration, true, level + 1, true, lifeLevel)
  local accelerationMax = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_Acceleration, false, level + 1, true, lifeLevel)
  local speedMinNotBonus = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_Speed, true, level + 1, false, lifeLevel)
  local speedMin = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_Speed, true, level + 1, true, lifeLevel)
  local speedMax = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_Speed, false, level + 1, true, lifeLevel)
  local corneringMinNotBonus = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_Cornering, true, level + 1, false, lifeLevel)
  local corneringMin = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_Cornering, true, level + 1, true, lifeLevel)
  local corneringMax = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_Cornering, false, level + 1, true, lifeLevel)
  local brakeMinNotBonus = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_Brake, true, level + 1, false, lifeLevel)
  local brakeMin = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_Brake, true, level + 1, true, lifeLevel)
  local brakeMax = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_Brake, false, level + 1, true, lifeLevel)
  local abilityMinNotBonus = math.min(math.min(accelerationMinNotBonus, speedMinNotBonus), math.min(corneringMinNotBonus, brakeMinNotBonus))
  local abilityMin = math.min(math.min(accelerationMin, speedMin), math.min(corneringMin, brakeMin))
  local abilityMax = math.max(math.max(accelerationMax, speedMax), math.max(corneringMax, brakeMax))
  local maxValueCount = 0
  self._growUpSelectInfo._abilityInfoList = {
    [__eHorseSimulateGrowUpStatType_Acceleration] = accelerationMax - accelerationMin,
    [__eHorseSimulateGrowUpStatType_Speed] = speedMax - speedMin,
    [__eHorseSimulateGrowUpStatType_Cornering] = corneringMax - corneringMin,
    [__eHorseSimulateGrowUpStatType_Brake] = brakeMax - brakeMin
  }
  for abilityValue = abilityMin, abilityMax do
    listManager:pushKey(toInt64(level, abilityValue))
  end
end
function PaGlobal_ServantSimulator:updateGrowUpResult_Skill(dataWrapper, level)
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  if dataWrapper == nil then
    return
  end
  local listManager = self._ui._growUp._lst_skill:getElementManager()
  if listManager == nil then
    return
  end
  local topIndex = self._ui._growUp._lst_skill:getCurrenttoIndex()
  local scroll = self._ui._growUp._lst_skill:GetVScroll()
  local scrollPos = scroll:GetControlPos()
  listManager:clearKey()
  local selectedSkillKeyString = ""
  if self._selectGrowUpSkillIndexList ~= nil then
    for key, value in pairs(self._selectGrowUpSkillIndexList) do
      if value ~= nil then
        selectedSkillKeyString = selectedSkillKeyString .. tostring(value._skillKey) .. ","
      end
    end
  end
  local horseCharacterKeyRaw = dataWrapper:getCharacterKeyRaw()
  local isImprint = self._ui._growUp._chk_imprint:IsCheck()
  local isEquipAvatar = self._ui._growUp._chk_equipAvatar:IsCheck()
  local lifeLevel = self._ui._growUp._cbx_lifeLevel:GetSelectIndex()
  if lifeLevel == 0 then
    lifeLevel = 1
  end
  local isValidResult = ToClient_MakeHorseSimulateGrowUpSkillInfo(horseCharacterKeyRaw, level, selectedSkillKeyString, isImprint, isEquipAvatar, lifeLevel)
  if isValidResult == false then
    return
  end
  listManager:pushKey(toInt64(0, self._list_subject_skillCantLearn))
  local dataCount = ToClient_GetHorseSimulateGrowUpSkillInfoCount()
  for dataIndex = 0, dataCount - 1 do
    listManager:pushKey(toInt64(0, dataIndex))
  end
  self._ui._growUp._lst_skill:setCurrenttoIndex(topIndex)
  scroll:SetControlPos(scrollPos)
end
function PaGlobal_ServantSimulator:updateGrowUpResult_DefaultStat(dataWrapper, level)
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  if dataWrapper == nil then
    return
  end
  local horseCharacterKeyRaw = dataWrapper:getCharacterKeyRaw()
  self._ui._growUp._txt_hp:SetText(ToClient_GetHorseSimulateGrowUpDefaultStat(horseCharacterKeyRaw, 1, __eHorseSimulateGrowUpStatType_HP))
  self._ui._growUp._txt_mp:SetText(ToClient_GetHorseSimulateGrowUpDefaultStat(horseCharacterKeyRaw, 1, __eHorseSimulateGrowUpStatType_MP))
  self._ui._growUp._txt_acceleration:SetText(PaGlobalFunc_Util_MakeRateDotString(ToClient_GetHorseSimulateGrowUpDefaultStat(horseCharacterKeyRaw, level, __eHorseSimulateGrowUpStatType_Acceleration) / 1000000, 1, true))
  self._ui._growUp._txt_speed:SetText(PaGlobalFunc_Util_MakeRateDotString(ToClient_GetHorseSimulateGrowUpDefaultStat(horseCharacterKeyRaw, level, __eHorseSimulateGrowUpStatType_Speed) / 1000000, 1, true))
  self._ui._growUp._txt_cornering:SetText(PaGlobalFunc_Util_MakeRateDotString(ToClient_GetHorseSimulateGrowUpDefaultStat(horseCharacterKeyRaw, level, __eHorseSimulateGrowUpStatType_Cornering) / 1000000, 1, true))
  self._ui._growUp._txt_brake:SetText(PaGlobalFunc_Util_MakeRateDotString(ToClient_GetHorseSimulateGrowUpDefaultStat(horseCharacterKeyRaw, level, __eHorseSimulateGrowUpStatType_Brake) / 1000000, 1, true))
  local horseNameString = dataWrapper:getHorseTitleNameForLua()
  if ToClient_IsDevelopment() == true then
    horseNameString = horseNameString .. "(" .. tostring(dataWrapper:getCharacterKeyRaw()) .. ")"
  end
  self._ui._growUp._txt_shape:SetText(horseNameString)
end
function PaGlobal_ServantSimulator:onCreateGrowUpVitalityContent(content, key)
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  if self._growUpSelectInfo._dataIndex == nil or self._growUpSelectInfo._isMyHorse == nil then
    return
  end
  local level = highFromUint64(key)
  local statValue = lowFromUint64(key)
  local dataWrapper
  if self._growUpSelectInfo._isMyHorse == true then
    dataWrapper = ToClient_GetHorseSimulateGrowUpMyHorseSelectInfoByIndex(self._growUpSelectInfo._dataIndex)
  else
    dataWrapper = ToClient_GetHorseSimulateGrowUpAllSelectInfoByIndex(self._growUpSelectInfo._dataIndex)
  end
  if dataWrapper == nil then
    return
  end
  local horseCharacterKeyRaw = dataWrapper:getCharacterKeyRaw()
  local baseHpDiff = 0
  local baseMpDiff = 0
  if dataWrapper:isExistExperienceStatic(level) == true and dataWrapper:isExistExperienceStatic(level + 1) == true then
    local currentBaseHP = ToClient_GetHorseSimulateGrowUpDefaultStat(horseCharacterKeyRaw, level, __eHorseSimulateGrowUpStatType_HP)
    local nextBaseHP = ToClient_GetHorseSimulateGrowUpDefaultStat(horseCharacterKeyRaw, level + 1, __eHorseSimulateGrowUpStatType_HP)
    local currentBaseMP = ToClient_GetHorseSimulateGrowUpDefaultStat(horseCharacterKeyRaw, level, __eHorseSimulateGrowUpStatType_MP)
    local nextBaseMP = ToClient_GetHorseSimulateGrowUpDefaultStat(horseCharacterKeyRaw, level + 1, __eHorseSimulateGrowUpStatType_MP)
    baseHpDiff = nextBaseHP - currentBaseHP
    baseMpDiff = nextBaseMP - currentBaseMP
  end
  local lifeLevel = self._ui._growUp._cbx_lifeLevel:GetSelectIndex()
  if lifeLevel == 0 then
    lifeLevel = 1
  end
  local hpMin = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_HP, true, level + 1, true, lifeLevel)
  local hpMax = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_HP, false, level + 1, true, lifeLevel)
  local hpDiff = hpMax - hpMin + 1
  local mpMin = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_MP, true, level + 1, true, lifeLevel)
  local mpMax = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_MP, false, level + 1, true, lifeLevel)
  local mpDiff = mpMax - mpMin + 1
  local txt_value1_small = UI.getChildControl(content, "StaticText_Value1_Small")
  local txt_value1_big = UI.getChildControl(content, "StaticText_Value1_Big")
  local txt_value2 = UI.getChildControl(content, "StaticText_Value2")
  local txt_value3_small = UI.getChildControl(content, "StaticText_Value1_Right_Small")
  local txt_value3_big = UI.getChildControl(content, "StaticText_Value1_Right_Big")
  local txt_value4 = UI.getChildControl(content, "StaticText_Value2_Right")
  if statValue == self._list_subject_vitality then
    txt_value1_small:SetShow(true)
    txt_value3_small:SetShow(true)
    txt_value1_big:SetShow(false)
    txt_value3_big:SetShow(false)
    txt_value1_small:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_RANGE_TITLE"))
    txt_value3_small:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_RANGE_TITLE"))
    txt_value2:SetText(PAGetString(Defines.StringSheet_RESOURCE, "SERVANT_INFO_TEXT_HP"))
    txt_value4:SetText(PAGetString(Defines.StringSheet_RESOURCE, "SERVANT_INFO_TEXT_STAMINA"))
    txt_value2:ChangeTextureInfoTextureIDAsync("Combine_Frame_03_TableBG_Title")
    txt_value2:setRenderTexture(txt_value2:getBaseTexture())
    txt_value4:ChangeTextureInfoTextureIDAsync("Combine_Frame_03_TableBG_Title")
    txt_value4:setRenderTexture(txt_value4:getBaseTexture())
  else
    txt_value1_small:SetShow(false)
    txt_value3_small:SetShow(false)
    txt_value1_big:SetShow(true)
    txt_value3_big:SetShow(true)
    txt_value1_big:SetText(baseHpDiff + statValue)
    txt_value3_big:SetText(baseMpDiff + statValue)
    txt_value2:SetText(PaGlobalFunc_Util_MakeRateDotString(1 / hpDiff, 4, true))
    txt_value4:SetText(PaGlobalFunc_Util_MakeRateDotString(1 / mpDiff, 4, true))
    txt_value2:ChangeTextureInfoTextureIDAsync("Combine_Frame_03_TableBG_Sub")
    txt_value2:setRenderTexture(txt_value2:getBaseTexture())
    txt_value4:ChangeTextureInfoTextureIDAsync("Combine_Frame_03_TableBG_Sub")
    txt_value4:setRenderTexture(txt_value4:getBaseTexture())
  end
end
function PaGlobal_ServantSimulator:onCreateGrowUpAbilityContent(content, key)
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  if self._growUpSelectInfo._dataIndex == nil or self._growUpSelectInfo._isMyHorse == nil then
    return
  end
  local level = highFromUint64(key)
  local statValue = lowFromUint64(key)
  local dataWrapper
  if self._growUpSelectInfo._isMyHorse == true then
    dataWrapper = ToClient_GetHorseSimulateGrowUpMyHorseSelectInfoByIndex(self._growUpSelectInfo._dataIndex)
  else
    dataWrapper = ToClient_GetHorseSimulateGrowUpAllSelectInfoByIndex(self._growUpSelectInfo._dataIndex)
  end
  if dataWrapper == nil then
    return
  end
  local txt_value1_small = UI.getChildControl(content, "StaticText_Value1_Small")
  local txt_value1_big = UI.getChildControl(content, "StaticText_Value1_Big")
  local txt_value2 = UI.getChildControl(content, "StaticText_Value2")
  local txt_value3 = UI.getChildControl(content, "StaticText_Value3")
  local txt_value4 = UI.getChildControl(content, "StaticText_Value4")
  local txt_value5 = UI.getChildControl(content, "StaticText_Value5")
  if statValue == self._list_subject_ability then
    txt_value1_small:SetShow(true)
    txt_value1_big:SetShow(false)
    txt_value1_small:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_RANGE_TITLE"))
    txt_value2:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_ACCELERATION"))
    txt_value3:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_MAXSPEED"))
    txt_value4:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_CORNERING"))
    txt_value5:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_BRAKE"))
    txt_value2:ChangeTextureInfoTextureIDAsync("Combine_Frame_03_TableBG_Title")
    txt_value2:setRenderTexture(txt_value2:getBaseTexture())
    txt_value3:ChangeTextureInfoTextureIDAsync("Combine_Frame_03_TableBG_Title")
    txt_value3:setRenderTexture(txt_value3:getBaseTexture())
    txt_value4:ChangeTextureInfoTextureIDAsync("Combine_Frame_03_TableBG_Title")
    txt_value4:setRenderTexture(txt_value4:getBaseTexture())
    txt_value5:ChangeTextureInfoTextureIDAsync("Combine_Frame_03_TableBG_Title")
    txt_value5:setRenderTexture(txt_value5:getBaseTexture())
  else
    local realStat = statValue / 10
    local lifeLevel = self._ui._growUp._cbx_lifeLevel:GetSelectIndex()
    if lifeLevel == 0 then
      lifeLevel = 1
    end
    local accelerationDiff = 1 / (self._growUpSelectInfo._abilityInfoList[__eHorseSimulateGrowUpStatType_Acceleration] + 1)
    local speedDiff = 1 / (self._growUpSelectInfo._abilityInfoList[__eHorseSimulateGrowUpStatType_Speed] + 1)
    local corneringDiff = 1 / (self._growUpSelectInfo._abilityInfoList[__eHorseSimulateGrowUpStatType_Cornering] + 1)
    local brakeDiff = 1 / (self._growUpSelectInfo._abilityInfoList[__eHorseSimulateGrowUpStatType_Brake] + 1)
    txt_value1_small:SetShow(false)
    txt_value1_big:SetShow(true)
    txt_value1_big:SetText(PaGlobalFunc_Util_MakeRateDotString(realStat / 100, 2, false))
    txt_value2:SetText(PaGlobalFunc_Util_MakeRateDotString(accelerationDiff, 4, true))
    txt_value3:SetText(PaGlobalFunc_Util_MakeRateDotString(speedDiff, 4, true))
    txt_value4:SetText(PaGlobalFunc_Util_MakeRateDotString(corneringDiff, 4, true))
    txt_value5:SetText(PaGlobalFunc_Util_MakeRateDotString(brakeDiff, 4, true))
    txt_value2:ChangeTextureInfoTextureIDAsync("Combine_Frame_03_TableBG_Sub")
    txt_value2:setRenderTexture(txt_value2:getBaseTexture())
    txt_value3:ChangeTextureInfoTextureIDAsync("Combine_Frame_03_TableBG_Sub")
    txt_value3:setRenderTexture(txt_value3:getBaseTexture())
    txt_value4:ChangeTextureInfoTextureIDAsync("Combine_Frame_03_TableBG_Sub")
    txt_value4:setRenderTexture(txt_value4:getBaseTexture())
    txt_value5:ChangeTextureInfoTextureIDAsync("Combine_Frame_03_TableBG_Sub")
    txt_value5:setRenderTexture(txt_value5:getBaseTexture())
  end
end
function PaGlobal_ServantSimulator:onCreateGrowUpSkillContent(content, key)
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  local dataIndex = Int64toInt32(key)
  local cbx_skill = UI.getChildControl(content, "CheckButton_SkillName")
  local stc_icon = UI.getChildControl(cbx_skill, "Static_SkillIcon")
  local txt_skillName = UI.getChildControl(cbx_skill, "StaticText_SkillName")
  local txt_rate = UI.getChildControl(cbx_skill, "StaticText_SkillPercent")
  local txt_learnedSkill = UI.getChildControl(cbx_skill, "StaticText_LearnedSkill")
  if dataIndex == self._list_subject_skillCantLearn then
    cbx_skill:SetIgnore(true)
    cbx_skill:SetCheck(false)
    stc_icon:SetShow(false)
    txt_skillName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_NO_SKILL_RATE"))
    txt_rate:SetText(PaGlobalFunc_Util_MakeRateDotString(ToClient_GetHorseSimulateGrowUpCantLearnableRate(), 4, true))
    txt_learnedSkill:SetShow(false)
  else
    local dataWrapper = ToClient_GetHorseSimulateGrowUpSkillInfoByIndex(dataIndex)
    if dataWrapper == nil then
      return
    end
    local skillWrapper = dataWrapper:getSkillWrapper()
    if skillWrapper == nil then
      return
    end
    local isDefaultSkill = dataWrapper:isDefaultSkill()
    local isSelect = dataWrapper:isSelected()
    if isDefaultSkill == true then
      cbx_skill:SetIgnore(true)
      cbx_skill:removeInputEvent("Mouse_LUp")
      cbx_skill:SetCheck(true)
    else
      cbx_skill:SetIgnore(false)
      cbx_skill:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSimulator_SelectGrowUpSkill(" .. tostring(dataIndex) .. "," .. tostring(dataWrapper:getSkillKey()) .. ")")
      cbx_skill:SetCheck(isSelect)
    end
    stc_icon:SetShow(true)
    stc_icon:ChangeTextureInfoNameAsync("Icon/" .. skillWrapper:getIconPath())
    txt_skillName:SetText(skillWrapper:getName())
    txt_rate:SetShow(true)
    if isSelect == true then
      if isDefaultSkill == true then
        txt_rate:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_DEFAULT_SKILL"))
        txt_learnedSkill:SetShow(false)
      else
        txt_rate:SetText("")
        txt_learnedSkill:SetShow(true)
      end
    else
      txt_rate:SetText(PaGlobalFunc_Util_MakeRateDotString(dataWrapper:getRate(), 4, true))
      txt_learnedSkill:SetShow(false)
    end
  end
end
