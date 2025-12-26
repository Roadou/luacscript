function PaGlobal_RadioPlayer:initialize()
  if true == self._initialize then
    return
  end
  self._uiMain.topBG = UI.getChildControl(Panel_Widget_RadioPlayer, "Static_Top_BG")
  self._uiMain.waveBG = UI.getChildControl(Panel_Widget_RadioPlayer, "Static_Wave_BG")
  self._uiMain.btn_Min = UI.getChildControl(Panel_Widget_RadioPlayer, "Button_Min")
  self._uiMain.btn_Close = UI.getChildControl(Panel_Widget_RadioPlayer, "Button_Close")
  self._uiMain.chk_Onoff = UI.getChildControl(Panel_Widget_RadioPlayer, "Static_1")
  self._uiMain.txt_ChannelName = UI.getChildControl(Panel_Widget_RadioPlayer, "StaticText_ChannelName")
  self._uiMain.txt_Title = UI.getChildControl(Panel_Widget_RadioPlayer, "StaticText_Title")
  self._uiMain.chk_IconVolume = UI.getChildControl(Panel_Widget_RadioPlayer, "CheckButton_Icon_Volume")
  self._uiMain.slider_1 = UI.getChildControl(Panel_Widget_RadioPlayer, "Slider_1")
  self._uiMain.slider_1_btn = UI.getChildControl(self._uiMain.slider_1, "Slider_1_Button")
  self._uiMain.progress2_2 = UI.getChildControl(Panel_Widget_RadioPlayer, "Progress2_2")
  self._uiMain.btn_ChannelL = UI.getChildControl(Panel_Widget_RadioPlayer, "Button_Channel_L")
  self._uiMain.btn_ChannelPlay = UI.getChildControl(Panel_Widget_RadioPlayer, "Button_Channel_Play")
  self._uiMain.btn_ChannelPause = UI.getChildControl(Panel_Widget_RadioPlayer, "Button_Channel_Pause")
  self._uiMain.btn_ChannelR = UI.getChildControl(Panel_Widget_RadioPlayer, "Button_Channel_R")
  self._uiMain.chk_AutoOn = UI.getChildControl(Panel_Widget_RadioPlayer, "CheckButton_Auto_On")
  self._uiMain.progressBG = UI.getChildControl(Panel_Widget_RadioPlayer, "Static_Progress_BG")
  self._uiMain.progress2_1 = UI.getChildControl(Panel_Widget_RadioPlayer, "Progress2_1")
  self._uiMain.progress2_1_Bar = UI.getChildControl(self._uiMain.progress2_1, "Progress2_1_Bar_Head")
  self._uiMain.txt_playTime = UI.getChildControl(Panel_Widget_RadioPlayer, "StaticText_PlayTime")
  self._uiMini.topBG = UI.getChildControl(Panel_Widget_RadioPlayer_Mini, "Static_Top_BG")
  self._uiMini.btn_Max = UI.getChildControl(Panel_Widget_RadioPlayer_Mini, "Button_Max")
  self._uiMini.btn_Close = UI.getChildControl(Panel_Widget_RadioPlayer_Mini, "Button_Close")
  self._uiMini.chk_Onoff = UI.getChildControl(Panel_Widget_RadioPlayer_Mini, "Static_1")
  self._uiMini.txt_ChannelName = UI.getChildControl(Panel_Widget_RadioPlayer_Mini, "StaticText_ChannelName")
  self._uiMini.txt_Title = UI.getChildControl(Panel_Widget_RadioPlayer_Mini, "StaticText_Title")
  self._uiMini.btn_ChannelL = UI.getChildControl(Panel_Widget_RadioPlayer_Mini, "Button_Channel_L")
  self._uiMini.btn_ChannelPlay = UI.getChildControl(Panel_Widget_RadioPlayer_Mini, "Button_Channel_Play")
  self._uiMini.btn_ChannelPause = UI.getChildControl(Panel_Widget_RadioPlayer_Mini, "Button_Channel_Pause")
  self._uiMini.btn_ChannelR = UI.getChildControl(Panel_Widget_RadioPlayer_Mini, "Button_Channel_R")
  self._uiMasking.txt_ChannelName1 = UI.getChildControl(Panel_Widget_RadioPlayer_ChannelName, "StaticText_ChannelName_1")
  self._uiMasking.txt_ChannelName2 = UI.getChildControl(Panel_Widget_RadioPlayer_ChannelName, "StaticText_ChannelName_2")
  self:validate()
  self:registerEventHandler()
  Panel_Widget_RadioPlayer_ChannelName:setMaskingChild(true)
  Panel_Widget_RadioPlayer_ChannelName:SetShow(false)
  self:loadAutoPlay()
  self._isLargeVersion = true
  self._initialize = true
end
function PaGlobal_RadioPlayer:prepareOpen()
  if nil == Panel_Widget_RadioPlayer or nil == Panel_Widget_RadioPlayer_Mini or nil == Panel_Widget_RadioPlayer_ChannelName then
    return
  end
  if false == _ContentsGroup_RadioPlayer then
    return
  end
  if ToClient_getGameUIManagerWrapper():hasLuaCacheDataList(__eMarniWaveSize) then
    self._isLargeVersion = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eMarniWaveSize)
  end
  PaGlobal_RadioPlayer:computePos()
  local mainChannelName = PaGlobal_RadioPlayer._uiMain.txt_ChannelName
  local miniChannelName = PaGlobal_RadioPlayer._uiMini.txt_ChannelName
  local maskingChannelName1 = PaGlobal_RadioPlayer._uiMasking.txt_ChannelName1
  local maskingChannelName2 = PaGlobal_RadioPlayer._uiMasking.txt_ChannelName2
  if true == self._isLargeVersion then
    Panel_Widget_RadioPlayer_ChannelName:SetSize(mainChannelName:GetSizeX(), mainChannelName:GetSizeY())
    maskingChannelName1:SetSize(mainChannelName:GetSizeX(), mainChannelName:GetSizeY())
    maskingChannelName2:SetSize(mainChannelName:GetSizeX(), mainChannelName:GetSizeY())
  else
    Panel_Widget_RadioPlayer_ChannelName:SetSize(miniChannelName:GetSizeX(), miniChannelName:GetSizeY())
    maskingChannelName1:SetSize(miniChannelName:GetSizeX(), miniChannelName:GetSizeY())
    maskingChannelName2:SetSize(miniChannelName:GetSizeX(), miniChannelName:GetSizeY())
  end
  self._isMaskingUpdate = false
  PaGlobal_RadioPlayer:open()
end
function PaGlobal_RadioPlayer:open()
  if nil == Panel_Widget_RadioPlayer or nil == Panel_Widget_RadioPlayer_Mini or nil == Panel_Widget_RadioPlayer_ChannelName then
    return
  end
  if true == self._isLargeVersion then
    Panel_Widget_RadioPlayer:SetShow(true)
    Panel_Widget_RadioPlayer:AddEffect("fUI_InGame_Music_01A")
  else
    Panel_Widget_RadioPlayer_Mini:SetShow(true)
    Panel_Widget_RadioPlayer_Mini:AddEffect("fUI_InGame_Music_01B")
  end
  PaGlobal_RadioPlayer:loadRadioPlayerPos()
  PaGlobal_RadioPlayer:isPlaying(false)
  PaGlobal_RadioPlayer:loadVolume()
end
function PaGlobal_RadioPlayer:prepareClose()
  if nil == Panel_Widget_RadioPlayer or nil == Panel_Widget_RadioPlayer_Mini or nil == Panel_Widget_RadioPlayer_ChannelName then
    return
  end
  PaGlobal_RadioPlayer:saveRadioPlayerPos()
  PaGlobal_RadioPlayer:isPlaying(false)
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(__eMarniWaveVolume, self._volume, CppEnums.VariableStorageType.eVariableStorageType_User)
  PaGlobal_RadioPlayer:close()
end
function PaGlobal_RadioPlayer:close()
  if nil == Panel_Widget_RadioPlayer or nil == Panel_Widget_RadioPlayer_Mini or nil == Panel_Widget_RadioPlayer_ChannelName then
    return
  end
  Panel_Widget_RadioPlayer:SetShow(false)
  Panel_Widget_RadioPlayer_Mini:SetShow(false)
  Panel_Widget_RadioPlayer_ChannelName:SetShow(false)
end
function PaGlobal_RadioPlayer:validate()
  if nil == Panel_Widget_RadioPlayer or nil == Panel_Widget_RadioPlayer_Mini or nil == Panel_Widget_RadioPlayer_ChannelName then
    return
  end
  self._uiMain.topBG:isValidate()
  self._uiMain.waveBG:isValidate()
  self._uiMain.btn_Min:isValidate()
  self._uiMain.btn_Close:isValidate()
  self._uiMain.chk_Onoff:isValidate()
  self._uiMain.txt_ChannelName:isValidate()
  self._uiMain.txt_Title:isValidate()
  self._uiMain.chk_IconVolume:isValidate()
  self._uiMain.slider_1:isValidate()
  self._uiMain.slider_1_btn:isValidate()
  self._uiMain.progress2_2:isValidate()
  self._uiMain.btn_ChannelL:isValidate()
  self._uiMain.btn_ChannelPlay:isValidate()
  self._uiMain.btn_ChannelPause:isValidate()
  self._uiMain.btn_ChannelR:isValidate()
  self._uiMain.progressBG:isValidate()
  self._uiMain.progress2_1:isValidate()
  self._uiMain.progress2_1_Bar:isValidate()
  self._uiMain.txt_playTime:isValidate()
  self._uiMini.topBG:isValidate()
  self._uiMini.btn_Max:isValidate()
  self._uiMini.btn_Close:isValidate()
  self._uiMini.chk_Onoff:isValidate()
  self._uiMini.txt_ChannelName:isValidate()
  self._uiMini.txt_Title:isValidate()
  self._uiMini.btn_ChannelL:isValidate()
  self._uiMini.btn_ChannelPlay:isValidate()
  self._uiMini.btn_ChannelPause:isValidate()
  self._uiMini.btn_ChannelR:isValidate()
  self._uiMasking.txt_ChannelName1:isValidate()
  self._uiMasking.txt_ChannelName2:isValidate()
end
function PaGlobal_RadioPlayer:computePos()
  if nil == Panel_Widget_RadioPlayer or nil == Panel_Widget_RadioPlayer_Mini or nil == Panel_Widget_RadioPlayer_ChannelName then
    return
  end
  local posX = 0
  local posY = 0
  if true == self._isLargeVersion then
    posX = Panel_Widget_RadioPlayer:GetPosX() + self._uiMain.txt_ChannelName:GetPosX()
    posY = Panel_Widget_RadioPlayer:GetPosY() + self._uiMain.txt_ChannelName:GetPosY()
  else
    posX = Panel_Widget_RadioPlayer_Mini:GetPosX() + self._uiMini.txt_ChannelName:GetPosX()
    posY = Panel_Widget_RadioPlayer_Mini:GetPosY() + self._uiMini.txt_ChannelName:GetPosY()
  end
  Panel_Widget_RadioPlayer_ChannelName:SetPosX(posX)
  Panel_Widget_RadioPlayer_ChannelName:SetPosY(posY)
end
function PaGlobal_RadioPlayer:registerEventHandler()
  if nil == Panel_Widget_RadioPlayer or nil == Panel_Widget_RadioPlayer_Mini or nil == Panel_Widget_RadioPlayer_ChannelName then
    return
  end
  self._uiMain.btn_Min:addInputEvent("Mouse_LUp", "HandleEventLUp_ChangeVersion(false)")
  self._uiMain.btn_Close:addInputEvent("Mouse_LUp", "HandleEventLUp_CloseRadioPlayer()")
  self._uiMain.btn_ChannelL:addInputEvent("Mouse_LUp", "HandleEventLUp_ChangeChannel(false)")
  self._uiMain.btn_ChannelR:addInputEvent("Mouse_LUp", "HandleEventLUp_ChangeChannel(true)")
  self._uiMain.btn_ChannelPlay:addInputEvent("Mouse_LUp", "HandleEventLUp_PlayOrPause()")
  self._uiMain.btn_ChannelPause:addInputEvent("Mouse_LUp", "HandleEventLUp_PlayOrPause()")
  self._uiMain.chk_IconVolume:addInputEvent("Mouse_LUp", "HandleEventLUp_MuteVolume()")
  self._uiMain.slider_1:addInputEvent("Mouse_LDown", "HandleEventLDown_ChangeVolume()")
  self._uiMain.slider_1:SetInterval(160)
  self._uiMain.slider_1:SetControlPos(100)
  self._uiMain.slider_1_btn:addInputEvent("Mouse_LPress", "HandleEventLPress_ChangeVolume()")
  self._uiMain.chk_AutoOn:addInputEvent("Mouse_LUp", "HandleEventLUp_AutoPlay()")
  self._uiMain.chk_AutoOn:SetCheck(true)
  self._uiMain.progress2_2:SetProgressRate(100)
  self._uiMain.txt_playTime:SetText("00:00 / 00:00")
  self._uiMini.btn_Max:addInputEvent("Mouse_LUp", "HandleEventLUp_ChangeVersion(true)")
  self._uiMini.btn_Close:addInputEvent("Mouse_LUp", "HandleEventLUp_CloseRadioPlayer()")
  self._uiMini.btn_ChannelL:addInputEvent("Mouse_LUp", "HandleEventLUp_ChangeChannel(false)")
  self._uiMini.btn_ChannelR:addInputEvent("Mouse_LUp", "HandleEventLUp_ChangeChannel(true)")
  self._uiMini.btn_ChannelPlay:addInputEvent("Mouse_LUp", "HandleEventLUp_PlayOrPause()")
  self._uiMini.btn_ChannelPause:addInputEvent("Mouse_LUp", "HandleEventLUp_PlayOrPause()")
  Panel_Widget_RadioPlayer_ChannelName:RegisterUpdateFunc("RadioPlayer_ChannelMove")
  self._uiMasking.txt_ChannelName2:SetPosX(self._uiMasking.txt_ChannelName1:GetPosX() + self._uiMasking.txt_ChannelName1:GetSizeX() + 50)
end
local channelFrameMove = 2
local count = 0
function RadioPlayer_ChannelMove(deltaTime)
  if nil == Panel_Widget_RadioPlayer or nil == Panel_Widget_RadioPlayer_Mini or nil == Panel_Widget_RadioPlayer_ChannelName then
    return
  end
  PaGlobal_RadioPlayer:computePos()
  if false == PaGlobal_RadioPlayer._needChannelMove then
    return
  end
  if count < channelFrameMove then
    count = count + 1
    return
  end
  if PaGlobal_RadioPlayer._isMaskingUpdate == false then
    Panel_Widget_RadioPlayer_ChannelName:SetShow(false)
    Panel_Widget_RadioPlayer_ChannelName:setMaskingChild(false)
    Panel_Widget_RadioPlayer_ChannelName:setMaskingChild(true)
    Panel_Widget_RadioPlayer_ChannelName:SetShow(true)
    PaGlobal_RadioPlayer._isMaskingUpdate = true
  end
  count = 0
  local extra = 50
  local maskingChannel1 = PaGlobal_RadioPlayer._uiMasking.txt_ChannelName1
  local maskingChannel2 = PaGlobal_RadioPlayer._uiMasking.txt_ChannelName2
  local maskingChannel1PosX = maskingChannel1:GetPosX()
  maskingChannel1:SetPosX(maskingChannel1PosX - 1)
  if maskingChannel1PosX < -(maskingChannel1:GetTextSizeX() + extra) then
    maskingChannel1:SetPosX(maskingChannel2:GetPosX() + maskingChannel2:GetTextSizeX() + extra)
  end
  local maskingChannel2PosX = maskingChannel2:GetPosX()
  maskingChannel2:SetPosX(maskingChannel2PosX - 1)
  if maskingChannel2PosX < -(maskingChannel2:GetTextSizeX() + extra) then
    maskingChannel2:SetPosX(maskingChannel1:GetPosX() + maskingChannel1:GetTextSizeX() + extra)
  end
end
function PaGlobal_RadioPlayer:changeVersion(toLargeVersion)
  if nil == Panel_Widget_RadioPlayer or nil == Panel_Widget_RadioPlayer_Mini or nil == Panel_Widget_RadioPlayer_ChannelName then
    return
  end
  if PaGlobal_RadioPlayer._isLargeVersion == toLargeVersion then
    return
  end
  PaGlobal_RadioPlayer._isLargeVersion = toLargeVersion
  Panel_Widget_RadioPlayer:SetShow(toLargeVersion)
  Panel_Widget_RadioPlayer_Mini:SetShow(not toLargeVersion)
  local mainChannelName = PaGlobal_RadioPlayer._uiMain.txt_ChannelName
  local miniChannelName = PaGlobal_RadioPlayer._uiMini.txt_ChannelName
  local maskingChannelName1 = PaGlobal_RadioPlayer._uiMasking.txt_ChannelName1
  local maskingChannelName2 = PaGlobal_RadioPlayer._uiMasking.txt_ChannelName2
  if true == toLargeVersion then
    Panel_Widget_RadioPlayer:AddEffect("fUI_InGame_Music_01A")
    Panel_Widget_RadioPlayer_ChannelName:SetSize(mainChannelName:GetSizeX(), mainChannelName:GetSizeY())
    maskingChannelName1:SetSize(mainChannelName:GetSizeX(), mainChannelName:GetSizeY())
    maskingChannelName2:SetSize(mainChannelName:GetSizeX(), mainChannelName:GetSizeY())
    Panel_Widget_RadioPlayer:SetPosXY(Panel_Widget_RadioPlayer_Mini:GetPosX(), Panel_Widget_RadioPlayer_Mini:GetPosY())
  else
    Panel_Widget_RadioPlayer_Mini:AddEffect("fUI_InGame_Music_01B")
    Panel_Widget_RadioPlayer_ChannelName:SetSize(miniChannelName:GetSizeX(), miniChannelName:GetSizeY())
    maskingChannelName1:SetSize(miniChannelName:GetSizeX(), miniChannelName:GetSizeY())
    maskingChannelName2:SetSize(miniChannelName:GetSizeX(), miniChannelName:GetSizeY())
    Panel_Widget_RadioPlayer_Mini:SetPosXY(Panel_Widget_RadioPlayer:GetPosX(), Panel_Widget_RadioPlayer:GetPosY())
  end
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eMarniWaveSize, PaGlobal_RadioPlayer._isLargeVersion, CppEnums.VariableStorageType.eVariableStorageType_User)
  self:saveRadioPlayerPos()
end
function PaGlobal_RadioPlayer:changeVolume()
  if nil == Panel_Widget_RadioPlayer or nil == Panel_Widget_RadioPlayer_Mini or nil == Panel_Widget_RadioPlayer_ChannelName then
    return
  end
  local nowPercent = PaGlobal_RadioPlayer._uiMain.slider_1:GetControlPos()
  local volume = nowPercent * 100
  PaGlobal_RadioPlayer._uiMain.progress2_2:SetProgressRate(math.ceil(volume))
  ToClient_RadioPlayerChangeVolume(volume)
  PaGlobal_RadioPlayer._volume = volume
  local volumeIcon = PaGlobal_RadioPlayer._uiMain.chk_IconVolume
  if nil == volumeIcon then
    return
  end
  if volume == 0 then
    volumeIcon:SetCheck(true)
  elseif volumeIcon:IsCheck() == true then
    volumeIcon:SetCheck(false)
  end
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(__eMarniWaveVolume, self._volume, CppEnums.VariableStorageType.eVariableStorageType_User)
end
function PaGlobal_RadioPlayer:isPlaying(isPlay)
  if nil == Panel_Widget_RadioPlayer or nil == Panel_Widget_RadioPlayer_Mini or nil == Panel_Widget_RadioPlayer_ChannelName then
    return
  end
  local largePlayButton = PaGlobal_RadioPlayer._uiMain.btn_ChannelPlay
  local largePauseButton = PaGlobal_RadioPlayer._uiMain.btn_ChannelPause
  local miniPlayButton = PaGlobal_RadioPlayer._uiMini.btn_ChannelPlay
  local miniPauseButton = PaGlobal_RadioPlayer._uiMini.btn_ChannelPause
  if nil == largePlayButton or nil == largePauseButton or nil == miniPlayButton or nil == miniPauseButton then
    return
  end
  if true == isPlay then
    largePlayButton:SetShow(false)
    largePauseButton:SetShow(true)
    miniPlayButton:SetShow(false)
    miniPauseButton:SetShow(true)
  else
    largePlayButton:SetShow(true)
    largePauseButton:SetShow(false)
    miniPlayButton:SetShow(true)
    miniPauseButton:SetShow(false)
  end
end
function FromClient_SetRadioPlayer(isRadioPlayerOn, isMute, reloadVolume)
  if nil == Panel_Widget_RadioPlayer or nil == Panel_Widget_RadioPlayer_Mini or nil == Panel_Widget_RadioPlayer_ChannelName then
    return
  end
  if true == isRadioPlayerOn then
    PaGlobal_RadioPlayer:prepareOpen()
  else
    PaGlobal_RadioPlayer:prepareClose()
  end
  local volumeIcon = PaGlobal_RadioPlayer._uiMain.chk_IconVolume
  if nil == volumeIcon then
    return
  end
  if PaGlobal_RadioPlayer._volume == 0 then
    volumeIcon:SetCheck(true)
  elseif volumeIcon:IsCheck() == true then
    volumeIcon:SetCheck(false)
  end
  FromClient_RadioPlayerChangeVolume(reloadVolume)
end
function PaGlobal_RadioPlayer:saveRadioPlayerPos()
  if nil == Panel_Widget_RadioPlayer or nil == Panel_Widget_RadioPlayer_Mini or nil == Panel_Widget_RadioPlayer_ChannelName then
    return
  end
  local savePosX = 0
  local savePosY = 0
  if true == self._isLargeVersion then
    savePosX = Panel_Widget_RadioPlayer:GetPosX()
    savePosY = Panel_Widget_RadioPlayer:GetPosY()
  else
    savePosX = Panel_Widget_RadioPlayer_Mini:GetPosX()
    savePosY = Panel_Widget_RadioPlayer_Mini:GetPosY()
  end
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(__eMarniWavePosX, savePosX, CppEnums.VariableStorageType.eVariableStorageType_User)
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(__eMarniWavePosY, savePosY, CppEnums.VariableStorageType.eVariableStorageType_User)
end
function PaGlobal_RadioPlayer:loadRadioPlayerPos()
  if nil == Panel_Widget_RadioPlayer or nil == Panel_Widget_RadioPlayer_Mini or nil == Panel_Widget_RadioPlayer_ChannelName then
    return
  end
  if ToClient_getGameUIManagerWrapper():hasLuaCacheDataList(__eMarniWavePosX) == false or ToClient_getGameUIManagerWrapper():hasLuaCacheDataList(__eMarniWavePosY) == false then
    return
  end
  if getScreenSizeX() >= __eMarniWavePosX or getScreenSizeY() >= __eMarniWavePosY then
    return
  end
  local posX = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eMarniWavePosX)
  local posY = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eMarniWavePosY)
  Panel_Widget_RadioPlayer:SetPosXY(posX, posY)
  Panel_Widget_RadioPlayer_Mini:SetPosXY(posX, posY)
end
function PaGlobal_RadioPlayer:loadVolume()
  if nil == Panel_Widget_RadioPlayer or nil == Panel_Widget_RadioPlayer_Mini or nil == Panel_Widget_RadioPlayer_ChannelName then
    return
  end
  local volume = 100
  if ToClient_getGameUIManagerWrapper():hasLuaCacheDataList(__eMarniWaveVolume) == true then
    volume = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eMarniWaveVolume)
  end
  PaGlobal_RadioPlayer._uiMain.slider_1:SetControlPos(volume)
  PaGlobal_RadioPlayer._uiMain.progress2_2:SetProgressRate(math.ceil(volume))
  ToClient_RadioPlayerChangeVolume(volume)
  self._volume = volume
  local volumeIcon = PaGlobal_RadioPlayer._uiMain.chk_IconVolume
  if nil == volumeIcon then
    return
  end
  if volume == 0 then
    volumeIcon:SetCheck(true)
  else
    volumeIcon:SetCheck(false)
  end
end
function PaGlobal_RadioPlayer:loadAutoPlay()
  if nil == Panel_Widget_RadioPlayer or nil == Panel_Widget_RadioPlayer_Mini or nil == Panel_Widget_RadioPlayer_ChannelName then
    return
  end
  local isAutoPlay = true
  if ToClient_getGameUIManagerWrapper():hasLuaCacheDataList(__eMarniWaveAutoPlay) == true then
    isAutoPlay = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eMarniWaveAutoPlay)
  end
  ToClient_RadioPlayerAutoPlay(isAutoPlay)
  self._uiMain.chk_AutoOn:SetCheck(isAutoPlay)
end
function PaGlobal_RadioPlayer:loadChannel()
  if nil == Panel_Widget_RadioPlayer or nil == Panel_Widget_RadioPlayer_Mini or nil == Panel_Widget_RadioPlayer_ChannelName then
    return
  end
end
function FromClient_RadioPlayerPlayOrPause(isPlay)
  if nil == Panel_Widget_RadioPlayer or nil == Panel_Widget_RadioPlayer_Mini or nil == Panel_Widget_RadioPlayer_ChannelName then
    return
  end
  PaGlobal_RadioPlayer:isPlaying(isPlay)
end
function FromClient_RadioPlayerChangeChannel(channelName)
  if nil == Panel_Widget_RadioPlayer or nil == Panel_Widget_RadioPlayer_Mini or nil == Panel_Widget_RadioPlayer_ChannelName then
    return
  end
  if nil == channelName then
    return
  end
  if nil == PaGlobal_RadioPlayer._uiMain.txt_ChannelName then
    return
  end
  PaGlobal_RadioPlayer._uiMain.txt_ChannelName:SetText(channelName)
  PaGlobal_RadioPlayer._uiMini.txt_ChannelName:SetText(channelName)
  PaGlobal_RadioPlayer._uiMasking.txt_ChannelName1:SetText(channelName)
  PaGlobal_RadioPlayer._uiMasking.txt_ChannelName2:SetText(channelName)
  PaGlobal_RadioPlayer._needChannelMove = false
  if true == PaGlobal_RadioPlayer._isLargeVersion then
    if PaGlobal_RadioPlayer._uiMain.txt_ChannelName:GetSizeX() < PaGlobal_RadioPlayer._uiMain.txt_ChannelName:GetTextSizeX() then
      PaGlobal_RadioPlayer._needChannelMove = true
    end
  elseif PaGlobal_RadioPlayer._uiMini.txt_ChannelName:GetSizeX() < PaGlobal_RadioPlayer._uiMini.txt_ChannelName:GetTextSizeX() then
    PaGlobal_RadioPlayer._needChannelMove = true
  end
  PaGlobal_RadioPlayer._uiMain.txt_ChannelName:SetShow(not PaGlobal_RadioPlayer._needChannelMove)
  PaGlobal_RadioPlayer._uiMini.txt_ChannelName:SetShow(not PaGlobal_RadioPlayer._needChannelMove)
  Panel_Widget_RadioPlayer_ChannelName:SetShow(PaGlobal_RadioPlayer._needChannelMove)
end
function FromClient_RadioPlayerChangeVolume(volume)
  if nil == Panel_Widget_RadioPlayer or nil == Panel_Widget_RadioPlayer_Mini or nil == Panel_Widget_RadioPlayer_ChannelName then
    return
  end
  if nil == PaGlobal_RadioPlayer._uiMain.slider_1 then
    return
  end
  PaGlobal_RadioPlayer._uiMain.slider_1:SetControlPos(volume)
  PaGlobal_RadioPlayer._uiMain.progress2_2:SetProgressRate(volume)
  PaGlobal_RadioPlayer._volume = volume
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(__eMarniWaveVolume, PaGlobal_RadioPlayer._volume, CppEnums.VariableStorageType.eVariableStorageType_User)
  local volumeIcon = PaGlobal_RadioPlayer._uiMain.chk_IconVolume
  if nil == volumeIcon then
    return
  end
  if volume == 0 then
    volumeIcon:SetCheck(true)
  else
    volumeIcon:SetCheck(false)
  end
end
function FromClient_RadioPlayerAudioTime(currentTimeSeconds, audioLengthMiliseconds)
  if nil == Panel_Widget_RadioPlayer or nil == Panel_Widget_RadioPlayer_Mini or nil == Panel_Widget_RadioPlayer_ChannelName then
    return
  end
  if nil == PaGlobal_RadioPlayer._uiMain.txt_playTime then
    return
  end
  PaGlobal_RadioPlayer._audioLength = audioLengthMiliseconds
  local audioLengthSeconds = audioLengthMiliseconds / 1000
  local audioLengthMinute = math.floor(audioLengthSeconds / 60)
  local audioLengthMinuteText = tostring(audioLengthMinute)
  if audioLengthMinute < 10 then
    audioLengthMinuteText = "0" .. audioLengthMinuteText
  end
  audioLengthSeconds = math.floor(audioLengthSeconds % 60)
  local audioLengthSecondsText = tostring(audioLengthSeconds)
  if audioLengthSeconds < 10 then
    audioLengthSecondsText = "0" .. audioLengthSecondsText
  end
  local lengthText = audioLengthMinuteText .. ":" .. audioLengthSecondsText
  PaGlobal_RadioPlayer._currentTime = currentTimeSeconds
  local currentMinute = math.floor(currentTimeSeconds / 60)
  local currentMinuteText = tostring(currentMinute)
  if currentMinute < 10 then
    currentMinuteText = "0" .. currentMinuteText
  end
  local currentSeconds = math.floor(currentTimeSeconds % 60)
  local currentSecondsText = tostring(currentSeconds)
  if currentSeconds < 10 then
    currentSecondsText = "0" .. currentSecondsText
  end
  local currentTimeText = currentMinuteText .. ":" .. currentSecondsText
  local timeText = currentTimeText .. " / " .. lengthText
  PaGlobal_RadioPlayer._uiMain.txt_playTime:SetText(timeText)
  local length = PaGlobal_RadioPlayer._audioLength / 1000
  local time = PaGlobal_RadioPlayer._currentTime
  PaGlobal_RadioPlayer._uiMain.progress2_1:SetProgressRate(time * 100 / length)
end
function FromClient_RadioPlayerNotAvailablePopup()
  if nil == Panel_Widget_RadioPlayer or nil == Panel_Widget_RadioPlayer_Mini or nil == Panel_Widget_RadioPlayer_ChannelName then
    return
  end
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_ESC_RADIOPLAYER_DESC")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GENERIC_KEYGUIDE_XBOX_APPLY"),
    content = messageBoxMemo,
    functionApply = MessageBox_Empty_function,
    exitButton = false,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FromClient_RadioPlayerApplyAudioTime(currentPosition, audioLength)
  if nil == Panel_Widget_RadioPlayer or nil == Panel_Widget_RadioPlayer_Mini or nil == Panel_Widget_RadioPlayer_ChannelName then
    return
  end
  FromClient_RadioPlayerAudioTime(currentPosition, audioLength)
end
registerEvent("FromClient_SetRadioPlayer", "FromClient_SetRadioPlayer")
registerEvent("FromClient_RadioPlayerPlayOrPause", "FromClient_RadioPlayerPlayOrPause")
registerEvent("FromClient_RadioPlayerChangeChannel", "FromClient_RadioPlayerChangeChannel")
registerEvent("FromClient_RadioPlayerChangeVolume", "FromClient_RadioPlayerChangeVolume")
registerEvent("FromClient_RadioPlayerAudioTime", "FromClient_RadioPlayerAudioTime")
registerEvent("FromClient_RadioPlayerNotAvailablePopup", "FromClient_RadioPlayerNotAvailablePopup")
registerEvent("FromClient_RadioPlayerApplyAudioTime", "FromClient_RadioPlayerApplyAudioTime")
