function PaGlobal_ReplayController:initialize()
  if true == self._initialize then
    return
  end
  self._ui.stc_titleBG = UI.getChildControl(Panel_Window_ReplayController_All, "Static_TitleArea")
  self._ui.btn_sticker = UI.getChildControl(self._ui.stc_titleBG, "CheckButton_PopUp")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleBG, "Button_Close")
  self._ui.stc_recordBG = UI.getChildControl(Panel_Window_ReplayController_All, "Static_RecordBG")
  self._ui.stc_recordTypeGroup = UI.getChildControl(self._ui.stc_recordBG, "Static_TemplateRadioBtnRecordGroup")
  self._ui.btn_recordTypeTemplate = UI.getChildControl(self._ui.stc_recordTypeGroup, "RadioButton_Template")
  self._ui.btn_streaming = UI.getChildControl(self._ui.stc_recordBG, "CheckButton_IsStreaming")
  self._ui.btn_replayStop = UI.getChildControl(self._ui.stc_recordBG, "Button_StopReplay")
  self._ui.btn_streamStop = UI.getChildControl(self._ui.stc_recordBG, "Button_StopStreamMode")
  self._ui.txt_currentRecord = UI.getChildControl(self._ui.stc_recordBG, "StaticText_CurrentRecord")
  self._ui.txt_recordNameBox = UI.getChildControl(self._ui.stc_recordBG, "Edit_ReplayName")
  self._ui.btn_recordStart = UI.getChildControl(self._ui.stc_recordBG, "Button_StartRecord")
  self._ui.btn_recordSaveAndStop = UI.getChildControl(self._ui.stc_recordBG, "Button_StopAndDownloadRecording")
  self._ui.btn_recordOnlyStop = UI.getChildControl(self._ui.stc_recordBG, "Button_OnlyStopRecording")
  self._ui.btn_recordListRefresh = UI.getChildControl(self._ui.stc_recordBG, "Button_Refresh")
  self._ui.btn_recording = UI.getChildControl(self._ui.stc_recordBG, "Button_Recording")
  self._ui.chk_isShowNak = UI.getChildControl(self._ui.stc_recordBG, "CheckButton_IsShowNak")
  self._ui.stc_playBG = UI.getChildControl(Panel_Window_ReplayController_All, "Static_PlayBG")
  self._ui.txt_playTitle = UI.getChildControl(self._ui.stc_playBG, "StaticText_SubTitle")
  self._ui.btn_deleteServer = UI.getChildControl(self._ui.stc_playBG, "Button_DeleteRecordAtServer")
  self._ui.btn_playListRefresh = UI.getChildControl(self._ui.stc_playBG, "Button_Refresh")
  self._ui.list2_playList = UI.getChildControl(self._ui.stc_playBG, "List2_1")
  self:initControl()
  self:registEventHandler()
  self:validate()
  self:createRecordTypeRadioButton()
  self._ui.btn_playListRefresh:SetPosX(self._ui.txt_playTitle:GetPosX() + self._ui.txt_playTitle:GetTextSizeX() + 10)
  self._ui.btn_streaming:SetCheck(true)
  self._ui.chk_isShowNak:SetCheck(true)
  self._baseRecordRefreshBtnPosX = self._ui.btn_recordListRefresh:GetPosX()
  self._loadPlayList = {}
  self._loadRecordList = {}
  self._isServerList = {}
  self._initialize = true
end
function PaGlobal_ReplayController:startCollectReplayData()
  if Panel_Window_ReplayController_All == nil then
    return
  end
  local stringDwonload = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_SELECT_DOWNLOAD")
  local stringRecord = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_SELECT_RECORD")
  local message = ""
  if self._isDownload == true then
    message = stringDwonload
  else
    message = stringRecord
  end
  if self._ui.txt_recordNameBox:GetText() == "" or self._ui.txt_recordNameBox:GetText() == stringRecord or self._ui.txt_recordNameBox:GetText() == stringDwonload then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_REPLAY"),
      content = message,
      functionYes = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  if self._recordType == -1 then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_REPLAY"),
      content = message,
      functionYes = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  local replayName = self._ui.txt_recordNameBox:GetText()
  self:startCollectReplayDataWithName(replayName)
end
function PaGlobal_ReplayController:startCollectReplayDataWithName(replayName)
  if Panel_Window_ReplayController_All == nil then
    return
  end
  local replayRecordType = self._recordType
  local isStreaming = self._ui.btn_streaming:IsCheck()
  local isOnlyDownload = self._isDownload
  if isOnlyDownload == false and self:checkReplayName(replayName) == false then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_REPLAY"),
      content = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_EXISTREPLAYNAME", "replayName", replayName),
      functionYes = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  ToClient_requestRecordReplay(replayName, replayRecordType, isStreaming, isOnlyDownload, false)
  self:reopen()
end
function PaGlobal_ReplayController:startStreamReplayData(replayName)
  if Panel_Window_ReplayController_All == nil then
    return
  end
  local function startStreamFunc()
    PaGlobal_ReplayController:startCollectReplayDataWithName(replayName)
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_REPLAY"),
    content = replayName .. " " .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_START_STREAMING_DESC"),
    functionYes = startStreamFunc,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_ReplayController:startDownLoadReplayData(replayName)
  local isReplayStreamMode = ToClient_IsReplayStreamingMode()
  if isReplayStreamMode == true then
    ToClient_SetStreamReplay(false)
  end
  local replayRecordType = self._recordType
  local isStreaming = false
  local isOnlyDownload = true
  ToClient_requestRecordReplay(replayName, replayRecordType, isStreaming, isOnlyDownload, false)
end
function PaGlobal_ReplayController:stopCollectReplayDataWithBox(replayName)
  local function stopCollectReplayDataFunc()
    ToClient_StopCollectReplayDataForController(replayName, true)
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_REPLAY"),
    content = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_STOP_COLLECT_AND_SAVE", "replayName", replayName),
    functionYes = stopCollectReplayDataFunc,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_ReplayController:stopAndRemoveReplayDataWithBox(replayName)
  local function stopCollectReplayDataFunc()
    ToClient_StopCollectReplayDataForController(replayName, false)
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_REPLAY"),
    content = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_FORCE_STOP_COLLECT", "replayName", replayName),
    functionYes = stopCollectReplayDataFunc,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_ReplayController:stopCollectReplayData(replayName)
  ToClient_StopCollectReplayDataForController(replayName, true)
end
function PaGlobal_ReplayController:deleteReplaydataAtServer()
  if Panel_Window_ReplayController_All == nil then
    return
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_REPLAY"),
    content = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_DELETESERVER_DESC"),
    functionYes = ToClient_requestClearRecordedReplayAtServer,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
  return
end
function PaGlobal_ReplayController:changeIsDownload(isDownload)
  self._ui.txt_recordNameBox:SetEditText("")
  if isDownload == true then
    self._ui.txt_recordNameBox:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_SELECT_DOWNLOAD"))
    self._ui.txt_recordNameBox:SetIgnore(true)
    self._ui.btn_recordStart:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_START_DOWNLOAD"))
  else
    self._ui.txt_recordNameBox:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_SELECT_RECORD"))
    self._ui.txt_recordNameBox:SetIgnore(false)
    self._ui.btn_recordStart:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_START_RECORD"))
  end
  self._isDownload = isDownload
  self:setCurrentRecordName(false)
end
function PaGlobal_ReplayController:clearRecordNameBox()
  if self._ui.txt_recordNameBox:GetText() == PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_SELECT_RECORD") then
    self._ui.txt_recordNameBox:SetText("")
    self._ui.txt_recordNameBox:SetEditText("")
  end
end
function PaGlobal_ReplayController:checkReplayName(replayName)
  local replayFileCount = ToClient_getLoadReplayDataSize(1)
  if replayFileCount > 0 then
    for ii = 0, replayFileCount - 1 do
      local wrapper = ToClient_getLoadReplayDataWrapper(1, Int64toInt32(ii))
      if wrapper ~= nil and wrapper:getReplayName() == replayName then
        return false
      end
    end
  end
  local recordCount = ToClient_getLoadReplayDataSize(2)
  if recordCount > 0 then
    for ii = 0, recordCount - 1 do
      local wrapper = ToClient_getLoadReplayDataWrapper(2, Int64toInt32(ii))
      if wrapper ~= nil and wrapper:getReplayName() == replayName then
        return false
      end
    end
  end
  return true
end
function PaGlobal_ReplayController:registEventHandler()
  if nil == Panel_Window_ReplayController_All then
    return
  end
  Panel_Window_ReplayController_All:addInputEvent("Mouse_LUp", "ClearFocusEdit()")
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_ReplayController_Close()")
  self._ui.btn_sticker:addInputEvent("Mouse_LUp", "HandleEventLUp_ReplayController_PopUpUI()")
  self._ui.btn_deleteServer:addInputEvent("Mouse_LUp", "PaGlobal_ReplayController:deleteReplaydataAtServer()")
  self._ui.btn_replayStop:addInputEvent("Mouse_LUp", "PaGlobal_ReplayController:stopReplay()")
  self._ui.btn_streamStop:addInputEvent("Mouse_LUp", "ToClient_SetStreamReplay(false)")
  self._ui.txt_recordNameBox:addInputEvent("Mouse_LUp", "PaGlobal_ReplayController:clearRecordNameBox()")
  self._ui.txt_currentRecord:addInputEvent("Mouse_LUp", "HandleEventLUp_ReplayController_CurrentRecordName()")
  self._ui.btn_recordStart:addInputEvent("Mouse_LUp", "PaGlobal_ReplayController:startCollectReplayData()")
  self._ui.btn_recordListRefresh:addInputEvent("Mouse_LUp", "ToClient_RequestReplayListAtServer()")
  self._ui.list2_playList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_ReplayController_PlayList2")
  self._ui.list2_playList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.btn_playListRefresh:addInputEvent("Mouse_LUp", "ToClient_RequestReplayListAtServer()")
  registerEvent("FromClient_ReloadRecordList", "FromClient_ReplayController_ReloadRecordList")
  registerEvent("FromClient_SaveReplayNameChange", "FromClient_ReplayController_SaveReplayNameChange")
  registerEvent("FromClient_GroundMouseLDown", "clearFocusEdit_GroundClick")
  registerEvent("FromClient_OpenReplayController", "PaGlobal_ReplayController_Open")
  registerEvent("FromClient_SetReplayState", "FromClient_ReplayController_ListButtonUpdate")
  registerEvent("FromClient_StopCollectReplay", "FromClient_ReplayController_SetDownloadEndAni")
  registerEvent("FromClient_ReciveDownloadPercent", "FromClient_ReplayController_ReciveDownloadPercent")
end
function clearFocusEdit_GroundClick()
  if CheckChattingInput() == false then
    ClearFocusEdit()
  end
end
function PaGlobal_ReplayController:setDownloadEndAni()
  self._ui.btn_recording:SetVertexAniRun("Ani_Color_New", true)
end
function PaGlobal_ReplayController:prepareOpen()
  if nil == Panel_Window_ReplayController_All then
    return
  end
  setSelfPlayerOnlyEffect(false)
  setUseOptimizationEffectFrame(false)
  self:reloadAndUpdate()
  self:setCurrentRecordName(true)
  self:open()
end
function PaGlobal_ReplayController:open()
  if nil == Panel_Window_ReplayController_All then
    return
  end
  Panel_Window_ReplayController_All:SetShow(true)
end
function PaGlobal_ReplayController:prepareClose()
  if nil == Panel_Window_ReplayController_All then
    return
  end
  if PaGlobal_ReplayController._isCheckPopUp == true then
    Panel_Window_ReplayController_All:CloseUISubApp()
    PaGlobal_ReplayController._isCheckPopUp = false
  end
  self:close()
end
function PaGlobal_ReplayController:close()
  if nil == Panel_Window_ReplayController_All then
    return
  end
  Panel_Window_ReplayController_All:SetShow(false)
end
function PaGlobal_ReplayController:update()
  if nil == Panel_Window_ReplayController_All then
    return
  end
end
function PaGlobal_ReplayController:validate()
  if nil == Panel_Window_ReplayController_All then
    return
  end
  self._ui.stc_titleBG:isValidate()
  self._ui.btn_sticker:isValidate()
  self._ui.btn_close:isValidate()
  self._ui.stc_recordBG:isValidate()
  self._ui.stc_recordTypeGroup:isValidate()
  self._ui.btn_recordTypeTemplate:isValidate()
  self._ui.btn_streaming:isValidate()
  self._ui.btn_replayStop:isValidate()
  self._ui.btn_streamStop:isValidate()
  self._ui.btn_deleteServer:isValidate()
  self._ui.btn_recording:isValidate()
  self._ui.txt_currentRecord:isValidate()
  self._ui.txt_recordNameBox:isValidate()
  self._ui.btn_recordStart:isValidate()
  self._ui.btn_recordSaveAndStop:isValidate()
  self._ui.btn_recordOnlyStop:isValidate()
  self._ui.btn_recordListRefresh:isValidate()
  self._ui.stc_playBG:isValidate()
  self._ui.txt_playTitle:isValidate()
  self._ui.btn_playListRefresh:isValidate()
  self._ui.list2_playList:isValidate()
  self._ui.chk_isShowNak:isValidate()
end
function PaGlobal_ReplayController:setRecordType(recordType)
  self._recordType = recordType
end
function PaGlobal_ReplayController:createRecordTypeRadioButton()
  self._ui.btn_recordTypeTemplate:SetGroup(0)
  local raidoButton = UI.cloneControl(self._ui.btn_recordTypeTemplate, self._ui.stc_recordTypeGroup, "RadioButton_" .. 0)
  raidoButton:addInputEvent("Mouse_LUp", "PaGlobal_ReplayController:setRecordType(" .. 0 .. ")")
  raidoButton:SetPosX(self._ui.btn_recordTypeTemplate:GetPosX())
  raidoButton:SetPosY(self._ui.btn_recordTypeTemplate:GetPosY())
  raidoButton:SetText("Arsha")
  raidoButton:SetCheck(true)
  raidoButton:SetShow(true)
  self._ui.btn_recordTypeList[0] = raidoButton
  self:setRecordType(0)
end
function PaGlobal_ReplayController:reloadAndUpdate()
  ToClient_RequestReplayListAtServer()
  self:playListUpdate()
end
function PaGlobal_ReplayController:recordListUpdate()
  local loadListSize = ToClient_getLoadReplayDataSize(2)
  local txt_replayName = UI.getChildControl(self._ui.btn_recording, "StaticText_ReplayName")
  local txt_replayLength = UI.getChildControl(self._ui.btn_recording, "StaticText_ReplayLength")
  local downloadingName = ToClient_GetCurrentSaveReplayName()
  txt_replayName:SetText("-")
  txt_replayLength:SetText("-")
  self._ui.btn_recordSaveAndStop:removeInputEvent("Mouse_LUp")
  self._ui.btn_recordOnlyStop:removeInputEvent("Mouse_LUp")
  self._ui.btn_recording:SetVertexAniRun("Ani_Color_New", false)
  self._ui.btn_recording:SetColorExtra(Defines.Color.C_FFFFFFFF, 1)
  if loadListSize <= 0 then
    return
  end
  local key = 0
  local wrapper
  local isFind = false
  for ii = 0, loadListSize - 1 do
    key = Int64toInt32(ii)
    wrapper = ToClient_getLoadReplayDataWrapper(2, key)
    if nil ~= wrapper and wrapper:isRecording() == true then
      self._ui.btn_recordSaveAndStop:SetIgnore(false)
      self._ui.btn_recordSaveAndStop:SetMonoTone(false)
      self._ui.btn_recordOnlyStop:SetIgnore(false)
      self._ui.btn_recordOnlyStop:SetMonoTone(false)
      txt_replayName:SetText(wrapper:getReplayName())
      txt_replayLength:SetText("Collector : " .. tostring(wrapper:getCollectorName()) .. " / ViewingCount : " .. wrapper:getDownloadUserCount())
      self:changeIsDownload(wrapper:getCollectorName() ~= getFamilyName())
      self._ui.btn_recording:SetColor(Defines.Color.C_FFFF0000)
      if self._isDownload == true then
        if downloadingName ~= wrapper:getReplayName() then
          self._ui.btn_recordSaveAndStop:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_START_STREAMING"))
          self._ui.btn_recordSaveAndStop:addInputEvent("Mouse_LUp", "PaGlobal_ReplayController:startStreamReplayData(\"" .. wrapper:getReplayName() .. "\")")
          self._ui.btn_recordOnlyStop:SetText("-")
        else
          local strmingStr = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_CEHCK_STREAMING")
          self._ui.btn_recordSaveAndStop:SetText(strmingStr .. "(0%)")
          self._ui.btn_recordSaveAndStop:addInputEvent("Mouse_LUp", "AlretIsDownload()")
          self._ui.btn_recordOnlyStop:SetText("-")
        end
        self._ui.btn_recordListRefresh:SetPosX(self._ui.txt_recordNameBox:GetPosX())
        self._ui.txt_recordNameBox:SetShow(false)
        self._ui.btn_recordStart:SetShow(false)
      else
        self._ui.btn_recordSaveAndStop:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_SAVE_AND_STOP_RECORD"))
        self._ui.btn_recordSaveAndStop:addInputEvent("Mouse_LUp", "PaGlobal_ReplayController:stopCollectReplayDataWithBox(\"" .. wrapper:getReplayName() .. "\")")
        self._ui.btn_recordOnlyStop:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_FORCE_STOP_RECORD"))
        self._ui.btn_recordOnlyStop:addInputEvent("Mouse_LUp", "PaGlobal_ReplayController:stopAndRemoveReplayDataWithBox(\"" .. wrapper:getReplayName() .. "\")")
        self._ui.btn_recordListRefresh:SetPosX(self._baseRecordRefreshBtnPosX)
        self._ui.txt_recordNameBox:SetShow(true)
        self._ui.btn_recordStart:SetShow(true)
      end
      isFind = true
    end
  end
  if isFind == false then
    self:changeIsDownload(downloadingName ~= "")
    self._ui.btn_recordSaveAndStop:SetIgnore(true)
    self._ui.btn_recordSaveAndStop:SetMonoTone(true)
    self._ui.btn_recordSaveAndStop:SetText("-")
    self._ui.btn_recordOnlyStop:SetIgnore(true)
    self._ui.btn_recordOnlyStop:SetMonoTone(true)
    self._ui.btn_recordOnlyStop:SetText("-")
    self._ui.btn_recordListRefresh:SetPosX(self._baseRecordRefreshBtnPosX)
    self._ui.txt_recordNameBox:SetShow(true)
    self._ui.btn_recordStart:SetShow(true)
  end
end
function PaGlobal_ReplayController:playListUpdate()
  ToClient_loadReplayPlayList()
  local loadListSize = ToClient_getLoadReplayDataSize(1)
  self._ui.list2_playList:getElementManager():clearKey()
  self._loadPlayList = {}
  self._loadRecordList = {}
  local clientList = {}
  local key = 0
  local wrapper
  if loadListSize > 0 then
    for ii = 0, loadListSize - 1 do
      key = Int64toInt32(ii)
      wrapper = ToClient_getLoadReplayDataWrapper(1, key)
      if wrapper ~= nil then
        clientList[wrapper:getReplayName()] = ii
      end
    end
  end
  local recordListSize = ToClient_getLoadReplayDataSize(2)
  if recordListSize > 0 then
    for ii = 0, recordListSize - 1 do
      key = Int64toInt32(ii)
      wrapper = ToClient_getLoadReplayDataWrapper(2, key)
      if wrapper ~= nil and wrapper:isRecording() == false and clientList[wrapper:getReplayName()] == nil then
        self._ui.list2_playList:getElementManager():pushKey(ii + self._serverFlag)
      end
    end
  end
  for key, value in pairs(clientList) do
    self._ui.list2_playList:getElementManager():pushKey(value)
  end
  self._ui.list2_playList:ComputePos()
  self:ListButtonUpdate()
end
function PaGlobal_ReplayController:ListButtonUpdate()
  self:ListButtonUpdateInner(self._loadRecordList, true)
  self:ListButtonUpdateInner(self._loadPlayList, false)
end
function PaGlobal_ReplayController:ListButtonUpdateInner(btnList, isServer)
  local downloadingName = ToClient_GetCurrentSaveReplayName()
  local isPlaying = ToClient_IsPlayingReplay()
  local isDownloading = downloadingName ~= ""
  for key, content in pairs(btnList) do
    local btn_select = UI.getChildControl(content, "Button_Select")
    local txt_replayName = UI.getChildControl(btn_select, "StaticText_ReplayName")
    local btn_playAndDownload = UI.getChildControl(content, "Button_PlayAndDownload")
    if self._isServerList[txt_replayName:GetText()] == isServer then
      if isDownloading == true and txt_replayName:GetText() == downloadingName then
        btn_playAndDownload:SetText("0%")
        btn_playAndDownload:addInputEvent("Mouse_LUp", "PaGlobal_ReplayController:AlretIsDownload()")
        btn_select:SetVertexAniRun("Ani_Color_New", true)
      elseif isPlaying == true and txt_replayName:GetText() == ToClient_getLoadReplayName() then
        btn_playAndDownload:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_STOP"))
        btn_playAndDownload:addInputEvent("Mouse_LUp", "PaGlobal_ReplayController:stopReplay()")
        btn_select:SetVertexAniRun("Ani_Color_New", true)
        btn_playAndDownload:SetIgnore(false)
        btn_playAndDownload:SetMonoTone(false)
      else
        if isServer == true then
          btn_playAndDownload:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_CEHCK_JUSTDOWNLOAD"))
        else
          btn_playAndDownload:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_PLAY"))
        end
        if isPlaying == true or isDownloading == true then
          btn_playAndDownload:SetIgnore(true)
          btn_playAndDownload:SetMonoTone(true)
          btn_playAndDownload:removeInputEvent("Mouse_LUp")
        else
          btn_playAndDownload:SetIgnore(false)
          btn_playAndDownload:SetMonoTone(false)
          if isServer == true then
            btn_playAndDownload:addInputEvent("Mouse_LUp", "PaGlobal_ReplayController:startDownLoadReplayData(\"" .. txt_replayName:GetText() .. "\")")
          else
            btn_playAndDownload:addInputEvent("Mouse_LUp", "PaGlobal_ReplayController:playReplay(\"" .. txt_replayName:GetText() .. "\")")
          end
        end
        btn_select:SetVertexAniRun("Ani_Color_New", false)
        btn_select:SetColorExtra(Defines.Color.C_FFFFFFFF, 1)
      end
    end
  end
end
function PaGlobal_ReplayController:ReciveDownloadPercent(percent)
  self:RecordPercentUpdate(percent)
  self:DownloadPercentUpdate(self._loadRecordList, percent)
  self:DownloadPercentUpdate(self._loadPlayList, percent)
end
function PaGlobal_ReplayController:RecordPercentUpdate(percent)
  local loadListSize = ToClient_getLoadReplayDataSize(2)
  if loadListSize > 0 then
    for ii = 0, loadListSize - 1 do
      local wrapper = ToClient_getLoadReplayDataWrapper(2, Int64toInt32(ii))
      if wrapper ~= nil and wrapper:isRecording() == true and wrapper:getCollectorName() ~= getFamilyName() then
        local result = math.floor(percent / 10000 * 100) / 100
        local strmingStr = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_CEHCK_STREAMING")
        self._ui.btn_recordSaveAndStop:SetText(strmingStr .. "(" .. result .. "%)")
        self._ui.btn_recordSaveAndStop:addInputEvent("Mouse_LUp", "PaGlobal_ReplayController:AlretIsDownload()")
        self._ui.btn_recordOnlyStop:SetText("-")
        self._ui.btn_recordOnlyStop:removeInputEvent("Mouse_LUp")
        return
      end
    end
  end
end
function PaGlobal_ReplayController:DownloadPercentUpdate(btnList, percent)
  local downloadingName = ToClient_GetCurrentSaveReplayName()
  local isPlaying = ToClient_IsPlayingReplay()
  for key, content in pairs(btnList) do
    local btn_select = UI.getChildControl(content, "Button_Select")
    local txt_replayName = UI.getChildControl(btn_select, "StaticText_ReplayName")
    local btn_playAndDownload = UI.getChildControl(content, "Button_PlayAndDownload")
    if txt_replayName:GetText() == downloadingName then
      local result = math.floor(percent / 10000 * 100) / 100
      btn_playAndDownload:SetText(result .. "%")
      btn_playAndDownload:addInputEvent("Mouse_LUp", "PaGlobal_ReplayController:AlretIsDownload()")
      return
    end
  end
end
function PaGlobal_ReplayController:AlretIsDownload()
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_REPLAY"),
    content = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_DOWNLOADING"),
    functionYes = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_ReplayController:setRecordName(replayName)
  if Panel_Window_ReplayController_All == nil then
    return
  end
  self._ui.txt_recordNameBox:SetText(replayName)
  self._ui.txt_recordNameBox:SetEditText(replayName)
end
function PaGlobal_ReplayController:playReplay(replayName)
  if Panel_Window_ReplayController_All == nil then
    return
  end
  local function playReplay()
    ToClient_ReadyReplayForController(replayName)
    PaGlobal_ReplayController:ListButtonUpdate()
    self:reopen()
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_REPLAY"),
    content = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_SELECT_REPLAY", "replayName", replayName),
    functionYes = playReplay,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
  return
end
function PaGlobal_ReplayController:setCurrentRecordName(isReload)
  if Panel_Window_ReplayController_All == nil then
    return
  end
  local currentRecordName = ToClient_GetCurrentSaveReplayName()
  local stringKey = "PANEL_WINDOW_REPLAYCONTROLLER_CURRENT_RECORD"
  if self._isDownload == true then
    stringKey = "PANEL_WINDOW_REPLAYCONTROLLER_CURRENT_DOWNLOAD"
  end
  if currentRecordName == "" then
    self._ui.txt_currentRecord:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, stringKey, "replayName", "X"))
    if isReload == true then
      self:reloadAndUpdate()
    end
  else
    self._ui.txt_currentRecord:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, stringKey, "replayName", currentRecordName))
  end
end
function PaGlobal_ReplayController:clickCurrentRecordName()
  if Panel_Window_ReplayController_All == nil then
    return
  end
  if isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_SHIFT) == true and isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_MENU) == true then
    local clearCurrentSaveReplayNameFunc = function()
      ToClient_SetCurrentSaveReplayName("")
    end
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_REPLAY"),
      content = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_CLEAR_RECORD_NAME"),
      functionYes = clearCurrentSaveReplayNameFunc,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  elseif isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_SHIFT) == true then
    local currentRecordName = ToClient_GetCurrentSaveReplayName()
    PaGlobal_ReplayController:stopCollectReplayDataWithBox(currentRecordName)
    return
  end
end
function PaGlobal_ReplayController:reopen()
  if Panel_Window_ReplayController_All == nil then
    return
  end
  if PaGlobal_ReplayController._isCheckPopUp == true then
    Panel_Window_ReplayController_All:OpenUISubApp()
  else
    Panel_Window_ReplayController_All:CloseUISubApp()
  end
end
function PaGlobal_ReplayController:stopReplay()
  if Panel_Window_ReplayController_All == nil then
    return
  end
  local isReplayStreamMode = ToClient_IsReplayStreamingMode()
  if isReplayStreamMode == true then
    ToClient_SetStreamReplay(false)
  end
  ToClient_requestSyncUser(false, true, false)
  ToClient_requestSyncUser(false, false, false)
  ToClient_ReplayStopTest()
  PaGlobal_ReplayController:ListButtonUpdate()
end
function PaGlobal_ReplayController:GetIsShowNak()
  if Panel_Window_ReplayController_All == nil then
    return
  end
  local isPlaying = ToClient_IsPlayingReplay()
  if isPlaying == false then
    return true
  end
  return self._ui.chk_isShowNak:IsCheck()
end
function PaGlobal_ReplayController:initControl()
  Panel_Window_ReplayController_All:ComputePos()
end
