function PaGlobalFunc_SolareReplayList_Open()
  if _ContentsGroup_SolareReplay == false then
    return
  end
  local self = PaGlobal_Solrare_ReplayList
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_SolareReplayList_Close()
  local self = PaGlobal_Solrare_ReplayList
  if self == nil then
    return
  end
  self:prepareClose()
end
function Solrare_ReplayList_CreateUploadListContent(content, key)
  local self = PaGlobal_Solrare_ReplayList
  if self == nil then
    return
  end
  self:createUploadListContent(content, key)
end
function Solrare_ReplayList_CreateDownloadCompleteListContent(content, key)
  local self = PaGlobal_Solrare_ReplayList
  if self == nil then
    return
  end
  self:createDownloadCompleteListContent(content, key)
end
function Solrare_ReplayList_OpenUploadList()
  local self = PaGlobal_Solrare_ReplayList
  if self == nil then
    return
  end
  self:openUploadList()
end
function FromClient_Solare_ReplayList_UpdateSolareReplayList()
  local self = PaGlobal_Solrare_ReplayList
  if self == nil then
    return
  end
  self:updateDownloadCompleteList()
end
function HandleEventLUp_SolrareReplayList_Play(dataIndex, isFileWarningState)
  local self = PaGlobal_Solrare_ReplayList
  if self == nil then
    return
  end
  local function requestReadyReplay()
    if ToClient_IsMatchingStateByMatchServer() == true then
      ToClient_requestCancleMatching()
    end
    ToClient_PlayInstanceContentsReplay(__eInstanceContentsType_Solare, dataIndex)
  end
  local messageStr = ""
  if isFileWarningState ~= nil and isFileWarningState == true then
    messageStr = PAGetString(Defines.StringSheet_GAME, "LUA_INSTANCE_CONTENTS_REPLAY_PLAYREPLAY_WARNING")
  else
    messageStr = PAGetString(Defines.StringSheet_GAME, "LUA_INSTANCE_CONTENTS_REPLAY_PLAYREPLAY")
  end
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = messageStr,
    functionYes = requestReadyReplay,
    functionNo = MessageBox_Empty_function,
    exitButton = true,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_SolrareReplayList_Delete(dataIndex)
  local self = PaGlobal_Solrare_ReplayList
  if self == nil then
    return
  end
  local function requestDeleteReplay()
    if ToClient_DeleteInstanceContentsReplaySimpleInfoFile(__eInstanceContentsType_Solare, dataIndex) == true then
      PaGlobal_Solrare_ReplayList:updateDownloadCompleteList()
    end
  end
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_INSTANCE_CONTENTS_REPLAY_REMOVEREPLAYFILE"),
    functionYes = requestDeleteReplay,
    functionNo = MessageBox_Empty_function,
    exitButton = true,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_SolrareReplayList_Download(dataIndex)
  local self = PaGlobal_Solrare_ReplayList
  if self == nil then
    return
  end
  local dataWrapper = ToClient_GetInstanceContentsReplayUploadData(__eInstanceContentsType_Solare, dataIndex)
  if dataWrapper == nil then
    return
  end
  local url = dataWrapper:getDownloadUrl()
  ToClient_OpenChargeWebPage(url, false)
end
function HandleEventLUp_SolareReplayList_OpenUploadList()
  local self = PaGlobal_Solrare_ReplayList
  if self == nil then
    return
  end
  if ToClient_IsDevelopment() == false then
    return
  end
  if self._ui._stc_uploadBg:GetShow() == true then
    self:closeUploadList()
  else
    ToClient_RequestGetInstanceContentsReplayUploadList(__eInstanceContentsType_Solare)
  end
end
function HandleEventLOnOut_SolareReplayList_OpenUploadList(isOn)
  local self = PaGlobal_Solrare_ReplayList
  if self == nil then
    return
  end
  if isOn == false then
    TooltipSimple_Hide()
    return
  end
  if ToClient_IsDevelopment() == false then
    return
  end
  local control = self._ui._btn_openUploadList
  local name = self._ui._btn_openUploadList:GetText()
  local desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SOLARE_REPLAYLIST_DOWNLOAD_DESC_DEV")
  TooltipSimple_Show(control, name, desc)
end
function FromClient_OnDownloadFromWeb_SolareReplay(path, filename, recordType)
  if recordType ~= __eReplayRecordType_Solare then
    return
  end
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SOLAREDOWNLOAD_COMPLETEMSG"),
    functionYes = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
