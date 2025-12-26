PaGlobal_ChannelDesc_ForNewbie_All = {
  _ui = {
    _stc_title = nil,
    _btn_exit = nil,
    _btn_close = nil,
    _frame = nil,
    _frame_content = nil,
    _txt_title1 = nil,
    _txt_desc1 = nil,
    _txt_title2 = nil,
    _txt_desc2 = nil,
    _frame_scroll = nil,
    _keyGuid_Console = nil
  },
  _isSeasonChannelOpen = false,
  _isPadSnapping = ToClient_isUsePadSnapping(),
  _initialize = false
}
registerEvent("FromClient_luaLoadCompleteLateUdpate", "FromClient_ChannelDesc_ForNewbie_All_Init")
function FromClient_ChannelDesc_ForNewbie_All_Init()
  PaGlobal_ChannelDesc_ForNewbie_All:initialize()
end
function PaGlobal_ChannelDesc_ForNewbie_All:initialize()
  if self._initialize == true then
    return
  end
  self._ui._stc_title = UI.getChildControl(Panel_Lobby_ChannelDesc_ForNewbie, "Static_TitleArea_Import_Import")
  self._ui._btn_close = UI.getChildControl(self._ui._stc_title, "Button_Close")
  self._ui._btn_exit = UI.getChildControl(Panel_Lobby_ChannelDesc_ForNewbie, "Button_Exit")
  self._ui._frame = UI.getChildControl(Panel_Lobby_ChannelDesc_ForNewbie, "Frame_Desc")
  self._ui._frame_content = UI.getChildControl(self._ui._frame, "Frame_1_Content")
  self._ui._txt_title1 = UI.getChildControl(self._ui._frame_content, "StaticText_Title_1")
  self._ui._txt_desc1 = UI.getChildControl(self._ui._frame_content, "StaticText_Desc_1")
  self._ui._txt_title2 = UI.getChildControl(self._ui._frame_content, "StaticText_Title_2")
  self._ui._txt_desc2 = UI.getChildControl(self._ui._frame_content, "StaticText_Desc_2")
  self._ui._frame_scroll = UI.getChildControl(self._ui._frame, "Frame_1_VerticalScroll")
  self._ui._keyGuid_Console = UI.getChildControl(Panel_Lobby_ChannelDesc_ForNewbie, "Static_KeyGuide_Console")
  self:validate()
  self:registEventHandler()
  self._initialize = true
  self:prepareOpen()
end
function PaGlobal_ChannelDesc_ForNewbie_All:registEventHandler()
  self._ui._btn_exit:addInputEvent("Mouse_LUp", "HandleEventLUp_ChannelDesc_SelectServer()")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_ChannelDesc_SelectServer()")
  if self._isPadSnapping == true then
    Panel_Lobby_ChannelDesc_ForNewbie:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_ChannelDesc_SelectServer()")
  end
end
function PaGlobal_ChannelDesc_ForNewbie_All:validate()
  self._ui._stc_title:isValidate()
  self._ui._btn_exit:isValidate()
  self._ui._btn_close:isValidate()
  self._ui._frame:isValidate()
  self._ui._frame_content:isValidate()
  self._ui._txt_title1:isValidate()
  self._ui._txt_desc1:isValidate()
  self._ui._txt_title2:isValidate()
  self._ui._txt_desc2:isValidate()
  self._ui._frame_scroll:isValidate()
  self._ui._keyGuid_Console:isValidate()
end
function PaGlobal_ChannelDesc_ForNewbie_All:prepareOpen()
  if Panel_Lobby_ChannelDesc_ForNewbie == nil then
    return
  end
  if ToClient_IsDevelopment() == true then
    return
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  if temporaryWrapper == nil then
    return
  end
  local userType = temporaryWrapper:getMyAdmissionToSpeedServer()
  if userType ~= 2 then
    return
  end
  local lastServerNo = temporaryWrapper:getLastServerNo()
  local findServerName = false
  local worldServerCount = getGameWorldServerDataCount()
  for ii = 1, worldServerCount do
    local worldServerData = getGameWorldServerDataByIndex(ii - 1)
    local lastServerName = getChannelName(worldServerData._worldNo, lastServerNo)
    if lastServerName ~= nil then
      findServerName = true
    end
  end
  if findServerName == true then
    return
  end
  for idx, value in pairs(PaGlobal_ServerSelect_All._treeData) do
    if value ~= nil then
      local worldIndex = value.worldIndex
      local serverIdx = value.channelIndex
      if worldIndex ~= nil and serverIdx ~= nil then
        local channelServerData = getGameChannelServerDataByIndex(worldIndex - 1, serverIdx - 1)
        if channelServerData ~= nil and channelServerData._isSeasonChannel == true then
          self._isSeasonChannelOpen = true
          break
        end
      end
    end
  end
  self._ui._frame_content:SetSize(self._ui._frame_content:GetSizeX(), self._ui._txt_title1:GetTextSizeY() + self._ui._txt_desc1:GetTextSizeY() + self._ui._txt_title2:GetTextSizeY() + self._ui._txt_desc2:GetTextSizeY() + 50)
  if self._ui._frame_content:GetSizeY() < self._ui._frame:GetSizeY() + 50 then
    self._ui._frame_scroll:SetShow(false)
  else
    self._ui._frame_scroll:SetShow(true)
  end
  if self._isPadSnapping == true then
    local windowBG = UI.getChildControl(Panel_Lobby_ChannelDesc_ForNewbie, "Static_WindowBG")
    Panel_Lobby_ChannelDesc_ForNewbie:SetSize(Panel_Lobby_ChannelDesc_ForNewbie:GetSizeX(), windowBG:GetSizeY())
    self._ui._keyGuid_Console:SetShow(true)
    self._ui._keyGuid_Console:SetPosY(Panel_Lobby_ChannelDesc_ForNewbie:GetSizeY())
    self._ui._btn_exit:SetShow(false)
    self._ui._btn_close:SetShow(false)
    self._ui._keyGuid_Console:SetIgnore(false)
    Panel_Lobby_ChannelDesc_ForNewbie:ignorePadSnapMoveToOtherPanel()
  end
  self._ui._txt_title1:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_title1:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LOBBY_STARTSERVER_DESC"))
  self:open()
end
function PaGlobal_ChannelDesc_ForNewbie_All:open()
  if Panel_Lobby_ChannelDesc_ForNewbie == nil then
    return
  end
  Panel_Lobby_ChannelDesc_ForNewbie:SetShow(true)
end
function PaGlobal_ChannelDesc_ForNewbie_All:prepareClose()
  if Panel_Lobby_ChannelDesc_ForNewbie == nil then
    return
  end
  self:close()
end
function PaGlobal_ChannelDesc_ForNewbie_All:close()
  if Panel_Lobby_ChannelDesc_ForNewbie == nil then
    return
  end
  Panel_Lobby_ChannelDesc_ForNewbie:SetShow(false)
end
function HandleEventLUp_ChannelDesc_SelectServer()
  if Panel_Lobby_ChannelDesc_ForNewbie == nil then
    return
  end
  if _ContentsOption_CH_GPM == true then
    ToClient_reportChinaGPM(__eReportSceneSeasonServerInfo, false)
  end
  PaGlobal_ChannelDesc_ForNewbie_All:prepareClose()
  if PaGlobal_ServerSelect_All == nil or PaGlobal_ServerSelect_All._treeData == nil then
    return
  end
  local enterWorldIndex = -1
  local enterServerIndex = -1
  local busyState = 4
  local isAccessible = ToClient_CheckToAccessSeasonNewbieChannel()
  local priorityResult = 5
  local selectServerInfoList = {}
  for idx, value in pairs(PaGlobal_ServerSelect_All._treeData) do
    if value ~= nil then
      local worldIndex = value.worldIndex
      local serverIndex = value.channelIndex
      if worldIndex ~= nil and serverIndex ~= nil then
        local channelServerData = getGameChannelServerDataByIndex(worldIndex - 1, serverIndex - 1)
        if channelServerData ~= nil and channelServerData:isPVPServer() == false and channelServerData:isPrepareToStop() == false and channelServerData._busyState ~= 0 and channelServerData._busyState ~= 4 and channelServerData:isClosed() == false then
          local priority = 5
          if channelServerData._isSeasonChannel == true and channelServerData._isSeasonNewbieChannel == true then
            priority = 0
          elseif channelServerData._isSeasonChannel == true and channelServerData._isSeasonNewbieChannel == false then
            priority = 1
          elseif channelServerData._isSpeedChannel == true and channelServerData._isSeasonNewbieChannel == true then
            priority = 2
          elseif channelServerData._isSpeedChannel == true and channelServerData._isSeasonNewbieChannel == false then
            priority = 3
          else
            priority = 4
          end
          if isAccessible == true or channelServerData._isSeasonNewbieChannel == false then
            if priorityResult > priority then
              busyState = channelServerData._busyState
              enterWorldIndex = worldIndex
              enterServerIndex = serverIndex
              priorityResult = priority
              for k in pairs(selectServerInfoList) do
                selectServerInfoList[k] = nil
              end
              if busyState == 3 then
                local data = {_worldIndex = worldIndex, _serverIndex = serverIndex}
                table.insert(selectServerInfoList, data)
              end
            elseif priorityResult == priority then
              if busyState > channelServerData._busyState then
                busyState = channelServerData._busyState
                enterWorldIndex = worldIndex
                enterServerIndex = serverIndex
                for k in pairs(selectServerInfoList) do
                  selectServerInfoList[k] = nil
                end
              end
              if busyState == 3 then
                local data = {_worldIndex = worldIndex, _serverIndex = serverIndex}
                table.insert(selectServerInfoList, data)
              end
            end
          end
        end
      end
    end
  end
  if next(selectServerInfoList) ~= nil then
    local randomIndex = math.random(#selectServerInfoList)
    enterWorldIndex = selectServerInfoList[randomIndex]._worldIndex
    enterServerIndex = selectServerInfoList[randomIndex]._serverIndex
  end
  if enterWorldIndex ~= -1 or enterServerIndex ~= -1 then
    selectServerGroup(enterWorldIndex - 1, enterServerIndex - 1)
  end
end
