function PaGlobal_GameoptionTutorial_All_Open(selectIndex)
  PaGlobal_GameoptionTutorial_All:initialize()
  PaGlobal_GameoptionTutorial_All._characterIndex = selectIndex
  ToClient_RequestOpenOptionPanel()
  ToClient_GameOptionPanelOpen()
end
function PaGlobal_GameoptionTutorial_All_Close()
  ToClient_SaveTutorialOption()
  PaGlobal_GameoptionTutorial_All:prepareClose()
  ToClient_NewSequenceTutorialSkipChangeStartPosition(false, __eQuestTutorialBranch_0, PaGlobal_GameoptionTutorial_All._characterIndex)
  ToClient_GameOptionPanelClose()
end
function FromClient_OpenTutorialVolumeOptionPanel(wrapper)
  local self = PaGlobal_GameoptionTutorial_All
  for _, option in pairs(self._controls) do
    if option._name == "BattleSoundType" then
      option._value = wrapper:getEnableBattleSoundType()
    elseif option._name == "AudioResourceType" then
      option._value = 0
    elseif option._name == "VolumeMaster" then
      option._value = PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getMasterVolume(), 0, 100)
    elseif option._name == "EnableMusic" then
      option._value = wrapper:getEnableMusic()
    elseif option._name == "VolumeMusic" then
      option._value = PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getMusicVolume(), 0, 100)
    elseif option._name == "EnableSound" then
      option._value = wrapper:getEnableSound()
    elseif option._name == "VolumeFx" then
      option._value = PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getFxVolume(), 0, 100)
    elseif option._name == "VolumeHitFxVolume" then
      option._value = PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getHitFxVolume(), 0, 100)
    elseif option._name == "VolumeHitFxWeight" then
      option._value = PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getHitFxWeight(), 0, 100)
    elseif option._name == "VolumeOtherPlayer" then
      option._value = PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getOtherPlayerVolume(), 0, 100)
    elseif option._name == "VolumeMusicPlay\t" then
      option._value = PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getAroundPlayMusicVolume(), 0, 100)
    elseif option._name == "EnableEnv" then
      option._value = wrapper:getEnableEnvSound()
    elseif option._name == "VolumeEnv" then
      option._value = PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getEnvSoundVolume(), 0, 100)
    elseif option._name == "VolumeDlg" then
      option._value = PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getDialogueVolume(), 0, 100)
    elseif option._name == "SequenceVolume" then
      option._value = PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getSequenceVolume(), 0, 100)
    end
    self:SetControlSetting(option, option._value)
  end
  self:prepareOpen()
end
function ToClient_SaveTutorialOption(value)
  local self = PaGlobal_GameoptionTutorial_All
  for _, option in pairs(self._controls) do
    if option._name == "BattleSoundType" then
      ToClient_SetTutorialOption_BattleSoundType(option._value)
    elseif option._name == "AudioResourceType" then
      ToClient_SetTutorialOption_AudioResourceType(PaGlobal_GameOption_All:radioButtonMapping_AudioResourceType(option._value))
    elseif option._name == "VolumeMaster" then
      ToClient_SetTutorialOption_VolumeMaster(option._value * 100)
    elseif option._name == "EnableMusic" then
      ToClient_SetTutorialOption_EnableMusic(option._value)
    elseif option._name == "VolumeMusic" then
      ToClient_SetTutorialOption_VolumeMusic(option._value * 100)
    elseif option._name == "EnableSound" then
      ToClient_SetTutorialOption_EnableSound(option._value)
    elseif option._name == "VolumeFx" then
      ToClient_SetTutorialOption_VolumeFx(option._value * 100)
    elseif option._name == "VolumeHitFxVolume" then
      ToClient_SetTutorialOption_VolumeHitFxVolume(option._value * 100)
    elseif option._name == "VolumeHitFxWeight" then
      ToClient_SetTutorialOption_VolumeHitFxWeight(option._value * 100)
    elseif option._name == "VolumeOtherPlayer" then
      ToClient_SetTutorialOption_VolumeOtherPlayer(option._value * 100)
    elseif option._name == "VolumeMusicPlay\t" then
      ToClient_SetTutorialOption_VolumeMusicPlay(option._value * 100)
    elseif option._name == "EnableEnv" then
      ToClient_SetTutorialOption_EnableEnv(option._value)
    elseif option._name == "VolumeEnv" then
      ToClient_SetTutorialOption_VolumeEnv(option._value * 100)
    elseif option._name == "VolumeDlg" then
      ToClient_SetTutorialOption_VolumeDlg(option._value * 100)
    end
  end
  ToClient_SetTutorialOption_RemasterMode(self._remasterMode)
  ToClient_SetTutorialOption_Apply()
end
function HandleEventLUp_GameoptionTutorial_All_Apply()
  ToClient_SaveTutorialOption()
  ToClient_RequestApplyTutorialOption()
end
function HandleEventLUp_GameoptionTutorial_All_PressNext()
  PaGlobal_GameoptionTutorial_All:pressedNextButton()
end
function HandleEventLUp_GameoptionTutorial_All_GraphicSettings(check)
  PaGlobal_GameoptionTutorial_All:setGraphicSettings(check)
end
function HandleEventLUp_GameoptionTutorial_All_NotPreparedAudio()
  local changeToDefaultAudio = function()
    local self = PaGlobal_GameoptionTutorial_All
    for _, option in pairs(self._controls) do
      if option._name == "AudioResourceType" then
        self:SetControlSetting(option, 0)
      end
    end
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_GRAPHICMODE_ALERTTITLE"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_SIMPLESETTING_IGNOR"),
    functionApply = changeToDefaultAudio,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
registerEvent("FromClient_OpenTutorialVolumeOptionPanel", "FromClient_OpenTutorialVolumeOptionPanel")
