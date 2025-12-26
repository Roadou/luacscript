function PaGlobal_ReplayController_Open()
  if Panel_Window_ReplayController_All == nil then
    return
  end
  PaGlobal_ReplayController:prepareOpen()
end
function PaGlobal_ReplayController_Close()
  if Panel_Window_ReplayController_All == nil then
    return
  end
  PaGlobal_ReplayController:prepareClose()
end
function PaGlobal_ReplayController_GetShow()
  if Panel_Window_ReplayController_All == nil then
    return
  end
  return PaGlobal_ReplayController:GetShow()
end
function PaGlobal_ReplayController_GetIsShowNak()
  if Panel_Window_ReplayController_All == nil then
    return
  end
  return PaGlobal_ReplayController:GetIsShowNak()
end
function PaGlobal_ReplayController_RecordList2(content, index)
  local key = Int64toInt32(index)
  local wrapper = ToClient_getLoadReplayDataWrapper(2, key)
  if nil == wrapper then
    return
  end
  local btn_select = UI.getChildControl(content, "Button_Select")
  local txt_replayName = UI.getChildControl(btn_select, "StaticText_ReplayName")
  local txt_replayLength = UI.getChildControl(btn_select, "StaticText_ReplayLength")
  txt_replayName:SetText(wrapper:getReplayName())
  txt_replayLength:SetText("Collector : " .. tostring(wrapper:getCollectorName()) .. " / ViewingCount : " .. wrapper:getDownloadUserCount())
  btn_select:addInputEvent("Mouse_LUp", "PaGlobal_ReplayController_SetRecordName(\"" .. wrapper:getReplayName() .. "\")")
end
function PaGlobal_ReplayController_PlayList2(content, index)
  local isServer = false
  if index >= toInt64(0, PaGlobal_ReplayController._serverFlag) then
    index = index - toInt64(0, PaGlobal_ReplayController._serverFlag)
    isServer = true
  end
  local key = Int64toInt32(index)
  local wrapper
  if isServer == true then
    wrapper = ToClient_getLoadReplayDataWrapper(2, key)
  else
    wrapper = ToClient_getLoadReplayDataWrapper(1, key)
  end
  if nil == wrapper then
    return
  end
  local btn_select = UI.getChildControl(content, "Button_Select")
  local txt_replayName = UI.getChildControl(btn_select, "StaticText_ReplayName")
  local txt_replayLength = UI.getChildControl(btn_select, "StaticText_ReplayLength")
  local btn_playAndDownload = UI.getChildControl(content, "Button_PlayAndDownload")
  txt_replayName:SetText(wrapper:getReplayName())
  if isServer == true then
    txt_replayLength:SetText("Collector : " .. tostring(wrapper:getCollectorName()) .. " / ViewingCount : " .. wrapper:getDownloadUserCount())
    btn_playAndDownload:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPLAYCONTROLLER_CEHCK_JUSTDOWNLOAD"))
    btn_playAndDownload:addInputEvent("Mouse_LUp", "PaGlobal_ReplayController:startDownLoadReplayData(\"" .. wrapper:getReplayName() .. "\")")
  else
    local minute = math.floor(wrapper:getLength() / 60000)
    local sec = math.floor((wrapper:getLength() - minute * 60000) / 1000)
    txt_replayLength:SetText(minute .. "min " .. sec .. "sec")
    btn_playAndDownload:addInputEvent("Mouse_LUp", "PaGlobal_ReplayController:playReplay(\"" .. wrapper:getReplayName() .. "\")")
  end
  PaGlobal_ReplayController._isServerList[wrapper:getReplayName()] = isServer
  if isServer == true then
    PaGlobal_ReplayController._loadRecordList[key] = content
  else
    PaGlobal_ReplayController._loadPlayList[key] = content
  end
  PaGlobal_ReplayController:ListButtonUpdate()
end
function PaGlobal_ReplayController_SetReplayName(replayName)
  if PaGlobal_ReplayController == nil then
    return
  end
  PaGlobal_ReplayController:setReplayName(replayName)
end
function PaGlobal_ReplayController_SetRecordName(replayName)
  if PaGlobal_ReplayController == nil then
    return
  end
  PaGlobal_ReplayController:setRecordName(replayName)
end
function PaGlobal_ReplayController_PlayReplay()
  if PaGlobal_ReplayController == nil then
    return
  end
  PaGlobal_ReplayController:playReplay()
end
function HandleEventLUp_ReplayController_PopUpUI()
  if Panel_Window_ReplayController_All == nil then
    return
  end
  if PaGlobal_ReplayController._isCheckPopUp == false then
    Panel_Window_ReplayController_All:OpenUISubApp()
    PaGlobal_ReplayController._isCheckPopUp = true
  else
    Panel_Window_ReplayController_All:CloseUISubApp()
    PaGlobal_ReplayController._isCheckPopUp = false
  end
end
function PaGlobal_ReplayController_ReplayListRefresh()
  if nil == Panel_Window_ReplayController_All then
    return
  end
  PaGlobal_ReplayController:recordListUpdate()
  PaGlobal_ReplayController:playListUpdate()
end
function FromClient_ReplayController_ReloadRecordList()
  if nil == Panel_Window_ReplayController_All then
    return
  end
  PaGlobal_ReplayController:recordListUpdate()
  PaGlobal_ReplayController:playListUpdate()
end
function FromClient_ReplayController_SaveReplayNameChange()
  if nil == Panel_Window_ReplayController_All then
    return
  end
  PaGlobal_ReplayController:setCurrentRecordName(true)
end
function FromClient_ReplayController_ListButtonUpdate(num)
  if nil == Panel_Window_ReplayController_All then
    return
  end
  PaGlobal_ReplayController:ListButtonUpdate()
end
function FromClient_ReplayController_SetDownloadEndAni()
  if nil == Panel_Window_ReplayController_All then
    return
  end
  PaGlobal_ReplayController:setDownloadEndAni()
end
function FromClient_ReplayController_ReciveDownloadPercent(percent)
  if nil == Panel_Window_ReplayController_All then
    return
  end
  PaGlobal_ReplayController:ReciveDownloadPercent(percent)
end
function HandleEventLUp_ReplayController_CurrentRecordName()
  if Panel_Window_ReplayController_All == nil then
    return
  end
  PaGlobal_ReplayController:clickCurrentRecordName()
end
