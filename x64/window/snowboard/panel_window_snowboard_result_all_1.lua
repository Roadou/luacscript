function PaGlobal_SnowBoardFieldResult:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.stc_mainBg = UI.getChildControl(Panel_Window_SnowBoard_Result_All, "Static_MainBg")
  self._ui.stc_resultImage = UI.getChildControl(self._ui.stc_mainBg, "Static_Finish")
  self._ui.stc_itemGroupBg = UI.getChildControl(self._ui.stc_mainBg, "Static_ItemModeGroup")
  self._ui.txt_itemCount = UI.getChildControl(self._ui.stc_itemGroupBg, "StaticText_CountValue")
  self._ui.stc_itemCountDeco = UI.getChildControl(self._ui.stc_itemGroupBg, "Static_CountDeco")
  self._ui.stc_speedGroupBg = UI.getChildControl(self._ui.stc_mainBg, "Static_SpeedModeGroup")
  self._ui.stc_bestLapTimeTitle = UI.getChildControl(self._ui.stc_speedGroupBg, "StaticText_BestLapTimeTitle")
  self._ui.txt_bestLapTime = UI.getChildControl(self._ui.stc_speedGroupBg, "StaticText_BestLapTimeValue")
  self._ui.stc_lapTimeTitle = UI.getChildControl(self._ui.stc_speedGroupBg, "StaticText_FinalLapTimeTitle")
  self._ui.txt_lapTime = UI.getChildControl(self._ui.stc_speedGroupBg, "StaticText_FinalLapTimeValue")
  self._ui.stc_penaltyTimeTitle = UI.getChildControl(self._ui.stc_speedGroupBg, "StaticText_PenaltyTimeTitle")
  self._ui.txt_penaltyTime = UI.getChildControl(self._ui.stc_speedGroupBg, "StaticText_PenaltyTimeValue")
  self._ui.txt_ghostDesc = UI.getChildControl(Panel_Window_SnowBoard_Result_All, "StaticText_Desc_Ghost")
  self._ui.btn_exit = UI.getChildControl(Panel_Window_SnowBoard_Result_All, "Button_Exit")
  self._ui.btn_retry = UI.getChildControl(Panel_Window_SnowBoard_Result_All, "Button_Retry")
  self._ui.keyGuide_exit = UI.getChildControl(Panel_Window_SnowBoard_Result_All, "StaticText_X_ConsoleUI")
  self._ui.keyGuide_retry = UI.getChildControl(Panel_Window_SnowBoard_Result_All, "StaticText_B_ConsoleUI")
  self._ui.stc_bestLapTimeTitle:SetSize(self._ui.stc_bestLapTimeTitle:GetTextSizeX(), self._ui.stc_bestLapTimeTitle:GetSizeY())
  self._ui.stc_lapTimeTitle:SetSize(self._ui.stc_lapTimeTitle:GetTextSizeX(), self._ui.stc_lapTimeTitle:GetSizeY())
  self._ui.stc_penaltyTimeTitle:SetSize(self._ui.stc_penaltyTimeTitle:GetTextSizeX(), self._ui.stc_penaltyTimeTitle:GetSizeY())
  if self._isConsole == true then
    self._ui.keyGuide_exit:SetShow(true)
    self._ui.keyGuide_retry:SetShow(true)
    self._ui.btn_exit:SetShow(false)
    self._ui.btn_retry:SetShow(false)
  end
  self:registEventHandler()
  self._initialize = true
end
function PaGlobal_SnowBoardFieldResult:registEventHandler()
  if Panel_Window_SnowBoard_Result_All == nil then
    return
  end
  self._ui.btn_exit:addInputEvent("Mouse_LUp", "PaGlobal_MessageBox_SnowBoard_Exit()")
  self._ui.btn_retry:addInputEvent("Mouse_LUp", "PaGlobal_MessageBox_SnowBoard_Retry()")
  registerEvent("FromClient_SnowBoardRaceComplete", "PaGlobalFunc_SnowBoardFieldResult_Open")
  registerEvent("FromClient_ChangeSnowBoardReplayUploadState", "FromClient_SnowBoardFieldResult_ChangeUploadState")
  registerEvent("FromClient_LeaveSnowBoardField", "PaGlobalFunc_SnowBoardFieldResult_CloseLeave")
end
function PaGlobal_SnowBoardFieldResult:prepareOpen(courseKeyRaw, isRaceComplete, isBestRecord, raceRecordTick, racePenaltyTick, isUploadingGhostReplay)
  if Panel_Window_SnowBoard_Result_All == nil then
    return
  end
  self._ui.stc_mainBg:EraseAllEffect()
  self:update(courseKeyRaw, isRaceComplete, isBestRecord, raceRecordTick, racePenaltyTick, isUploadingGhostReplay)
  self:open()
end
function PaGlobal_SnowBoardFieldResult:update(courseKeyRaw, isRaceComplete, isBestRecord, raceRecordTick, racePenaltyTick, isUploadingGhostReplay)
  if Panel_Window_SnowBoard_Result_All == nil then
    return
  end
  self:updateExitText(isUploadingGhostReplay)
  self._ui.stc_itemGroupBg:SetShow(false)
  self._ui.stc_speedGroupBg:SetShow(false)
  local snowBoardStatic = ToClient_GetSnowBoardStaticStatusByKey(courseKeyRaw)
  if snowBoardStatic == nil then
    return
  end
  self._ui.stc_penaltyTimeTitle:SetShow(false)
  self._ui.txt_penaltyTime:SetShow(false)
  if isRaceComplete == true then
    self._ui.stc_mainBg:ChangeTextureInfoTextureIDAsync(self._textureBgBase)
    self._ui.stc_mainBg:setRenderTexture(self._ui.stc_mainBg:getBaseTexture())
    self._ui.stc_resultImage:ChangeTextureInfoTextureIDAsync(self._textureFinishBase)
    self._ui.stc_resultImage:setRenderTexture(self._ui.stc_resultImage:getBaseTexture())
    self._ui.stc_itemCountDeco:ChangeTextureInfoTextureIDAsync(self._textureItemCountDecoBase)
    self._ui.stc_itemCountDeco:setRenderTexture(self._ui.stc_itemCountDeco:getBaseTexture())
  else
    self._ui.stc_mainBg:ChangeTextureInfoTextureIDAsync(self._textureBgFail)
    self._ui.stc_mainBg:setRenderTexture(self._ui.stc_mainBg:getBaseTexture())
    self._ui.stc_resultImage:ChangeTextureInfoTextureIDAsync(self._textureFinishFail)
    self._ui.stc_resultImage:setRenderTexture(self._ui.stc_resultImage:getBaseTexture())
    self._ui.stc_itemCountDeco:ChangeTextureInfoTextureIDAsync(self._textureItemCountDecoFail)
    self._ui.stc_itemCountDeco:setRenderTexture(self._ui.stc_itemCountDeco:getBaseTexture())
  end
  local mode = snowBoardStatic:getMode()
  if mode == __eSnowBoardCourseMode_Item then
    self._ui.txt_itemCount:SetText(ToClient_SnowBoardCoinCount())
    self._ui.stc_itemGroupBg:SetShow(true)
  elseif mode == __eSnowBoardCourseMode_Speed then
    local recordTick = Int64toInt32(ToClient_SnowBoardRecordTick())
    local recordMinute = math.min(99, math.floor(recordTick / 60000))
    local recordSecond = math.floor(recordTick % 60000 / 1000)
    local recordMillis = math.floor(recordTick % 1000)
    local recordText = string.format("%02d:%02d:%03d", recordMinute, recordSecond, recordMillis)
    self._ui.txt_lapTime:SetText(recordText)
    self._ui.txt_lapTime:SetSize(self._ui.txt_lapTime:GetTextSizeX(), self._ui.txt_lapTime:GetSizeY())
    self._ui.txt_lapTime:SetShow(true)
    local lapTimeSumX = self._ui.stc_lapTimeTitle:GetSizeX() + self._ui.txt_lapTime:GetSizeX() + 10
    local lapTimeBeginX = (self._ui.stc_speedGroupBg:GetSizeX() - lapTimeSumX) / 2
    self._ui.stc_lapTimeTitle:SetSpanSize(lapTimeBeginX, self._ui.stc_lapTimeTitle:GetSpanSize().y)
    self._ui.stc_lapTimeTitle:ComputePos()
    self._ui.txt_lapTime:SetSpanSize(self._ui.stc_lapTimeTitle:GetSpanSize().x + self._ui.stc_lapTimeTitle:GetSizeX() + 10, self._ui.txt_lapTime:GetSpanSize().y)
    self._ui.txt_lapTime:ComputePos()
    local bestRecordTick = Int64toInt32(ToClient_GetMySnowBoardBestRecordTick(courseKeyRaw))
    if bestRecordTick ~= 0 then
      local bestMinute = math.min(99, math.floor(bestRecordTick / 60000))
      local bestSecond = math.floor(bestRecordTick % 60000 / 1000)
      local bestMillis = math.floor(bestRecordTick % 1000)
      local bestText = string.format("%02d:%02d:%03d", bestMinute, bestSecond, bestMillis)
      self._ui.txt_bestLapTime:SetText(bestText)
      self._ui.txt_bestLapTime:SetSize(self._ui.txt_bestLapTime:GetTextSizeX(), self._ui.txt_bestLapTime:GetSizeY())
      self._ui.txt_bestLapTime:SetShow(true)
      local bestSumX = self._ui.stc_bestLapTimeTitle:GetSizeX() + self._ui.txt_bestLapTime:GetSizeX() + 10
      local bestBeginX = (self._ui.stc_speedGroupBg:GetSizeX() - bestSumX) / 2
      self._ui.stc_bestLapTimeTitle:SetSpanSize(bestBeginX, self._ui.stc_bestLapTimeTitle:GetSpanSize().y)
      self._ui.stc_bestLapTimeTitle:ComputePos()
      self._ui.stc_bestLapTimeTitle:SetShow(true)
      self._ui.txt_bestLapTime:SetSpanSize(self._ui.stc_bestLapTimeTitle:GetSpanSize().x + self._ui.stc_bestLapTimeTitle:GetSizeX() + 10, self._ui.txt_bestLapTime:GetSpanSize().y)
      self._ui.txt_bestLapTime:ComputePos()
    else
      self._ui.stc_bestLapTimeTitle:SetShow(false)
      self._ui.txt_bestLapTime:SetShow(false)
    end
    local penaltyTick = Int64toInt32(ToClient_RacePenaltyTick())
    if penaltyTick > 0 and isRaceComplete == true then
      self._ui.stc_penaltyTimeTitle:SetShow(true)
      local penaltyMinute = math.min(99, math.floor(penaltyTick / 60000))
      local penaltySecond = math.floor(penaltyTick % 60000 / 1000)
      local penaltyMillis = math.floor(penaltyTick % 1000)
      local penaltyText = string.format("<PAColor0xFF797979>+%02d:%02d:%03d<PAOldColor>", penaltyMinute, penaltySecond, penaltyMillis)
      self._ui.txt_penaltyTime:SetText(penaltyText)
      self._ui.txt_penaltyTime:SetSize(self._ui.txt_penaltyTime:GetTextSizeX(), self._ui.txt_penaltyTime:GetSizeY())
      self._ui.txt_penaltyTime:SetShow(true)
      local paneltyTimeSumX = self._ui.stc_penaltyTimeTitle:GetSizeX() + self._ui.txt_penaltyTime:GetSizeX() + 10
      local paneltyTimeBeginX = (self._ui.stc_speedGroupBg:GetSizeX() - paneltyTimeSumX) / 2
      self._ui.stc_penaltyTimeTitle:SetSpanSize(paneltyTimeBeginX, self._ui.stc_penaltyTimeTitle:GetSpanSize().y)
      self._ui.stc_penaltyTimeTitle:ComputePos()
      self._ui.txt_penaltyTime:SetSpanSize(self._ui.stc_penaltyTimeTitle:GetSpanSize().x + self._ui.stc_penaltyTimeTitle:GetSizeX() + 10, self._ui.txt_penaltyTime:GetSpanSize().y)
      self._ui.txt_penaltyTime:ComputePos()
    end
    self._ui.stc_speedGroupBg:SetShow(true)
  end
  if isRaceComplete == true then
    self._ui.stc_lapTimeTitle:SetShow(true)
    self._ui.txt_lapTime:SetShow(true)
    local recordTick = Int64toInt32(ToClient_SnowBoardRecordTick())
    local bestRecordTick = Int64toInt32(ToClient_GetMySnowBoardBestRecordTick(courseKeyRaw))
    local applyRecord = ToClient_GetPossibleSnowBoardRecord()
    local isNewRecord = isBestRecord
    if isNewRecord == true then
      audioPostEvent_SystemUi(11, 174)
      self._ui.stc_mainBg:EraseAllEffect()
      self._ui.stc_mainBg:AddEffect("fUI_SnowBoard_Fanfare_01A", true, 0, 0)
    else
      audioPostEvent_SystemUi(11, 173)
      self._ui.stc_mainBg:EraseAllEffect()
      self._ui.stc_mainBg:AddEffect("fUI_SnowBoard_Finish_01A", false, 0, 0)
    end
  else
    audioPostEvent_SystemUi(11, 178)
    self._ui.stc_lapTimeTitle:SetShow(false)
    self._ui.txt_lapTime:SetShow(false)
  end
end
function PaGlobal_SnowBoardFieldResult:open()
  if Panel_Window_SnowBoard_Result_All == nil then
    return
  end
  local screenX = getScreenSizeX()
  local screenY = getScreenSizeY()
  Panel_Window_SnowBoard_Result_All:SetSize(screenX, screenY)
  Panel_Window_SnowBoard_Result_All:ComputePosAllChild()
  Panel_Window_SnowBoard_Result_All:SetShow(true)
end
function PaGlobal_SnowBoardFieldResult:prepareClose(doForceClose)
  if Panel_Window_SnowBoard_Result_All == nil then
    return
  end
  if doForceClose ~= nil and doForceClose == true then
    self:close()
  elseif ToClient_IsSnowBoardGhostReplayUploading() == true then
    return
  end
end
function PaGlobal_SnowBoardFieldResult:close()
  if Panel_Window_SnowBoard_Result_All == nil then
    return
  end
  self._ui.stc_resultImage:EraseAllEffect()
  Panel_Window_SnowBoard_Result_All:SetShow(false)
end
function PaGlobal_SnowBoardFieldResult:updateExitText(isUploadingGhostReplay)
  if Panel_Window_SnowBoard_Result_All == nil then
    return
  end
  if isUploadingGhostReplay == true then
    self._ui.txt_ghostDesc:SetShow(true)
    self._ui.btn_exit:SetEnable(false)
    self._ui.btn_retry:SetEnable(false)
    self._ui.btn_exit:SetMonoTone(true)
    self._ui.btn_retry:SetMonoTone(true)
    if self._isConsole == true then
      self._ui.keyGuide_exit:SetShow(false)
      self._ui.keyGuide_retry:SetShow(false)
    end
  else
    self._ui.txt_ghostDesc:SetShow(false)
    self._ui.btn_exit:SetEnable(true)
    self._ui.btn_retry:SetEnable(true)
    self._ui.btn_exit:SetMonoTone(false)
    self._ui.btn_retry:SetMonoTone(false)
    if self._isConsole == true then
      self._ui.keyGuide_exit:SetShow(true)
      self._ui.keyGuide_retry:SetShow(true)
    end
  end
  Panel_Window_SnowBoard_Result_All:SetEnable(isUploadingGhostReplay == false)
end
