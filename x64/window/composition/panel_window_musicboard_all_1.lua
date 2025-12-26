function PaGlobal_MusicBoard_All_ListControlCreate(control, key)
  local self = PaGlobal_MusicBoard_All
  local _key = Int64toInt32(key)
  local musicName = UI.getChildControl(control, "StaticText_MusicName")
  local authorName = UI.getChildControl(control, "StaticText_Composer")
  local arrangerName = UI.getChildControl(control, "StaticText_Arranger")
  local gradeValue = UI.getChildControl(control, "StaticText_GradeValue")
  local bg = UI.getChildControl(control, "Static_Bg")
  local btn_Listen = UI.getChildControl(control, "Button_Listen")
  local btn_Play = UI.getChildControl(control, "Button_Play")
  local btn_Etc = UI.getChildControl(control, "Button_ETC")
  local musicInfo = ToClient_GetMusicInfoByIndex(_key)
  if nil == musicInfo then
    return
  end
  local arrangerNameStr = musicInfo:getLastComposer()
  musicName:SetTextMode(__eTextMode_LimitText)
  musicName:SetText(musicInfo:getMusicName())
  authorName:SetTextMode(__eTextMode_LimitText)
  authorName:SetText(musicInfo:getAuthorName())
  arrangerName:SetTextMode(__eTextMode_LimitText)
  arrangerName:SetText(arrangerNameStr)
  gradeValue:SetTextMode(__eTextMode_LimitText)
  gradeValue:SetText(musicInfo:getRank())
  gradeValue:SetShow(_ContentsGroup_MusicUpgrade2023 == false)
  local myLevel = ToClient_GetMusicLevel()
  local isLevelOver = musicInfo:isLevelOver(myLevel)
  local trackList = {}
  for index = 0, self._instrumentTrackListSize - 1 do
    local midiType = Toclient_getTrackTypeByIndex(index)
    if -1 ~= midiType then
      local advancedType = ToClient_getAdvancedTypeByIndex(midiType)
      trackList[index] = {}
      trackList[index]._cover = UI.getChildControl(control, "Static_Instrument_" .. midiType % self._controlCount + 1)
      trackList[index]._filter = UI.getChildControl(control, "Radiobutton_Instrument_" .. midiType % self._controlCount + 1)
      trackList[index]._cover:SetMonoTone(true)
      if midiType == 13 and advancedType == __eInstrumentAdvancedType_Advanced then
        trackList[index]._filter:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Concert_00.dds")
        trackList[index]._filter:ChangeOnTextureInfoNameAsync("Combine/Etc/Combine_Etc_Concert_00.dds")
        trackList[index]._filter:ChangeClickTextureInfoNameAsync("Combine/Etc/Combine_Etc_Concert_00.dds")
        local normalUV, onUV, clickUV
        normalUV = {
          x1 = 311,
          y1 = 180,
          x2 = 341,
          y2 = 210
        }
        onUV = {
          x1 = 311,
          y1 = 221,
          x2 = 341,
          y2 = 241
        }
        clickUV = {
          x1 = 311,
          y1 = 242,
          x2 = 341,
          y2 = 272
        }
        local x1, y1, x2, y2 = setTextureUV_Func(trackList[index]._filter, normalUV.x1, normalUV.y1, normalUV.x2, normalUV.y2)
        trackList[index]._filter:getBaseTexture():setUV(x1, y1, x2, y2)
        local x1, y1, x2, y2 = setTextureUV_Func(trackList[index]._filter, onUV.x1, onUV.y1, onUV.x2, onUV.y2)
        trackList[index]._filter:getOnTexture():setUV(x1, y1, x2, y2)
        local x1, y1, x2, y2 = setTextureUV_Func(trackList[index]._filter, clickUV.x1, clickUV.y1, clickUV.x2, clickUV.y2)
        trackList[index]._filter:getClickTexture():setUV(x1, y1, x2, y2)
        trackList[index]._filter:setRenderTexture(trackList[index]._filter:getBaseTexture())
      elseif midiType == 3 and advancedType == __eInstrumentAdvancedType_Novice then
        trackList[index]._filter:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Concert_00.dds")
        trackList[index]._filter:ChangeOnTextureInfoNameAsync("Combine/Etc/Combine_Etc_Concert_00.dds")
        trackList[index]._filter:ChangeClickTextureInfoNameAsync("Combine/Etc/Combine_Etc_Concert_00.dds")
        local normalUV, onUV, clickUV
        normalUV = {
          x1 = 156,
          y1 = 87,
          x2 = 186,
          y2 = 117
        }
        onUV = {
          x1 = 156,
          y1 = 118,
          x2 = 186,
          y2 = 148
        }
        clickUV = {
          x1 = 156,
          y1 = 149,
          x2 = 186,
          y2 = 179
        }
        local x1, y1, x2, y2 = setTextureUV_Func(trackList[index]._filter, normalUV.x1, normalUV.y1, normalUV.x2, normalUV.y2)
        trackList[index]._filter:getBaseTexture():setUV(x1, y1, x2, y2)
        local x1, y1, x2, y2 = setTextureUV_Func(trackList[index]._filter, onUV.x1, onUV.y1, onUV.x2, onUV.y2)
        trackList[index]._filter:getOnTexture():setUV(x1, y1, x2, y2)
        local x1, y1, x2, y2 = setTextureUV_Func(trackList[index]._filter, clickUV.x1, clickUV.y1, clickUV.x2, clickUV.y2)
        trackList[index]._filter:getClickTexture():setUV(x1, y1, x2, y2)
        trackList[index]._filter:setRenderTexture(trackList[index]._filter:getBaseTexture())
      end
      if false == isLevelOver then
        if true == _ContentsGroup_InstrumentShop then
          trackList[index]._filter:addInputEvent("Mouse_LUp", "PaGloabl_SelectInstruments_All_Open(" .. _key .. ")")
        else
          trackList[index]._filter:addInputEvent("Mouse_LUp", "PaGlobal_MusicBoard_All_SelectTrack(" .. _key .. ", " .. midiType .. ")")
        end
        trackList[index]._cover:addInputEvent("Mouse_LUp", "PaGlobal_MusicBoard_All_Edit(" .. _key .. ")")
      else
        trackList[index]._filter:addInputEvent("Mouse_LUp", "")
        trackList[index]._cover:addInputEvent("Mouse_LUp", "")
      end
      trackList[index]._cover:SetShow(false)
      trackList[index]._filter:SetShow(false)
      trackList[index]._midiType = midiType
      trackList[index]._advancedType = advancedType
    end
  end
  local etcIndex = self._instrumentTrackListSize
  trackList[etcIndex] = {}
  trackList[etcIndex]._cover = UI.getChildControl(control, "Static_Instrument_etc")
  trackList[etcIndex]._filter = UI.getChildControl(control, "Radiobutton_Instrument_etc")
  trackList[etcIndex]._filter:addInputEvent("Mouse_On", "PaGlobal_MusicBoard_All_ListEtcTooltip(" .. _key .. ")")
  trackList[etcIndex]._cover:addInputEvent("Mouse_On", "PaGlobal_MusicBoard_All_ListEtcTooltip(" .. _key .. ")")
  trackList[etcIndex]._filter:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
  trackList[etcIndex]._cover:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
  if false == isLevelOver then
    if true == self._isResemble and true == _ContentsGroup_InstrumentShop then
      trackList[etcIndex]._filter:addInputEvent("Mouse_LUp", "PaGloabl_SelectInstruments_All_Open(" .. _key .. ")")
    else
      trackList[etcIndex]._filter:addInputEvent("Mouse_LUp", "PaGlobal_MusicBoard_All_Edit(" .. _key .. ")")
    end
    trackList[etcIndex]._cover:addInputEvent("Mouse_LUp", "PaGlobal_MusicBoard_All_Edit(" .. _key .. ")")
  else
    trackList[etcIndex]._filter:addInputEvent("Mouse_LUp", "")
    trackList[etcIndex]._cover:addInputEvent("Mouse_LUp", "")
  end
  trackList[etcIndex]._filter:SetShow(false)
  trackList[etcIndex]._cover:SetShow(false)
  trackList[etcIndex]._midiType = -1
  local notHaveInstrument = false
  if false == self._isResemble then
    notHaveInstrument = self:setTrackForSolo(trackList, musicInfo, _key)
  else
    notHaveInstrument = self:setTrackForResemble(trackList, musicInfo, _key)
  end
  btn_Play:SetMonoTone(self._isResemble or isLevelOver or notHaveInstrument)
  btn_Play:SetIgnore(self._isResemble or isLevelOver or notHaveInstrument)
  btn_Etc:SetMonoTone(self._isResemble)
  btn_Etc:SetIgnore(self._isResemble)
  btn_Listen:addInputEvent("Mouse_LUp", "PaGlobal_MusicBoard_All_PlayMusic_Self(" .. _key .. ")")
  btn_Play:addInputEvent("Mouse_LUp", "PaGlobal_MusicBoard_All_PlayMusic_OpenSetting(" .. _key .. "," .. self._current_InstrumentType .. ")")
  btn_Etc:addInputEvent("Mouse_LUp", "PaGlobal_MusicBoard_All_PlayMusic_OpenSubMenu(" .. _key .. ")")
  if false == self._isResemble and false == isLevelOver then
    bg:addInputEvent("Mouse_LUp", "PaGlobal_MusicBoard_All_Edit(" .. _key .. ")")
  else
    bg:addInputEvent("Mouse_LUp", "")
  end
end
function PaGlobal_MusicBoard_All:myInstrumentCheck(midiType)
  local myInstrument = PaGlobal_MyInstruments_All:makeForType(self._current_InstrumentType)
  if true == myInstrument[midiType] then
    return false
  else
    return true
  end
end
function PaGlobal_MusicBoard_All:setTrackForSolo(trackList, musicInfo, _key)
  if nil == musicInfo then
    return
  end
  for index = 0, self._instrumentTrackListSize - 1 do
    if nil ~= trackList[index] then
      trackList[index]._cover:SetIgnore(false)
      trackList[index]._filter:SetIgnore(true)
      trackList[index]._cover:SetShow(false)
      trackList[index]._filter:SetShow(false)
      trackList[index]._filter:SetCheck(false)
    end
  end
  local etcIndex = self._instrumentTrackListSize
  trackList[etcIndex]._cover:SetIgnore(false)
  trackList[etcIndex]._filter:SetIgnore(true)
  trackList[etcIndex]._filter:SetShow(false)
  trackList[etcIndex]._cover:SetShow(false)
  local instrumentCount = 0
  for index = 0, self._instrumentTrackListSize - 1 do
    if nil ~= trackList[index] and false == musicInfo:isEmpty(trackList[index]._midiType) and self._current_InstrumentType == trackList[index]._advancedType then
      instrumentCount = instrumentCount + 1
      if instrumentCount <= self._instrumentShowCount then
        trackList[index]._filter:SetShow(true)
        trackList[index]._filter:SetCheck(true)
        trackList[index]._cover:SetShow(true)
      end
    end
  end
  if instrumentCount > self._instrumentShowCount then
    trackList[etcIndex]._filter:SetShow(true)
    trackList[etcIndex]._cover:SetShow(true)
    instrumentCount = self._instrumentShowCount + 1
  end
  local instrumentTitle = self._ui._stc_instrumentTitle
  local iconSizeX = trackList[0]._filter:GetSizeX()
  local gapX = 10
  local middlePosX = instrumentTitle:GetPosX() + instrumentTitle:GetSizeX() * 0.5
  local totalSizeX = instrumentCount * iconSizeX + (instrumentCount - 1) * gapX
  local startPosX = middlePosX - totalSizeX * 0.5
  local checkIndex = 1
  local insertInstrumentTable = {}
  local monoTone = true
  for index = 0, self._instrumentTrackListSize - 1 do
    if nil ~= trackList[index] and self._current_InstrumentType == trackList[index]._advancedType and true == trackList[index]._filter:GetShow() and false == musicInfo:isEmpty(trackList[index]._midiType) then
      local addedInstrument = false
      local instrumnetName = PAGetString(Defines.StringSheet_GAME, "AUDIO_MIDI_INSTRUMENT_" .. tostring(trackList[index]._midiType))
      for ii = 1, checkIndex do
        if nil ~= insertInstrumentTable[ii] and insertInstrumentTable[ii] == instrumnetName then
          addedInstrument = true
          break
        end
      end
      if addedInstrument == false then
        insertInstrumentTable[checkIndex] = instrumnetName
        checkIndex = checkIndex + 1
        trackList[index]._filter:SetPosX(startPosX)
        trackList[index]._cover:SetPosX(startPosX)
        startPosX = startPosX + iconSizeX + gapX
        self:changeIcon(trackList[index]._filter, trackList[index]._midiType)
        local isMonoTone = self:myInstrumentCheck(trackList[index]._midiType)
        monoTone = monoTone and isMonoTone
        trackList[index]._cover:SetMonoTone(isMonoTone)
        trackList[index]._filter:SetMonoTone(isMonoTone)
        trackList[index]._filter:addInputEvent("Mouse_On", "PaGlobal_MusicBoard_All_ListTooltipShow( " .. _key .. ", " .. trackList[index]._midiType % self._controlCount .. "," .. trackList[index]._midiType .. ")")
        trackList[index]._filter:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
        trackList[index]._cover:addInputEvent("Mouse_On", "PaGlobal_MusicBoard_All_ListTooltipShow( " .. _key .. ", " .. trackList[index]._midiType % self._controlCount .. "," .. trackList[index]._midiType .. ")")
        trackList[index]._cover:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
      end
    end
  end
  if true == trackList[etcIndex]._filter:GetShow() then
    trackList[etcIndex]._filter:SetPosX(startPosX + 5)
    trackList[etcIndex]._cover:SetPosX(startPosX + 5)
  end
  return monoTone
end
function PaGlobal_MusicBoard_All:setTrackForResemble(trackList, musicInfo, _key)
  if nil == musicInfo then
    return
  end
  local myLevel = ToClient_GetMusicLevel()
  local isLevelOver = musicInfo:isLevelOver(myLevel)
  for index = 0, self._instrumentTrackListSize - 1 do
    if nil ~= trackList[index] then
      trackList[index]._cover:SetIgnore(true)
      trackList[index]._filter:SetIgnore(isLevelOver)
      trackList[index]._cover:SetShow(false)
      trackList[index]._filter:SetShow(false)
      trackList[index]._filter:SetCheck(true)
    end
  end
  local etcIndex = self._instrumentTrackListSize
  trackList[etcIndex]._cover:SetIgnore(true)
  trackList[etcIndex]._filter:SetIgnore(isLevelOver)
  trackList[etcIndex]._filter:SetShow(false)
  trackList[etcIndex]._cover:SetShow(false)
  trackList[etcIndex]._filter:SetCheck(true)
  local checkIndex = 1
  local insertInstrumentTable = {}
  local instrumentCount = 0
  for index = 0, self._instrumentTrackListSize - 1 do
    if nil ~= trackList[index] and false == musicInfo:isEmpty(trackList[index]._midiType) and self._current_InstrumentType == trackList[index]._advancedType then
      instrumentCount = instrumentCount + 1
      if instrumentCount <= self._instrumentShowCount then
        if true == _ContentsGroup_InstrumentShop then
          trackList[index]._filter:SetCheck(true)
        else
          trackList[index]._filter:SetCheck(false)
        end
        trackList[index]._filter:SetShow(true)
        trackList[index]._cover:SetShow(true)
      end
    end
  end
  if instrumentCount > self._instrumentShowCount then
    trackList[etcIndex]._filter:SetShow(true)
    trackList[etcIndex]._cover:SetShow(true)
    instrumentCount = self._instrumentShowCount + 1
  end
  local instrumentTitle = self._ui._stc_instrumentTitle
  local iconSizeX = trackList[0]._filter:GetSizeX()
  local gapX = 10
  local middlePosX = instrumentTitle:GetPosX() + instrumentTitle:GetSizeX() * 0.5
  local totalSizeX = instrumentCount * iconSizeX + (instrumentCount - 1) * gapX
  local startPosX = middlePosX - totalSizeX * 0.5
  local monoTone = true
  for index = 0, self._instrumentTrackListSize - 1 do
    if nil ~= trackList[index] and trackList[index]._advancedType == self._current_InstrumentType and true == trackList[index]._filter:GetShow() and false == musicInfo:isEmpty(trackList[index]._midiType) then
      local addedInstrument = false
      local instrumnetName = PAGetString(Defines.StringSheet_GAME, "AUDIO_MIDI_INSTRUMENT_" .. tostring(trackList[index]._midiType))
      for ii = 1, checkIndex do
        if nil ~= insertInstrumentTable[ii] and insertInstrumentTable[ii] == instrumnetName then
          addedInstrument = true
          break
        end
      end
      if addedInstrument == false then
        insertInstrumentTable[checkIndex] = instrumnetName
        checkIndex = checkIndex + 1
        trackList[index]._filter:SetPosX(startPosX)
        trackList[index]._cover:SetPosX(startPosX)
        startPosX = startPosX + iconSizeX + gapX
        self:changeIcon(trackList[index]._filter, trackList[index]._midiType)
        local isMonoTone = self:myInstrumentCheck(trackList[index]._midiType)
        monoTone = monoTone and isMonoTone
        trackList[index]._cover:SetMonoTone(isMonoTone)
        trackList[index]._filter:SetMonoTone(isMonoTone)
        trackList[index]._filter:addInputEvent("Mouse_On", "PaGlobal_MusicBoard_All_ListTooltipShow( " .. _key .. ", " .. trackList[index]._midiType % self._controlCount .. "," .. trackList[index]._midiType .. ")")
        trackList[index]._filter:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
        trackList[index]._cover:addInputEvent("Mouse_On", "PaGlobal_MusicBoard_All_ListTooltipShow( " .. _key .. ", " .. trackList[index]._midiType % self._controlCount .. "," .. trackList[index]._midiType .. ")")
        trackList[index]._cover:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
      end
    end
  end
  if true == trackList[etcIndex]._filter:GetShow() then
    trackList[etcIndex]._filter:SetPosX(startPosX + 5)
    trackList[etcIndex]._cover:SetShow(startPosX + 5)
  end
  return monoTone
end
function PaGlobal_MusicBoard_All:setMainFilterPos()
  local filterCount = self._instrumentTrackListSize
  local startPosX = self._ui._txt_GradeValue:GetPosX() + self._ui._txt_GradeValue:GetTextSizeX() + 50
  local totalSizeX = self._ui._stc_topGroupBg:GetSizeX() - startPosX - 50
  local gapX = totalSizeX / filterCount
  for index = 0, filterCount - 1 do
    if nil ~= self._ui._checkBox_Filter[index] then
      self._ui._checkBox_Filter[index].control:SetPosX(startPosX)
      startPosX = startPosX + gapX
    end
  end
end
function PaGlobal_MusicBoard_All:initialize()
  if true == PaGlobal_MusicBoard_All._initialize then
    return
  end
  if _ContentsGroup_ContraInstrument == false and _ContentsGroup_ContraInstrument == false then
    self._controlCount = 10
  end
  self._instrumentTrackListSize = Toclient_MidiInstrumentTrackCount()
  if true == _ContentsGroup_AdvancedMusic then
    self._instrumentTrackListSize = Toclient_MidiInstrumentTrackCount()
  else
    self._instrumentTrackListSize = Toclient_MidiInstrumentTrackCount()
    if self._controlCount < self._instrumentTrackListSize then
      self._instrumentTrackListSize = self._controlCount
    end
  end
  Panel_Window_MusicBoard_All:SetShow(false)
  Panel_Window_MusicBoard_All:setGlassBackground(true)
  Panel_Window_MusicBoard_All:ActiveMouseEventEffect(false)
  local topBg = UI.getChildControl(Panel_Window_MusicBoard_All, "Static_TitleBG")
  self._ui._btn_Close = UI.getChildControl(topBg, "Button_Win_Close_PC")
  local AllCheckBox = {}
  self._ui._btn_Question = UI.getChildControl(topBg, "Button_Question_PC")
  if true == _ContentsGroup_AdvancedMusic then
    self._ui._stc_topGroupBg = UI.getChildControl(Panel_Window_MusicBoard_All, "Static_TopExpertGroup")
    self._ui._stc_Expert_Group = UI.getChildControl(Panel_Window_MusicBoard_All, "Static_Expert_RadioGroup")
    local NotUseBg = UI.getChildControl(Panel_Window_MusicBoard_All, "Static_TopGroup")
    NotUseBg:SetShow(false)
    self._ui._stc_FilterBg = UI.getChildControl(self._ui._stc_topGroupBg, "Static_FilterBg")
    self._ui._radio_InstrumentType[__eInstrumentAdvancedType_Novice] = UI.getChildControl(self._ui._stc_Expert_Group, "RadioButton_Newbie")
    self._ui._radio_InstrumentType[__eInstrumentAdvancedType_Advanced] = UI.getChildControl(self._ui._stc_Expert_Group, "RadioButton_Expert")
    self._ui._radio_InstrumentType[__eeInstrumentAdvancedType_Synth] = UI.getChildControl(self._ui._stc_Expert_Group, "RadioButton_Marnis")
    self._ui._radio_InstrumentType[self._current_InstrumentType]:SetCheck(true)
    if _ContentsGroup_MarnisInstrument == false then
      self._ui._radio_InstrumentType[__eeInstrumentAdvancedType_Synth]:SetShow(false)
      local sizeX = self._ui._radio_InstrumentType[__eeInstrumentAdvancedType_Synth]:GetSizeX() * 0.5 + 10
      self._ui._radio_InstrumentType[__eInstrumentAdvancedType_Novice]:SetSpanSize(sizeX * -1, spanSizeY)
      self._ui._radio_InstrumentType[__eInstrumentAdvancedType_Advanced]:SetSpanSize(sizeX, spanSizeY)
    end
    for index = 0, self._controlCount - 1 do
      AllCheckBox[index] = UI.getChildControl(self._ui._stc_FilterBg, "CheckButton_Instrument_" .. index + 1)
      AllCheckBox[index]:SetShow(false)
    end
  else
    self._ui._stc_topGroupBg = UI.getChildControl(Panel_Window_MusicBoard_All, "Static_TopGroup")
    local NotUseBg = UI.getChildControl(Panel_Window_MusicBoard_All, "Static_TopExpertGroup")
    NotUseBg:SetShow(false)
    self._ui._chk_instrument_temp = UI.getChildControl(self._ui._stc_topGroupBg, "CheckButton_Instrument_Temp")
  end
  self._ui._stc_topGroupBg:SetShow(true)
  self._ui._checkBox_Filter = {}
  local checkIndex = 1
  local insertInstrumentTable = {}
  for index = 0, self._instrumentTrackListSize - 1 do
    local midiType = Toclient_getTrackTypeByIndex(index)
    if -1 ~= midiType then
      local advancedType = ToClient_getAdvancedTypeByIndex(midiType)
      if true == _ContentsGroup_AdvancedMusic then
        if advancedType ~= __eInstrumentAdvancedType_Novice then
          local addedInstrument = false
          local instrumnetName = PAGetString(Defines.StringSheet_GAME, "AUDIO_MIDI_INSTRUMENT_" .. tostring(midiType))
          for ii = 1, checkIndex do
            if nil ~= insertInstrumentTable[ii] and insertInstrumentTable[ii] == instrumnetName then
              addedInstrument = true
              break
            end
          end
          local isOpenContent = true
          if midiType == 15 and false == _ContentsGroup_ContraInstrument then
            isOpenContent = false
          end
          if false == addedInstrument and true == isOpenContent then
            insertInstrumentTable[checkIndex] = instrumnetName
            checkIndex = checkIndex + 1
            local checkBox = UI.cloneControl(AllCheckBox[midiType % self._controlCount], self._ui._stc_FilterBg, "CheckButton_Instrument_Copy_" .. midiType + 1)
            self._ui._checkBox_Filter[index] = {}
            self._ui._checkBox_Filter[index].control = checkBox
            self._ui._checkBox_Filter[index].control:SetShow(true)
            self._ui._checkBox_Filter[index].midiType = midiType
            local icon = UI.getChildControl(self._ui._checkBox_Filter[index].control, "Static_Icon")
            if midiType == 13 then
              local normalUV
              normalUV = {
                x1 = 311,
                y1 = 242,
                x2 = 341,
                y2 = 272
              }
              icon:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Concert_00.dds")
              local x1, y1, x2, y2 = setTextureUV_Func(icon, normalUV.x1, normalUV.y1, normalUV.x2, normalUV.y2)
              icon:getBaseTexture():setUV(x1, y1, x2, y2)
              icon:setRenderTexture(icon:getBaseTexture())
            end
            self:changeIcon(icon, midiType)
            icon:setRenderTexture(icon:getBaseTexture())
            self._ui._checkBox_Filter[index].advancedType = advancedType
          end
        else
          self._ui._checkBox_Filter[index] = {}
          self._ui._checkBox_Filter[index].control = AllCheckBox[midiType]
          self._ui._checkBox_Filter[index].control:SetShow(false)
          self._ui._checkBox_Filter[index].midiType = midiType
          self._ui._checkBox_Filter[index].advancedType = advancedType
        end
      else
        local checkBox = UI.cloneControl(self._ui._chk_instrument_temp, self._ui._stc_topGroupBg, "CheckButton_Instrument_" .. midiType + 1)
        self._ui._checkBox_Filter[index] = {}
        self._ui._checkBox_Filter[index].control = checkBox
        self._ui._checkBox_Filter[index].control:SetShow(true)
        self._ui._checkBox_Filter[index].midiType = midiType
        self._ui._checkBox_Filter[index].advancedType = advancedType
        local icon = UI.getChildControl(self._ui._checkBox_Filter[index].control, "Static_Icon")
        if midiType == 13 then
          local normalUV
          normalUV = {
            x1 = 311,
            y1 = 242,
            x2 = 341,
            y2 = 272
          }
          icon:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Concert_00.dds")
          local x1, y1, x2, y2 = setTextureUV_Func(icon, normalUV.x1, normalUV.y1, normalUV.x2, normalUV.y2)
          icon:getBaseTexture():setUV(x1, y1, x2, y2)
          icon:setRenderTexture(icon:getBaseTexture())
        end
        self:changeIcon(icon, midiType)
        icon:setRenderTexture(icon:getBaseTexture())
      end
    end
  end
  self._ui._txt_GradeValue = UI.getChildControl(self._ui._stc_topGroupBg, "StaticText_MyGradeValue")
  self._ui._stc_gradeTitle = UI.getChildControl(self._ui._stc_topGroupBg, "StaticText_MyGrade_Title")
  local gabX = self._ui._stc_gradeTitle:GetTextSizeX() - self._ui._stc_gradeTitle:GetSizeX()
  if gabX > 0 then
    self._ui._txt_GradeValue:SetSpanSize(self._ui._txt_GradeValue:GetSpanSize().x + gabX, self._ui._txt_GradeValue:GetSpanSize().y)
  end
  self._ui._stc_list = UI.getChildControl(Panel_Window_MusicBoard_All, "Static_ListBg")
  self._ui._list2 = UI.getChildControl(self._ui._stc_list, "List2_MusicList")
  self._subMenuStartPosY = self._ui._stc_list:GetPosY() + self._ui._list2:GetPosY()
  self._ui._stc_instrumentTitle = UI.getChildControl(self._ui._stc_list, "StaticText_InstrumentTitle")
  self._ui._txt_gradeTitle = UI.getChildControl(self._ui._stc_list, "StaticText_GradeTitle")
  self._ui._txt_gradeTitle:SetShow(_ContentsGroup_MusicUpgrade2023 == false)
  local bottomBg = UI.getChildControl(Panel_Window_MusicBoard_All, "Static_BottomGroup")
  self._ui._btn_Composition = UI.getChildControl(bottomBg, "Button_Composition")
  self._ui._btn_Album = UI.getChildControl(bottomBg, "Button_Album")
  self._ui._btn_Option = UI.getChildControl(bottomBg, "Button_Option")
  self._ui._btn_Ready = UI.getChildControl(bottomBg, "Button_Ready")
  self._ui._btn_Refuse = UI.getChildControl(bottomBg, "Button_Refuse")
  self._ui._btn_MyInstruments = UI.getChildControl(bottomBg, "Button_MyInstruments")
  self._ui._edit_search = UI.getChildControl(bottomBg, "Edit_SearchText_PCUI_Import")
  self._ui._btn_search = UI.getChildControl(self._ui._edit_search, "Button_BtnSearch_PCUI")
  self._ui._btn_searchReset = UI.getChildControl(self._ui._edit_search, "Button_Reset")
  self._ui._stc_searchConsole = UI.getChildControl(self._ui._edit_search, "StaticText_XButton")
  self._ui._btn_BottomClose = UI.getChildControl(bottomBg, "Button_Close")
  self._ui._subGroup_bg = UI.getChildControl(Panel_Window_MusicBoard_All, "Static_SubButtonBg")
  self._ui._btn_Share = UI.getChildControl(self._ui._subGroup_bg, "Button_Share")
  self._ui._btn_Delete = UI.getChildControl(self._ui._subGroup_bg, "Button_Delete")
  self._ui._btn_Edit = UI.getChildControl(self._ui._subGroup_bg, "Button_Edit")
  self._ui._subGroup_bg:SetShow(false)
  self._ui._stc_emptyDesc = UI.getChildControl(self._ui._stc_list, "StaticText_Empty_Desc")
  self._ui._stc_emptyDesc:SetShow(true)
  if true == isGameTypeGT() then
    self:closeShareButton()
  end
  if true == _ContentsGroup_AdvancedMusic then
    self:filterPosInit()
  else
    self:setMainFilterPos()
  end
  self:setConsoleUI()
  PaGlobal_MusicBoard_All:registEventHandler()
  PaGlobal_MusicBoard_All:validate()
  PaGlobal_MusicBoard_All._initialize = true
end
function PaGlobal_MusicBoard_All:registEventHandler()
  if nil == Panel_Window_MusicBoard_All then
    return
  end
  registerEvent("FromClient_OpenMusicBoardToPartyMusic", "FromClient_OpenMusicBoardToPartyMusic")
  registerEvent("FromClient_OpenMessageBoxAutoRefuse", "FromClient_OpenMessageBoxAutoRefuse")
  registerEvent("FromClient_ClosePartyMusic", "FromClient_ClosePartyMusic")
  registerEvent("FromClient_IncreaseExp", "FromClient_IncreaseExp_MusicBoard")
  registerEvent("FromClient_InstrumentItem_Use", "FromClient_InstrumentItem_Use")
  registerEvent("FromClient_CheckChinaProhibitedWord_SearchMusicBoardList", "FromClient_CheckChinaProhibitedWord_SearchMusicBoardList")
  Panel_Window_MusicBoard_All:RegisterShowEventFunc(true, "PaGlobal_MusicBoard_All_ShowAni()")
  Panel_Window_MusicBoard_All:RegisterShowEventFunc(false, "PaGlobal_MusicBoard_All_HideAni()")
  self._ui._list2:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_MusicBoard_All_ListControlCreate")
  self._ui._list2:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_MusicBoard_All_Close()")
  self._ui._btn_BottomClose:addInputEvent("Mouse_LUp", "PaGlobal_MusicBoard_All_Close()")
  if isGameTypeCH() == true then
    self._ui._btn_Question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"MusicAlbum\" )")
  end
  self._ui._btn_Composition:addInputEvent("Mouse_LUp", "PaGlobal_Composition_All_Open()")
  self._ui._btn_Album:addInputEvent("Mouse_LUp", "PaGlobal_MusicBoard_All_OpenAlbum()")
  self._ui._btn_Option:addInputEvent("Mouse_LUp", "PaGlobal_MusicBoard_All_SoundOption()")
  self._ui._btn_Ready:addInputEvent("Mouse_LUp", "PaGlobal_MusicBoard_All_Ready()")
  self._ui._btn_Refuse:addInputEvent("Mouse_LUp", "PaGlobal_MusicBoard_All_Refuse()")
  self._ui._btn_MyInstruments:addInputEvent("Mouse_LUp", "PaGlobal_MyInstruments_All_Open()")
  self._ui._btn_Share:addInputEvent("Mouse_LUp", "PaGlobal_MusicBoard_All_Share()")
  self._ui._btn_Delete:addInputEvent("Mouse_LUp", "PaGlobal_MusicBoard_All_Delete()")
  self._ui._btn_Edit:addInputEvent("Mouse_LUp", "PaGlobal_MusicBoard_All_Edit()")
  for index = 0, self._instrumentTrackListSize - 1 do
    local midiType = Toclient_getTrackTypeByIndex(index)
    if -1 ~= midiType and nil ~= self._ui._checkBox_Filter[index] then
      local checkBox = self._ui._checkBox_Filter[index].control
      checkBox:addInputEvent("Mouse_LUp", "PaGlobal_MusicBoard_All_ClickedFilter()")
      checkBox:addInputEvent("Mouse_On", "PaGlobal_MusicBoard_All_FilterTooltipShow(" .. index .. ", " .. midiType .. ")")
      checkBox:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
    end
  end
  if true == _ContentsGroup_AdvancedMusic then
    self._ui._radio_InstrumentType[__eInstrumentAdvancedType_Novice]:addInputEvent("Mouse_LUp", "PaGlobal_MusicBoard_All_ChangeFilterType(" .. __eInstrumentAdvancedType_Novice .. ")")
    self._ui._radio_InstrumentType[__eInstrumentAdvancedType_Advanced]:addInputEvent("Mouse_LUp", "PaGlobal_MusicBoard_All_ChangeFilterType(" .. __eInstrumentAdvancedType_Advanced .. ")")
    self._ui._radio_InstrumentType[__eeInstrumentAdvancedType_Synth]:addInputEvent("Mouse_LUp", "PaGlobal_MusicBoard_All_ChangeFilterType(" .. __eeInstrumentAdvancedType_Synth .. ")")
  end
  self._ui._edit_search:addInputEvent("Mouse_LUp", "PaGlobal_MusicBoard_All:setFocusSearchText()")
  if true == ToClient_isConsole() then
    self._ui._edit_search:setXboxVirtualKeyBoardEndEvent("PaGlobal_MusicBoard_All:searchList()")
  else
    self._ui._edit_search:RegistReturnKeyEvent("PaGlobal_MusicBoard_All:searchList()")
  end
  self._ui._btn_search:addInputEvent("Mouse_LUp", "PaGlobal_MusicBoard_All:searchList()")
  self._ui._btn_searchReset:addInputEvent("Mouse_LUp", "PaGlobal_MusicBoard_All:clearSearch()")
  self._ui._btn_searchReset:addInputEvent("Mouse_On", "HandleEventOnOut_MusicBoard_All_SearchResetTooltip(true)")
  self._ui._btn_searchReset:addInputEvent("Mouse_Out", "HandleEventOnOut_MusicBoard_All_SearchResetTooltip(false)")
end
function PaGlobal_MusicBoard_All:setConsoleUI()
  self._ui._btn_search:SetShow(not _ContentsGroup_UsePadSnapping)
  self._ui._stc_searchConsole:SetShow(_ContentsGroup_UsePadSnapping)
end
function PaGlobal_MusicBoard_All:closeShareButton()
  self._ui._btn_Share:SetShow(false)
  self._ui._subGroup_bg:SetSize(self._ui._subGroup_bg:GetSizeX(), self._ui._subGroup_bg:GetSizeY() - self._ui._btn_Share:GetSizeY() - 5)
  self._ui._btn_Edit:SetPosY(self._ui._btn_Share:GetPosY())
  self._ui._btn_Delete:SetPosY(self._ui._btn_Edit:GetPosY() + self._ui._btn_Edit:GetSizeY() + 5)
  self._ui._btn_Album:SetShow(false)
  self._ui._btn_Option:SetPosX(Panel_Window_MusicBoard_All:GetSizeX() / 2 - self._ui._btn_Option:GetSizeX() / 2)
  self._ui._btn_Composition:SetPosX(self._ui._btn_Option:GetPosX() - self._ui._btn_Composition:GetSizeX() - 20)
  self._ui._btn_BottomClose:SetPosX(self._ui._btn_Option:GetPosX() + self._ui._btn_Option:GetSizeX() + 20)
end
function PaGlobal_MusicBoard_All:prepareOpen(isResemble)
  if nil == Panel_Window_MusicBoard_All then
    return
  end
  if not ToClient_IsPopUpToggle() then
    return
  end
  if true == PaGlobal_PlayMusic_All_IsShow() or true == ToClient_IsRequesetSummonForPlayMusic() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantPlayMusic"))
    return
  end
  audioPostEvent_SystemUi(13, 6)
  _AudioPostEvent_SystemUiForXBOX(13, 6)
  if true == _ContentsGroup_AdvancedMusic then
    for ii = 0, self._instrumentTrackListSize - 1 do
      if nil ~= self._ui._checkBox_Filter[ii] then
        self._ui._checkBox_Filter[ii].control:SetCheck(true)
      end
    end
  else
    for ii = 0, self._instrumentTrackListSize - 1 do
      if nil ~= self._ui._checkBox_Filter[ii] then
        self._ui._checkBox_Filter[ii].control:SetCheck(true)
      end
    end
  end
  self:clearFocusSearchText()
  if true == isResemble then
    PaGlobal_MusicBoard_All_SelectTrack(-1, -1)
  end
  self._ui._btn_Album:setRenderTexture(self._ui._btn_Album:getBaseTexture())
  self._isResemble = isResemble
  self:resize()
  self:setButton(self._isResemble)
  ToClient_loadMusicList()
  self:update()
  PaGlobal_MusicBoard_All:open()
end
function PaGlobal_MusicBoard_All:updateReadyButton()
  if -1 == self._musicIndex or -1 == self._trackIndex then
    self._ui._btn_Ready:SetIgnore(true)
    self._ui._btn_Ready:SetMonoTone(true)
  else
    self._ui._btn_Ready:SetIgnore(false)
    self._ui._btn_Ready:SetMonoTone(false)
  end
end
function PaGlobal_MusicBoard_All:filterPosInit()
  if true == _ContentsGroup_AdvancedMusic then
    local viewControl = {}
    local viewCount = 0
    for index = 0, self._instrumentTrackListSize - 1 do
      if nil ~= self._ui._checkBox_Filter[index] and self._ui._checkBox_Filter[index].advancedType == self._current_InstrumentType then
        if true == ToClient_getInstrumentIsOpenedByIndex(self._ui._checkBox_Filter[index].midiType) then
          viewControl[viewCount] = self._ui._checkBox_Filter[index].control
          viewControl[viewCount]:SetShow(true)
          viewCount = viewCount + 1
        else
          self._ui._checkBox_Filter[index].control:SetShow(false)
        end
      elseif nil ~= self._ui._checkBox_Filter[index] then
        self._ui._checkBox_Filter[index].control:SetShow(false)
      end
    end
    local gap = (self._ui._stc_FilterBg:GetSizeX() - self._ui._checkBox_Filter[0].control:GetSizeX() * viewCount) / viewCount
    local startPos = gap / 2
    for index = 0, viewCount - 1 do
      viewControl[index]:SetPosX(startPos + (viewControl[index]:GetSizeX() + gap) * index)
    end
  else
    for index = 1, self._instrumentTrackListSize - 1 do
      if nil ~= self._ui._checkBox_Filter[index] and nil ~= self._ui._checkBox_Filter[index - 1] then
        self._ui._checkBox_Filter[index].control:SetPosX(self._ui._checkBox_Filter[index - 1].control:GetPosX() + self._ui._checkBox_Filter[index - 1].control:GetTextSizeX() + 50)
      end
    end
  end
end
function PaGlobal_MusicBoard_All:setButton(isResemble)
  if nil == Panel_Window_MusicBoard_All then
    return
  end
  self._ui._btn_Composition:SetShow(not isResemble)
  if false == isGameTypeGT() then
    self._ui._btn_Album:SetShow(not isResemble)
  end
  self._ui._btn_BottomClose:SetShow(not isResemble)
  self._ui._btn_Option:SetShow(not isResemble)
  self._ui._btn_Ready:SetShow(isResemble)
  self._ui._btn_Refuse:SetShow(isResemble)
end
function PaGlobal_MusicBoard_All:update()
  if nil == Panel_Window_MusicBoard_All then
    return
  end
  local musicCount = ToClient_GetMusicListCount()
  self._ui._subGroup_bg:SetShow(false)
  self._etcMusicIndex = -1
  self._ui._list2:getElementManager():clearKey()
  self._ui._stc_emptyDesc:SetShow(false)
  local isEmpty = true
  for index = 0, musicCount - 1 do
    if self:checkedFiter(index) then
      if self._isResemble == true then
        local musicInfo = ToClient_GetMusicInfoByIndex(index)
        if musicInfo:getMusicName() == self._ensembleMusicName or self._ensembleMusicName == nil then
          self._ui._list2:getElementManager():pushKey(index)
          isEmpty = false
        end
      else
        self._ui._list2:getElementManager():pushKey(index)
        isEmpty = false
      end
    end
  end
  if isEmpty == true then
    self._ui._stc_emptyDesc:SetShow(true)
  end
  self._ui._txt_GradeValue:SetText(ToClient_GetMusicRank())
end
function PaGlobal_MusicBoard_All:checkedFiter(index)
  local musicInfo = ToClient_GetMusicInfoByIndex(index)
  if nil == musicInfo then
    return false
  end
  local size = musicInfo:getTrackSize()
  for ii = 0, size - 1 do
    if nil ~= self._searchString and false == stringSearch(musicInfo:getMusicName(), self._searchString) then
      return false
    end
    local trackTypeIndex = musicInfo:getTrackTypeByIndex(ii)
    local isEmpty = musicInfo:isEmpty(trackTypeIndex)
    if false == isEmpty and true == Toclient_isExistTrackType(trackTypeIndex) then
      local checkBoxIndex = PaGlobal_MusicBoard_All:checkBoxIndexByMidiType(trackTypeIndex)
      if -1 ~= checkBoxIndex and true == self._ui._checkBox_Filter[checkBoxIndex].control:IsCheck() then
        return true
      end
    end
  end
  return false
end
function PaGlobal_MusicBoard_All:checkBoxIndexByMidiType(midiType)
  if self._current_InstrumentType == __eeInstrumentAdvancedType_Synth then
    if midiType > 20 and midiType <= 23 then
      midiType = 20
    elseif midiType > 24 and midiType <= 27 then
      midiType = 24
    elseif midiType > 28 and midiType <= 31 then
      midiType = 28
    elseif midiType > 32 and midiType <= 35 then
      midiType = 32
    end
  end
  for ii = 0, self._instrumentTrackListSize - 1 do
    if nil ~= self._ui._checkBox_Filter[ii] and midiType == self._ui._checkBox_Filter[ii].midiType and self._current_InstrumentType == self._ui._checkBox_Filter[ii].advancedType then
      return ii
    end
  end
  return -1
end
function PaGlobal_MusicBoard_All:open()
  if nil == Panel_Window_MusicBoard_All then
    return
  end
  Panel_Window_MusicBoard_All:SetShow(true)
end
function PaGlobal_MusicBoard_All:prepareClose()
  if nil == Panel_Window_MusicBoard_All then
    return
  end
  if false == Panel_Window_MusicBoard_All:GetShow() then
    return
  end
  if _ContentsOption_CH_CheckProhibitedWord == true then
    self._ui._edit_search:RegistReturnKeyEvent("PaGlobal_MusicBoard_All:searchList()")
    self._ui._btn_search:SetIgnore(false)
  end
  audioPostEvent_SystemUi(13, 5)
  _AudioPostEvent_SystemUiForXBOX(13, 5)
  ToClient_StopMusic(false)
  PaGlobal_MusicBoard_All:close()
end
function PaGlobal_MusicBoard_All:close()
  if nil == Panel_Window_MusicBoard_All then
    return
  end
  Panel_Window_MusicBoard_All:SetShow(false)
end
function PaGlobal_MusicBoard_All:validate()
  if nil == Panel_Window_MusicBoard_All then
    return
  end
end
function PaGlobal_MusicBoard_All:resize()
  if nil == Panel_Window_MusicBoard_All then
    return
  end
  Panel_Window_MusicBoard_All:SetPosX(getScreenSizeX() * 0.5 - Panel_Window_MusicBoard_All:GetSizeX() * 0.5)
  Panel_Window_MusicBoard_All:SetPosY(getScreenSizeY() * 0.5 - Panel_Window_MusicBoard_All:GetSizeY() * 0.5)
  PaGlobal_MusicBoard_All:BottomBtnPosSetting()
end
function PaGlobal_MusicBoard_All:OpenSubMenu(musicIndex)
  if nil == Panel_Window_MusicBoard_All then
    return
  end
  local contents = self._ui._list2:GetContentByKey(musicIndex)
  local listContentsPosY = contents:GetPosY()
  local subMenuPosY = self._subMenuStartPosY + listContentsPosY
  local musicInfo = ToClient_GetMusicInfoByIndex(musicIndex)
  if nil == musicInfo then
    return
  end
  self._etcMusicIndex = musicIndex
  local myLevel = ToClient_GetMusicLevel()
  local isLevelOver = musicInfo:isLevelOver(myLevel)
  if true == isLevelOver then
    self._ui._btn_Edit:SetIgnore(true)
    self._ui._btn_Edit:SetMonoTone(true)
  else
    self._ui._btn_Edit:SetIgnore(false)
    self._ui._btn_Edit:SetMonoTone(false)
  end
  self._ui._subGroup_bg:SetPosY(subMenuPosY)
  self._ui._subGroup_bg:SetShow(true)
end
function PaGlobal_MusicBoard_All:BottomBtnPosSetting()
  if nil == Panel_Window_MusicBoard_All then
    return
  end
  if true == _ContentsGroup_InstrumentShop then
    local uiList = {}
    if false == self._isResemble then
      uiList = {
        self._ui._btn_MyInstruments,
        self._ui._btn_Composition,
        self._ui._btn_Album,
        self._ui._btn_Option,
        self._ui._btn_BottomClose,
        self._ui._edit_search
      }
    else
      uiList = {
        self._ui._btn_MyInstruments,
        self._ui._btn_Ready,
        self._ui._btn_Refuse,
        self._ui._edit_search
      }
    end
    local listCount = #uiList
    local gap = 10
    local enableBgSize = 0
    for index = 1, listCount do
      local btnXSize = uiList[index]:GetSizeX()
      enableBgSize = enableBgSize + btnXSize
    end
    enableBgSize = enableBgSize + (listCount - 1) * gap
    local bottomBg = UI.getChildControl(Panel_Window_MusicBoard_All, "Static_BottomGroup")
    local startPosX = (bottomBg:GetSizeX() - enableBgSize) * 0.5
    for index = 1, listCount do
      uiList[index]:SetPosX(startPosX)
      local buttonGap = uiList[index]:GetSizeX()
      startPosX = startPosX + buttonGap + gap
    end
  else
    self._ui._btn_MyInstruments:SetShow(false)
  end
end
function PaGlobal_MusicBoard_All:setFocusSearchText()
  if nil == self._searchString then
    self._ui._edit_search:SetEditText("")
  end
  SetFocusEdit(self._ui._edit_search)
end
function PaGlobal_MusicBoard_All:clearFocusSearchText()
  ClearFocusEdit()
  TooltipSimple_Hide()
  self._ui._edit_search:SetEditText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INGAMECASHSHOP_NEW_EDIT_GOODSNAME"))
  UI.setLimitTextAndAddTooltip(_edit_search)
  self._searchString = nil
  self._ui._btn_search:SetShow(true)
  self._ui._btn_searchReset:SetShow(false)
end
function PaGlobal_MusicBoard_All:clearSearch()
  self:clearFocusSearchText()
  self:update()
end
function PaGlobal_MusicBoard_All:searchList()
  if false == CheckChattingInput() then
    ClearFocusEdit()
  end
  self._searchString = self._ui._edit_search:GetEditText()
  if "" == self._searchString then
    self._searchString = nil
    self._ui._edit_search:SetEditText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INGAMECASHSHOP_NEW_EDIT_GOODSNAME"))
    UI.setLimitTextAndAddTooltip(_edit_search)
  end
  if _ContentsOption_CH_CheckProhibitedWord == true and self._searchString ~= nil then
    local result = ToClient_CheckChinaProhibitedWord(self._searchString, __eSceneIdSearchMusicBoardList)
    if result == true then
      self._ui._edit_search:RegistReturnKeyEvent("")
      self._ui._btn_search:SetIgnore(true)
    end
    return
  end
  self._ui._btn_search:SetShow(nil == self._searchString)
  self._ui._btn_searchReset:SetShow(nil ~= self._searchString)
  self:update()
end
function PaGlobal_MusicBoard_All:changeIcon(control, midiType)
  if 10 == midiType or 0 == midiType then
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_Guitar_Click", 0)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_Guitar_Normal", 1)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_Guitar_Click", 2)
  elseif 11 == midiType or 1 == midiType then
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_Flute_Click", 0)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_Flute_Normal", 1)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_Flute_Click", 2)
  elseif 2 == midiType then
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LRecorder_Click", 0)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LRecorder_Normal", 1)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LRecorder_Click", 2)
  elseif 4 == midiType then
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LDjembe_Click", 0)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LDjembe_Normal", 1)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LDjembe_Click", 2)
  elseif 5 == midiType then
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LCymbals_Click", 0)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LCymbals_Normal", 1)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LCymbals_Click", 2)
  elseif 13 == midiType then
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LDurmSet_Click", 0)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LDurmSet_Normal", 1)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LDurmSet_Click", 2)
  elseif 14 == midiType then
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LMarnibass_Click", 0)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LMarnibass_Normal", 1)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LMarnibass_Click", 2)
  elseif 15 == midiType then
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LDoublebass_Click", 0)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LDoublebass_Normal", 1)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LDoublebass_Click", 2)
  elseif 16 == midiType or 6 == midiType then
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LHarp_Click", 0)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LHarp_Normal", 1)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LHarp_Click", 2)
  elseif 17 == midiType or 7 == midiType then
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LPiano_Cick", 0)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LPiano_Cick", 1)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LPiano_Cick", 2)
  elseif 18 == midiType or 8 == midiType then
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LVioiln_Click", 0)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LVioiln_Normal", 1)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LVioiln_Click", 2)
  elseif 19 == midiType then
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LPandurm_Cick", 0)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LPandurm_Normal", 1)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LPandurm_Cick", 2)
  elseif midiType >= 20 and midiType <= 23 then
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LMarnion_A_Click", 0)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LMarnion_A_Normal", 1)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LMarnion_A_Click", 2)
  elseif midiType >= 24 and midiType <= 27 then
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LMarnion_B_Click", 0)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LMarnion_B_Normal", 1)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LMarnion_B_Click", 2)
  elseif midiType >= 28 and midiType <= 31 then
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LMarnion_C_Click", 0)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LMarnion_C_Normal", 1)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LMarnion_C_Click", 2)
  elseif midiType >= 32 and midiType <= 35 then
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LMarnion_D_Click", 0)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LMarnion_D_Normal", 1)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LMarnion_D_Click", 2)
  elseif 36 == midiType then
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_ElectricGuitar_Silverwaves_Cick", 0)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_ElectricGuitar_Silverwaves_Normal", 1)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_ElectricGuitar_Silverwaves_Cick", 2)
  elseif 37 == midiType then
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_ElectricGuitar_Highway_Cick", 0)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_ElectricGuitar_Highway_Normal", 1)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_ElectricGuitar_Highway_Cick", 2)
  elseif 38 == midiType then
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_ElectricGuitar_Hexeglam_Cick", 0)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_ElectricGuitar_Hexeglam_Normal", 1)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_ElectricGuitar_Hexeglam_Cick", 2)
  elseif 39 == midiType then
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_Clarinet_Cick", 0)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_Clarinet_Normal", 1)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_Clarinet_Cick", 2)
  elseif 40 == midiType then
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_Horn_Cick", 0)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_Horn_Normal", 1)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_Horn_Cick", 2)
  end
  control:setRenderTexture(control:getBaseTexture())
end
