function PaGlobal_Solrare_ReplayList:initialize()
  if Panel_Window_Solrare_ReplayList == nil or self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  local stc_title = UI.getChildControl(Panel_Window_Solrare_ReplayList, "Static_TitleArea")
  self._ui._btn_close = UI.getChildControl(stc_title, "Button_Close")
  self._ui._btn_close:SetShow(self._isConsole == false)
  local stc_top = UI.getChildControl(Panel_Window_Solrare_ReplayList, "Static_TopArea")
  self._ui._btn_openUploadList = UI.getChildControl(stc_top, "Button_OpenUploadList")
  self._ui._btn_openDownloadWeb = UI.getChildControl(stc_top, "Button_OpenDownloadWeb")
  self._ui._btn_reloadDownloadCompleteList = UI.getChildControl(stc_top, "Button_Reload")
  self._ui._stc_uploadBg = UI.getChildControl(Panel_Window_Solrare_ReplayList, "Static_UploadArea")
  self._ui._lst_uploadList = UI.getChildControl(self._ui._stc_uploadBg, "List2_UploadList")
  self._ui._stc_uploadListEmpty = UI.getChildControl(self._ui._lst_uploadList, "StaticText_Empty")
  local stc_downloadList = UI.getChildControl(Panel_Window_Solrare_ReplayList, "Static_DownloadList")
  self._ui._lst_downloadComplete = UI.getChildControl(Panel_Window_Solrare_ReplayList, "List2_DownloadList")
  self._ui._stc_downloadCompleteListEmpty = UI.getChildControl(self._ui._lst_downloadComplete, "StaticText_Empty")
  self:closeUploadList()
  self:registEventHandler()
  self._initialize = true
end
function PaGlobal_Solrare_ReplayList:registEventHandler()
  if Panel_Window_Solrare_ReplayList == nil then
    return
  end
  if ToClient_IsDevelopment() == true then
    self._ui._btn_openUploadList:SetShow(true)
    self._ui._btn_openUploadList:addInputEvent("Mouse_LUp", "HandleEventLUp_SolareReplayList_OpenUploadList()")
    self._ui._btn_openUploadList:addInputEvent("Mouse_On", "HandleEventLOnOut_SolareReplayList_OpenUploadList(true)")
    self._ui._btn_openUploadList:addInputEvent("Mouse_Out", "HandleEventLOnOut_SolareReplayList_OpenUploadList(false)")
  end
  self._ui._btn_openDownloadWeb:addInputEvent("Mouse_LUp", "PaGlobalFunc_InstanceContentsReplayDownloadWeb_Open()")
  self._ui._lst_uploadList:registEvent(__ePAUIList2EventType_LuaChangeContent, "Solrare_ReplayList_CreateUploadListContent")
  self._ui._lst_uploadList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._lst_downloadComplete:registEvent(__ePAUIList2EventType_LuaChangeContent, "Solrare_ReplayList_CreateDownloadCompleteListContent")
  self._ui._lst_downloadComplete:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._btn_reloadDownloadCompleteList:addInputEvent("Mouse_LUp", "PaGlobal_Solrare_ReplayList:updateDownloadCompleteList()")
  if self._isConsole == false then
    self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_SolareReplayList_Close()")
  end
  registerEvent("FromClient_LoadInstanceContentsReplayUploadData", "Solrare_ReplayList_OpenUploadList")
  registerEvent("FromClient_UpdateInstanceContentsReplayDownloadList", "FromClient_Solare_ReplayList_UpdateSolareReplayList")
  registerEvent("FromClient_OnDownloadFromWeb", "FromClient_OnDownloadFromWeb_SolareReplay")
end
function PaGlobal_Solrare_ReplayList:prepareOpen()
  if Panel_Window_Solrare_ReplayList == nil then
    return
  end
  PaGlobalFunc_Solrare_Matching_Close()
  self:updateDownloadCompleteList()
  self:computePanelPosition()
  if self._isConsole == true then
    ToClient_padSnapSetTargetPanel(Panel_Window_Solrare_ReplayList)
  end
  self:open()
end
function PaGlobal_Solrare_ReplayList:open()
  if Panel_Window_Solrare_ReplayList == nil then
    return
  end
  Panel_Window_Solrare_ReplayList:SetShow(true)
end
function PaGlobal_Solrare_ReplayList:prepareClose()
  if Panel_Window_Solrare_ReplayList == nil then
    return
  end
  ToClient_ClearInstanceContentsReplaySimpleInfoList()
  PaGlobalFunc_Solrare_Matching_Open()
  self:close()
end
function PaGlobal_Solrare_ReplayList:close()
  if Panel_Window_Solrare_ReplayList == nil then
    return
  end
  Panel_Window_Solrare_ReplayList:SetShow(false)
end
function PaGlobal_Solrare_ReplayList:computePanelPosition()
  local panel = Panel_Window_Solrare_ReplayList
  if panel == nil then
    return
  end
  local screenCenterX = getScreenSizeX() / 2
  local screenCenterY = getScreenSizeY() / 2
  local panelSizeX = panel:GetSizeX()
  local panelSizeY = panel:GetSizeY()
  local calcPosX = screenCenterX - panelSizeX / 2
  local calcPosY = screenCenterY - panelSizeY / 2
  if calcPosX < 0 then
    calcPosX = 0
  end
  if calcPosY < 0 then
    calcPosY = 0
  end
  panel:SetPosX(calcPosX)
  panel:SetPosY(calcPosY)
end
function PaGlobal_Solrare_ReplayList:openUploadList()
  if Panel_Window_Solrare_ReplayList == nil then
    return
  end
  self._ui._stc_uploadBg:SetShow(true)
  self:updateUploadList()
end
function PaGlobal_Solrare_ReplayList:closeUploadList()
  if Panel_Window_Solrare_ReplayList == nil then
    return
  end
  self._ui._stc_uploadBg:SetShow(false)
end
function PaGlobal_Solrare_ReplayList:updateUploadList()
  if Panel_Window_Solrare_ReplayList == nil then
    return
  end
  local listManager = self._ui._lst_uploadList:getElementManager()
  if listManager == nil then
    return
  end
  listManager:clearKey()
  local dataCount = ToClient_GetInstanceContentsReplayUploadListCount(__eInstanceContentsType_Solare)
  if dataCount == 0 then
    self._ui._stc_uploadListEmpty:SetShow(true)
    return
  end
  self._ui._stc_uploadListEmpty:SetShow(false)
  for index = 0, dataCount - 1 do
    listManager:pushKey(toInt64(0, index))
  end
end
function PaGlobal_Solrare_ReplayList:updateDownloadCompleteList()
  if Panel_Window_Solrare_ReplayList == nil then
    return
  end
  if ToClient_LoadInstanceContentsReplaySimpleInfoList(__eInstanceContentsType_Solare) == false then
    return
  end
  local listManager = self._ui._lst_downloadComplete:getElementManager()
  if listManager == nil then
    return
  end
  listManager:clearKey()
  local dataCount = ToClient_GetInstanceContentsReplaySimpleInfoListCount(__eInstanceContentsType_Solare)
  if dataCount == 0 then
    self._ui._stc_downloadCompleteListEmpty:SetShow(true)
    return
  end
  self._ui._stc_downloadCompleteListEmpty:SetShow(false)
  for index = 0, dataCount - 1 do
    listManager:pushKey(toInt64(0, index))
  end
end
function PaGlobal_Solrare_ReplayList:createUploadListContent(content, key)
  if Panel_Window_Solrare_ReplayList == nil then
    return
  end
  local dataIndex = Int64toInt32(key)
  local dataWrapper = ToClient_GetInstanceContentsReplayUploadData(__eInstanceContentsType_Solare, dataIndex)
  if dataWrapper == nil then
    return
  end
  local stc_record = UI.getChildControl(content, "Static_Record")
  local txt_info = UI.getChildControl(stc_record, "StaticText_Info")
  local btn_download = UI.getChildControl(stc_record, "Button_Download")
  local recordTime = dataWrapper:getRegisterDate()
  local recordNo = dataWrapper:getReplayUniqueNo()
  local infoString = ""
  local paTime = PATime(recordTime)
  local year = tostring(paTime:GetYear())
  local month = paTime:GetMonth()
  local day = paTime:GetDay()
  local hour = paTime:GetHour()
  local minute = paTime:GetMinute()
  if month < 10 then
    month = "0" .. tostring(month)
  else
    month = tostring(month)
  end
  if day < 10 then
    day = "0" .. tostring(day)
  else
    day = tostring(day)
  end
  if hour < 10 then
    hour = "0" .. tostring(hour)
  else
    hour = tostring(hour)
  end
  if minute < 10 then
    minute = "0" .. tostring(minute)
  else
    minute = tostring(minute)
  end
  infoString = "<PAColor0xFF83A543>[" .. year .. "-" .. month .. "-" .. day .. " " .. hour .. ":" .. minute .. "]<PAOldColor> RecordNo : " .. tostring(recordNo) .. " [Download : " .. tostring(dataWrapper:getDownloadCount()) .. "]"
  txt_info:SetText(infoString)
  btn_download:addInputEvent("Mouse_LUp", "HandleEventLUp_SolrareReplayList_Download(" .. tostring(dataIndex) .. ")")
end
function PaGlobal_Solrare_ReplayList:createDownloadCompleteListContent(content, key)
  if Panel_Window_Solrare_ReplayList == nil then
    return
  end
  local dataIndex = Int64toInt32(key)
  local dataWrapper = ToClient_GetInstanceContentsReplaySimpleInfo(__eInstanceContentsType_Solare, dataIndex)
  if dataWrapper == nil then
    return
  end
  local stc_record = UI.getChildControl(content, "Static_Record")
  local txt_title = UI.getChildControl(stc_record, "StaticText_Title")
  local txt_recordNo = UI.getChildControl(stc_record, "StaticText_RecordNo")
  local btn_play = UI.getChildControl(stc_record, "Button_Play")
  if btn_play ~= nil then
    UI.setLimitTextAndAddTooltip(btn_play, btn_play:GetText(), "")
  end
  local btn_delete = UI.getChildControl(stc_record, "Button_Delete")
  if btn_delete ~= nil then
    UI.setLimitTextAndAddTooltip(btn_delete, btn_delete:GetText(), "")
  end
  local recordNoString = ""
  local isValidateFile = dataWrapper:isValidate()
  local isFileWarningState = dataWrapper:isFileStateWarning()
  if isValidateFile == true then
    btn_play:SetIgnore(false)
    btn_play:SetMonoTone(false)
    btn_delete:SetShow(true)
    if isFileWarningState == true then
      recordNoString = PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_REPLAYLIST_PLAY_POSSIBLE_WARNING")
    else
      recordNoString = PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_REPLAYLIST_PLAY_POSSIBLE")
    end
    recordNoString = recordNoString .. " " .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SOLARE_REPLAYLIST_RECORDNO", "recordID", tostring(dataWrapper:getRecordNo()))
  else
    btn_play:SetIgnore(true)
    btn_play:SetMonoTone(true)
    btn_delete:SetShow(true)
    recordNoString = PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_REPLAYLIST_PLAY_IMPOSSIBLE")
  end
  local replayTitle = dataWrapper:getReplayTitle()
  txt_title:SetText(replayTitle)
  txt_recordNo:SetText(recordNoString)
  btn_play:addInputEvent("Mouse_LUp", "HandleEventLUp_SolrareReplayList_Play(" .. tostring(dataIndex) .. "," .. tostring(isFileWarningState) .. ")")
  btn_delete:addInputEvent("Mouse_LUp", "HandleEventLUp_SolrareReplayList_Delete(" .. tostring(dataIndex) .. ")")
end
