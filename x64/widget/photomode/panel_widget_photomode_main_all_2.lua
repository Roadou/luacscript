function HandleEventLUp_PhotoModeSocialIcon(isPrior)
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  local visibleCountStart = 0
  local visibleCountEnd = 0
  local maxSocialIconWindow = math.floor(#PaGlobal_PhotoMode._socialIconSlot / 30)
  if true == isPrior then
    PaGlobal_PhotoMode._currentSocialActionWindowIndex = PaGlobal_PhotoMode._currentSocialActionWindowIndex - 1
    if 0 > PaGlobal_PhotoMode._currentSocialActionWindowIndex then
      PaGlobal_PhotoMode._currentSocialActionWindowIndex = 0
    end
  else
    PaGlobal_PhotoMode._currentSocialActionWindowIndex = PaGlobal_PhotoMode._currentSocialActionWindowIndex + 1
    if maxSocialIconWindow < PaGlobal_PhotoMode._currentSocialActionWindowIndex then
      PaGlobal_PhotoMode._currentSocialActionWindowIndex = maxSocialIconWindow
    end
  end
  if 0 == PaGlobal_PhotoMode._currentSocialActionWindowIndex then
    visibleCountEnd = 29
  elseif 1 == PaGlobal_PhotoMode._currentSocialActionWindowIndex then
    visibleCountStart = 30
    visibleCountEnd = 59
  elseif 2 == PaGlobal_PhotoMode._currentSocialActionWindowIndex then
    visibleCountStart = 60
    visibleCountEnd = #PaGlobal_PhotoMode._socialIconSlot
  end
  for index, value in pairs(PaGlobal_PhotoMode._socialIconSlot) do
    if nil ~= value then
      if index >= visibleCountStart and index <= visibleCountEnd then
        value:SetShow(true)
      else
        value:SetShow(false)
      end
    end
  end
  local isIconSelectShow = false
  if visibleCountStart <= PaGlobal_PhotoMode._currentSelectedIconIndex and visibleCountEnd >= PaGlobal_PhotoMode._currentSelectedIconIndex then
    isIconSelectShow = true
  end
  PaGlobal_PhotoMode._ui.socialIconSelect:SetPosX(PaGlobal_PhotoMode._socialIconSlot[PaGlobal_PhotoMode._currentSelectedIconIndex]:GetPosX() - 2.5)
  PaGlobal_PhotoMode._ui.socialIconSelect:SetPosY(PaGlobal_PhotoMode._socialIconSlot[PaGlobal_PhotoMode._currentSelectedIconIndex]:GetPosY() - 2.5)
  PaGlobal_PhotoMode._ui.socialIconSelect:SetShow(isIconSelectShow)
  local socialActionInfo = ToClient_getSocialActionInfoByIndex(PaGlobal_PhotoMode._currentSelectedIconIndex)
  local sASS = socialActionInfo:getStaticStatus()
  local name = sASS:getName()
  PaGlobal_PhotoMode._ui.txt_socialSubTitle:SetText(name)
end
function HandleEventLUp_PhotoMode_ChangeSocialActionTarget(radioType)
  local self = PaGlobal_PhotoMode
  if self == nil then
    return
  end
  if radioType == nil then
    return
  end
  local saveCacheNumber
  if radioType == __eMaidActorSocialActionType_SelfPlayer then
    saveCacheNumber = __eMaidActorSocialActionType_SelfPlayer
    self._ui.rdo_socialCharacter:SetCheck(true)
  elseif radioType == __eMaidActorSocialActionType_MaidActor then
    saveCacheNumber = __eMaidActorSocialActionType_MaidActor
    self._ui.rdo_socialMaid:SetCheck(true)
  elseif radioType == __eMaidActorSocialActionType_Together then
    saveCacheNumber = __eMaidActorSocialActionType_Together
    self._ui.rdo_socialTogether:SetCheck(true)
  else
    UI.ASSERT_NAME(false, "inputType\236\157\180 \235\185\132\236\160\149\236\131\129\236\157\180\235\139\164!", "\236\157\180\236\163\188")
  end
  if saveCacheNumber ~= nil then
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(__eMaidActorSocialActionType, saveCacheNumber, CppEnums.VariableStorageType.eVariableStorageType_User)
  end
end
function HandleEventLUp_KeyGuideOptionName(index)
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  ToClient_isPhotoModeFromObservation()
  if true == PaGlobal_PhotoMode._isPhotoModeFromObservation and (index == _photoModeOption.screenLook or index == _photoModeOption.noiseVignetting or index == _photoModeOption.socialAction or index == _photoModeOption.socialActionStart or index == _photoModeOption.filterChange) then
    return
  end
  PaGlobal_PhotoMode._currentSelectedKeyGuide = index
  if index == _photoModeOption.blurForce or index == _photoModeOption.blurPosition then
    ToClient_isDOFOptionOn()
    return
  end
  if index == _photoModeOption.contrastControl then
    ToClient_isNonContrastOptionOn()
    return
  end
  local isSocialActionSelect = false
  if index == _photoModeOption.socialActionStart then
    index = _photoModeOption.socialAction
    isSocialActionSelect = true
  end
  for idx = 1, PaGlobal_PhotoMode._keyGuideCount do
    local modeList = PaGlobal_PhotoMode._keyGuideList[idx]._modeList
    if idx == index then
      if idx == _photoModeOption.socialAction then
        HandleEventLUp_PhotoModeSocialIcon(true)
      end
      for modeIndex, modeValue in pairs(modeList) do
        modeValue:SetShow(true)
      end
    else
      for modeIndex, modeValue in pairs(modeList) do
        modeValue:SetShow(false)
      end
    end
  end
  if true == isSocialActionSelect then
    index = _photoModeOption.socialActionStart
  end
  if _photoModeOption.filterChange == index then
    local filterMode = getCameraLUTFilterRender()
    local filterName = getCameraLUTFilterName(filterMode)
    if _ContentsGroup_ChinaOnly == true then
      filterName = PaGlobalFunc_changeTranslateLUTForChina(filterName)
    end
    PaGlobal_PhotoMode._ui.txt_filterName:SetText(filterName)
  end
  PaGlobal_PhotoMode._ui.activateKeyOption:SetPosX(PaGlobal_PhotoMode._keyGuideList[index]._keyGuideName:GetPosX() + 20)
  PaGlobal_PhotoMode._ui.activateKeyOption:SetPosY(PaGlobal_PhotoMode._keyGuideList[index]._keyGuideName:GetPosY())
end
function HandleEventLUp_SelectSocialIcon(index)
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  PaGlobal_PhotoMode:findSelectedSocialIcon(index, true)
end
function HandleEventLDown_ChangeTimeWeather()
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  PaGlobal_PhotoMode:changeTimeWeather()
end
function HandleEventLPress_ChangeTimeWeather()
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  PaGlobal_PhotoMode:changeTimeWeather()
end
function HandleEventLUp_SelectOptionPreset(index)
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  for optionIndex, value in pairs(PaGlobal_PhotoMode._optionPresetButton) do
    if optionIndex == index then
      value:SetCheck(true)
    else
      value:SetCheck(false)
    end
  end
  ToClient_SetPhotoModeOptionPresetIndex(index - 1)
  HandleEventLUp_KeyGuideOptionName(_photoModeOption.optionPreset)
end
function HandleEventLUp_ResetOption()
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  for optionIndex, value in pairs(PaGlobal_PhotoMode._optionPresetButton) do
    value:SetCheck(false)
  end
  ToClient_ResetPhotoModeOption()
  HandleEventLUp_KeyGuideOptionName(_photoModeOption.optionPreset)
end
function HandleEventLUp_SaveOption()
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  Panel_PhotoMode_Preset:SetShow(true)
  HandleEventLUp_KeyGuideOptionName(_photoModeOption.optionPreset)
end
function HandleEventLDown_ChangeSlider(index)
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  PaGlobal_PhotoMode:changeSliderOption(index)
end
function HandleEventLPress_ChangeSlider(index)
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  PaGlobal_PhotoMode:changeSliderOption(index)
end
function HandleEventLUp_ChangeFilterDown()
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  ToClient_SetPhotoModeFilter(false)
end
function HandleEventLUp_ChangeFilterUp()
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  ToClient_SetPhotoModeFilter(true)
end
function HandleEventLUp_SelectVignetting(vignettingIndex)
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  PaGlobal_PhotoMode:selectVignetting(vignettingIndex)
  ToClient_SetPhotoModeVignetting(vignettingIndex - 1)
end
function HandleEventLUp_SavePanelClose()
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  Panel_PhotoMode_Preset:SetShow(false)
  local saveOptionButton = PaGlobal_PhotoMode._saveButton[PaGlobal_PhotoMode._currentSelectedOptionIndex]
  if nil == saveOptionButton then
    return
  end
  saveOptionButton:SetCheck(false)
end
function HandleEventLUp_SaveOptionPreset()
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  local saveOptionButton = PaGlobal_PhotoMode._saveButton[PaGlobal_PhotoMode._currentSelectedOptionIndex]
  if nil == saveOptionButton then
    return
  end
  saveOptionButton:SetCheck(false)
  local optionPresetIndex = PaGlobal_PhotoMode._currentSelectedOptionIndex - 1
  if optionPresetIndex < 0 or optionPresetIndex > 5 then
    return
  end
  ToClient_SavePhotoModeOptionPreset(optionPresetIndex)
  FromClient_photoModePresetDataValid(optionPresetIndex)
  Panel_PhotoMode_Preset:SetShow(false)
end
function HandleEventLUp_CloseOptionPreset()
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  Panel_PhotoMode_Preset:SetShow(false)
  local saveOptionButton = PaGlobal_PhotoMode._saveButton[PaGlobal_PhotoMode._currentSelectedOptionIndex]
  if nil == saveOptionButton then
    return
  end
  saveOptionButton:SetCheck(false)
end
function HandleEventLUp_SelectSaveOptionIndex(index)
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  PaGlobal_PhotoMode._currentSelectedOptionIndex = index
end
function HandleEventLUp_ChangeWeatherIndex(isUp)
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  ToClient_SetPhotoModeWeatherIndex(isUp)
end
function HandleEventLUp_SelectWeatherRecommend(index)
  ToClient_SetPhotoModeSelectWeatherIndex(index - 1)
end
