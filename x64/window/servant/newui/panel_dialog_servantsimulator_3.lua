function ServantSimulator_ResultSort(ii, jj)
  if ii._tierValue < jj._tierValue then
    return -1
  elseif ii._tierValue > jj._tierValue then
    return 1
  else
    return 0
  end
end
function PaGlobal_ServantSimulator:initMatingControl()
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  self._ui._mating._stc_matingBg = UI.getChildControl(Panel_Dialog_ServantSimulator, "Static_MatingRate")
  self._ui._mating._stc_matingLeft = UI.getChildControl(self._ui._mating._stc_matingBg, "Static_LeftBg")
  self._ui._mating._stc_editBg = UI.getChildControl(self._ui._mating._stc_matingLeft, "Static_Edit")
  self._ui._mating._txt_proficiency = UI.getChildControl(self._ui._mating._stc_editBg, "StaticText_InputStat")
  self._ui._mating._btn_editClear = UI.getChildControl(self._ui._mating._stc_editBg, "Button_Clear")
  self._ui._mating._btn_editClearConsole = UI.getChildControl(self._ui._mating._stc_editBg, "Static_ConsoleXIcon")
  local horseImageMaleBg = UI.getChildControl(self._ui._mating._stc_matingLeft, "Static_HorseImageBG_Male")
  local horseImageMale = UI.getChildControl(horseImageMaleBg, "Static_HorseImage")
  self._ui._mating._stc_horseImageMale = UI.getChildControl(horseImageMale, "Static_RealImage")
  self._ui._mating._stc_selectHorseMale = UI.getChildControl(horseImageMale, "Static_SelectHorse")
  self._ui._mating._stc_horseGenderMale = UI.getChildControl(horseImageMale, "Static_Gender")
  self._ui._mating._txt_horseNameMale = UI.getChildControl(horseImageMale, "StaticText_Name")
  self._ui._mating._btn_changeHorseMale = UI.getChildControl(horseImageMaleBg, "Button_ChangeHorse")
  self._ui._mating._btn_resetMale = UI.getChildControl(horseImageMaleBg, "Button_Reset")
  self._ui._mating._cbx_horseLevelMale = UI.getChildControl(self._ui._mating._stc_matingLeft, "Combobox_HorseLevel_Male")
  local horseSkillMale = UI.getChildControl(self._ui._mating._stc_matingLeft, "Static_SelectSkill_Male")
  self._ui._mating._lst_horseSkillMale = UI.getChildControl(horseSkillMale, "List2_HorseSkillList")
  local horseImageFemaleBg = UI.getChildControl(self._ui._mating._stc_matingLeft, "Static_HorseImageBG_Female")
  local horseImageFemale = UI.getChildControl(horseImageFemaleBg, "Static_HorseImage")
  self._ui._mating._stc_horseImageFemale = UI.getChildControl(horseImageFemale, "Static_RealImage")
  self._ui._mating._stc_selectHorseFemale = UI.getChildControl(horseImageFemale, "Static_SelectHorse")
  self._ui._mating._stc_horseGenderFemale = UI.getChildControl(horseImageFemale, "Static_Gender")
  self._ui._mating._txt_horseNameFemale = UI.getChildControl(horseImageFemale, "StaticText_Name")
  self._ui._mating._btn_changeHorseFemale = UI.getChildControl(horseImageFemaleBg, "Button_ChangeHorse")
  self._ui._mating._btn_resetFemale = UI.getChildControl(horseImageFemaleBg, "Button_Reset")
  self._ui._mating._cbx_horseLevelFemale = UI.getChildControl(self._ui._mating._stc_matingLeft, "Combobox_HorseLevel_Female")
  local horseSkillFemale = UI.getChildControl(self._ui._mating._stc_matingLeft, "Static_SelectSkill_Female")
  self._ui._mating._lst_horseSkillFemale = UI.getChildControl(horseSkillFemale, "List2_HorseSkillList")
  self._ui._mating._stc_matingRight = UI.getChildControl(self._ui._mating._stc_matingBg, "Static_RightBg")
  self._ui._mating._frm_matingResult = UI.getChildControl(self._ui._mating._stc_matingRight, "Frame_MatingResultList")
  self._ui._mating._frmContent_matingResult = UI.getChildControl(self._ui._mating._frm_matingResult, "Frame_1_Content")
  self._ui._mating._stc_matingResultGroupTemplate = UI.getChildControl(self._ui._mating._frmContent_matingResult, "Static_GroupTemplate")
  self._ui._mating._stc_matingResultHorseTemplate = UI.getChildControl(self._ui._mating._stc_matingResultGroupTemplate, "Static_HorseImageTemplate")
  self._ui._mating._stc_matingResultGroupTemplate:SetShow(false)
  self._ui._mating._stc_matingResultHorseTemplate:SetShow(false)
  self:clearMatingEditText()
end
function PaGlobal_ServantSimulator:registEventHandler_Mating()
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  self._ui._mating._stc_editBg:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSimulator_InputStat()")
  self._ui._mating._btn_editClear:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSimulator_ClearMatingEditText()")
  self._ui._mating._stc_selectHorseMale:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSimulator_ToggleSubView(" .. tostring(__eHorseSimulateHorseMaleType_Male) .. ")")
  self._ui._mating._stc_selectHorseFemale:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSimulator_ToggleSubView(" .. tostring(__eHorseSimulateHorseMaleType_Female) .. ")")
  self._ui._mating._btn_changeHorseMale:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSimulator_ToggleSubView(" .. tostring(__eHorseSimulateHorseMaleType_Male) .. ")")
  self._ui._mating._btn_changeHorseMale:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSimulator_ShowChangeHorseButtonTooltip(1, true)")
  self._ui._mating._btn_changeHorseMale:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantSimulator_ShowChangeHorseButtonTooltip(1, false)")
  self._ui._mating._btn_changeHorseFemale:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSimulator_ToggleSubView(" .. tostring(__eHorseSimulateHorseMaleType_Female) .. ")")
  self._ui._mating._btn_changeHorseFemale:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSimulator_ShowChangeHorseButtonTooltip(2, true)")
  self._ui._mating._btn_changeHorseFemale:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantSimulator_ShowChangeHorseButtonTooltip(2, false)")
  self._ui._mating._btn_resetMale:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSimulator_ResetMatingSelectInfo(" .. tostring(__eHorseSimulateHorseMaleType_Male) .. ")")
  self._ui._mating._btn_resetMale:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSimulator_ShowSelectInfoResetButtonTooltip(1, true)")
  self._ui._mating._btn_resetMale:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantSimulator_ShowSelectInfoResetButtonTooltip(1, false)")
  self._ui._mating._btn_resetFemale:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSimulator_ResetMatingSelectInfo(" .. tostring(__eHorseSimulateHorseMaleType_Female) .. ")")
  self._ui._mating._btn_resetFemale:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSimulator_ShowSelectInfoResetButtonTooltip(2, true)")
  self._ui._mating._btn_resetFemale:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantSimulator_ShowSelectInfoResetButtonTooltip(2, false)")
  self._ui._mating._cbx_horseLevelMale:GetListControl():AddSelectEvent("HandleEventLUp_ServantSimulator_MatingHorseLevelComboBoxItem(" .. tostring(__eHorseSimulateHorseMaleType_Male) .. ")")
  self._ui._mating._cbx_horseLevelMale:setListTextHorizonCenter()
  self._ui._mating._cbx_horseLevelMale:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSimulator_MatingHorseLevelComboBox(" .. tostring(__eHorseSimulateHorseMaleType_Male) .. ")")
  self._ui._mating._cbx_horseLevelFemale:GetListControl():AddSelectEvent("HandleEventLUp_ServantSimulator_MatingHorseLevelComboBoxItem(" .. tostring(__eHorseSimulateHorseMaleType_Female) .. ")")
  self._ui._mating._cbx_horseLevelFemale:setListTextHorizonCenter()
  self._ui._mating._cbx_horseLevelFemale:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSimulator_MatingHorseLevelComboBox(" .. tostring(__eHorseSimulateHorseMaleType_Female) .. ")")
  self._ui._mating._lst_horseSkillMale:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_ServantSimulator_OnCreateMaleMatingSkillContent")
  self._ui._mating._lst_horseSkillMale:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._mating._lst_horseSkillFemale:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_ServantSimulator_OnCreateFemaleMatingSkillContent")
  self._ui._mating._lst_horseSkillFemale:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_ServantSimulator:validate_Mating()
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  self._ui._mating._stc_matingBg:isValidate()
  self._ui._mating._stc_matingLeft:isValidate()
  self._ui._mating._stc_editBg:isValidate()
  self._ui._mating._txt_proficiency:isValidate()
  self._ui._mating._btn_editClear:isValidate()
  self._ui._mating._btn_editClearConsole:isValidate()
  self._ui._mating._stc_horseImageMale:isValidate()
  self._ui._mating._stc_selectHorseMale:isValidate()
  self._ui._mating._btn_changeHorseMale:isValidate()
  self._ui._mating._txt_horseNameMale:isValidate()
  self._ui._mating._stc_horseGenderMale:isValidate()
  self._ui._mating._btn_resetMale:isValidate()
  self._ui._mating._cbx_horseLevelMale:isValidate()
  self._ui._mating._lst_horseSkillMale:isValidate()
  self._ui._mating._stc_horseImageFemale:isValidate()
  self._ui._mating._stc_selectHorseFemale:isValidate()
  self._ui._mating._btn_changeHorseFemale:isValidate()
  self._ui._mating._txt_horseNameFemale:isValidate()
  self._ui._mating._stc_horseGenderFemale:isValidate()
  self._ui._mating._btn_resetFemale:isValidate()
  self._ui._mating._cbx_horseLevelFemale:isValidate()
  self._ui._mating._lst_horseSkillFemale:isValidate()
  self._ui._mating._stc_matingRight:isValidate()
  self._ui._mating._frm_matingResult:isValidate()
  self._ui._mating._frmContent_matingResult:isValidate()
  self._ui._mating._stc_matingResultGroupTemplate:isValidate()
  self._ui._mating._stc_matingResultHorseTemplate:isValidate()
end
function PaGlobal_ServantSimulator:updateRightBg_MatingSelectInfo(index, isOnlyMyHorse, maleType)
  if Panel_Dialog_ServantSimulator == nil or index == nil then
    return false
  end
  if maleType ~= __eHorseSimulateHorseMaleType_Male and maleType ~= __eHorseSimulateHorseMaleType_Female then
    UI.ASSERT_NAME(false, "maleType \234\176\146\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return false
  end
  local dataWrapper
  if isOnlyMyHorse == true then
    dataWrapper = ToClient_GetHorseSimulateMatingMyHorseSelectInfoByIndex(maleType, index)
  else
    dataWrapper = ToClient_GetHorseSimulateMatingAllSelectInfoByIndex(maleType, index)
  end
  if dataWrapper == nil then
    return false
  end
  local horseName = "-"
  if dataWrapper:isMyHorse() == true then
    horseName = dataWrapper:getMyHorseNameForLua()
  else
    horseName = dataWrapper:getHorseTitleNameForLua()
  end
  if ToClient_IsDevelopment() == true then
    horseName = horseName .. "(" .. tostring(dataWrapper:getCharacterKeyRaw()) .. ")"
  end
  local matingEffectiveLevelMax = ToClient_GetHorseMatingEffectiveLevelMax()
  if maleType == __eHorseSimulateHorseMaleType_Male then
    self._matingMaleSelectInfo._dataIndex = nil
    self._matingMaleSelectInfo._isMyHorse = nil
    self._ui._mating._stc_selectHorseMale:SetShow(false)
    self._ui._mating._btn_changeHorseMale:SetShow(true)
    self._ui._mating._txt_horseNameMale:SetText(horseName)
    if isOnlyMyHorse == true then
      local servantNo = dataWrapper:getServantNo()
      local servantWrapper = stable_getServantByServantNo(servantNo, CppEnums.ServantWhereType.ServantWhereTypeUser)
      if servantWrapper == nil then
        servantWrapper = stable_getServantByServantNo(servantNo, CppEnums.ServantWhereType.ServantWhereTypeCrogdaloStable)
      end
      local currentServantFormIndexRaw = servantWrapper:getFormIndexRaw()
      local formManager = getServantFormManager()
      if formManager == nil then
        self._ui._mating._stc_horseImageMale:ChangeTextureInfoNameAsync(dataWrapper:getIconPath1())
      else
        local currentDefaultFormIndexRaw = servantWrapper:getDefaultFormIndexRaw()
        if currentServantFormIndexRaw == 0 or currentServantFormIndexRaw == currentDefaultFormIndexRaw then
          self._ui._mating._stc_horseImageMale:ChangeTextureInfoNameAsync(dataWrapper:getIconPath1())
        else
          local changableFormSSW = formManager:getFormByFormIndexRaw(currentServantFormIndexRaw)
          if changableFormSSW ~= nil then
            self._ui._mating._stc_horseImageMale:ChangeTextureInfoNameAsync(changableFormSSW:getIcon1())
          end
        end
      end
    else
      self._ui._mating._stc_horseImageMale:ChangeTextureInfoNameAsync(dataWrapper:getIconPath1())
    end
    self._ui._mating._stc_horseImageMale:setRenderTexture(self._ui._mating._stc_horseImageMale:getBaseTexture())
    self._ui._mating._stc_horseImageMale:SetShow(true)
    local genderTextureId
    if dataWrapper:isMale() == true then
      genderTextureId = "Combine_Etc_Stable_Male"
    else
      genderTextureId = "Combine_Etc_Stable_Female"
    end
    self._ui._mating._stc_horseGenderMale:ChangeTextureInfoTextureIDAsync(genderTextureId)
    self._ui._mating._stc_horseGenderMale:setRenderTexture(self._ui._mating._stc_horseGenderMale:getBaseTexture())
    self._ui._mating._stc_horseGenderMale:SetShow(true)
    self._ui._mating._cbx_horseLevelMale:DeleteAllItem(0)
    local maxLevel = dataWrapper:getMaxLevel()
    if matingEffectiveLevelMax < maxLevel then
      maxLevel = matingEffectiveLevelMax
    end
    for level = 1, maxLevel do
      self._ui._mating._cbx_horseLevelMale:AddItem(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_HORSE_LEVEL", "level", level))
    end
    self._ui._mating._cbx_horseLevelMale:SetSelectItemIndex(0)
    self._lastMatingHorseLevelMaleComboBoxToIndex = nil
    if self._isConsole == true then
      ToClient_padSnapRefreshTarget(self._ui._mating._cbx_horseLevelMale)
    end
    local characterKeyRaw = dataWrapper:getCharacterKeyRaw()
    local skillCount = ToClient_GetHorseSimulateMatingSkillCount(characterKeyRaw)
    self._ui._mating._lst_horseSkillMale:getElementManager():clearKey()
    for skillIndex = 0, skillCount - 1 do
      self._ui._mating._lst_horseSkillMale:getElementManager():pushKey(toInt64(characterKeyRaw, skillIndex))
    end
    self._matingMaleSelectInfo._dataIndex = index
    self._matingMaleSelectInfo._isMyHorse = isOnlyMyHorse
  else
    self._matingFemaleSelectInfo._dataIndex = nil
    self._matingFemaleSelectInfo._isMyHorse = nil
    self._ui._mating._stc_selectHorseFemale:SetShow(false)
    self._ui._mating._btn_changeHorseFemale:SetShow(true)
    self._ui._mating._txt_horseNameFemale:SetText(horseName)
    if isOnlyMyHorse == true then
      local servantNo = dataWrapper:getServantNo()
      local servantWrapper = stable_getServantByServantNo(servantNo, CppEnums.ServantWhereType.ServantWhereTypeUser)
      if servantWrapper == nil then
        servantWrapper = stable_getServantByServantNo(servantNo, CppEnums.ServantWhereType.ServantWhereTypeCrogdaloStable)
      end
      local currentServantFormIndexRaw = servantWrapper:getFormIndexRaw()
      local formManager = getServantFormManager()
      if formManager == nil then
        self._ui._mating._stc_horseImageFemale:ChangeTextureInfoNameAsync(dataWrapper:getIconPath1())
      else
        local currentDefaultFormIndexRaw = servantWrapper:getDefaultFormIndexRaw()
        if currentServantFormIndexRaw == 0 or currentServantFormIndexRaw == currentDefaultFormIndexRaw then
          self._ui._mating._stc_horseImageFemale:ChangeTextureInfoNameAsync(dataWrapper:getIconPath1())
        else
          local changableFormSSW = formManager:getFormByFormIndexRaw(currentServantFormIndexRaw)
          if changableFormSSW ~= nil then
            self._ui._mating._stc_horseImageFemale:ChangeTextureInfoNameAsync(changableFormSSW:getIcon1())
          end
        end
      end
    else
      self._ui._mating._stc_horseImageFemale:ChangeTextureInfoNameAsync(dataWrapper:getIconPath1())
    end
    self._ui._mating._stc_horseImageFemale:setRenderTexture(self._ui._mating._stc_horseImageFemale:getBaseTexture())
    self._ui._mating._stc_horseImageFemale:SetShow(true)
    local genderTextureId
    if dataWrapper:isMale() == true then
      genderTextureId = "Combine_Etc_Stable_Male"
    else
      genderTextureId = "Combine_Etc_Stable_Female"
    end
    self._ui._mating._stc_horseGenderFemale:ChangeTextureInfoTextureIDAsync(genderTextureId)
    self._ui._mating._stc_horseGenderFemale:setRenderTexture(self._ui._mating._stc_horseGenderFemale:getBaseTexture())
    self._ui._mating._stc_horseGenderFemale:SetShow(true)
    self._ui._mating._cbx_horseLevelFemale:DeleteAllItem(0)
    local maxLevel = dataWrapper:getMaxLevel()
    if matingEffectiveLevelMax < maxLevel then
      maxLevel = matingEffectiveLevelMax
    end
    for level = 1, maxLevel do
      self._ui._mating._cbx_horseLevelFemale:AddItem(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_HORSE_LEVEL", "level", level))
    end
    self._ui._mating._cbx_horseLevelFemale:SetSelectItemIndex(0)
    self._lastMatingHorseLevelFemaleComboBoxToIndex = nil
    if self._isConsole == true then
      ToClient_padSnapRefreshTarget(self._ui._mating._cbx_horseLevelFemale)
    end
    local characterKeyRaw = dataWrapper:getCharacterKeyRaw()
    local skillCount = ToClient_GetHorseSimulateMatingSkillCount(characterKeyRaw)
    self._ui._mating._lst_horseSkillFemale:getElementManager():clearKey()
    for skillIndex = 0, skillCount - 1 do
      self._ui._mating._lst_horseSkillFemale:getElementManager():pushKey(toInt64(characterKeyRaw, skillIndex))
    end
    self._matingFemaleSelectInfo._dataIndex = index
    self._matingFemaleSelectInfo._isMyHorse = isOnlyMyHorse
  end
  self:updateMatingResult()
  return true
end
function PaGlobal_ServantSimulator:updateMatingResult()
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  self._ui._mating._frm_matingResult:SetShow(false)
  if self._matingMaleSelectInfo._dataIndex == nil or self._matingMaleSelectInfo._isMyHorse == nil then
    return
  end
  if self._matingFemaleSelectInfo._dataIndex == nil or self._matingFemaleSelectInfo._isMyHorse == nil then
    return
  end
  local maleDataWrapper
  if self._matingMaleSelectInfo._isMyHorse == true then
    maleDataWrapper = ToClient_GetHorseSimulateMatingMyHorseSelectInfoByIndex(__eHorseSimulateHorseMaleType_Male, self._matingMaleSelectInfo._dataIndex)
  else
    maleDataWrapper = ToClient_GetHorseSimulateMatingAllSelectInfoByIndex(__eHorseSimulateHorseMaleType_Male, self._matingMaleSelectInfo._dataIndex)
  end
  if maleDataWrapper == nil then
    UI.ASSERT_NAME(false, "\236\132\160\237\131\157\235\144\156 \236\136\152\236\187\183 \236\160\149\235\179\180\234\176\128 \236\151\134\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local femaleDataWrapper
  if self._matingFemaleSelectInfo._isMyHorse == true then
    femaleDataWrapper = ToClient_GetHorseSimulateMatingMyHorseSelectInfoByIndex(__eHorseSimulateHorseMaleType_Female, self._matingFemaleSelectInfo._dataIndex)
  else
    femaleDataWrapper = ToClient_GetHorseSimulateMatingAllSelectInfoByIndex(__eHorseSimulateHorseMaleType_Female, self._matingFemaleSelectInfo._dataIndex)
  end
  if femaleDataWrapper == nil then
    UI.ASSERT_NAME(false, "\236\132\160\237\131\157\235\144\156 \236\149\148\236\187\183 \236\160\149\235\179\180\234\176\128 \236\151\134\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local fromCharacterKeyRaw = maleDataWrapper:getCharacterKeyRaw()
  local fromLevel = self._ui._mating._cbx_horseLevelMale:GetSelectIndex() + 1
  local fromSkillIndexString = ""
  local toCharacterKeyRaw = femaleDataWrapper:getCharacterKeyRaw()
  local toLevel = self._ui._mating._cbx_horseLevelFemale:GetSelectIndex() + 1
  local toSkillIndexString = ""
  if self._selectMatingSkillList_Male ~= nil then
    for key, value in pairs(self._selectMatingSkillList_Male) do
      if value ~= nil and fromCharacterKeyRaw == value._characterKeyRaw then
        fromSkillIndexString = fromSkillIndexString .. "," .. tostring(value._skillIndex)
      end
    end
  end
  if self._selectMatingSkillList_Female ~= nil then
    for key, value in pairs(self._selectMatingSkillList_Female) do
      if value ~= nil and toCharacterKeyRaw == value._characterKeyRaw then
        toSkillIndexString = toSkillIndexString .. "," .. tostring(value._skillIndex)
      end
    end
  end
  local editText = self._ui._mating._txt_proficiency:GetText()
  local inputTrainingPower = 0
  if editText ~= nil and editText ~= "" then
    inputTrainingPower = tonumber(editText)
    if inputTrainingPower ~= nil and inputTrainingPower > 0 then
      if self._isConsole == true then
        self._ui._mating._btn_editClear:SetShow(false)
        self._ui._mating._btn_editClearConsole:SetShow(true)
      else
        self._ui._mating._btn_editClear:SetShow(true)
        self._ui._mating._btn_editClearConsole:SetShow(false)
      end
      self._ui._mating._txt_proficiency:SetText(tostring(inputTrainingPower))
    else
      inputTrainingPower = 0
      self:clearMatingEditText()
    end
  else
    self:clearMatingEditText()
  end
  local isValidResult = ToClient_MakeHorseSimulateMatingResult(fromCharacterKeyRaw, fromLevel, fromSkillIndexString, toCharacterKeyRaw, toLevel, toSkillIndexString, inputTrainingPower)
  if isValidResult == false then
    self._ui._mating._frm_matingResult:SetShow(false)
    return
  end
  self._ui._mating._frm_matingResult:SetShow(true)
  self:clearMatingResult()
  local resultCount = ToClient_GetHorseSimulateMatingResultCount()
  for resultIndex = 1, resultCount do
    local dataWrapper = ToClient_GetHorseSimulateMatingResultInfoByIndex(resultIndex - 1)
    if dataWrapper ~= nil then
      local horseTierValue = dataWrapper:getTier()
      local resultGroupDataIndex = self:findMatingResultGroupDataIndex(horseTierValue)
      local resultGroupData
      if resultGroupDataIndex == nil then
        resultGroupData = self:makeMatingResultGroup("Group_Tier_", horseTierValue)
        if horseTierValue == 0 then
          resultGroupData._title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_IMPERIALHORSELIST"))
          resultGroupData._helpIcon:SetShow(true)
          resultGroupData._helpIcon:SetPosX(resultGroupData._title:GetPosX() + resultGroupData._title:GetTextSizeX() + 5)
          resultGroupData._helpIcon:addInputEvent("Mouse_On", "PaGlobal_ServantSimulator:ShowTwinsTooltip(true)")
          resultGroupData._helpIcon:addInputEvent("Mouse_Out", "PaGlobal_ServantSimulator:ShowTwinsTooltip(false)")
          self._ui._mating._helpIcon = resultGroupData._helpIcon
        elseif horseTierValue == 9 then
          resultGroupData._title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_9TIERLIST"))
          resultGroupData._helpIcon:SetShow(false)
        else
          resultGroupData._title:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_HORSE_LIST", "tier", horseTierValue))
          resultGroupData._helpIcon:SetShow(false)
        end
        self._matingResultList:push_back(resultGroupData)
      else
        resultGroupData = self._matingResultList[resultGroupDataIndex]
      end
      resultGroupData._group:SetShow(true)
      resultGroupData._title:SetShow(true)
      resultGroupData._showHorseCount = resultGroupData._showHorseCount + 1
      local resultHorseData = resultGroupData._horseList[resultGroupData._showHorseCount]
      if resultHorseData == nil then
        resultHorseData = self:makeMatingResultHorse(resultGroupData._group, "Horse_" .. tostring(resultGroupData._showHorseCount))
        resultGroupData._horseList:push_back(resultHorseData)
      end
      resultHorseData._horse:SetShow(true)
      resultHorseData._image:ChangeTextureInfoNameAsync(dataWrapper:getIconPath1())
      resultHorseData._image:setRenderTexture(resultHorseData._image:getBaseTexture())
      resultHorseData._image:SetShow(true)
      if self._isConsole == true then
        ToClient_padSnapRefreshTarget(resultGroupData._group)
        ToClient_padSnapRefreshTarget(resultHorseData._image)
        resultHorseData._image:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSimulator_ToggleMatingResultHorseTypeToolTip( true, " .. resultIndex - 1 .. "," .. horseTierValue .. ", " .. resultGroupData._showHorseCount .. ")")
        resultHorseData._image:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantSimulator_ToggleMatingResultHorseTypeToolTip( false )")
      end
      local genderTextureId
      if dataWrapper:isMale() == true then
        genderTextureId = "Combine_Etc_Stable_Male"
      else
        genderTextureId = "Combine_Etc_Stable_Female"
      end
      resultHorseData._gender:ChangeTextureInfoTextureIDAsync(genderTextureId)
      resultHorseData._gender:setRenderTexture(resultHorseData._gender:getBaseTexture())
      resultHorseData._gender:SetShow(true)
      resultHorseData._gender:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSimulator_ToggleMatingResultHorseTypeToolTip( true, " .. resultIndex - 1 .. "," .. horseTierValue .. ", " .. resultGroupData._showHorseCount .. ")")
      resultHorseData._gender:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantSimulator_ToggleMatingResultHorseTypeToolTip( false )")
      resultHorseData._name:SetShow(false)
      resultHorseData._rate:SetText(PaGlobalFunc_Util_MakeRateDotString(dataWrapper:getRate(), 4, true))
      resultHorseData._rate:SetShow(true)
    end
  end
  self:refreshMatingResultFrameSize()
end
function PaGlobal_ServantSimulator:clearMatingResult()
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  if self._matingResultList == nil then
    self._matingResultList = Array.new()
  else
    for key, value in pairs(self._matingResultList) do
      if value ~= nil then
        value._group:SetShow(false)
        for horseKey, horseValue in pairs(value._horseList) do
          if horseValue ~= nil then
            horseValue._horse:SetShow(false)
          end
        end
        value._showHorseCount = 0
      end
    end
  end
end
function PaGlobal_ServantSimulator:findMatingResultGroupDataIndex(horseTierValue)
  if Panel_Dialog_ServantSimulator == nil then
    return nil
  end
  for key, value in pairs(self._matingResultList) do
    if value ~= nil and value._tierValue == horseTierValue then
      return key
    end
  end
  return nil
end
function PaGlobal_ServantSimulator:makeMatingResultGroup(name, tierValue)
  if Panel_Dialog_ServantSimulator == nil then
    return nil
  end
  local groupData = {
    _group = nil,
    _title = nil,
    _helpIcon = nil,
    _tierValue = nil,
    _showHorseCount = nil,
    _horseList = nil
  }
  groupData._group = UI.cloneControl(self._ui._mating._stc_matingResultGroupTemplate, self._ui._mating._frmContent_matingResult, name .. tostring(tierValue))
  groupData._title = UI.getChildControl(groupData._group, "StaticText_GroupTitle")
  groupData._helpIcon = UI.getChildControl(groupData._group, "Static_HorseHelpIcon")
  groupData._tierValue = tierValue
  groupData._showHorseCount = 0
  groupData._horseList = Array.new()
  return groupData
end
function PaGlobal_ServantSimulator:makeMatingResultHorse(parent, name)
  if Panel_Dialog_ServantSimulator == nil then
    return nil
  end
  local horseData = {
    _horse = nil,
    _image = nil,
    _gender = nil,
    _name = nil,
    _rate = nil
  }
  horseData._horse = UI.cloneControl(self._ui._mating._stc_matingResultHorseTemplate, parent, name)
  horseData._image = UI.getChildControl(horseData._horse, "Static_RealImage")
  horseData._gender = UI.getChildControl(horseData._horse, "Static_Gender")
  horseData._name = UI.getChildControl(horseData._horse, "StaticText_Name")
  horseData._rate = UI.getChildControl(horseData._horse, "StaticText_Rate")
  return horseData
end
function PaGlobal_ServantSimulator:refreshMatingResultFrameSize()
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  if self._matingResultList ~= nil then
    self._matingResultList:quicksort(ServantSimulator_ResultSort)
  end
  local frameVScroll = self._ui._mating._frm_matingResult:GetVScroll()
  local frameScrollPos = frameVScroll:GetControlPos()
  local groupTitleTemp = UI.getChildControl(self._ui._mating._stc_matingResultGroupTemplate, "StaticText_GroupTitle")
  local groupTitleSizeY = groupTitleTemp:GetSpanSize().y + groupTitleTemp:GetSizeY()
  local maxRowCount = math.floor(self._ui._mating._stc_matingResultGroupTemplate:GetSizeX() / self._ui._mating._stc_matingResultHorseTemplate:GetSizeX())
  local horseDataSizeX = self._ui._mating._stc_matingResultHorseTemplate:GetSizeX()
  local horseDataSizeY = self._ui._mating._stc_matingResultHorseTemplate:GetSizeY()
  local horseDataTermX = 5
  local horseDataTermY = 5
  local lastGroupSpanY = 0
  local lastGroupSizeY = 0
  for key, value in pairs(self._matingResultList) do
    if value ~= nil and value._group:GetShow() == true then
      local showHorseCount = 0
      local horseColIndex = 0
      local lastHorseSpanY = 0
      for horseKey, horseData in pairs(value._horseList) do
        if horseData ~= nil and horseData._horse:GetShow() == true then
          if maxRowCount <= showHorseCount then
            showHorseCount = 0
            horseColIndex = horseColIndex + 1
          end
          local spanX = showHorseCount * horseDataSizeX + horseDataTermX * (showHorseCount + 1)
          lastHorseSpanY = groupTitleSizeY + horseColIndex * horseDataSizeY + horseDataTermY * (horseColIndex + 1)
          horseData._horse:SetSpanSize(spanX, lastHorseSpanY)
          horseData._horse:ComputePos()
          showHorseCount = showHorseCount + 1
        end
      end
      lastGroupSpanY = lastGroupSpanY + lastGroupSizeY
      value._group:SetSpanSize(value._group:GetSpanSize().x, lastGroupSpanY)
      lastGroupSizeY = groupTitleSizeY + lastHorseSpanY + horseDataSizeY + horseDataTermY
      value._group:SetSize(value._group:GetSizeX(), lastGroupSizeY)
      value._group:ComputePos()
    end
  end
  self._ui._mating._frmContent_matingResult:SetSize(self._ui._mating._frmContent_matingResult:GetSizeX(), lastGroupSpanY + lastGroupSizeY)
  frameVScroll:SetControlPos(frameScrollPos)
  self._ui._mating._frm_matingResult:UpdateContentPos()
  if self._ui._mating._frm_matingResult:GetSizeY() < self._ui._mating._frmContent_matingResult:GetSizeY() then
    frameVScroll:SetShow(true)
  else
    frameVScroll:SetShow(false)
  end
end
function PaGlobal_ServantSimulator:onCreateMaleMatingSkillContent(content, key)
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  local characterKeyRaw = highFromUint64(key)
  local index = lowFromUint64(key)
  local dataWrapper = ToClient_GetHorseSimulateMatingSkillWrapperByIndex(characterKeyRaw, index)
  if dataWrapper == nil then
    return
  end
  local chk_skillInfo = UI.getChildControl(content, "CheckButton_SkillInfo")
  local stc_skillIcon = UI.getChildControl(chk_skillInfo, "Static_SkillIcon")
  local txt_skillName = UI.getChildControl(chk_skillInfo, "StaticText_SkillName")
  chk_skillInfo:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSimulator_SelectMatingSkill(" .. tostring(__eHorseSimulateHorseMaleType_Male) .. "," .. tostring(characterKeyRaw) .. ", " .. tostring(index) .. ")")
  stc_skillIcon:ChangeTextureInfoNameAsync("Icon/" .. dataWrapper:getIconPath())
  if txt_skillName ~= nil then
    txt_skillName:SetTextMode(__eTextMode_LimitText)
    txt_skillName:SetText(dataWrapper:getName())
    UI.setLimitTextAndAddTooltip(txt_skillName, txt_skillName:GetText())
  end
  self:updateMatingSkillButtonState(content, __eHorseSimulateHorseMaleType_Male, characterKeyRaw, index)
end
function PaGlobal_ServantSimulator:onCreateFemaleMatingSkillContent(content, key)
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  local characterKeyRaw = highFromUint64(key)
  local index = lowFromUint64(key)
  local dataWrapper = ToClient_GetHorseSimulateMatingSkillWrapperByIndex(characterKeyRaw, index)
  if dataWrapper == nil then
    return
  end
  local chk_skillInfo = UI.getChildControl(content, "CheckButton_SkillInfo")
  local stc_skillIcon = UI.getChildControl(chk_skillInfo, "Static_SkillIcon")
  local txt_skillName = UI.getChildControl(chk_skillInfo, "StaticText_SkillName")
  chk_skillInfo:SetCheck(false)
  chk_skillInfo:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSimulator_SelectMatingSkill(" .. tostring(__eHorseSimulateHorseMaleType_Female) .. "," .. tostring(characterKeyRaw) .. ", " .. tostring(index) .. ")")
  stc_skillIcon:ChangeTextureInfoNameAsync("Icon/" .. dataWrapper:getIconPath())
  if txt_skillName ~= nil then
    txt_skillName:SetTextMode(__eTextMode_LimitText)
    txt_skillName:SetText(dataWrapper:getName())
    UI.setLimitTextAndAddTooltip(txt_skillName, txt_skillName:GetText())
  end
  self:updateMatingSkillButtonState(content, __eHorseSimulateHorseMaleType_Female, characterKeyRaw, index)
end
function PaGlobal_ServantSimulator:updateMatingSkillButtonState(content, maleType, characterKeyRaw, skillIndex)
  if Panel_Dialog_ServantSimulator == nil or content == nil then
    return
  end
  local isSelected = false
  if maleType == __eHorseSimulateHorseMaleType_Male then
    if self._selectMatingSkillList_Male ~= nil then
      for key, value in pairs(self._selectMatingSkillList_Male) do
        if value ~= nil and value._characterKeyRaw == characterKeyRaw and value._skillIndex == skillIndex then
          isSelected = true
          break
        end
      end
    end
  elseif maleType == __eHorseSimulateHorseMaleType_Female then
    if self._selectMatingSkillList_Female ~= nil then
      for key, value in pairs(self._selectMatingSkillList_Female) do
        if value ~= nil and value._characterKeyRaw == characterKeyRaw and value._skillIndex == skillIndex then
          isSelected = true
          break
        end
      end
    end
  else
    UI.ASSERT_NAME(false, "maleType\236\157\180 \235\185\132\236\160\149\236\131\129\236\157\180\235\139\164!", "\236\157\180\236\163\188")
    return
  end
  local chk_skillInfo = UI.getChildControl(content, "CheckButton_SkillInfo")
  chk_skillInfo:SetCheck(isSelected)
end
function PaGlobal_ServantSimulator:clearMatingEditText()
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  self._ui._mating._btn_editClear:SetShow(false)
  self._ui._mating._btn_editClearConsole:SetShow(false)
  self._ui._mating._txt_proficiency:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_LIFEEXPERT"))
end
function PaGlobal_ServantSimulator:clearMatingSelectInfo(maleType)
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  if maleType ~= __eHorseSimulateHorseMaleType_Male and maleType ~= __eHorseSimulateHorseMaleType_Female then
    return
  end
  if maleType == __eHorseSimulateHorseMaleType_Male then
    self._selectMatingSkillList_Male = nil
    self._matingMaleSelectInfo._dataIndex = nil
    self._matingMaleSelectInfo._isMyHorse = nil
    self._ui._mating._stc_selectHorseMale:SetShow(true)
    self._ui._mating._btn_changeHorseMale:SetShow(true)
    self._ui._mating._txt_horseNameMale:SetText("-")
    self._ui._mating._stc_horseImageMale:SetShow(false)
    self._ui._mating._stc_horseGenderMale:SetShow(false)
    self._ui._mating._cbx_horseLevelMale:DeleteAllItem(0)
    self._ui._mating._cbx_horseLevelMale:AddItem(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTSIMULATOR_SELECT_HORSE_LEVEL"))
    self._ui._mating._cbx_horseLevelMale:SetSelectItemIndex(0)
    self._lastMatingHorseLevelMaleComboBoxToIndex = nil
    self._ui._mating._lst_horseSkillMale:getElementManager():clearKey()
    if self._isConsole == true then
      ToClient_padSnapRefreshTarget(self._ui._mating._cbx_horseLevelMale)
    end
  else
    self._selectMatingSkillList_Female = nil
    self._matingFemaleSelectInfo._dataIndex = nil
    self._matingFemaleSelectInfo._isMyHorse = nil
    self._ui._mating._stc_selectHorseFemale:SetShow(true)
    self._ui._mating._btn_changeHorseFemale:SetShow(true)
    self._ui._mating._txt_horseNameFemale:SetText("-")
    self._ui._mating._stc_horseImageFemale:SetShow(false)
    self._ui._mating._stc_horseGenderFemale:SetShow(false)
    self._ui._mating._cbx_horseLevelFemale:DeleteAllItem(0)
    self._ui._mating._cbx_horseLevelFemale:AddItem(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTSIMULATOR_SELECT_HORSE_LEVEL"))
    self._ui._mating._cbx_horseLevelFemale:SetSelectItemIndex(0)
    self._lastMatingHorseLevelFemaleComboBoxToIndex = nil
    self._ui._mating._lst_horseSkillFemale:getElementManager():clearKey()
    if self._isConsole == true then
      ToClient_padSnapRefreshTarget(self._ui._mating._cbx_horseLevelFemale)
    end
  end
  self._ui._mating._frm_matingResult:SetShow(false)
end
function PaGlobal_ServantSimulator:toggleMatingResultHorseTypeToolTip(isShow, resultIndex, horseTier, horseIndex)
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
  end
  local dataWrapper = ToClient_GetHorseSimulateMatingResultInfoByIndex(resultIndex)
  if dataWrapper == nil then
    return
  end
  local horseTypeTooltip = dataWrapper:getHorseTitleNameForLua()
  if ToClient_IsDevelopment() == true then
    horseTypeTooltip = horseTypeTooltip .. "(" .. tostring(dataWrapper:getCharacterKeyRaw()) .. ")"
  end
  local resultGroupDataIndex = self:findMatingResultGroupDataIndex(horseTier)
  if resultGroupDataIndex == nil then
    return
  end
  local resultGroupData = self._matingResultList[resultGroupDataIndex]
  if resultGroupData == nil then
    return
  end
  local resultHorseData = resultGroupData._horseList[horseIndex]
  if resultHorseData == nil then
    return
  end
  TooltipSimple_Show(resultHorseData._gender, "", horseTypeTooltip)
end
function PaGlobal_ServantSimulator:ShowTwinsTooltip(isShow)
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_TWINSTOOLTIPTITLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_TWINSTOOLTIPDESC")
  local control = self._ui._mating._helpIcon
  TooltipSimple_Show(control, name, desc)
end
