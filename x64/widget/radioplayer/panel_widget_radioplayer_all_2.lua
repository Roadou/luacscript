function HandleEventLUp_ChangeVersion(toLargeVersion)
  if nil == Panel_Widget_RadioPlayer or nil == Panel_Widget_RadioPlayer_Mini or nil == Panel_Widget_RadioPlayer_ChannelName then
    return
  end
  PaGlobal_RadioPlayer:changeVersion(toLargeVersion)
end
function HandleEventLUp_CloseRadioPlayer()
  if nil == Panel_Widget_RadioPlayer or nil == Panel_Widget_RadioPlayer_Mini or nil == Panel_Widget_RadioPlayer_ChannelName then
    return
  end
  ToClient_RadioPlayerOnOff(false)
end
function HandleEventLUp_ChangeChannel(isNextChannel)
  if nil == Panel_Widget_RadioPlayer or nil == Panel_Widget_RadioPlayer_Mini or nil == Panel_Widget_RadioPlayer_ChannelName then
    return
  end
  PaGlobal_RadioPlayer._currentTime = 0
  PaGlobal_RadioPlayer._timeUpdateDelta = 1
  PaGlobal_RadioPlayer:isPlaying(true)
  PaGlobal_RadioPlayer._uiMain.progress2_1:SetProgressRate(0)
  ToClient_RadioPlayerChangeChannelNext(isNextChannel)
end
function HandleEventLUp_PlayOrPause()
  if nil == Panel_Widget_RadioPlayer or nil == Panel_Widget_RadioPlayer_Mini or nil == Panel_Widget_RadioPlayer_ChannelName then
    return
  end
  ToClient_RadioPlayerPlayOrPause()
end
function HandleEventLDown_ChangeVolume()
  PaGlobal_RadioPlayer:changeVolume()
end
function HandleEventLPress_ChangeVolume()
  PaGlobal_RadioPlayer:changeVolume()
end
function HandleEventLUp_MuteVolume()
  if nil == Panel_Widget_RadioPlayer or nil == Panel_Widget_RadioPlayer_Mini or nil == Panel_Widget_RadioPlayer_ChannelName then
    return
  end
  local volumeIcon = PaGlobal_RadioPlayer._uiMain.chk_IconVolume
  if nil == volumeIcon then
    return
  end
  local volume = PaGlobal_RadioPlayer._uiMain.slider_1:GetControlPos() * 100
  if true == volumeIcon:IsCheck() then
    ToClient_RadioPlayerMute(true, volume)
  else
    ToClient_RadioPlayerMute(false, volume)
  end
end
function HandleEventLUp_AutoPlay()
  if nil == Panel_Widget_RadioPlayer or nil == Panel_Widget_RadioPlayer_Mini or nil == Panel_Widget_RadioPlayer_ChannelName then
    return
  end
  local autoPlay = PaGlobal_RadioPlayer._uiMain.chk_AutoOn
  if nil == autoPlay then
    return
  end
  local isAutoPlayCheck = autoPlay:IsCheck()
  ToClient_RadioPlayerAutoPlay(isAutoPlayCheck)
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eMarniWaveAutoPlay, isAutoPlayCheck, CppEnums.VariableStorageType.eVariableStorageType_User)
end
function PaGlobal_RadioPlayerOpen()
  if nil == Panel_Widget_RadioPlayer or nil == Panel_Widget_RadioPlayer_Mini or nil == Panel_Widget_RadioPlayer_ChannelName then
    return
  end
  ToClient_RadioPlayerAvailable()
end
function HandleEventLUp_SeekAudio()
  if nil == Panel_Widget_RadioPlayer or nil == Panel_Widget_RadioPlayer_Mini or nil == Panel_Widget_RadioPlayer_ChannelName then
    return
  end
  local startX = Panel_Widget_RadioPlayer:GetPosX()
  local endX = startX + PaGlobal_RadioPlayer._uiMain.progressBG:GetSizeX()
  local mousePosX = getMousePosX()
  local progressRate = math.ceil((mousePosX - startX) * 100 / (endX - startX))
  PaGlobal_RadioPlayer._uiMain.progress2_1:SetProgressRate(progressRate)
  PaGlobal_RadioPlayer._currentTime = PaGlobal_RadioPlayer._audioLength / 1000 * progressRate / 100
  ToClient_RadioPlayerSeekAudio(PaGlobal_RadioPlayer._currentTime * 1000)
end
function PaGlobal_SaveRadioPlayerPos()
  if nil == Panel_Widget_RadioPlayer or nil == Panel_Widget_RadioPlayer_Mini or nil == Panel_Widget_RadioPlayer_ChannelName then
    return
  end
  PaGlobal_RadioPlayer._mainPosX = Panel_Widget_RadioPlayer:GetPosX()
  PaGlobal_RadioPlayer._mainPosY = Panel_Widget_RadioPlayer:GetPosY()
  PaGlobal_RadioPlayer._miniPosX = Panel_Widget_RadioPlayer_Mini:GetPosX()
  PaGlobal_RadioPlayer._miniPosY = Panel_Widget_RadioPlayer_Mini:GetPosY()
  PaGlobal_RadioPlayer:saveRadioPlayerPos()
end
function PaGlobal_SaveVersion()
  if nil == Panel_Widget_RadioPlayer or nil == Panel_Widget_RadioPlayer_Mini or nil == Panel_Widget_RadioPlayer_ChannelName then
    return
  end
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eMarniWaveSize, PaGlobal_RadioPlayer._isLargeVersion, CppEnums.VariableStorageType.eVariableStorageType_User)
end
function PaGlobal_ApplyRadioPlayerPos()
  if nil == Panel_Widget_RadioPlayer or nil == Panel_Widget_RadioPlayer_Mini or nil == Panel_Widget_RadioPlayer_ChannelName then
    return
  end
  Panel_Widget_RadioPlayer:SetPosXY(PaGlobal_RadioPlayer._mainPosX, PaGlobal_RadioPlayer._mainPosY)
  Panel_Widget_RadioPlayer_Mini:SetPosXY(PaGlobal_RadioPlayer._miniPosX, PaGlobal_RadioPlayer._miniPosY)
end
function PAGlobal_CloseRadioPlayer()
  if _ContentsGroup_RadioPlayer == false then
    return
  end
  if nil == Panel_Widget_RadioPlayer or nil == Panel_Widget_RadioPlayer_Mini or nil == Panel_Widget_RadioPlayer_ChannelName then
    return
  end
  if Panel_Widget_RadioPlayer:IsShow() == false and Panel_Widget_RadioPlayer_Mini:IsShow() == false then
    return
  end
  HandleEventLUp_CloseRadioPlayer()
end
